---
id: privilege_escalation_linux
aliases:
  - privesc
tags:
  - linux
---

## Find commands and binaries user can run:
  - `sudo -l`

## Find SETUID binaries:
  -The setuid/setgid (SUID/SGID) bits allows the binary to run with the privileges of the user/group owner instead of those of the user executing it. They can be spotted with the s or S permission in the file user or group owner permissions (i.e. ---s--s---). When the file permissions features an uppercase S instead of a lowercase one, it means the corresponding user or group owner doesn't have execution rights.
  ```bash
 find $starting_path -perm -u=s -type f 2>/dev/null

# Or in octal mode
find $starting_path -perm -4000 -type f 2>/dev/null 
  ```
## LPEAS:
   [linpeas](hack/tools/linpeas.md) is a tool looking for potential privesc vectors on linux
   
