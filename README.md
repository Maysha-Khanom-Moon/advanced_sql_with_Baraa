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

### Why you must master SQL?
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


## 2️⃣Windows Functions
### Windows Function Basics
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
    - ##### group by rule: all columns in select must be included in group by
        - ##### here coming the window
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
- 2 types of ranking:
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
        - functions:
            - cume_dist()
            - percent_rank()
    <br>

#### row_number():
- assign a unique number to each row
- it doesn't handle ties
- unique ranking without gaps/skipping
    <br>

#### rank():
- assign a rank to each row
- it handles ties
- it leaves gaps in ranking --> for shared rank



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