# Exploit

## Basic machanism

This vulnerability exploits the absence of protection mechanisms against repeated login attempts:

1. The web application has a login page with username and password fields
1. There are no measures to prevent or limit multiple consecutive login attempts
1. An attacker can create an automated script to systematically try thousands of password combinations
1. The script detects successful logins by monitoring response differences (absence of "WrongAnswer.gif")
1. Eventually, if using common credentials or weak passwords, access is gained

## What can this do ?

- Unauthorized account access: Gaining entry to user or admin accounts
- Privilege escalation: If admin credentials are compromised
- Data theft: Access to private and sensitive information
- Identity theft: Ability to impersonate legitimate users
- Further system compromise: Using the compromised account as a foothold for additional attacks
- Reputation damage: Loss of user trust when security is compromised

## What we did

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

- Implement account lockout: Temporarily disable accounts after multiple failed attempts
- Add CAPTCHA challenges: Force human verification after failed attempts
- Implement rate limiting: Restrict the number of login attempts per time period
- Use IP-based restrictions: Block or challenge IPs with suspicious patterns
- Enforce strong password policies: Require complex passwords that resist guessing
- Implement multi-factor authentication: Require something the user has in addition to the password
- Log and alert on suspicious activity: Monitor and respond to unusual login patterns
- Use progressive delays: Increase wait time between login attempts
Consider passwordless options: Email magic links or OAuth authentication

# Tools

- [Python Requests library](https://requests.readthedocs.io/)
- [SecLists Password Dictionary](https://github.com/danielmiessler/SecLists)