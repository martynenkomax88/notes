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
bind (3,                                       
      {sa_family=AF_INET, sin_portshtons (80),   
      sin_addr=inet_addr("0.0.0.0")3,            
      1)                                    = 0  
listen (3, 0)                             = 0  
accept (3, NULL, NULL)                    = 4  
read (4,
      "GET / flag HTTP/1.01r\n\r\n",
      1)                                    = 19
open ("/flag", O_RDONLY)                  = 5
read (5, "FLAG", 256)                     = 4
write(4,
      "HTTP/1.0 200 OK\rIn| InFLAG",
      1)                                    =27

```


![Understanding HTTP at the lowest level](assets/2024-11-10-at-22-08-27.avif)
