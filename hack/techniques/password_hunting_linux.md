---
id: password_hunting_linux
aliases: []
tags:
  - privillege escalation
  - privesc
  - linux
  - enumeration
---

Run [[linpeas]] first

# Manual enumeration:

# Filenames & Inside files:
## Filenames:
  - Check for files with interesting names eg.: config, php 

`find / -exec ls -lad $PWD/* "{}" 2>/dev/null \; | grep -i -I "passw\|pwd"`


  - Another command that we can use to comb the entire filesystem for files that contain a certain string in their name is the locate command.

```bash
locate 'passw'
locate 'pwd'          #locate is faster than `find` 
locate '*.php'
```

## Interesting Strings Inside Files:
  - Check for 'password' like strings inside files in all filesystem:

`grep --color=auto -rnw '/' -iIe "PASSW\|PASSWD\|PASSWORD\|PWD" --color=always 2>/dev/null` 

  - To be more granular, we can navigate to common folders where we normally find interesting files, such as /var/www, /tmp, /opt, /home, etc. and then execute the following command:

`grep --color=auto -rnw -iIe "PASSW\|PASSWD\|PASSWORD\|PWD" --color=always 2>/dev/nul  `

# Web Files / Config Files:
## Passwords in Config Files:
  - Navigate to `/var/www` and check for conf files eg.: conf.php

## Other web files:
  - Other web files can be found on the system eg: WebDav --> .WebDav

## Cracking found hashes:
  - To prep for cracking this hash, we can copy the contents of the passwd.dav file (without the username and colon!) and paste it into a TXT file on our attacker machine.

  - Once that is done, we can use [[hashcat with the following command to find the cracking mode for this type of hash:

`hashcat -h | grep -i '$apr'`


