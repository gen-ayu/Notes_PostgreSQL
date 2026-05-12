-- Relational Operations 
/*It explains the logical process of retriving and manupilating data.Sql is simple a practical langauage
built on top of these concepts.*/
/*Relational operations are the basic operations that can be performed on relational databases. They include:
1. Selection: This operation retrieves specific rows from a table based on a specified condition. It is denoted by the sigma (σ) symbol. For example, σ(condition)(Table) will return all rows from the Table that satisfy the condition.
2. Projection: This operation retrieves specific columns from a table. It is denoted by the pi (π) symbol. For example, π(column1, column2)(Table) will return only the specified columns from the Table.
3. Renaming: This operation allows you to rename the attributes (columns) of a relation (table). It is denoted by the rho (ρ) symbol. For example, ρ(new_name)(Table) will return the Table with the new name for its attributes.
there respective symbols are σ, π, ρ. These operations can be combined to perform complex queries on relational databases. For example, you can use selection and projection together to retrieve specific columns from rows that satisfy a certain condition.*/

/*While using select statement we can also use Distinct or all (which is default) to specify whether we want to retrieve only unique values or all values from a column.
For example, "SELECT DISTINCT column_name FROM Table" will return only unique values from the specified column, while "SELECT ALL column_name FROM Table" will return all values, including duplicates.

--Now we will talk about the aggregate functions which are used with filtering (where) and group by clause the result cna further be sorted by order by clause.*/

--AGGREGATE FUNCTIONS
/*Aggregate functions are used to perform calculations on a set of values and return a single value as a result. They are commonly used in SQL to summarize data. Some common aggregate functions include:
1. COUNT(): This function counts the number of rows in a specified column or the total number of rows in a table. For example, COUNT(*) will return the total number of rows in a table, while COUNT(column_name) will return the number of non-null values in that column.
2. SUM(): This function calculates the total sum of a specified column. For example, SUM(column_name) will return the sum of all values in that column.
3. AVG(): This function calculates the average value of a specified column. For example, AVG(column_name) will return the average of all values in that column.
4. MAX(): This function returns the maximum value from a specified column. For example, MAX(column_name) will return the highest value in that column.
5. MIN(): This function returns the minimum value from a specified column. For example, MIN(column_name) will return the lowest value in that column.
Aggregate functions are often used in conjunction with the GROUP BY clause to group rows based on a specified column and perform calculations on each group. For example, you can use COUNT() to count the number of rows in each group, or SUM() to calculate the total for each group.*/

-- An example of Aggregate function with select, where and group by and order by clause.
select tags, avg(average_count) as avg_animal 
from animals 
where animal = "cow"
group by tags
order by tags asc;

-- we can also use it as so 
select count (distinct animals) as animal_count from animals;

--Distinct keyword is used to return only distinct (different) values. It eliminates duplicate values from the result set. 
--For example, if you have a table with multiple rows containing the same value in a column, using DISTINCT will return only one instance of that value.
-- This is useful when you want to find out how many unique values exist in a column or when you want to retrieve a list of unique values from a column.

--GROUP BY 
--Group by is used to group rows that have the same value in one or more columns, usually with aggregate functions.
--Example of group by clause.
select category, sum(amount) as total_sales from sales
where amount > 500
group by categories
order by total_sales desc;

--Having clause is used to filter groups based on a specified condition, similar to the WHERE clause but for groups. For example, you can use HAVING to filter groups based on the result of an aggregate function, such as "HAVING SUM(amount) > 1000" to return only groups where the total sales amount exceeds 1000.
--an example of having clause(it is used after group by clause)
select category, sum(amount) as total_sales from sales
group by category
having sum(amount) > 1000
order by total_sales desc;

/*WHERE filters individual rows before grouping and aggregation occur.

HAVING filters grouped results after aggregation has been performed using GROUP BY.*/


--Limit clause is used to specify the maximum number of rows to return in the result set.
--Example of limit clause
select * from employees
order by salary desc
limit 5;

--we also have OFFSET clause which is used to specify the number of rows to skip before starting to return rows from the query result. It is often used in conjunction with the LIMIT clause for pagination purposes. For example, "OFFSET 10" will skip the first 10 rows and return the subsequent rows based on the specified limit.
--Example of offset clause
select * from employees
order by salary desc
limit 5
offset 10;

