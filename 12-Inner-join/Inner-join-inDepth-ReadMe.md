# Day 12 – INNER JOIN in Depth

## Overview

INNER JOIN retrieves rows that have matching values in both tables based on the specified join condition.

This lesson explores more advanced INNER JOIN queries using our food delivery database.

## Topics Covered

### 1. INNER JOIN with Different Columns

A JOIN does not always need a primary-key and foreign-key comparison.

Tables can be joined using other suitable matching columns.

Example:

```sql
SELECT
    c.customer_name,
    r.restaurant_name
FROM customers c
INNER JOIN restaurants r
    ON c.city = r.city;
```

### 2. INNER JOIN with Multiple Conditions

Multiple conditions can be included in the ON clause.

Example:

```sql
SELECT
    o.order_id,
    p.payment_status
FROM orders o
INNER JOIN payments p
    ON o.order_id = p.order_id
    AND o.status = 'DELIVERED'
    AND p.payment_status = 'SUCCESS';
```

### 3. INNER JOIN with WHERE

WHERE filters the rows after the matching operation in the logical query-processing model.

Example:

```sql
SELECT
    c.customer_name,
    o.order_id,
    o.amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.amount > 400;
```

### 4. INNER JOIN with DISTINCT

DISTINCT removes duplicate rows from the selected result.

Example:

```sql
SELECT DISTINCT c.customer_name
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
```

### 5. Joining Three Tables

Multiple INNER JOIN operations can be used to retrieve information from three or more related tables.

Example:

```sql
SELECT
    c.customer_name,
    o.order_id,
    p.amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN payments p
    ON o.order_id = p.order_id;
```

### 6. SQL Logical Query Processing Order

A simplified logical order:

1. FROM
2. ON / JOIN
3. WHERE
4. GROUP BY
5. HAVING
6. SELECT
7. DISTINCT
8. ORDER BY
9. LIMIT

The database optimizer may execute operations differently internally.

## Important Concepts Learned

- INNER JOIN with different columns
- Multiple conditions in ON
- JOIN with WHERE
- JOIN with ORDER BY
- JOIN with DISTINCT
- Three-table JOIN
- SQL logical query-processing order
- Matching row combinations

## Practice Questions

1. Display customer names and order IDs.
2. Display customer names, order IDs and amounts in descending order.
3. Display only Ananya's orders.
4. Display customer names who have placed orders greater than 400.
5. Display unique customer names who have placed orders.
6. Display successfully paid and delivered orders using multiple ON conditions.
7. Display customer names, order IDs and payment methods by joining three tables.
8. Display customers with successful payment amounts above 400.

## Learning Outcome

Learned how to construct more advanced INNER JOIN queries, combine multiple conditions, retrieve information from three tables, and use filtering and sorting with JOIN operations.

**Next Topic:** LEFT JOIN – Retrieving all records from the left table, including unmatched records.