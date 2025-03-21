# Tools

- [Python Requests library](https://requests.readthedocs.io/)
- [SecLists Password Dictionary](https://github.com/danielmiessler/SecLists)

# Exploit

We first examine the login page at:
```bash
http://localhost:8080/?page=signin
```
The page contains a standard login form with username and password fields. We notice that there's no protection against brute force attacks such as:

- No CAPTCHA
- No account lockout
- No rate limiting
- No IP-based restrictions

We create a script to automate login attempts using a common dictionary of passwords:
``python3 script.py``

The script tries the username "admin" with thousands of common passwords until it finds the correct one. It detects a successful login when the "WrongAnswer.gif" image is no longer present in the response.

# Patch
To fix this vulnerability:

- Implement account lockout after multiple failed attempts
- Add CAPTCHA or other human verification
- Add rate limiting to prevent automated attacks
- Use strong password policies
- Implement multi-factor authentication
- Log and alert on multiple failed login attempts