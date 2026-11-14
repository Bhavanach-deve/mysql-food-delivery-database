# Day 16 – SQL Aggregate Functions

## Overview

Day 16 focuses on SQL Aggregate Functions, which perform calculations on multiple rows and return summary values.

Aggregate functions are commonly used in reporting, data analysis, and business applications to calculate totals, averages, counts, minimum values, and maximum values.

## Topics Covered

- Introduction to Aggregate Functions
- `COUNT()`
- `COUNT(*)` vs `COUNT(column_name)`
- `COUNT(DISTINCT column_name)`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- Handling NULL values in aggregate functions
- Using multiple aggregate functions in one SELECT statement
- Aggregate Functions with `WHERE`
- Scalar Functions vs Aggregate Functions
- Aggregate Functions without `GROUP BY`

## Aggregate Functions

| Function | Description |
|---|---|
| `COUNT()` | Counts rows or non-NULL values |
| `SUM()` | Calculates the total of numeric values |
| `AVG()` | Calculates the average of numeric values |
| `MIN()` | Returns the smallest value |
| `MAX()` | Returns the largest value |

## Practical Examples

The following examples use the `practice_orders` table from the food delivery database.

### 1. Count all orders

```sql
SELECT COUNT(*) AS total_orders
FROM practice_orders;
```

### 2. Count unique customers

```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM practice_orders;
```

### 3. Calculate total order amount

```sql
SELECT SUM(amount) AS total_order_amount
FROM practice_orders;
```

### 4. Calculate average order amount

```sql
SELECT AVG(amount) AS average_order_amount
FROM practice_orders;
```

### 5. Find minimum and maximum order amounts

```sql
SELECT
    MIN(amount) AS minimum_order,
    MAX(amount) AS maximum_order
FROM practice_orders;
```

### 6. Use multiple aggregate functions together

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_order_value,
    MIN(amount) AS minimum_order,
    MAX(amount) AS maximum_order
FROM practice_orders;
```

## Important Concepts

### COUNT(*) vs COUNT(column_name)

- `COUNT(*)` counts all rows, including rows containing NULL values.
- `COUNT(column_name)` counts only non-NULL values in that column.
- `COUNT(DISTINCT column_name)` counts unique, non-NULL values.

### NULL Handling

- `COUNT(*)` includes every row.
- `COUNT(column_name)` ignores NULL values.
- `SUM()`, `AVG()`, `MIN()`, and `MAX()` ignore NULL values.
- If there are no non-NULL values to aggregate, these four functions return NULL.

### Scalar Functions vs Aggregate Functions

| Scalar Functions | Aggregate Functions |
|---|---|
| Operate on individual values | Operate on a set of rows |
| Usually return one result per input row | Return a summary result per group |
| Examples: `UPPER()`, `LENGTH()`, `ROUND()` | Examples: `COUNT()`, `SUM()`, `AVG()` |

## Food Delivery Database Use Cases

Aggregate functions help answer business questions such as:

- How many orders have been placed?
- What is the total order revenue?
- What is the average order value?
- What is the highest-value order?
- What is the lowest-value order?
- How many unique customers have placed orders?

## Key Takeaways

- Aggregate functions summarize data from multiple rows.
- `COUNT(*)` and `COUNT(column_name)` behave differently when NULL values are present.
- `COUNT(DISTINCT)` helps count unique values.
- Aggregate functions can be combined in a single SELECT statement.
- Without `GROUP BY`, aggregate functions calculate an overall summary for the matching result set.
- `WHERE` can filter rows before aggregate calculations are performed.

