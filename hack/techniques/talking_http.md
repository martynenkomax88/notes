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
## Set headers:
  - Curl
  `curl -H "Host: mosh" example.com`

  - nc
  ```bash
  nc example.com 80
  GET / HTTP/1.1
  Host: mosh 
  ```

  - Python 
  ```Python
  import requests
  r = requests.get("http://www.example.com/", headers={"Content-Type":"text"})
  ```

## Set params:
  - pass url followed by ?
  - ![url_scehme](hack/protocols/url_scehme.md)
  - same for all tooling
example: `curl http://example.com?param1=abcd&param2=nglkd` 
