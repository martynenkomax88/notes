---
id: web_shell_upload_via_extension_blacklist_bypass
aliases:
  - file_upload_exploitation
tags:
  - web
  - shell_delivery
  - vulnerabilities/file_upload
---
1. Log in and upload an image as your avatar, then go back to your account page.
2. In Burp, go to Proxy > HTTP history and notice that your image was fetched using a GET request to /files/avatars/<YOUR-IMAGE>. Send this request to Burp Repeater.
3. On your system, create a file called exploit.php containing a script for fetching the contents of user's secret. For example:
`<?php echo file_get_contents('/home/user/secret'); ?>`
4. Attempt to upload this script as your avatar. The response indicates that you are not allowed to upload files with a .php extension.
5. In Burp's proxy history, find the POST /my-account/avatar request that was used to submit the file upload. In the response, notice that the headers reveal that you're talking to an Apache server. Send this request to Burp Repeater.
6. In Burp Repeater, go to the tab for the POST /my-account/avatar request and find the part of the body that relates to your PHP file. Make the following changes:
    - Change the value of the filename parameter to .htaccess.
    - Change the value of the Content-Type header to text/plain.
    - Replace the contents of the file (your PHP payload) with the following Apache directive:
    - AddType application/x-httpd-php .l33t
    This maps an arbitrary extension (.l33t) to the executable MIME type application/x-httpd-php. As the server uses the mod_php module, it knows how to handle this already.
1. Send the request and observe that the file was successfully uploaded.
2. Use the back arrow in Burp Repeater to return to the original request for uploading your PHP exploit.
3. Change the value of the filename parameter from exploit.php to exploit.l33t. Send the request again and notice that the file was uploaded successfully.
4. Switch to the other Repeater tab containing the GET /files/avatars/<YOUR-IMAGE> request. In the path, replace the name of your image file with exploit.l33t and send the request. Observe that Carlos's secret was returned in the response. Thanks to our malicious .htaccess file, the .l33t file was executed as if it were a .php file.

