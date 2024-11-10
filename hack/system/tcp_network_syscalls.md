---
id: tcp_network_syscalls
aliases: []
tags:
  - system
  - sysalls
  - network
  - tcp_ip
---

### Steps to Accept TCP/IP Network Connections

``` C
socket (AF_INET, SOCK_STREAM, IPPROTO_IP) = 3
bind (3,
    {sa_family=AF_INET, sin_portshtons (80),
    sin_addr=inet_addr("0.0.0.0")3,
    1)                                    = 0
listen (3, 0)                             = 0
accept (3, NULL, NULL)                    = 4
```

![Steps to accept TCP/IP network connections](assets/2024-11-10-at-21-42-50.avif)
