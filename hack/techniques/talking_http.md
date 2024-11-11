---
id: talking_http
aliases: []
tags:
  - http
  - web
  - communication
  - requests
---
## Communicate with servers:
  - Curl
    `curl http://example.com`
  - NC
    ``` bash
    nc http://example.com 80
    GET / HTTP/1.1
    ```
  - Python
    ```py
    import requests
    r = requests.get('http://example.com')
    r.text
    ```