--One similar clause is FETCH which is used to specify the number of rows to return after the OFFSET clause. It is part of the SQL standard and can be used as an alternative to LIMIT. For example, "FETCH FIRST 5 ROWS ONLY" will return the first 5 rows after skipping the specified number of rows with OFFSET.
--Example of fetch clause
select * from employees
order by salary desc
offset 10
fetch first 5 rows only;    
--we may use it without offset as well
select * from employees
order by salary desc
fetch first 5 rows only;

--we can also use next instead of first
select * from employees
order by salary desc
fetch next 5 rows only;

--we can add ties to fetch as well in case of ties in the order by clause
select * from employees
order by salary desc
fetch first 5 rows with ties;

--JOIN
/*JOIN is used to combine rows from two or more tables based on a related column between them. 
It allows you to retrieve data from multiple tables in a single query. There are several types of JOINs, including:
1. INNER JOIN: Returns only the rows that have matching values in both tables.
2. LEFT JOIN (or LEFT OUTER JOIN): Returns all rows from the left table and the matching rows from the right table. If there is no match, NULL values are returned for columns from the right table.
3. RIGHT JOIN (or RIGHT OUTER JOIN): Returns all rows from the right table and the matching rows from the left table. If there is no match, NULL values are returned for columns from the left table.
4. FULL JOIN (or FULL OUTER JOIN): Returns all rows when there is a match in either left or right table. If there is no match, NULL values are returned for columns from the table that does not have a match.
5. NORMAL JOIN: This is a type of JOIN that does not require the use of the ON clause to specify the join condition.
It is used when the join condition is based on the natural relationship between the tables, such as matching columns with the same name and data type. For example, if you have two tables,
 Employees and Departments, and both tables have a column named department_id, you can use a NORMAL JOIN to automatically join the tables based on this common column without explicitly specifying the join condition.
6. CROSS JOIN: Returns the Cartesian product of the two tables, meaning it returns all possible combinations of rows from both tables. This type of JOIN does not require a join condition and can result in a large number of rows if both tables have many records.
7. SELF JOIN: This is a type of JOIN where a table is joined with itself. It is used to compare rows within the same table or to find relationships between rows in the same table. For example, if you have an Employees table with a manager_id column that references the employee_id of the manager, you can use a SELF JOIN to retrieve information about employees and their managers.    
8.EQUI JOIN: This is a type of JOIN that uses an equality condition to match rows between tables. It is a specific type of INNER JOIN where the join condition is based on the equality of values in specified columns. For example, if you have two tables, Orders and Customers, and both tables have a column named customer_id, you can use an EQUI JOIN to retrieve orders along with customer information by matching the customer_id in both tables.
JOINs are typically performed using the ON clause to specify the condition for matching rows between the tables*/

--INNER JOIN returns only matching rows from both tables.
--OUTER JOIN also includes non-matching rows.    
--General syntax for JOIN
SELECT columns
FROM table1 
JOIN table2
ON table1.column_name = table2.column_name
ORDER BY column_name;

--Symbols for Join and subqueries are
--Join symbol is (⨝),left outer join is (⟕), right outer join is (⟖), full outer join is (⟗), cross join is (⨯), self join is (⨝) as well, equi join is (⨝) as well.
--Other joins are theta join (⨝ with condition)or ⋈θ, natural join (⨝ without condition), and semi join ⋉(left semi join) ⋊(right semi join) or (⨝ with condition but only returns columns from one table).
--Subquery symbol is (∈) for in, (∃) for exists, (∀) for all, (∃) for any, and (=) for one value.

/*Now we do set operations which are used to combine the results of two or more SELECT statements. The main set operations in SQL are:
1. UNION: This operation combines the results of two SELECT statements and returns distinct rows from both result sets.
The columns in the SELECT statements must have the same data types and be in the same order. For example, "SELECT column_name FROM table1 UNION SELECT column_name FROM table2" will return a combined result set with unique values from both tables.
2. UNION ALL: This operation is similar to UNION but returns all rows from both SELECT statements, including duplicates. For example, "SELECT column_name FROM table1 UNION ALL SELECT column_name FROM table2" will return a combined result set with all values from both tables, including duplicates.
3. INTERSECT: This operation returns only the rows that are common to both SELECT statements. For example, "SELECT column_name FROM table1 INTERSECT SELECT column_name FROM table2" will return only the values that exist in both tables.
4. EXCEPT (or MINUS): This operation returns the rows from the first SELECT statement that do not exist in the second SELECT statement. For example, "SELECT column_name FROM table1 EXCEPT SELECT column_name FROM table2" will return the values that exist in table1 but not in table2.
Set operations are useful for combining and comparing data from multiple tables or queries, allowing you to perform complex data analysis and retrieval tasks in SQL.*/

