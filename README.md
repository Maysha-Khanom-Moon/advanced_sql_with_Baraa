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
### Windows function basics
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
-  <b>aggregate</b>:
    - count(expr)
    - sum(expr)
    - avg(expr)
    - min(expr)
    - max(expr)
    <br>
- <b>ranking</b>:
    - row_number()
    - rank()
    - dense_rank()
    - cume_dist()
    - percent_rank()
    - ntile(n)
    <br>
- <b>value(analytical)</b>:
    - lead(expr, offset, default)
    - lag(expr, offset, default)
    - first_value(expr)
    - last_value(expr)
<br>


### The syntax
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


### Aggregate window function
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


### Ranking window function
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

### Value functions **
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

### Rules
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

### Operators
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
### The syntax
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

### Use cases
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
#### basic
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

### Functions
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

#### COALESCE:
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
```
        if column1 value is null then replace it with column2
            if column2 is also null then replace it with column3
                if column3 is also null then replace it with column4
                    ... ...
                else column3
            else column2
        else column1
```
<br>

#### ISNULL vs COALESCE:
1. 
    - isnull: limited to two values
    - coalesce: unlimited
2. 
    - isnull: fast
    - coalesce: slow
3. 
    - isnull: different database server has different keyword for isnull
        - sql server --> ISNULL
        - oracle --> NVL
        - mysql --> IFNULL
    - coalesce: available in all databases
        - so coalesce recommended

- if coalesce query is really slow then just use isnull, otherwise coalesce recommended
    <br>

#### NULLIF:
- compares two expressions returns:
    1. NULL, if they are equal
    2. First Value, if they are not equal
        <br>
    
    - NULLIF(column1, value)
        - if column1.value = value --> NULL
        - else column1.value
        <br>
    
    - NULLIF(column1, column2)
        - if column1.value = column2 --> NULL
        - else column1.value
        <br>

- use case --> division by zero
    <br>

#### IS NULL:
column IS NULL
- returns true if the value is null,
  otherwise it returns false

- use case: anti joins
    <br>

#### IS NOT NULL:
column IS NOT NULL
- returns true if the value is not null,
  otherwise it returns false
    <br>

#### Left anti join:
- left join + isnull
- all rows from left table without matches in the right table
    <br>

### Handle null(use case)
#### data aggregation:
- for every aggregate function: Nulls ignored
- just count(*) doesn't ignored null
    
But sometimes specially for avg we have to count null as zero
    <br>

#### mathematical operators:
- no matter what arithmetic operation is done with a null, it's always null
- null never affected by any mathematical operations
- handle the Null before doing mathematical operations
- we know:
    1. 1 + 5 = 6, 'A' + 'B' = 'AB'
    2. 0 + 5 = 5,  '' + 'B' = 'B'

    ##### but,
    - Null + 5 = Null
    - Null + 'B' = Null
        - sql don't know + something = don't know
    <br>

#### before joining tables:
- handle the null before joining tables
- usually we join tables based on some comperison. But Null-Null comperison is not possible
    - sql will ignore these records
    - so we lost these records
    - that's why we have to handle NULLs
    <br>

#### sorting data:
- handle the null before sorting the data
- is case of sorting, sql treats null as the smallest value

- to put null at the last position in desc order:
    1. lazy way:
        - via coalesce
        - replace the nulls with very big number
        - it's a static way
            <br>
    
    2. flag use:
        - via case statement
    <br>

### Null vs Empty string vs Blank space
- empty string and blank space are looking similar, but length is different

#### null vs empty string vs blank space:
1. representation:
    - null: NULL
    - empty string: ''
    - blank space: ' '
2. meaning:
    - null: unknown
    - empty string: known, empty value
    - blank space: known, space value
3. data type:
    - null: Special Marker
    - empty string: String(0)
    - blank space: String(1 or more)
4. storage:
    - null: very minimal
    - empty string: occupies memory
    - blank space: occupies memory(each space)
5. performance:
    - null: best
    - empty string: fast
    - blank space: slow
6. comparison:
    - null: IS NULL
    - empty string: = ''
    - blank space: = ' '
    <br>

#### data policy:
- set of rules that defines how data should be handled

