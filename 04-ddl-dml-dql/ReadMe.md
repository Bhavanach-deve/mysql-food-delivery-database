
# Day 4 - SQL CRUD Operations

## What is CRUD?

CRUD represents the four basic operations performed on database records.

| Operation | Meaning | SQL Command |
|---|---|---|
| C | Create | INSERT |
| R | Read | SELECT |
| U | Update | UPDATE |
| D | Delete | DELETE |

## 1. INSERT

Adds new records to a table.

Example:

INSERT INTO customers (customer_id, customer_name, city)
VALUES (7, 'Sneha', 'Hyderabad');

## 2. SELECT

Retrieves records from a table.

Example:

SELECT * FROM customers;

## 3. UPDATE

Modifies existing records.

Example:

UPDATE customers
SET city = 'Chennai'
WHERE customer_id = 7;

## 4. DELETE

Removes records from a table.

Example:

DELETE FROM customers
WHERE customer_id = 7;

## Important: WHERE Clause

The WHERE clause specifies which records should be affected.

Without WHERE:
- UPDATE modifies all rows.
- DELETE removes all rows.

Always verify the target records before executing UPDATE or DELETE.

## Backend Development Connection

CRUD operations are the foundation of database operations in backend applications.

They are commonly exposed through REST API operations:

| REST API | Typical database operation |
|---|---|
| POST | INSERT |
| GET | SELECT |
| PUT/PATCH | UPDATE |
| DELETE | DELETE |