--Set union all simply stacks both the return query results on top of each other and returns all the rows from both queries, including duplicates.
--Intersect and expect automatically remove duplicates from the result set, so they return only distinct rows that satisfy the specified conditions.

--Example of set operations
SELECT column_name FROM table1
UNION
SELECT column_name FROM table2;

SELECT column_name FROM table1
UNION ALL   
SELECT column_name FROM table2;

SELECT column_name FROM table1
INTERSECT
SELECT column_name FROM table2;

SELECT column_name FROM table1
EXCEPT  
SELECT column_name FROM table2;

-- Symbols for such operators are 
--set difference operator (-)
--set intersection operator (∩)
--set union operator (∪)

--Set union r U s == r ∪ s this is called comutative property of set union.order of relation does not matter in set union.
--(r u s) u t == r u (s u t) this is called associative property of set union. we can group the relations in any way in set union.

/*Cartesian product is a mathematical operation that returns all possible combinations of rows from two or more tables.
It is denoted by the symbol (×) and is used in SQL to combine rows from two tables without any specific join condition. For example, if you have two tables,
TableA with 3 rows and TableB with 4 rows, the Cartesian product of these tables will return 12 rows (3 rows from TableA multiplied by 4 rows from TableB).
The result will include every possible combination of rows from both tables, which can be useful for certain types of analysis but can also lead to large result sets if the tables have many rows.*/

/*Assignment Operators are used to assign values to variables or columns in SQL. The most common assignment operator is the equals sign (=), which is used to set a variable or column to a specific value. 
For example, "SET @variable_name = value" will assign the specified value to the variable. In an UPDATE statement, you can use the assignment operator to update the value of a column for specific rows, 
such as "UPDATE table_name SET column_name = new_value WHERE condition". Assignment operators are essential for modifying data in SQL and performing calculations or updates based on specific conditions.*/

--VIEWS
/*A view is a virtual table in SQL that is based on the result of a SELECT query. It does not store data itself but provides a way to access and manipulate data from one or more tables as if it were a single table.
Views are created using the CREATE VIEW statement and can be used to simplify complex queries, enhance security by restricting access to specific columns or rows, and provide a layer of abstraction for users.
For example, you can create a view that combines data from multiple tables to provide a simplified interface for users to query specific information without needing to understand the underlying table structure. 
Once a view is created, you can query it just like a regular table, and it will return the results based on the defined SELECT statement.*/

/*In many cases, modifying data through a view can also modify the actual data in the base tables, provided the view is updatable.
However, some complex views (such as views using GROUP BY, aggregate functions, DISTINCT, or joins) may not allow updates.*/

--Syntax for creating a view
create or replace view view_name as
select column1, column2, ...
from table_name
where condition;

--droping / deleting a view
drop view view_name; -- or
drop view if exists view_name;

--renaming a view
alter view view_name rename to new_view_name;

--Subqueries(also known as nested queries) and scalar sub queries
/*A subquery is a query that is nested inside another query. It allows you to perform a query within a query, enabling you to retrieve data based on the results of another query.
Subqueries can be used in various parts of a SQL statement, such as the SELECT, FROM, WHERE, and HAVING clauses. They can return a single value (scalar subquery) or multiple rows and columns (table subquery).
A row subquery contains one row but can have multiple columns.
A table subquery can return multiple rows and columns, and it is often used in the FROM clause to create a temporary table that can be joined with other tables in the main query.*/
--Example of a scalar subquery:
SELECT employee_name, (SELECT department_name FROM departments WHERE department_id = employees.department_id) AS department
FROM employees;
--Example of a table subquery:
SELECT employee_name, department_name
FROM employees
JOIN (SELECT department_id, department_name FROM departments) AS dept
ON employees.department_id = dept.department_id;
--or
SELECT employee_name, department_name
FROM employees
where department_id in (select department_id from departments where location = 'New York');