1. Only use NULLs and empty strings, but avoid blank spaces
    ##### trim:
    - remove unwanted leading and trailing spaces from a string
    - but still it's hard to understand that is a empty string or blank spaces
        <br>

2. only use NULLs and avoid empty strings and blank spaces
    - it's easy to handle and understand
    - replaceing empty strings and blanks with NULL during data preparation before <b>inserting</b> into a database to optimize storage and performance
        <br>

3. use the default value 'unknown' and avoid using nulls, empty strings, and blank spaces
    - replacing empty strings, blanks, nulls with default value during data preparation before using it in <b>reporting</b> to improve readiblity and reduce confusion.
    <br>

#### summary:
- nulls special markers means missing value
- using nulls can optimize storage and performance
    <br>
- functions:
    - NULL --- coalesce | isnull --> value
    - value --- nullif --> null
    - is null | is not null -----> true | false
        <br>
- use cases:
    - handle nulls:
        1. data aggregation
        2. mathematical operations
        3. joining tables
        4. sorting data
            <br>
    - finding unmatched data - left anti join
        <br>
- data policies: nulls | default value
    <br>
<br>

## 6️⃣Date & Time Functions
There is 4 parts:
1. part extraction:
    - day
    - month
    - year
    - datepart
    - datename
    - datetrunc
    - eomonth
2. format & casting:
    - format
    - convert
    - cast
3. calculations:
    - dateadd
    - datediff
4. validation:
    - isdate
    <br>

### Basics
#### Date:
- 3 components:
    1. year: no limit
    2. month: 1-12
    3. day: 1-31

#### Time:
- 3 components:
    1. hours: 0-23
    2. minutes: 0-59
    3. seconds: 0-59

#### Time + Date combination:
- Timestamp: oracle, postgres, mysql
- Datetime2: sql server
    - another one is datetime, but datetime2 has more precision
        <br>

#### Date & time values:
1. date column from a table
2. hardcoded constant string value
3. getdate() function:
    - returns the current datetime at the moment when the query is executed
        <br>

### Part Extraction
#### day(date):
- returns the day from a date

#### month(date):
- returns the month from a date

#### year(date):
- returns the year from a date
    <br>

#### datepart(part, date):
- returns specific part of a date as a number
- part: year | month | day | hour | quater | week

#### datename(part, date):
- returns the name of a specific part of a date
- part: month | weekday || (year, day, hour, quater, week)
- without month and weekday, others are return number. but it's not a integer, it's a string
    <br>

#### datetrunc(part, date):
- truncates the datetime to the specific part
- part: level of details

DateTime: Year-Month-Day Hours-Minutes-Seconds

- part: year | month | day | hour | minute | second
    - until part we keep, rest of the things are reset
        - date part reset: 01
        - time part reset: 00
    <br>

#### eomonth(date):
- returns the last day of a month
- fun part:
    - datetrunc(month, date) returns the first day of a month
    <br>

#### use case:
- data aggregation using datetrunc
    1. by year
    2. by month
    3. by day
        <br>

- data filtering
    - <b>**</b> filtering data using integer is faster than using a string
    - avoid using datename for filtering data, instead of datepart
        <br>

#### summary:
1. day, month, year, datepart --> int
2. datename --> string
3. datetrunc --> datetime
4. eomonth --> date
    <br>

### Format & casting
#### format specifier:
- datetime: yyyy-MM-dd HH:mm:ss
    <br>

- date format standards:
    1. international standard(Iso 8601): yyyy-MM-dd
        - sql server standard
            <br>

    2. usa standard: MM-dd-yyyy
    3. european standard: dd-MM-yyyy
    <br>

#### formatting & casting:
- date:
    1. format: MM/dd/yy | MMM yyyy
    2. convert: style no
        <br>

- number:
    1. format: N, C, P
        <br>

- casting:
    - changing the data type from one to another
    1. cast()
    2. convert()
        <br>

#### fomart(value, format [, culture]):
- culture: specifies the local-aware formatting
    - an optional parameter
    - default culture: en-US
        <br>

- <b>formatting use cases</b>:
    1. data aggregations
    2. data standardization
        - the process of converting data from various sources into a common format so that it can be easily processed and analyzed
        <br>

#### convert(data_type, value [, style]):
- casting + formating
- converts a date or time value to a different data type & formats the value
    <br>

