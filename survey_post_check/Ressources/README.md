# Tools

# Exploit

We notice that there is a form with a post request where the website only offers 10 choices for each form.
So I tried to change the value send through that post request to be higher than the choices offered to us.
We can also do a one line with this command:  

```bash 
curl 'http://127.0.0.1:8080/index.php?page=survey#' --data 'sujet=2&valeur=100' | grep 'flag is'
```

# Patch

Check the value sent through that post request