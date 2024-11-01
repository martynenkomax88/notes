---
id: nikto
aliases: []
tags:
  - vulnerability_scan
  - enumeration
  - web
---
## Usage:
  - Finds vulnerabilities in a web context

## Commands:
```bash
nikto -h http://foo.com # Scans the specified host

nikto -h http://foo.com -Tuning 6   # Uses a specific Nikto scan tuning level

nikto -h http://foo.com -port 8000  # Scans the specified port

nikto -h http://foo.com -ssl  # Scans for SSL vulnerabilities

nikto -h http://foo.com -Format html  # Formats output in HTML

nikto -h http://foo.com -output out.txt   # Saves the output to a file
```
