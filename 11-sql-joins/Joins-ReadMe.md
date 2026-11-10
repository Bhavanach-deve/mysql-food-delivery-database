# Day 11 – SQL JOIN Fundamentals

## Overview

SQL JOIN is used to retrieve related information from two or more tables based on a matching condition.

In a relational database, information is usually separated into multiple tables. JOIN allows us to combine that information when querying the database.

## Why Do We Need JOINs?

In our food delivery database:

- Customer details are stored in the `customers` table.
- Order details are stored in the `orders` table.
- Payment details are stored in the `payments` table.

If we want to display a customer's name along with their order ID, we need information from both customers and orders.

JOIN helps us retrieve that information together.

## Basic JOIN Syntax

```sql
SELECT columns
FROM table1
JOIN table2
ON table1.common_column = table2.common_column;
```

### Important Keywords

- `SELECT`: Specifies the columns to retrieve.
- `FROM`: Specifies the first table.
- `JOIN`: Combines rows from another table.
- `ON`: Specifies the matching condition.

## INNER JOIN

INNER JOIN returns only the rows that have matching values in both tables according to the join condition.

Example:

```sql
SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM practice_customers c
INNER JOIN practice_orders o
    ON c.customer_id = o.customer_id;
```

### Important Points

- Only matching rows are returned.
- Customers without orders are excluded.
- A customer can appear multiple times if they have multiple orders.
- In MySQL, `JOIN` without a type means `INNER JOIN`.

## Table Aliases

Aliases make SQL queries shorter and easier to read.

Example:

```sql
FROM practice_customers c
INNER JOIN practice_orders o
```

Here:
- `c` represents `practice_customers`.
- `o` represents `practice_orders`.

## Combining JOIN with Other SQL Clauses

JOIN can be combined with:

- `WHERE` to filter matching rows.
- `ORDER BY` to sort the results.
- `GROUP BY` to group matching records.
- Aggregate functions such as `COUNT()` and `SUM()`.

## JOIN and Foreign Keys

A foreign key establishes a relationship between tables.

A JOIN uses a condition to retrieve related information.

Example relationship:

```text
practice_customers.customer_id
                |
                v
practice_orders.customer_id
```

The foreign key connects the tables, while the JOIN retrieves their related data.

## Practice Questions

1. Display customer names and their order IDs.
2. Display customer names, order IDs and order amounts.
3. Display only Ananya's orders.
4. Sort orders from highest amount to lowest amount.
5. Find customers who have placed orders worth more than 400.
6. Count the matching order rows for each customer.

## Concepts Learned

- SQL JOIN
- Why JOINs are needed
- INNER JOIN
- JOIN syntax
- ON condition
- Table aliases
- JOIN with WHERE
- JOIN with ORDER BY
- Joining multiple tables conceptually
- JOIN versus foreign-key relationships

## Learning Outcome

Learned how to combine related information from multiple tables using INNER JOIN, identify matching records using the ON condition, and write practical queries using table aliases and filtering.

**Next Topic:** INNER JOIN practice and understanding LEFT JOIN.