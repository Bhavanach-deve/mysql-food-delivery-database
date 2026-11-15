# Day 17 – SQL GROUP BY and HAVING

## Overview

Day 17 focuses on SQL `GROUP BY` and `HAVING` clauses.

These clauses are used with aggregate functions to group records, calculate separate summaries, and filter grouped results.

They are important for generating reports and analyzing business data.

## Topics Covered

- Introduction to `GROUP BY`
- Grouping records using one column
- Using aggregate functions with `GROUP BY`
- `COUNT()` with `GROUP BY`
- `SUM()` with `GROUP BY`
- `AVG()` with `GROUP BY`
- `MIN()` and `MAX()` with `GROUP BY`
- Grouping records using multiple columns
- Introduction to `HAVING`
- Filtering groups using aggregate conditions
- Difference between `WHERE` and `HAVING`
- Combining `WHERE`, `GROUP BY`, `HAVING`, and `ORDER BY`
- Logical SQL query processing order

## 1. GROUP BY

`GROUP BY` groups rows that have the same values in specified columns.

It is commonly used with aggregate functions to calculate summaries for each group.

### Example: Count orders placed by each customer

```sql
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id;
```

### Example: Calculate total spending per customer

```sql
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM practice_orders
GROUP BY customer_id;
```

## 2. GROUP BY with Multiple Aggregate Functions

Multiple aggregate functions can be used in a single query.

```sql
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_spent,
    AVG(amount) AS average_order_amount,
    MIN(amount) AS minimum_order,
    MAX(amount) AS maximum_order
FROM practice_orders
GROUP BY customer_id;
```

## 3. GROUP BY with Multiple Columns

Records can be grouped using more than one column.

```sql
SELECT
    customer_id,
    order_status,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id, order_status;
```

Rows are grouped based on the combination of both columns.

## 4. HAVING

`HAVING` filters groups after they have been created using `GROUP BY`.

### Example: Customers whose total spending exceeds 500

```sql
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM practice_orders
GROUP BY customer_id
HAVING SUM(amount) > 500;
```

### Example: Customers who placed more than one order

```sql
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM practice_orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

## 5. WHERE vs HAVING

| WHERE | HAVING |
|---|---|
| Filters individual rows | Filters groups |
| Applied before GROUP BY | Applied after GROUP BY |
| Filters source records | Filters aggregated results |
| Cannot directly use aggregate functions in its condition | Can use aggregate functions in its condition |

### Example: Combining WHERE and HAVING

```sql
SELECT
    customer_id,
    SUM(amount) AS delivered_total
FROM practice_orders
WHERE order_status = 'DELIVERED'
GROUP BY customer_id
HAVING SUM(amount) > 400;
```

This query:

1. Filters only delivered orders using `WHERE`.
2. Groups the remaining records by customer.
3. Calculates the total amount for each customer.
4. Retains groups with a total greater than 400 using `HAVING`.

## 6. Logical SQL Query Processing Order

A simplified logical processing order is:

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

Understanding this order helps explain why aggregate conditions belong in `HAVING`, not `WHERE`.

## 7. Food Delivery Database Use Cases

`GROUP BY` and `HAVING` are useful for business questions such as:

- How many orders has each customer placed?
- What is the total spending of each customer?
- Which customers have placed more than one order?
- What is the total order amount for each status?
- Which order statuses have more than a specified number of orders?
- Which customers have spent more than a specified amount?
- What is the average order value for each customer?

## Key Takeaways

- `GROUP BY` creates groups of records with matching values.
- Aggregate functions calculate separate summaries for each group.
- Multiple aggregate functions can be used with the same `GROUP BY`.
- Multiple columns can be used for grouping.
- `HAVING` filters grouped results.
- `WHERE` filters individual rows before grouping.
- `HAVING` is commonly used to filter aggregate calculations.
- `ORDER BY` can sort grouped results.
