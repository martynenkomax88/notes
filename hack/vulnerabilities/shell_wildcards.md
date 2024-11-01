---
id: shell_wildcards
aliases:
  - wildcards
tags:
  - vulnerabilities
  - linux
  - vulnerabilities/linux
---

This is a security vulnerability because of how UNIX shells handles wildcards. Let's see an example with the ls command :
```bash
$ ls -lha
total 84K
drwxrwxr-x 2 user user 4,0K avril 27 22:32 .
drwxrwxrwt 89 user user 76K avril 27 22:31 ..
-rw-rw-r-- 1 user user 0 avril 27 22:31 file1
-rw-rw-r-- 1 user user 0 avril 27 22:31 file2
-rw-rw-r-- 1 user user 0 avril 27 22:31 file3
$ ls *
file1 file2 file3

$ echo '' > '-lha'
$ ls -lha 
total 88K
drwxrwxr-x 2 user user 4,0K avril 27 22:32 .
drwxrwxrwt 89 user user 76K avril 27 22:31 ..
-rw-rw-r-- 1 user user 0 avril 27 22:31 file1
-rw-rw-r-- 1 user user 0 avril 27 22:31 file2
-rw-rw-r-- 1 user user 0 avril 27 22:31 file3
-rw-rw-r-- 1 user user 1 avril 27 22:32 -lha
$ ls *
-rw-rw-r-- 1 user user 0 avril 27 22:31 file1
-rw-rw-r-- 1 user user 0 avril 27 22:31 file2
-rw-rw-r-- 1 user user 0 avril 27 22:31 file3
```
> [!NOTE]
> The shell wildcards are resolved by the shell, and not by the command. This means filenames can be treated as options if they are starting with a -. In our previous example, we added a file called -lha into the folder. When we type ls *, the shell replaces the * by all matching files in the current directory, and therefore our command becomes ls file1 file2 file3 -lha. After the wildcard resolution, the shell executes the command with our options.
