# Exploit

## Basic mechanism

This vulnerability exploits a weakness in how the web application validates uploaded files:

1. The web application has a file upload feature
2. The security mechanism only checks the Content-Type HTTP header to determine if a file is acceptable
3. It accepts files with Content-Type "image/jpeg" but doesn't actually verify the file contents
4. An attacker can upload any file (like a PHP script) and simply change the Content-Type header to "image/jpeg"

## What can this do ?

1. Remote Code Execution (RCE): Attacker can run arbitrary code on your server
1. Data theft: Access to databases, files, and sensitive information
1. Full server compromise: Complete control of the web server
1. Installation of backdoors: Persistent access to your system
1. Website defacement: Changing the appearance of your website
Use as a pivot point to attack internal networks

## What we did

In this one, we try to exploit a breach in the upload. We notice that the web application firewall seems to check only the content-type.
It only seems to accept jpg, so we just have to send a malicious file with the content-type changed to image/jpeg.

```bash
echo '<?php echo "malware" ?>' > /tmp/malware.php && curl -X POST -F "Upload=Upload" -F "uploaded=@/tmp/malware.php;type=image/jpeg" "http://127.0.0.1:8080/index.php?page=upload" | grep 'The flag is :'
```

# Patch

1. Use Safe Storage Location: Store uploaded files outside the web root directory or configure the server to prevent execution of files in the upload directory.

2. Set Proper File Permissions: Set restrictive permissions on the upload directory (e.g., 0750).

3. Consider Using a CDN or Dedicated Image Service: For larger applications, consider using specialized services for handling user uploads.

4. Implement Image Processing: Reprocess all uploaded images to strip any embedded code.

5. Add Logging: Log all upload attempts, successful or not, for security monitoring