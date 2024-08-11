### Special thanks [Data with Baraa](https://www.youtube.com/@DataWithBaraa) And [Playlist](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZY_2eAtUzEUulNjTJREhQe)

## Advanced SQL Course
1. Prepare Environment
2. Window Functions
3. Sets Operators
4. Case Statement
5. Null Functions
6. Date & Time Functions
7. Subqueries
8. CTE: Common Table Expression
9. Views & Temp Tables
10. AI - ChatGPT & SQL
11. Analytical Project

#### Why you must master SQL?
- sql is everywhere, its a relational database
- sql in all platforms & can use it for any analytical tast
- sql in high demand


### 1️⃣Prepare Your Environment
- [link](https://www.datawithbaraa.com/sql-introduction/advanced-sql-thank-you/)
    1. #### download & install sql server
    - Express
    - basic


    2. #### download & install ssms

    3. #### download & create 3x database
    ```
        1. create Database Engine type with window authentication
        2. connect to server
    ```
    - project sales db
    - adventure works dwh db
        - dwh: data warehouse --> olab
            - data source --> dwh
        - olab: online analytical processing
            - query --> olab(qube) --> dwh
    - adventure works oltp db
        - oltp: online transactional  processing
        <br>

    - these are bak file
        - backup file used to stores contents of a database

    - ##### restore database into ssms
        - restore database --> device(...) --> add --> select --> ok --> ok --> okay
        - add one by one


- 4. #### tour into the interface ssms
    - object explorer, query editor, result grid
    - caution:
        - make sure to select the correct database
    - to work with multiple database:
        - database.schema.table
    - USE: used to select a database
    <br>

    - database --> schema(model) --> a table belongs to a single schema

<br>

- dbms: that manages databases and stores data
- sql server: it's a dbms 
- ssms: sql server management studio
    - graphical interface to interact with sql server