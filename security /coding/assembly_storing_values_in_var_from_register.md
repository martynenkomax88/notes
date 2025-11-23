---
id: assembly_storing_values_in_var_from_register
aliases: []
tags:
  - assembly
  - coding
  - memory management
  - storing return value
  - syscall return
  - function return
---
> [!NOTE]
> When storing values in variables from a register we must initialize a space equal to the size of the register or the value might get overwritten

```asm 

mov rdi, 2      
mov rsi, 1      
mov rdx, 0      
mov rax, 41     
syscall

mov [rip+fd], rax    #store the output of syscall in fd

.section .data

fd: .quad 0  #initializing the right size 
```

