## Day 14 — RIGHT JOIN and FULL OUTER JOIN

### What I Learned
- RIGHT JOIN preserves every row from the right table.
- Unmatched left-table columns contain NULL.
- FULL OUTER JOIN preserves all matching and non-matching rows from both tables.
- MySQL does not directly support FULL OUTER JOIN.
- FULL OUTER JOIN can be simulated using LEFT JOIN, RIGHT JOIN, and UNION ALL.
- UNION removes duplicate result rows, whereas UNION ALL preserves them.

### RIGHT JOIN Example
```sql
SELECT c.customer_name, o.order_id
FROM right_join_customers_demo c
RIGHT JOIN right_join_orders_demo o
    ON c.customer_id = o.customer_id;
```

### FULL OUTER JOIN Simulation in MySQL
```sql
SELECT c.customer_id, c.customer_name, o.order_id
FROM right_join_customers_demo c
LEFT JOIN right_join_orders_demo o
    ON c.customer_id = o.customer_id

UNION ALL

SELECT c.customer_id, c.customer_name, o.order_id
FROM right_join_customers_demo c
RIGHT JOIN right_join_orders_demo o
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;
```
