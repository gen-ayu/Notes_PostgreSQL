-- DATA vs INFORMATION
-- Data: raw facts (numbers, text)
-- Information: processed data, meaningful

-- TYPES OF DATA
-- Structured: organized (tables, rows/columns), easy to query
-- Unstructured: no format (images, videos, text)
-- Semi-structured: partial structure (XML, JSON, emails)

-- KEY TERMS
-- Redundancy: duplicate data
-- Inconsistency: conflicting data versions
-- Data Integrity: accuracy + consistency
-- Security: protection from unauthorized access

-- TYPES OF DBMS
-- Hierarchical: tree structure (1:M), rigid
-- Network: multiple links (M:N), complex
-- Relational: tables + SQL, widely used
-- Object-Oriented: objects (data + methods)
-- NoSQL: flexible schema, big/unstructured data
-- (types: key-value, document, column, graph)

--syntax to create a database
CREATE DATABASE database_name;

-- DATABASE BASICS
-- Database: collection of related data
-- DB Engine: software managing DB (MySQL, PostgreSQL, Oracle)

-- CORE COMPONENTS
-- Data Dictionary: metadata (tables, columns, types, constraints)
-- Query Processor: parses, optimizes, executes SQL
-- Transaction Manager: ensures ACID (Atomicity, Consistency, Isolation, Durability)
-- Concurrency Control: manages multi-user access, avoids conflicts
-- Backup & Recovery: restores DB, ensures reliability

-- ROLE
-- DBA: manages design, security, maintenance, performance

--DBMS Architecture:
--1-Tier: all components on one machine (simple, limited)
--2-Tier: client-server (client app + DB server)
--3-Tier: client, application server, DB server (scalable, secure)

--3 Levels of Architecture:
--Presentation: user interface
--Application: business logic, processes requests
--Database: storage, retrieval, management

--3Level Schema Architecture:
--External: user views (customized)highest level, how users see data
--Conceptual: overall logical structure (entities, relationships) middle level
--Internal: physical storage (files, indexes) lowest level, how data is stored on disk

--Data Independence:(Change a t one layer without affecting others)
-- Logical: changes in conceptual schema don't affect external views
-- Physical: changes in internal schema don't affect conceptual schema

--Database Schema a blueprint of the database structure, defines tables, columns, data types, relationships, constraints
--Datatypes Examples: INT, VARCHAR, DATE, FLOAT, BOOLEAN, DECIMAL, TEXT, DATE, TIME, TIMESTAMP, CHAR, REAL, DOUBLE PRECISION, NUMERIC, BIG/SMALL INT ETC.

create table table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
    columnN datatype constraints
);

insert into table_name (column1, column2, ..., columnN) values (value1, value2, ..., valueN);
insert into table_name VALUES (value1, value2, ..., valueN);
insert into table_name (column1, column2) select column1, column2 from another_table where condition/ order by etc;

select * from table_name;
select column1, column2 from table_name where condition order by column1 etc;

-- GENERALIZATION (Bottom-up)
-- Combine multiple similar entities into one higher-level entity (supertype)
-- Common attributes are moved to supertype
-- Original entities become subtypes

-- Example:
-- Car, Bike → Vehicle
-- (Vehicle has common attrs: id, speed; Car/Bike have specific attrs)

-- SPECIALIZATION (Top-down)
-- Start with one general entity and divide into subtypes
-- Subtypes have additional specific attributes

-- Example:
-- Employee → Manager, Developer
-- (Employee has common attrs; Manager/Developer add extra fields)

--ER Models (Physical design)
--Entity: real-world object (Person, Product) represented as rectangle
--Attribute: property of an entity (name, age) represented as oval can be simple (single value) or composite (multiple values)
--Derived attribute: can be calculated from other attributes (age from birthdate) represented as dashed oval
--Relationship: association between entities (works_for) represented as diamond can have cardinality (1:1, 1:M, M:N)
--Single Value Attribute: holds one value (e.g., age)
--Multi Value Attribute: can hold multiple values (e.g., phone numbers) represented as double oval
--Entity Set: collection of similar entities (all employees)
--Relationship Set: collection of similar relationships (all works_for relationships)

--All the Keys:(Primary, Candidate, Alternate, Foreign, Composite, Surrogate, Super and Secondary keys)
--Primary Key: unique identifier for a table (e.g., employee_id)
--Candidate Key: potential primary keys (e.g., email, ssn)
--Alternate Key: candidate keys not chosen as primary (e.g., email if employee_id is primary)
--Foreign Key: attribute in one table that references primary key in another (e.g., department_id in Employee referencing Department)
--Composite Key: primary key made of multiple attributes (e.g., order_id + product_id in OrderDetails)
--Surrogate Key: system-generated unique identifier (e.g., auto-increment id)
--Super Key: set of attributes that can uniquely identify a record (e.g., employee_id + email)
--Secondary Key: non-primary key used for indexing may not be unique  (e.g., last_name in Employee for faster search)

--Key Constraints:
--Uniqueness: primary key must be unique
-- CASCADE
-- If parent row is deleted/updated → child rows also deleted/updated
-- Keeps data fully synchronized

-- RESTRICT
-- Prevents delete/update if child rows exist
-- Immediate check → operation fails

-- NO ACTION
-- Same as RESTRICT (in PostgreSQL)
-- Checked at end of statement/transaction

-- SET NULL
-- Sets foreign key in child table to NULL
-- Only works if column allows NULL

-- SET DEFAULT
-- Sets foreign key to its DEFAULT value
-- Default must exist and be valid

--Strong and weak entities:
--Strong Entity: has a primary key, can exist independently (e.g., Employee)
--Weak Entity: no primary key, depends on strong entity (e.g., Dependent relies on Employee) represented with double rectangle

--Relational and non relational databases:
--Relational: structured data, tables, SQL (e.g., MySQL, PostgreSQL)
--Non-relational: unstructured/semi-structured data, flexible schema (e.g., MongoDB, Cassandra)
