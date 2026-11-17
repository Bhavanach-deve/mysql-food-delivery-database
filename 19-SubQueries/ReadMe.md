"""# Day 19 – Subqueries Fundamentals

## Learning objectives

- Understand what a subquery is and why it is used.
- Identify the inner query (subquery) and the outer query (main query).
- Understand scalar subqueries that return a single value.
- Understand non-correlated subqueries.
- Use `IN` with a subquery.
- Use a derived table in the `FROM` clause.
- Combine subqueries with `WHERE`, `GROUP BY`, and `HAVING`.

## What is a subquery?

A **subquery** is a SQL query written inside another SQL query.

- **Inner query / subquery:** runs to produce a result used by the outer query.
- **Outer query / main query:** uses the result returned by the inner query.

Example:

```sql
SELECT *
FROM practice_orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM practice_orders
);
```

The inner query calculates the average order amount. The outer query returns orders whose amount is greater than that average.

## Important concepts

### 1. Scalar subquery

A scalar subquery returns exactly one value, such as:

- `AVG(total_amount)`
- `MAX(total_amount)`
- `MIN(total_amount)`
- `COUNT(*)`

It can be used with comparison operators such as `=`, `>`, and `<`, when the returned value is appropriate for that comparison.

### 2. Non-correlated subquery

A non-correlated subquery does not refer to columns from the outer query. It can execute independently of the outer query.

### 3. `IN` with a subquery

`IN` checks whether a value matches any value in the set returned by the subquery.

```sql
SELECT *
FROM practice_customers
WHERE customer_id IN (
    SELECT customer_id
    FROM practice_orders
);
```

This returns customers whose IDs appear in the orders table.

### 4. Derived table

A subquery in the `FROM` clause acts as a temporary result set (derived table). It must have an alias in MySQL.

For Day 19, the derived table calculates each customer's spending first. The outer aggregate then calculates the average of those customer-level totals.

## Practice dataset

The SQL script creates two practice tables:

- `practice_customers`: customer details.
- `practice_orders`: order details, status, and amount.

| Order ID | Customer ID | Status | Amount |
|---:|---:|---|---:|
| 101 | 1 | DELIVERED | 450.00 |
| 102 | 1 | DELIVERED | 650.00 |
| 103 | 2 | CANCELLED | 300.00 |
| 104 | 3 | DELIVERED | 800.00 |
| 105 | 4 | PENDING | 250.00 |
| 106 | 4 | DELIVERED | 550.00 |
| 107 | 5 | FAILED | 200.00 |

## Practice questions covered

1. Find orders with an amount greater than the average order amount.
2. Find the order(s) with the minimum order amount.
3. Find customers who have placed at least one order.
4. Find orders whose amount is greater than the highest order amount placed by customer 1.
5. Find customers whose total spending is greater than the average total spending per customer.

All five solutions are included in `subqueries-fundamentals.sql`.

## Key distinction: average order amount vs. average customer spending

These are different calculations:

- **Average order amount:** average of every row in the orders table.
- **Average customer spending:** first add all orders for each customer, then average those customer totals.

For Question 5, the second calculation is required. Grouping by customer before calculating the average is essential.

## Day 19 summary

- A subquery is a query inside another query.
- A scalar subquery returns one value.
- A non-correlated subquery is independent of the outer query.
- `IN` checks membership in a set of returned values.
- A derived table is a subquery in the `FROM` clause.
- Use `HAVING` to filter grouped customer totals.
