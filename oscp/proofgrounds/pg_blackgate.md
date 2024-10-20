---
id: pg_blalckgate
aliases: []
tags: []
---


### pg_blalckgate
* 2024-10-1913:15


## tags: 

### techniques

### vulnerabilities 
----------


## Enumeration

### Info gathering   
##### Open ports:
> `ssh /22`
> `redis /6379`

  

### Services

>   `$nmap : 6379/tcp open  redis   syn-ack ttl 61 Redis key-value store 4.0.14`
>   [[services#redis-6379|Services ❯ Redis /6379]] 

## Exploitation
> **[Redis-rogue-server.py](https://github.com/n0b0dyCN/redis-rogue-server)**  


## Privilege escalation

`redis-status` is located in `/usr/local/bin/` --> can be run as root and is asking for input (Auth key)

