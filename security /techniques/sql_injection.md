---
id: sql_injection
aliases: []
tags:
  - web_app
  - owasp
---

## Usage:


## Syntax:
  - There are different syntaxes depending on the DB and version


> [!NOTE]
> `admin'` prefix can be used
> `asd'` prefix can be used


## Cheat-sheet:
  - Comment out a part of the legit query:
    - When introducing an injection it ends in the legit query. For example if you have 2 fields LOGIN and PASSWORD the legit query would be <injected query> + WHERE LOGIN = ...AND PASSWORD = ...
    - If not commented out it ends up in a syntax error
    - Insert `-- -` at the end of the query to comment out the unwanted part 
  - Find the number of columns
    - `' union select 1,2 -- -` 