--depending on the use instead of in we can also use exists,all,any(for ) or even (= for one value)

--Query Prossing Order
/*The order of query processing in SQL is as follows:
1. FROM clause: The database engine identifies the tables involved in the query and retrieves the data from those tables.
2. WHERE clause: The engine filters the rows based on the specified conditions in the WHERE clause.
3. GROUP BY clause: If there is a GROUP BY clause, the engine groups the rows based on the specified columns.
4. HAVING clause: If there is a HAVING clause, the engine filters the groups based on the specified conditions in the HAVING clause.
5. SELECT clause: The engine processes the SELECT clause to determine which columns to include in the final result set.
6. ORDER BY clause: If there is an ORDER BY clause, the engine sorts the result set based on the specified columns and sort order.
7. LIMIT/OFFSET/FETCH clause: If there is a LIMIT, OFFSET, or FETCH clause, the engine applies these to restrict the number of rows returned in the final result set.
Understanding the order of query processing is important for writing efficient SQL queries and ensuring that the desired results are obtained. It helps in optimizing the query and avoiding unnecessary computations or data retrieval.*/  

--Order = Pursuing and translation -> Optimization -> Execution -> Final result
--where Pursuing and translation is the process of parsing the SQL query and translating it into an internal representation that the database engine can understand.
--Optimization is the process of analyzing the query and determining the most efficient way to execute it, including choosing the appropriate indexes and join strategies.
--Execution is the actual process of running the query and retrieving the data from the database.

--EXPLAIN AND EXPLAIN ANALYZE
/*EXPLAIN is a command in SQL that provides information about how the database engine plans to execute a query. It shows the execution plan, which includes details about the order of operations, the use of indexes, and the estimated cost of each step in the query execution process.
EXPLAIN ANALYZE is an extension of the EXPLAIN command that not only shows the execution plan but also executes the query and provides actual runtime statistics, such as the time taken for each step and the number of rows processed.
This can help in identifying performance bottlenecks and optimizing queries for better performance.*/

--Types of optimization is Cost based optimization and heuristic optimization/Rule Based Optimization.
/*Cost based optimization uses statistics about the data and the query to estimate the cost of different execution plans and choose the most efficient one.
Heuristic optimization uses rules of thumb and predefined strategies to optimize queries without relying on detailed cost estimates.DBMS applies selection and to reduce cost*/

--CORELATED SUBQUERIES
/*A correlated subquery is a type of subquery that references columns from the outer query. It is evaluated once for each row processed by the outer query, making it dependent on the outer query's current row.
For example, if you have a query that retrieves employees and their salaries, and you want to find employees whose salary is greater than the average salary of their department, you can use a correlated subquery to calculate the average salary for each department and compare it to the employee's salary.
Correlated subqueries can be less efficient than non-correlated subqueries because they require the inner query to be executed multiple times, once for each row of the outer query. However, they can be useful for certain types of queries where the inner query needs to reference values from the outer query.*/

--Relational algebra is a theoretical language that provides a set of operations for manipulating and retrieving data from relational databases. It serves as the foundation for SQL and helps in understanding how queries are processed and optimized in a relational database management system (RDBMS).
--Selection (σ), Projection (π), Renaming (ρ), Join (⨝), Union (∪), Intersection (∩), Difference (-), Cartesian product (×) are the basic operations in relational algebra. These operations can be combined to perform complex queries and data manipulations in a relational database.

--WINDOW FUNCTIONS

--Windows functions are a powerful feature in SQL that allow you to perform calculations across a set of rows that are related to the current row. They are often used for tasks such as ranking, running totals, moving averages, and other calculations that require access to multiple rows of data.
/*Window functions operate on a specified window of rows, which can be defined using the OVER() clause. The OVER() clause allows you to specify the partitioning and ordering of the rows within the window.
For example, you can use the ROW_NUMBER() function to assign a unique sequential integer to rows within a partition of a result set, or the RANK() function to assign a rank to each row based on the values in a specified column.
Window functions are different from aggregate functions in that they do not collapse the result set into a single row. Instead, they return a value for each row in the result set, allowing you to perform calculations that depend on the values of other rows without losing the individual row details.*/

