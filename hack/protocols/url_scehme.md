---
id: url_scehme
aliases: []
tags:
  - http
  - url
  - web
---

# HTTP URL Scheme:
  - < scheme>: //<host>: ‹port>/<path›?<query>#<fragment>
`http://example.com:80/cat.gif?width=256&height=256#t=2s`

  - scheme: Protocol used to access resource 

  - host: Host that holds resource 

  - port: Port for program servicing resource 

  - path: Identifies the specific resource

  - query: Information that the resource can use 

  - fragment: Client information about the resource


# Must Be Encoded:
  - Unsafe: SP，<，>，"，#，%，｛，｝，I，\，^，~，［，］，‘
  - Reserved: ;, /, ?,:, @, =, &
  - Unprintable: 0x00 - 0x1F, 0X7F 
  - Any other character may be encoded 



![URL encoding](assets/2024-11-09-at-22-57-15.avif)