- style:
    - an output style (optional)
    - default style = 0
        <br>

#### cast(value as data_type):
- converts a value to a specified data type
    <br>

#### cast vs convert vs format:
1. casting:
    - cast: anytype to anytype
    - convert: anytype to anytype
    - format: anytype to <b>only string</b>

2. formating:
    - cast: no formating
    - convert: formating only data & time
    - format: date & time | numbers
    <br>

### Calculations & Validation
#### dateadd(part, interval, date):
- adds or subtracts a specific time interval to/from a date
- part: year, month, day

#### datediff(part, start_date, end_date):
- find the difference between two dates
- part: year, month, day
    <br>

#### isdate(value):
- check if a value is a date
    - returns 1 if string value is a valid date
    - otherwise 0
        <br>

- <b>if string value is not a valid date then it's not possible to casting as date</b>
    <br>
<br>


# SQL Techniques
To reduce & optimize the complexity of sql queries
            <br>

The 5 techniques are:
1. SUBQUERY
2. CTE
3. VIEW
4. TMP
5. CTAs
    <br>

#### real-world scenarios:
1. DBA: database administration
    - does database architechture

2. data engineer
    - ETL(extract, transform, load) --> DWH --> analyst | sceintist
    - dwh: data warehouse

3. Analyst
    - get data by query --> analysis --> report

4. data scientist
    - get data by query --> model
    <br>

##### challenges
- redundancy
- performance issues
- complexity
- hard to maintain
- DB stress
- security

##### solutions
1. SUBQUERY
2. CTE
3. VIEW
4. TMP
5. CTAs
    <br>

#### database architechture:
There are 2 sides:
1. server
    - database engine
        - it is the brain of the database, executing multiple operations such as storing, retrieving, and managing data within the database
    
    - storage
        1. disk storage: long-term memory, where data is stored permanently
            - capacity: can hold a large amount of data
            - speed: slow to read and write
                    <br>

        2. cache storage: fast short-term memory, where data is stored temporarily
            - capacity: can hold smaller amount of data
            - speed: extremely fast to read and write
                            <br>
        - subquery results stay in cache memory
        <br>

2. client
    - user | queries
    <br>

#### 3 types of area are there in a disk storage:
1. user data storage
    - it's the main content of the database. this is where the actual data that users care about is stored
                <br>
2. system catalog
    - database's internal storage for its own information. a blueprint that keeps track of everything about the database itself, not the user data
    - it holds the Metadata information about the database
        - Metadata: data about data
            - you can find this in information schema 
                <br>

    - information schema: a system-defined schema with built-in views that provide info about the database, like tables and columns
```
    SELECT 
        *
    FROM INFORMATION_SCHEMA.___
```

3. temporary data storage
    - temporary space used by the database for short-term tasks, like processing queries or sorting data
    - system databases --> tempdb
        - although to access this, need authorization
    <br>

##### how simple query works?
``` client(query) --> 1st check cache memory:
        if exist in cache memory
            return data from cache memory

        else
            check in user data storage
```
<br>

## 7️⃣Subquery
A query inside another query

```
Nested queries:

Outer(main) query{
    Inner(sub) query {
        ... ...
    }
}
```

#### Categories of subquery
Following dependancy:
1. Non-correlated subquery
    - inner query does not depend on the outer query

2. Correlated subquery
    - inner query depends on the outer query
        <br>

Based on result types:
1. scaler subquery
    - returns single value | one row with one column

2. single row subquery
    - retruns single row, which can contain multiple column values

3. multi-rows subquery
    - row subquery
    - returns multiple rows but usually only one column

4. multi-columns subquery
    - returns multiple rows and multiple columns
    - placed in WHERE or HAVING clause

5. table subquery
    - returns multiple rows and multiple columns
    - placed in FROM clause
        <br>

Based on Location | Caluses:
1. select clause
2. from
3. jon
4. where
    - comparison operators: <, >, =, !=, >=, <=
    - logical operators: IN, ANY, ALL, EXSITS
    <br>

### Based on Location | Caluses
#### From clause:
- used as temporary table for the main query
- we need subquery because window function only can use in SELECT or ORDER BY clauses

```
SELECT 
    column1,
    column2,
    ...
FROM ( subquery ) AS alias
```

#### Select clause:





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
<br>