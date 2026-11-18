# Day 20 – Correlated Subqueries in MySQL

## Objective
Learn how correlated subqueries work in MySQL and understand how to use them to solve real-world database problems.

## Topics Covered

- Introduction to correlated subqueries
- Difference between correlated and non-correlated subqueries
- EXISTS operator
- NOT EXISTS operator
- Using aggregate functions inside correlated subqueries
- Outer query and inner query relationships
- Real-world SQL interview challenges

## Key Concepts

### 1. Correlated Subquery

A correlated subquery is a subquery that references a column from the outer query.

Unlike a regular subquery, it depends on the outer query for its values.

### 2. EXISTS

EXISTS checks whether the subquery returns at least one row.

Example:

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

### 3. NOT EXISTS

NOT EXISTS checks whether the subquery returns zero rows.

Example:

```sql
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

### 4. Aggregate Functions in Correlated Subqueries

Aggregate functions such as SUM(), COUNT(), AVG(), MIN(), and MAX() can be used inside correlated subqueries.

Example:

```sql
SELECT c.customer_id
FROM customers c
WHERE (
    SELECT SUM(o.total_amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > 1000;
```

