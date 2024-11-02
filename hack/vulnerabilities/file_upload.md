---
id: file_upload
aliases: []
tags: []
---
## How the server handles file requests:
 The process for handling these static files is still largely the same as before. At some point, the server parses the path in the request to identify the file extension. It then uses this to determine the type of the file being requested, typically by comparing it to a list of preconfigured mappings between extensions and MIME types. What happens next depends on the file type and the server's configuration.

   - If this file type is non-executable, such as an image or a static HTML page, the server may just send the file's contents to the client in an HTTP response.
   - If the file type is executable, such as a PHP file, and the server is configured to execute files of this type, it will assign variables based on the headers and parameters in the HTTP request before running the script. The resulting output may then be sent to the client in an HTTP response.
   - If the file type is executable, but the server is not configured to execute files of this type, it will generally respond with an error. However, in some cases, the contents of the file may still be served to the client as plain text. Such misconfigurations can occasionally be exploited to leak source code and other sensitive information. You can see an example of this in our information disclosure learning materials.
> [!TIP]
> The Content-Type response header may provide clues as to what kind of file the server thinks it has served. If this header hasn't been explicitly set by the application code, it normally contains the result of the file extension/MIME type mapping. 

## Example of vulnerable code on different programming languages:
• in PHP:

A common mistake is not validating the file type before uploading it to the server. Attackers can exploit this by uploading a malicious file with a fake extension that can be executed on the server. The following code shows an example of how not to validate the file type:

`$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"])). " has been uploaded.";
} else {
    echo "Sorry, there was an error uploading your file.";
}`


A more secure way to validate the file type in PHP is to use the $_FILES["fileToUpload"]["type"] attribute or a third-party library to check if the file type is allowed.

• in Python:

A common mistake is not setting a size limit for the uploaded file. Attackers can exploit this by uploading a very large file, causing a denial of service or exhausting the server’s disk space. The following code shows an example of how not to set a size limit:

`@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    file.save(file.filename)
    return 'File uploaded successfully'`


To set a size limit in Python, you can use the max_content_length attribute in the app object, as shown in the following example:

`from flask import Flask, request
app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB limit
@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    file.save(file.filename)
    return 'File uploaded successfully'`


• in Java:

A common mistake is not sanitizing the file name before saving it to the server. Attackers can exploit this by uploading a file with a malicious name that can contain special characters or path traversal sequences. The following code shows an example of how not to sanitize the file name:

`@RequestMapping(value = "/upload", method = RequestMethod.POST)
@ResponseBody
public String handleFileUpload(@RequestParam("file") MultipartFile file) {
    try {
        byte[] bytes = file.getBytes();
        Path path = Paths.get(file.getOriginalFilename());
        Files.write(path, bytes);
        return "File uploaded successfully";
    } catch (IOException e) {
        e.printStackTrace();
        return "Error uploading file";
    }
}`


To sanitize the file name in Java, you can use a regular expression or a third-party library, as shown in the following example:

`import org.apache.commons.lang3.StringUtils;`

## Examples of exploitation File Upload Vulnerabilities

### Malware Injection:

An attacker can exploit a file upload vulnerability by uploading a file containing malware, such as a virus, Trojan, or worm. Once the file is uploaded and executed on the server or client-side, the attacker can gain access to sensitive data or take control of the system.

For example, an attacker may upload a PHP shell script as an image file and execute it on the server to gain access to the system. They can then use the shell script to launch further attacks or steal sensitive data.

### Remote Code Execution:

An attacker can exploit a file upload vulnerability by uploading a file containing malicious code that can be executed on the server. This can allow the attacker to gain full control of the system and perform actions such as modifying data, stealing information, or launching further attacks.

For example, an attacker may upload a PHP file that contains a script that allows them to execute arbitrary commands on the server. They can then use these commands to take control of the system or launch further attacks.

### Denial of Service:

An attacker can exploit a file upload vulnerability by uploading large files that consume all available disk space or bandwidth, causing a denial of service. This can prevent legitimate users from accessing the system or cause it to crash.

For example, an attacker may upload a very large file that consumes all available disk space, causing the server to crash or become unresponsive. This can prevent legitimate users from accessing the system or cause it to be temporarily unavailable.
Privilege escalation techniques for File Upload Vulnerabilities

### Uploading an executable file and executing it as a privileged user:

If the web application is running with elevated permissions, an attacker can exploit the file upload vulnerability to upload an executable file, such as a shell script or a binary file, and then execute it with elevated privileges. This can allow the attacker to gain full control over the system and access sensitive data.

### Uploading a web shell and gaining remote access:

An attacker can upload a web shell, which is a script that can be executed through the web browser to gain remote access to the server. This can allow the attacker to execute commands on the server, access sensitive data, and escalate privileges.

### Uploading a file with a malicious payload:

An attacker can upload a file with a malicious payload, such as a virus or a Trojan, that can allow them to gain access to sensitive data or execute commands on the server with elevated privileges.

### Uploading a file that overwrites a sensitive file:

If the web application is running with elevated permissions and a file upload vulnerability exists, an attacker can upload a file that overwrites a sensitive file on the server. This can allow the attacker to gain access to sensitive data or execute commands with elevated privileges.
General methodology and checklist for File Upload Vulnerabilities

## Methodology:

    Identify file upload functionality: Identify any file upload functionality that exists in the web application. This can include file upload forms, file upload API endpoints, or any other mechanism that allows users to upload files to the server.

    Analyze file upload functionality: Analyze the file upload functionality to identify any potential vulnerabilities. This can include checking whether input validation and sanitization are in place, looking for any size restrictions or other constraints on file uploads, and examining the permissions and access controls on the server.

    Test for file upload vulnerabilities: Attempt to upload files that contain malicious code, such as viruses or Trojans, or that can execute arbitrary code on the server. Test for different types of file extensions, such as PHP, JSP, and ASP, as these can be used to execute code on the server.

    Test for different types of attacks: Test for different types of file upload attacks, such as remote code execution, denial of service, and file overwrite attacks. Attempt to upload files that have different types of payloads, such as malware or shell scripts, and check for any unexpected behaviors or responses from the server.

    Test for client-side vulnerabilities: Test for client-side vulnerabilities by attempting to upload files with different types of extensions, sizes, and content types. This can help identify any client-side issues that may be present in the file upload functionality.

    Monitor and log all activity: Monitor and log all activity during testing to identify any suspicious behavior or unexpected responses from the server. This can help identify any attempts to exploit file upload vulnerabilities.

    Document findings: Document any vulnerabilities or issues identified during testing, including the steps taken to reproduce them and the impact they could have on the system. This can help developers and system administrators understand the risks associated with file upload vulnerabilities and take steps to remediate them.
