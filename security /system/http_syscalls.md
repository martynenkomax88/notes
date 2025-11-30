---
id: http_syscall
aliases: []
tags:
  - system
  - syscalls
  - network
  - web
  - http
---

### Steps to communicate over http                                               

``` C                                          
socket (AF_INET, SOCK_STREAM, IPPROTO_IP) = 3  
bind/connect (3,                                 //bind for local connection connect for remote connections      
      {sa_family=AF_INET, 
      sin_port=htons (80),   
      sin_addr=inet_addr("0.0.0.0")},            
      16)                                 = 0  
listen (3, 0)                             = 0  
accept (3, NULL, NULL)                    = 4  
read (4,
      "GET / flag HTTP/1.0\r\n\r\n",
      1)                                  = 19
open ("/flag", O_RDONLY)                  = 5
read (5, "FLAG", 256)                     = 4
write(4,
      "HTTP/1.0 200 OK\r\n\r\nFLAG",
      1)                                  =27

```


![Understanding HTTP at the lowest level](assets/2024-11-10-at-22-08-27.avif)

![Sockaddr_in.avif](assets/Sockaddr_in.avif)

![Listen.avif](assets/Listen.avif)

![Accept.avif](assets/Accept.avif)


## Multiprocessing

1. ### Server setup
#### The server creates a listening socket (socket()).
- Binds it to an address ( bind()).
- Marks it as passive (listen()).

2. ### Accept loop
#### The server enters a loop:
```C
for (;;) {                                                    
conn_fd = accept(listen_fd, ...);  // wait for a client   
    pid = fork();                      // create child process
} 
```

3. ### Fork call
#### Parent process (pid > 0):

- Continues the loop.
- Closes conn_fd (because the child will handle it).
- Keeps listen_fd open to accept more clients.
- Child process (pid == 0):
- Closes listen_fd (child doesn’t need to accept new clients).
- Uses conn_fd to communicate with the connected client.
- Handles the request (read/write).
- Closes conn_fd when done.
- Calls exit() to terminate.

4. ### Process lifecycle
#### Parent keeps running, accepting new clients.
- Each client gets its own child process.
- When the child exits, the parent should wait() or handle SIGCHLD to reap zombies.
```

Client connects
   ↓
accept() returns conn_fd
   ↓
fork()
   ├─ Parent (pid > 0):
   │    close(conn_fd)
   │    loop back to accept()
   │
   └─ Child (pid = 0):
        close(listen_fd)
        handle client via conn_fd
        close(conn_fd)
        exit()
```

![Fork multiprocessing.avif](assets/Fork%20multiprocessing.avif)
