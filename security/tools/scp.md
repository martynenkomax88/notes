---
id: scp
aliases: []
tags:
  - ssh
  - transfer
  - download
  - share
  - data
  - remote server
---

> [!NOTE]
> Similar usage and args as ssh

`$scp -args User@remote_server:path/directory /path/where/to/transfer`

Example
`$scp -i key hacker@dojo.pwn.college:/home/hacker/build_server/server.s /users/maksmarty/notes` 



Copy a Local File to a Remote System with the scp Command
To copy a file from a local to a remote system, run the following command:

`$scp file.txt remote_username@10.10.0.2:/remote/directory`

To copy a directory and all its files, invoke the scp command with the -r flag, which recursively copies the entire directory and its contents:

`$scp -r /local/directory remote_username@10.10.0.2:/remote/directory`
When using wildcards such as * or ? to match specific files or directories, to avoid shell expansion, you must enclose the path that includes wildcard characters in quotes (" ") or single quotes (' '). In the following example, we are copying all the .txt files from the local Projects directory to the Projects directory on the remote server:


`$scp "~Projects/*.txt" remote_username@10.10.0.2:/home/user/Projects/`

Copy a Remote File to a Local System using the scp Command
To copy a file from a remote to a local system, use the remote location as a source and the local location as the destination.

`$scp remote_username@10.10.0.2:/remote/file.txt /local/directory`

Copy a File Between Two Remote Systems using the scp Command
Unlike rsync, when using scp, you don’t have to log in to one of the servers to transfer files from one remote machine to another.

`$scp user1@host1.com:/files/file.txt user2@host2.com:/files`
You will be prompted to enter the passwords for both remote accounts. The data will be transferred directly from one remote host to the other.

To route the traffic through the machine on which the command is issued, use the -3 option:

`$scp -3 user1@host1.com:/files/file.txt user2@host2.com:/files`
Tips for Everyday Use
Set up an SSH key-based authentication and connect to your Linux servers without entering a password.

If you regularly connect to the same hosts, simplify your workflow by defining all of your connections in the SSH config file .

```bash
~/.ssh/config
Host myserver_name
    HostName 10.10.0.2
    User leah
    Port 2222
Copy
```

Modern Note (2025)
The most recent OpenSSH versions default to the SFTP protocol for scp. To force the legacy SCP protocol (sometimes needed for very old servers), use the -O flag:

`$scp -O file_name.txt remote_host:/tmp/`

