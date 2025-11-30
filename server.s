.intel_syntax noprefix            
.globl _start                     
                                  
.section .text                    
                                  
_start: 
	# socket()
	mov rdi, 2      # AF_INET
	mov rsi, 1      # SOCK_STREAM
	mov rdx, 0      # IPPROTO_IP
	mov rax, 41     # SYS_socket
	syscall

	mov [rip+fd], rax    # store FD in a variable (or rbx - preserved reg)

	# bind()
	mov rdi, [rip+fd]    # socket FD --> rdi / 1st arg of bind
	lea rsi, [rip+sockaddr]   # points to the addr of sockaddr struct
	mov rdx, 16     # addr len
	mov rax, 49	# SYS_bind
	syscall
	
	# listen()
	mov rdi, [rip+fd]    	#sockfd
	mov rsi, 0		#backlog - 0
	mov rax, 50
	syscall

accept_loop:
	#accept()
	mov rdi, [rip+fd]	#sockfd
	xor rsi, rsi 		#NULL / Other options: #mov rsi, 0x000000   #lea rsi, [rip+client_addr]
	xor rdx, rdx  		#same     "      "     #mov rdx, 0x000000   #lea rdx, [client_len]
	mov rax, 43
	syscall

	mov [rip+conn_fd], rax    # move return FD of connected socket from rax to a variable

	#fork
	mov rax, 57		#fork() syscall nr
	syscall
	test rax, rax		#check if rax is 0, 0 is returned at child process
	jz child_proc
	mov rdi, [rip+conn_fd]
	mov rax, 3
	syscall
	jmp accept_loop

	jmp exit

child_proc:
	#close listening in child
	mov rdi, [rip+fd]
	mov rax, 3
	syscall

	#read
	mov rdi, [rip+conn_fd]	#sockfd of the client connected
	lea rsi, [rip+read_buf]	#read buffer the request is read from the socket to
	mov r12, rsi		#move the received buffer address to a persistant register to use in get_path and write_path function
	mov rdx, 512		#read len
	mov rax, 0
	syscall
		
	#GET or POST
	cmp byte ptr [r12], 0x47
	je get
	cmp byte ptr [r12], 0x50
	je post

	#jmp close_exit

get:
	#get_path
	xor rcx, rcx    	#set the rcx counter to 0 to use as incrementer in called func
	xor r13, r13		#set the counter of bytes to 0
	lea rdi, [rip+path]	#load the address of path in rdi to save the trimmed request path
	call get_path

	#open
	lea rdi, [rip+path]
	mov rsi, 0
	mov rdx, 0
	mov rax, 2
	syscall

	mov rbx, rax   #fd of received path

	#read_file
	mov rdi, rbx
	lea rsi, [rip+buffer_flag]
	mov rdx, 256
	mov rax, 0
	syscall

	mov r13, rax	#move the number of read bytes to r13 to feed the write syscall len
	
	#close path file
	mov rdi, rbx
	mov rax, 3
	syscall

	#write HTTP 200
	mov rdi, [rip+conn_fd]	#sockfd of client
	lea rsi, [rip+response]	#reference the addr where the response to write to the socket - send to the client is stored 
	mov rdx, 19		#response len
	mov rax, 1
	syscall

	#write the reply - path file content
	mov rdi, [rip+conn_fd]   #sockfd of client  
	lea rsi, [rip+buffer_flag] #reference the addr of buffer with file content
	mov rdx, r13             #response len      
	mov rax, 1                                 
	syscall                                    
	
	mov rdi, [rip+conn_fd]
	mov rax, 3
	syscall

	jmp exit

post:
 	#get_path
 	xor rcx, rcx            #set the rcx counter to 0 to use as incrementer in called func
 	xor r13, r13            #set the counter of bytes to 0
 	lea rdi, [rip+path]     #load the address of path in rdi to save the trimmed request path
 	call get_path

 	#open
 	lea rdi, [rip+path]
 	mov rsi, 0x41
 	mov rdx, 0777
 	mov rax, 2
 	syscall

 	mov rbx, rax   #fd of received path
	
	#get_content
	#jmp get_content

get_content:
	#find the pattern appearence
	mov eax, [r12]		#move 4 bytes in address stored in r12 containing the received request body
	cmp eax, 0x0A0D0A0D	#compare the 4 bytes at eax with "\r\n\r\n"
	je cmsb			#looking for the pattern and jump to cmsb func when found
	inc r12			#inc when not found
	jmp get_content		#loop

cmsb:
	lea rsi, [r12]		#r12 is now at the address of the found pattern. setting the registers for the cmpsb call which compares the pattern and returns in rsi the address of the byte just after the pattern. Could have been done alternatively by adding 4 bytes to the address of r12 when pattern was found : 'lea rsi, [r12+4]' - replacing the 4 lines 
	lea rdi, [rip+regex]
	mov rcx, 4
	repe cmpsb

	xor rcx, rcx		#set the counter for iteration to 0
	xor rdi, rdi
	xor r13, r13		#setting the counter for the lenght of the request body 

iter:
	#write the request body byte by byte till 0 byte into the buffer
	lea rdi, [rip+buffer_flag]
	mov al, [rsi]
	cmp al, 0
	je write
	mov [rdi+rcx], al
	inc rsi
	inc rcx
	inc r13
	jmp iter

write:
	#write the request body from buffer to the created file 
	mov rdi, rbx
	lea rsi, [rip+buffer_flag]
	mov rdx, r13
	mov rax, 1
	syscall
	
	#close the file after write
	mov rdi, rbx
	mov rax, 3
	syscall

	#send HTTP 200 OK
	mov rdi, [rip+conn_fd]   
	lea rsi, [rip+response] 
	mov rdx, 19             
	mov rax, 1              
	syscall                 
	
	#close
	mov rdi, [rip+conn_fd]	#close the connected socked
	mov rax, 3
	syscall
	
	jmp exit

get_path:
	mov al, [r12]		#move the received buffer byte by byte to al
	cmp al, '/'		#looking for the first / - start of path
	je write_path		#jump to next func
	inc r12			#increment the buffer address
	jmp get_path		#iterate

write_path:	
	mov al, [r12]		#same as above
	cmp al, 0x20		#compare with space or 0 for the end of the path
	je return		#return when found
	cmp al, 0
	je return
	mov [rdi+rcx], al	#write the path byte by byte to the path var
	inc r12			#increment the received buffer

	inc rcx			#increment the counter
	mov byte ptr [rdi+rcx], 0  #move a 0 at the end of the path var to have a string
	jmp write_path		#iterate

return:
	ret			#return to start func
	
exit:                                          
	mov rdi, 0      	# ERROR TO RETURN      
	mov rax, 60     	# SYS_exit    
	syscall                       

.section .data 

sockaddr:
        .word 0x0002      # AF_INET
        .word 0x5000      # htons(80)
        .quad 0x00000000  # ip = 0.0.0.0
	.quad 0x00000000  # padding 8 bytes

response: .asciz "HTTP/1.0 200 OK\r\n\r\n"

fd: 	.quad 0		# When storing values in variables from a register we must initialize a space equal to the size of the register or the value might get overwritten  

conn_fd: .quad 0

read_buf: .space 512

path:	.space 256

buffer_flag: .space 256

write_buf: .space 512

regex: .asciz "\r\n\r\n"
