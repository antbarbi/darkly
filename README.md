# Darkly - Web Security Vulnerabilities Project

## Project Overview

Darkly is a cybersecurity project focused on identifying and exploiting common web vulnerabilities. This repository contains documentation and proof-of-concepts for various security flaws found in a deliberately vulnerable web application.

The project demonstrates the importance of security awareness in web development by showcasing how attackers can exploit poorly secured applications and how developers can protect against these attacks.

## Purpose & Learning Objectives

- Understand common web security vulnerabilities
- Learn practical exploitation techniques
- Develop skills in identifying security flaws
- Implement proper mitigation strategies and patches
- Gain experience in security assessment methodology

## Key Vulnerabilities Covered

This repository documents several critical web vulnerabilities, including:

1. **SQL Injection** - Exploiting unsanitized database queries
2. **Input Validation Bypass** - Manipulating form submissions with unexpected values
3. **XSS (Cross-Site Scripting)** - Injecting malicious scripts
4. **Directory Traversal** - Accessing unauthorized files and directories
5. **Authentication Flaws** - Bypassing login mechanisms
6. **Insecure Direct Object References** - Accessing resources without proper authorization

## Repository Structure

Each vulnerability is documented in its own directory with the following structure:

```
vulnerability_name/
├── Ressources/
│   └── README.md  # Detailed explanation of the vulnerability
├── flag           # The achievement token for successful exploitation
```

The README for each vulnerability covers:
- Basic mechanism of the vulnerability
- Potential impact and risks
- Step-by-step exploitation process
- Recommended patches and mitigation strategies

## Getting Started

1. Clone this repository
2. Review the README in each vulnerability directory to understand the security concept
3. Try to reproduce the vulnerabilities in a safe, controlled environment
4. Study the recommended patches to learn proper security implementation

## Security Notice

The techniques and code examples in this repository are for educational purposes only. Always:
- Obtain proper authorization before testing security on any system
- Practice responsible disclosure if you find vulnerabilities
- Apply the defensive techniques you learn to protect your own applications

## Subject

[Darkly](./en.subject.pdf)