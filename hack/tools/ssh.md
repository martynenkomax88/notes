---
id: ssh
aliases: []
tags:
  - connection
  - network
  - remote
  - file_transfer
---

## Transferer files while in ssh connection:
#### Forwarding
On an existing connection, you can establish a reverse ssh tunnel. On the ssh command line, create a remote forwarding by passing 
`-R 22042:localhost:22 `
where 22042 is a randomly chosen number that's different from any other port number on the remote machine. Then 
`ssh -p 22042 localhost` 
on the remote machine connects you back to the source machine; you can use 
`scp -P 22042 foo localhost`
to copy files.

You can automate this further with 
`RemoteForward 22042 localhost:22` 
> [!NOTE]
> The problem with this is that if you connect to the same computer with multiple instances of ssh, or if someone else is using the port, you don't get the forwarding.

If you haven't enabled a remote forwarding from the start, you can do it on an existing ssh session. Type
`Enter ~C Enter -R 22042:localhost:22 Enter` 
See “Escape characters” in the manual for more information.
