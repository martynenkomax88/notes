---
id: usr_include
aliases: []
tags:
  - search syscalls arguments
  - syscall
  - C headers
---

NOTE: Looking through documentation, the arguments of the system calls are listed as names in all capitals. For instance, we may wish to call socket(AF_INET, SOCK_STREAM, 0) but we cannot simply perform mov rdi, AF_INET: AF_INET is simply not a concept at the assembly level. We need to find the integer which corresponds to AF_INET. These numbers are not even found in the man pages, but these numbers do exist on your machine. Check out the /usr/include directory. All the system's general-use include files for C programming are placed here. (For those who have written C, think of any header files you've included in your code "#include <stdio.h>". All those Functions and constants are defined somewhere here). Since C is compiled to assembly, these numbers are present somewhere in this directory. Rather than manually searching, you can grep for them.



