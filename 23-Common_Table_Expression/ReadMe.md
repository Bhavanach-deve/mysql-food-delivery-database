
# Day 23 - Common Table Expressions (CTEs)

## Overview

Day 23 focuses on Common Table Expressions (CTEs) in MySQL.

A CTE is a temporary named result set defined using the WITH clause. It helps divide complex SQL queries into smaller, readable, and reusable logical sections within a single SQL statement.

## Learning Objectives

- Understand Common Table Expressions.
- Learn the WITH clause.
- Create and use single CTEs.
- Work with multiple CTEs.
- Reference previously defined CTEs.
- Combine CTEs with GROUP BY and aggregate functions.
- Join CTEs with database tables.
- Use CTEs with EXISTS and NOT EXISTS.
- Compare CTEs, subqueries, temporary tables, and views.
- Build reporting queries using CTEs.

## Topics Covered

### 1. CTE Fundamentals

- CTE definition and purpose
- WITH clause syntax
- CTE scope
- CTE versus subquery

### 2. Multiple CTEs

- Defining multiple CTEs
- Separating CTEs using commas
- Referencing earlier CTEs
- Combining multiple CTEs using JOIN

### 3. CTEs with SQL Operations

- WHERE
- GROUP BY
- HAVING
- COUNT()
- SUM()
- AVG()
- LEFT JOIN
- CROSS JOIN
- EXISTS
- NOT EXISTS

### 4. Practical SQL Challenges

- Finding high-value orders
- Calculating customer spending
- Calculating restaurant revenue
- Finding frequent customers
- Finding customers without orders
- Comparing product prices with average prices
- Generating restaurant performance reports

## Key Concepts

| Concept | Description |
|---|---|
| CTE | Temporary named result set |
| WITH | Starts a CTE definition |
| Multiple CTEs | Multiple named result sets in one WITH clause |
| CTE scope | Limited to one SQL statement |
| Recursive CTE | CTE that can refer to itself |
| View | Persistently saved query definition |
| Temporary table | Temporary database table that can be reused across statements in its session |

## Important SQL Syntax

```sql
WITH cte_name AS (
    SELECT column_name
    FROM table_name
)
SELECT *
FROM cte_name;
```

### Multiple CTEs

```sql
WITH first_cte AS (
    SELECT ...
),
second_cte AS (
    SELECT ...
    FROM first_cte
)
SELECT *
FROM second_cte;
```

