# Tools

- [Hash analyzer](https://www.tunnelsup.com/hash-analyzer/#google_vignette)
- [Hash lookup table](https://crackstation.net/)

# Exploit

We first inspect the home page with:
```bash
curl -I http://localhost:8080/index.php
```
We can then notice a cookie named admin (major red flag):
```bash
Set-Cookie: I_am_admin=68934a3e9455fa72420237eb05902327;
```

After searching for the hash algorithm we determine that ``68934a3e9455fa72420237eb05902327`` is ``md5sum`` of ``false``  
We only need to create a hash of ``true`` and change the cookie value and reload to gain permissions.

# Patch

1. Replace the current cookie-based admin check with server-side sessions
2. Add proper authentication logic before granting admin privileges
3. Add HTTP security headers to your server configuration
4. Ensure all sessions are properly expired after logout or inactivity