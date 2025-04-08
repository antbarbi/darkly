# Exploit

In `http://localhost:8080/?page=feedback` we have a feedback page where we can see other people name and messages.
So we try to use an XSS attack in the message field
```bash
<script>alert(document.cookie)</script>
```
And it works

# Patch

- Server-Side Input Sanitization
- Output Encoding When Displaying Feedback
- Add Content Security Policy