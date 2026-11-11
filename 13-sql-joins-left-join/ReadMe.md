## Day 13 — LEFT JOIN

### What I Learned
- LEFT JOIN returns all rows from the left table and matching rows from the right table.
- When no matching right-table record exists, its columns contain NULL.
- LEFT JOIN is useful when we need to preserve records even when related data is missing.
- We can use multiple LEFT JOINs to retrieve related information from multiple tables.
- `LEFT JOIN ... WHERE right_table.primary_key IS NULL` helps identify unmatched records (anti-join).
- Conditions inside ON and WHERE can produce different results with LEFT JOIN.

### Important SQL Concepts

**1. LEFT JOIN syntax**
```sql
SELECT columns
FROM table1
LEFT JOIN table2
    ON table1.id = table2.id;
```

**2. Find customers without orders**
```sql
SELECT c.customer_name
FROM practice_customers c
LEFT JOIN practice_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

**3. ON vs WHERE**
- ON determines which rows match during the join.
- WHERE filters the resulting rows.
- A right-table condition in WHERE can remove unmatched rows from a LEFT JOIN result.

### Practical Exercises
1. Retrieve all customers and their orders.
2. Find customers who have never placed an order.
3. Retrieve all orders and their payment statuses.
4. Join customers, orders, and payments using LEFT JOIN.
5. Compare filtering successful payments in ON versus WHERE.
6. Find customers without any matching payment.

### Key Takeaway
LEFT JOIN preserves every row from the left table, even when no matching record exists in the right table. Missing right-side values are represented by NULL.
