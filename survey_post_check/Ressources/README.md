# Exploit

## Basic mechanism

This vulnerability exploits insufficient server-side validation in the survey form:

1. The web application presents a form with a dropdown that only shows values 1-10
2. While the client-side interface limits selections to this range, the server doesn't validate the submitted values
3. An attacker can intercept and modify the POST request to submit any arbitrary value
4. The server processes these manipulated values without checking if they're within the valid range
5. This indicates that the application relies solely on client-side validation, which can easily be bypassed

## What can this do?

Inadequate server-side validation can lead to various issues:
- Data corruption by inserting invalid values into the database
- Potential for integer overflow or buffer overflow if large values are accepted
- Skewing of survey results or statistics
- Indication of other validation weaknesses that could be exploited
- In more complex systems, could lead to privilege escalation or authorization bypass

## What we did

We notice that there is a form with a post request where the website only offers 10 choices for each form.
So I tried to change the value send through that post request to be higher than the choices offered to us.
We can also do a one line with this command:  

```bash 
curl 'http://127.0.0.1:8080/index.php?page=survey#' --data 'sujet=2&valeur=100' | grep 'flag is'
```

# Patch

To prevent this vulnerability:

1. Implement proper server-side validation that checks if submitted values are within the allowed range

2. Use a whitelist approach to only accept predefined values

3. Consider implementing both client-side validation (for user experience) and server-side validation (for security)

4. Apply consistent input validation across the entire application

5. Log validation failures to detect potential attacks