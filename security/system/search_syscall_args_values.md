---
id: search_syscall_args_values
aliases: []
tags:
  - linux
  - syscalls
  - assembly
  - C
---

### To search the syscall args values or any other C commands arguments values we can search for definitions of those in `/usr/include` dir containing C libraries :

Example:
  - `grep -r '#define O_RDWR' /usr/include`   
