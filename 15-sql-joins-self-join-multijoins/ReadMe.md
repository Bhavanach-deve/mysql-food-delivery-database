## Day 15 — SELF JOIN and Multiple-table JOINs

### What I Learned

**SELF JOIN**
- A SELF JOIN joins a table with itself.
- It is useful for hierarchical relationships such as employees and managers.
- It is not a separate SQL keyword.
- We use aliases to represent the same table in different roles.
- SELF JOIN can use INNER JOIN or LEFT JOIN depending on the requirement.

**Multiple-table JOIN**
- Combines information from three or more tables.
- Each JOIN needs an appropriate matching condition.
- The JOIN type depends on the business requirement.
- INNER JOIN removes records without a match.
- LEFT JOIN preserves all rows from the left-side result.

### SELF JOIN Example

```sql
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM practice_employees e
LEFT JOIN practice_employees m
    ON e.manager_id = m.employee_id;
```

### Multiple-table JOIN Example

```sql
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status
FROM practice_customers c
INNER JOIN practice_orders o
    ON c.customer_id = o.customer_id
INNER JOIN practice_payments p
    ON o.order_id = p.order_id;
```

### Practical Exercises
1. Display employees with their managers.
2. Find employees reporting to a particular manager.
3. Retrieve customers, orders, and payments.
4. Compare INNER JOIN and LEFT JOIN across multiple tables.
5. Filter multi-table JOIN results using WHERE.

### Key Takeaways
- SELF JOIN compares rows within the same table.
- Aliases help distinguish different roles of the same table.
- Multiple-table JOINs retrieve related information from several tables.
- Every JOIN must have a meaningful matching condition.
