### Special thanks [Data with Baraa](https://www.youtube.com/@DataWithBaraa). And [Playlist](https://www.youtube.com/playlist?list=PLNcg_FV9n7qZY_2eAtUzEUulNjTJREhQe)

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
    <br>
### Why you must master SQL?
- sql is everywhere, its a relational database
- sql in all platforms & can use it for any analytical tast
- sql in high demand
    <br>

### 1️⃣Prepare Your Environment
- [link](https://www.datawithbaraa.com/sql-introduction/advanced-sql-thank-you/)
1. #### download & install sql server
    - Express
    - basic

2. #### download & install ssms

3. #### download & create 3x database
    1. create Database Engine type with window authentication
    2. connect to server
    ```
    1. project sales db
    2. adventure works dwh db
        - dwh: data warehouse --> olab
            - data source --> dwh
        - olab: online analytical processing
            - query --> olab(qube) --> dwh
    3. adventure works oltp db
        - oltp: online transactional  processing
    ```

    - these are bak file
        - backup file used to stores contents of a database

    - ##### restore database into ssms
        - restore database --> device(...) --> add --> select --> ok --> ok --> okay
        - add one by one
    <br>

4. #### tour into the interface ssms
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
    <br>
<br>

## 2️⃣Windows Functions
### Windows function basics:
- it's like GROUP BY. but it's advance
- #### but:
    - window works row wise
    - group by works group wise
    <br>
    - group by returns single row for each group
    - window returns a result for each row
    <br>
    - group by --> simple aggregations
    - window --> aggregations + keep details
    <br>
    - group by has only agrregate functions
    - window has aggregate, rank, value functions
    <br>
##### group by rule: all columns in select must be included in group by
- here coming the window
    <br>

- don't lose the details of data
- row-level calculation

#### windows functions:
- ##### aggregate:
    - count(expr)
    - sum(expr)
    - avg(expr)
    - min(expr)
    - max(expr)
    <br>
- ##### ranking:
    - row_number()
    - rank()
    - dense_rank()
    - cume_dist()
    - percent_rank()
    - ntile(n)
    <br>
- ##### value(analytical):
    - lead(expr, offset, default)
    - lag(expr, offset, default)
    - first_value(expr)
    - last_value(expr)
<br>


### The syntax:
- 2 parts: window function + over clause
#### over clasue:
- 3 parts:
    1. partition clause
    2. order caluse
    3. frame caluse
- tells sql that the function used is a window function
- it defines a window or subset of data
    <br>
- AVG(Sales) OVER(PARTITION BY Category ORDER BY OrderDate ROWS UNBOUNDED PRECEDING)
    <br>

#### partition clause:
- optional for any type of function
- divides the rows into groups, based on the column/s

- without partition:
    - calculation done on entier dataset --> single window
- with partition:
    - divide into groups --> multiple window
- we can use multiple columns partition
    <br>
- flexibility of window:
    - allows aggregation of data at different granualarities within the same query

#### order clause:
- optional for aggregate function
- required for rank and value functions
- sort the data within a window (asc | desc)
    - asc default

#### frame clause:
- window inside a window
- defines a subset of rows within each window that is relevant for the calculation
- 2 parts have:
    - frame types: 
        - rows
        - range
    - frame boundary(lower value):
        - current row
            - 0-th row
        - n preceding
            - n-th row before the current row
        - unbounded preceding
            - from first row
    - frame boundary(higher value):
        - current row
            - 0-th row
        - n following
            - upto the n-th row after the current row
        - unbounded following
            - upto last row
        - <br>
- rules:
    - frame clasue can only used together with order by clause
    - lower value must be before the higher value
    - <br>
- shortcut:
    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        - ROWS 2 PRECEDING
    - ##### shortcut only works for preceding
- default frame:
    - order by always uses a hidden frame
        <br>
    - ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    - ROWS UNBOUNDED PRECEDING
    <br>

#### 4x rules:
1. window functions can be used only in SELECT and ORDER BY clauses
2. nesting window functions is not allowed
3. sql execute window functions after WHERE clasue
    - first filtering then aggregation
4. window function can be used together with GROUP BY in the same query, only if the same columns are used
<br>


### Aggregate window function:
- expression is required
- sql does not support nesting window functions directly
    - add sub-queries
- ##### use case:
    1. overall analysis
        - quick summary or snapshot of the entire dataset
    2. total per groups analysis
        - group-wise analysis, to understand patterns within different categories
    3. part to whole analysis
    4. comparison analysis
    5. identify duplicates
    6. outlier detection
    7. running total
    8. rolling total
    9. moving average
    <br>
#### count(expr):
- counts all the rows in a table
- count(*):
    - counts all the rows in a table, regardless of whether any value in NULL
    - count(1) --> same as count(*)
    
- count(column):
    - counts the number of non-NULL values in the column
- ##### use case:
    - identify duplicate rows to improve data quality
        1. overall analysis
        2. category analysis
        3. quality checks: identify NULLs
        4. quality checks: identify Duplicates
        <br>
- data quality issue:
    - duplicates leads to inaccuracies in analysis
    - check the duplicates using primary key which is unique
    - although in general primary keys are unique but in real life we have do build a function to check duplicate primary keys
    <br>

#### sum(expr):
- numeric expression only
- ##### use case:
    - shows the contribution of each data point to the overall dataset
- ##### comparison use cases:
    - compare the current value and aggregated value of window functions
- <br>

#### avg(expr):
- numeric expression only
- NULLs will ignored
    <br>
- sometimes we consider NULL as zero
    - so first we have to handle the NULL value
    - AVG(COALESCE(expr, 0))
        - replace the NULL with 0
        - it can be any specific value
    <br>
- ##### use case:
    - outlier detection
    - compare to average. helps to evaluate whether a value is above or below the average
    <br>

#### min(expr) & max(expr):
- NULL is consider by default as ZERO

- for max:
    - no problem at all
- for min:
    - it's a problem
    <br>

#### running & rolling total:
- analysis over time:
     they aggregate sequence of members, and the aggregation is updated each time a new memeber is added
- ##### use case:
    - tracking:
        - tracking current sales with target sales
    - trend analysis:
        - providing insights into historical patterns
    <br>
- ##### running total:
    - aggregate all values from the beginning up to the current point without dropping off older data
    - default order by frame

- ##### rolling total:
    - aggregate all values within a fixed time window(e.g. 30 days). As new data is added, the oldest data point will be dropped
    - fixed window size
    <br>

#### moving average:
- similar to running and rolling total
- running total: default window
- rolling total: fixed window
- <br>

#### summary:
1. overall total: overview of entire data
2. total per groups: compare catergories
3. running total: progress over time
4. rolling total: progress over time in specific fixed window
<br>


### Ranking window function:
- before using ranking function sort the data
    - so, order clause required
    - but frame clause not allowed
#### 2 types of ranking:
1. integer-based ranking
    - discrete distinct value
    - top/bottom N analysis
    - functions:
        - row_number()
        - rank()
        - dense_rank()
        - ntile(n)
2. percentage-based ranking
    - continuous value
    - distribution analysis
    - calculate percentile
    - functions:
        - cume_dist()
        - percent_rank()
    <br>

#### row_number():
- unique rank
- does not handle ties
- no gaps in ranks
    <br>

#### rank():
- shared rank
- handles ties
- gaps in ranks
    <br>

#### dense_rank():
- shared rank
- handles ties
- no gaps in ranks
    <br>

#### row_number() uses:
1. top-n analysis
    - analysis the top performers to do targeted marketing
2. bottom-n analysis
    - help analysis the underperformance to manage risks and to do optimizations
3. assign unique ids
    - help to assign unique identifier for each row to help paginating
    - ##### paginating:
        - process of breaking down a large data into smaller, more manageable chunks
4. identify duplicates
    - identify and remove duplicate rows to improve data quality
    <br>

#### ntile(n):
- divides the rows into a specified number of approximately equal groups(Buckets)
- bucket size = no of rows / no of buckets
    - n = no of buckets

- ##### when bucket size not integer:
    - say we have m rows
    1. 1st bucket size, n1 = ceil(m / n)
    2. 2nd bucket size, n2 = ceil((m-n1) / n)
    3. 3rd bucket size, n3 = ceil((m-n1-n2) / n)
    4. ... ...
    <br>

- ##### ntile(n) use cases:
    1. data analyst --> data segmentation
        - divides a dataset into distinct subsets based on certain criteria

    2. data engineer --> equalizing load processing
        - use primary key to order
        - to transfer big data it takes long time. sometimes it shows network error because load stressed the network
        - so we split the dataset into small tables using ntile(n)
        - to balance the processing of extracting data
    <br>

#### cume_dist():
- cumulative distribution calculates the distribution of data points within a window

- cume_dist = position no / no of rows

- ##### tie rule:
    - took the position of the last occurrence

- ##### scale: 0 < cume_dist <= 1

- ##### inclusive --> the current row is included
    <br>

#### percent_rank():
- calculates the relative position of each row
- percent_rank = (position no - 1) / (no of rows - 1)

- ##### tie rule:
    - took the position of the first occurrence

- ##### 0 <= percent_rank() <= 1

- ##### exclusive --> the current row is excluded
    <br>

### Value functions **:
- window analytical functions
- order clause required
- ##### MONTH(date):
    - extracts and returns the month from a given date
- ##### CAST:
    - cast( __ as float)
- ##### DATEDIFF():
    - calculates the difference between two date values

#### time series analysis:
- the process of analyzing the data to understand patterns, trends, and behaviors over time

1. YoY:
    - Year-over-Year
    - Analyze the overall growth or decline of the business's performance over time

2. MoM:
    - Month-over-Month
    - Analyze short-term trends and discover patterns in seasonality

#### time gaps analysis:
3. Customer Retention    
    - measure customer's behavior and loyalty to help businesses build strong relationships with customers
    <br>

#### lead(expr, offset, default):
- frame clause not allowed
- access a value from the next row within a window

- ##### arguments:
    - expression is required
    - offset --> no of rows forward from current row
        - default = 1
    - default value --> return default value if next row is not avaiable
        - default = null

#### lag(expr, offset, default):
- frame clause not allowed
- access a value from the previous row within a window

- ##### arguments:
    - expression is required
    - offset --> no of rows previous from current row
        - default = 1
    - default value --> return default value if previous row is not avaiable
        - default = null
    <br>

#### first_value(expr):
- frame clause should be used
- access a value from the first row within a window

#### last_value(expr):
- frame clause should be used
- access a value from the last row within a window
    <br>
<br>

## 3️⃣Sets Operators
- set operations in sql combine the results of multiple queries into a single result set

- 2 methods:
    1. to combine columns: JOINs
        - Key column
        1. Inner join
        2. Full join
        3. Lest join
        4. Right join
    2. to combine rows: SET operations
        - Same columns
        1. union
        2. union all
        3. except(minus)
        4. intersect
    <br>

### Rules:
#### 1. sql clauses
- set operator can be used almost in all clauses 
    - where
    - join
    - group by
    - having

- but order by is allowed only once at the end of query
        <br>

#### 2. num of columns
- the number of columns in each query must be the same
        <br>

#### 3. data types
- data types of columns in each qury must be compatible
        <br>

#### 4. order of columns
- the order of the columns in each query must be the same
        <br>

#### 5. column aliases
- the column names in the result set are determined by the column names specified in the first query
- 1st query controls column names
        <br>

#### 6. correct columns
- even if all rules are met and sql shows no errors, the may be incorrect
- incorrect column selection leads to inaccurate results
    <br>

### Operators:
- steps:
    1. firstly explore both table
    2. find out the compatible rows and map them
    <br>
#### union:
- returns all distinct rows from both queries
- first performs a sorting operation
- then removes duplicate rows from the result
    <br>

#### union all:
- returns all rows from both queries, inlcuding duplicates
- union all is generally faster than union
    - no sorting and elimination
- use union all to find duplicates and quality issues
    <br>

#### except: (minus)
- returns unique rows in 1st table that are not in 2nd table

- ##### order of queries:
    - only here the order of queries in a except does affect the result
    <br>

#### intersect:
- returns only the rows that are common in both queries
    <br>

#### use cases:
1. combine information:
    - union or union all use case
    - combine similar information before analyzing the data
    - database developers divide the data into multiple tables to optimize performance and archive old data
    
    - ##### best practices:
        - never use an asterisk(*) to combine tables; list needed columns instead
        - because after combining if a new column is added in any table then it will return error
        - also we saw a clear map
    - ##### source flag:
        - include additional column to indicate the source of each row
    <br>

2. delta detection:
- except use case
- identifying the differences or changes(delta) between two batches of data
- data engineer use new data generated pipeline
    - source system -----> data warehouse
    <br>

3. data completeness check:
- except use case
- check both tables are identical or not
    - A - B = B - A = empty
- except operator can be used to compare tables to detect discrepancies between databases
    <br>
<br>

## 4️⃣Conditional(case) statments
### The syntax:
```
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result
END
```
- top-down approch
- without ELSE default is NULL
    <br>

#### quick form syntax:
- if all conditions for specific one column
```
CASE coulmn
    WHEN _1_ THEN _1_
    WHEN _2_ THEN _2_
    ... ...
    ELSE
```
- not need to use the same column name in every statement
- but full format is recommended
- because if you add another column in case statement then you have to rewrite whole statement
    <br>

### Use cases:
#### case rule:
- the data type of the result must be compitable(matching)
    <br>

#### 1. categorizing data:
- group the data into different categories based on certain conditions
- main purpose is data transformation
- derive new information
    - create new columns based on existing data
    <br>

#### 2. mapping values:
- transform the values from one form to another
- to get unique values to map:
    - select distinct
    <br>

#### 3. handling nulls:
- replace nulls with a specific value
- nulls can lead to inaccurate results, which can lead to wrong decision-making
    <br>

#### 4. condition aggregation:
- apply aggregate functions only on subsets of data that fulfill certain conditions
##### flag:
- binary indicator(1, 0) to be summarized to show how many times the condition is true
    <br>
<br>


## 5️⃣Null Functions
#### basic:
- NULL means nothing, unknown!
- NULL is not equal to anything!
    - NULL is not zero
        - zero is a value

    - NULL is not empty string
        - empty refers to something that has zero length

    - NULL is not blank space
        - empty string

- NULL means there is no value or missing or I don't know what it is or not defined
- Like someone's middle name is empty just means he/she doesn't have a name, if middle name is Null, then it means the middle name is missing, could be empty, or "A" or "ABC" or anything
    <br>

### Functions:
#### for replace values: (function)
- NULL ---- ISNULL | COALESCE ----> value
- value ---- NULLIF ----> NULL
    <br>

#### check for null: (boolean)
- NULL --- IS NULL ---> True
- NULL --- IS NOT NULL ---> False
    <br>

#### ISNULL:
1. replace null by default value: (static)
    - ISNULL(column1, replacement_value)
        - if column1 value is null then replace it with replacement_value
            <br>

2. replace null by another column's value: (dynamic)
    - ISNULL(column1, column2):
        - if column1 value is null then replace it with another column2's value
            <br>
    <br>

#### COALESCE
- as it is like isnull function but we can use multiple values or columns to check
1. static:
    - COALESCE(column1, replacement_value)
        - if column1 value is null then replace it with replacement_value
            <br>

2. dynamic:
    - COALESCE(column1, column2):
        - if column1 value is null then replace it with another column2's value
            <br>

3. multiple:
##### it's a nested isnull function
- COALESCE(column1, column2, ..., value)
- COALESCE(column1, column2, column3, ...)
    - if column1 value is null then replace it with column2
        - if column2 is also null then replace it with column3
            - if column3 is also null then replace it with column4
                - ...
            - else replace by column3
        - else replace by column2
    - else replace by column1
    <br>

#### 





## 🌟Query Clauses
```
SELECT DISTINCT country, COUNT(c.customer_id) AS total_customers

FROM customers AS c

INNER JOIN orders o ON o.cutomer_id = c.cutomer_id

WHERE country = 'germany'

GROUP BY c.country

HAVING COUNT(c.customer_id) > 1

ORDER BY c.country

LIMIT 2
```