# Day 18 — Advanced GROUP BY and HAVING

## Overview
Practiced advanced SQL grouping and aggregation using a food delivery database.

## Topics Covered
- GROUP BY with multiple columns
- GROUP BY with multiple aggregate functions
- Combining WHERE, GROUP BY and HAVING
- Filtering groups using aggregate conditions
- Sorting aggregated results using ORDER BY
- Returning top results using LIMIT

## Key Concepts

### 1. GROUP BY multiple columns
Groups rows by each unique combination of the selected columns.

```sql
SELECT customer_id, order_status, COUNT(*) AS total_orders
FROM order_Status
GROUP BY customer_id, order_status;
```

### 2. Multiple aggregate functions
Multiple aggregate functions can be used in the same grouped query.

```sql
SELECT customer_id,
       COUNT(*) AS total_orders,
       SUM(total_amount) AS total_spending,
       AVG(total_amount) AS average_order_amount
FROM orders
GROUP BY customer_id;
```

### 3. WHERE and HAVING together
- WHERE filters individual records before grouping.
- GROUP BY creates groups.
- HAVING filters groups after aggregation.

```sql
SELECT customer_id,
       SUM(total_amount) AS delivered_spending
FROM orders
WHERE order_status = 'Delivered'
GROUP BY customer_id
HAVING SUM(total_amount) > 500;
```

### 4. Finding the highest-revenue order status

```sql
SELECT order_status,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_status
ORDER BY total_revenue DESC
LIMIT 1;
```

## Logical Query Processing Order

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

## Important Interview Points
- Grouping by multiple columns creates a group for each unique combination.
- Use HAVING to filter aggregate results.
- Use SUM to calculate total revenue.
- Use MAX to find the highest individual value.
- Use ORDER BY DESC with LIMIT 1 to retrieve the highest result.