-Syntax for window functions
select coulumn1, colunm2 , window_function() over(partition by column3 order by column4 asc) as window result;

--Some window functions include:
1. ROW_NUMBER(): Assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition.
2. RANK(): Assigns a rank to each row within a partition of a result set, with gaps in the ranking for ties. For example, if two rows are tied for first place, they will both receive a rank of 1, and the next rank will be 3.
3. DENSE_RANK(): Similar to RANK(), but without gaps in the ranking for ties. For example, if two rows are tied for first place, they will both receive a rank of 1, and the next rank will be 2.
4. LAG(): Provides access to a row at a specified physical offset that comes before the current row within the partition. For example, LAG(column_name, 1) will return the value of column_name from the previous row.
5. LEAD(): Provides access to a row at a specified physical offset that comes after the current row within the partition. For example, LEAD(column_name, 1) will return the value of column_name from the next row.
6. SUM(), AVG(), COUNT(), MAX(), MIN(): These aggregate functions can also be used as window functions to perform calculations across a set of rows related to the current row. For example, SUM(column_name) OVER (PARTITION BY column3) will return the sum of column_name for each partition defined by column3. 

--Partition by clause is used to divide the result set into partitions to which the window function is applied.

--Syntax for row_number function
select employee_name, department_id, row_number() over(partition by department_id order by salary desc) as rank
from employees;
--Syntax for Rank
select employee_name , department_id, rank() over(partition by department_id order by salary desc) as rank
from employees;
--just replace rank with dense_rank to get dense rank
--Syntax for lag function offset default value is 1 and default value is null by default.
select Employee_name , salary, lag(salary,1) over(partition by department_id order by salary desc) as previous_salary
from employees;
--Syntax for lead function
select Employee_name , salary, lead(salary,1) over(partition by department_id order by salary desc) as next_salary
from employees;

-- now using sum as window function
select department_id, employee_name, salary, sum(salary) over(partition by department_id) as total_salary
from employees;

/*Hashing is a technique used in databases to efficiently retrieve data based on a key value. 
It involves using a hash function to convert the key value into a hash code, which is then used to determine the location of the corresponding data in the database.
hash code is a fixed-size string of characters that is generated from the key value using a hash function. The hash code is used to index the data in the database, allowing for fast retrieval based on the key value.
hash functions are designed to distribute the hash codes uniformly across the available storage space, minimizing collisions (where different key values produce the same hash code) and ensuring efficient data retrieval.
Hashing is commonly used in database indexing and can significantly improve the performance of data retrieval operations, especially when dealing with large datasets. It allows for constant time complexity (O(1)) for lookups, making it an efficient method for accessing data based on key values.*/

/*BUCKET is a storage structure used in databases to organize and manage data based on hash values.
A bucket is a container that holds a group of records that share the same hash value. When a record is inserted into the database, the hash function is applied to the key value to determine the appropriate bucket for storing the record.
Each bucket can contain multiple records, and the records within a bucket are typically stored in a linked list or an array. When a query is executed to retrieve data based on a key value, the hash function is applied to the key value to determine the corresponding bucket, and then the records within that bucket are searched for a match.
Buckets are used in hash-based indexing to improve the efficiency of data retrieval operations. By organizing records into buckets based on their hash values, the database can quickly narrow down the search space and retrieve the desired records more efficiently.
This is particularly beneficial when dealing with large datasets, as it reduces the number of records that need to be scanned during a query.*/

--Collision is a situation that occurs in hashing when two different key values produce the same hash code. This can lead to ambiguity in data retrieval, as the database may not be able to determine which record corresponds to the given key value.
--To handle collisions, databases use various techniques such techniques are chaining, open addressing, quadratic probing, double hashing and static hashing. These techniques help to resolve collisions and ensure that data can be retrieved accurately even when multiple key values produce the same hash code.
/*Chaining is a technique where each bucket in the hash table contains a linked list of records that share the same hash code. When a collision occurs, the new record is added to the linked list for that bucket. During retrieval, the database searches through the linked list to find the matching record.
Open addressing is a technique where, when a collision occurs, the database searches for the next available bucket in the hash table to store the new record. This can be done using linear probing (searching sequentially), quadratic probing (searching with a quadratic function), or double hashing (using a second hash function to determine the next bucket).
Static hashing is a technique where the hash table is divided into a fixed number of buckets, and each bucket can hold a certain number of records. When a collision occurs, the database uses a predefined method to determine how to store the new record, such as using overflow buckets or chaining within the bucket.
Quadratic probing is a technique where, when a collision occurs, the database searches for the next available bucket using a quadratic function. For example, if the initial hash code is h, the database would check buckets at positions h + 1^2, h + 2^2, h + 3^2, and so on until it finds an available bucket.
Double hashing is a technique where, when a collision occurs, the database uses a second hash function to determine the next bucket to check. For example, if the initial hash code is h and the second hash function is g, the database would check buckets at positions h + g(key), h + 2*g(key), h + 3*g(key), and so on until it finds an available bucket.*/

