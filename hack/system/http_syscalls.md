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


### Multiprocessing

In order to handle multiple connections a loop with `fork()` is used:
  - The process is doubled --> child returns 0 and parent returns child's PID
  - The parent is closing its specific connection since the handling of the process is passed to the child
  - The parent is doing `accept()` and fork again to create another child connection 
  - Different logic and daat can be handled by the subconnections

