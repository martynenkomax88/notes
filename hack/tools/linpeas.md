---
id: linpeas
aliases: []
tags:
  - privilege_escalation
  - enumeration
---

## Installation:

From public github
`curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh`

## Commands:

   ```bash
   -a (all checks except regex) - This will execute also the check of processes during 1 min, will search more possible hashes inside files, and brute-force each user using su with the top2000 passwords.
   -e (extra enumeration) - This will execute enumeration checkes that are avoided by default
   -r (regex checks) - This will search for hundreds of API keys of different platforms in the Filesystem
   -s (superfast & stealth) - This will bypass some time consuming checks - Stealth mode (Nothing will be written to disk)
   -P (Password) - Pass a password that will be used with sudo -l and bruteforcing other users
   -D (Debug) - Print information about the checks that haven't discovered anything and about the time each check took
   -d/-p/-i/-t (Local Network Enumeration) - Linpeas can also discover and port-scan local networks
   ```

It's recommended to use the params -a and -r if you are looking for a complete and intensive scan.