Common Hash functions include:
1. Division method: This method uses the modulus operator to calculate the hash code. For example, hash_code = key_value % table_size.
2. Multiplication method: This method multiplies the key value by a constant and then takes the fractional part to calculate the hash code. For example, hash_code = floor(table_size * (key_value * constant % 1)).
3. Dynamic hashing: This method allows the hash table to grow dynamically as more records are added, using a combination of hashing and directory structures to manage the buckets.
4. Extendible hashing: This method is an extension of dynamic hashing that allows for more efficient handling of collisions and dynamic resizing of the hash table.
5. Linear hashing: This method is a dynamic hashing technique that allows for incremental growth of the hash table and efficient handling of collisions by using a linear probing approach. 


Indexing is a technique used in databases to improve the speed of data retrieval operations. An index is a data structure that provides a fast lookup mechanism for specific columns in a table. It allows the database engine to quickly locate and access the desired rows based on the indexed column values.
Indexes are created on one or more columns of a table and can be used to optimize query performance by reducing the amount of data that needs to be scanned during a query. When a query is executed that includes a condition on an indexed column, 
the database engine can use the index to quickly find the relevant rows, rather than scanning the entire table. Indexes can be created using various types of data structures, such as B-trees, hash tables, or bitmap indexes, 
depending on the specific use case and the database system being used. They can significantly improve query performance, especially for large tables, by allowing for faster data retrieval based on the indexed columns. 
However, it is important to use indexes judiciously, as they can also consume additional storage space and may slow down data modification operations (such as INSERT, UPDATE, DELETE) due to the need to maintain the index.

Types of indexes include:
1. Primary Index: This is an index that is created on the primary key of a table. It ensures that the values in the primary key column are unique and provides fast access to rows based on the primary key.
2. Secondary Index: This is an index that is created on a non-primary key column of a table. It allows for fast access to rows based on the values in the indexed column, even if it is not the primary key.
3. Dynamic Index: This is an index that can grow and shrink dynamically as records are added or removed from the table. It allows for efficient handling of varying data sizes and can adapt to changes in the data distribution.
4. Multi-level Index: This is an index that is organized in multiple levels, with each level containing pointers to the next level. It allows for efficient searching and retrieval of data by reducing the number of comparisons needed to find a specific value.

Query optimization is the process of improving the performance of a SQL query by analyzing and modifying the query execution plan. The goal of query optimization is to minimize the time and resources required to execute a query while still producing the correct results.
Query optimization involves several steps, including:
1. Parsing: The SQL query is parsed to check for syntax errors and to create an internal representation of the query.
2. Logical Optimization: The query is analyzed to identify opportunities for optimization, such as reordering joins, eliminating redundant operations, and simplifying expressions.
3. Physical Optimization: The query execution plan is generated based on the logical optimization, and the database engine selects the most efficient plan for executing the query.
4. Execution: The optimized query execution plan is executed, and the results are returned to the user.
Query optimization is crucial for improving the performance of SQL queries, especially when dealing with large datasets or complex queries. It helps to reduce the execution time and resource usage, making the database more efficient and responsive. Database management systems (DBMS) often have built-in query optimizers that automatically analyze and optimize queries to ensure optimal performance.

It follows equivalence rules such as commutative, associative, distributive, and idempotent properties to optimize queries.
Cost Based Optimization (CBO) uses statistics about the data and the query to estimate the cost of different execution plans and choose the most efficient one. Heuristic Optimization (Rule-Based Optimization) uses rules of thumb and predefined strategies to optimize queries without relying on detailed cost estimates. DBMS applies selection and projection to reduce cost.

