# Day 26 – SQL Views

## Overview

Day 26 focuses on SQL Views in MySQL.

A View is a virtual table created using a SQL query. It allows us to reuse queries, simplify complex SQL statements, combine multiple tables, and expose selected information.

A regular MySQL view stores the query definition rather than a separate copy of the result data.

## Topics Covered

- What is a SQL View?
- `CREATE VIEW`
- Selecting data from a View
- Views using JOIN
- Views using Aggregate Functions
- `CREATE OR REPLACE VIEW`
- `ALTER VIEW`
- Updating data through Views
- Updatable and Non-updatable Views
- `WITH CHECK OPTION`
- `DROP VIEW`
- `DROP VIEW IF EXISTS`

## 1. What is a View?

A View is a virtual table based on the result of a SQL query.

Example:

```sql
CREATE VIEW completed_orders AS
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE status = 'COMPLETED';
```

Retrieve the view:

```sql
SELECT * FROM completed_orders;
```

### Table vs View

| Feature | Table | View |
|---|---|---|
| Stores actual data | Yes | Normally stores query definition |
| Based on | Table structure | SQL query |
| Can combine tables | Through queries | Yes |
| Can use aggregate functions | Through queries | Yes |
| Can be updated | Yes, subject to constraints | Only if updatable |

## 2. Why Do We Use Views?

1. **Reusability:** Avoid repeatedly writing the same SQL query.
2. **Simplicity:** Hide complex JOINs and calculations.
3. **Data access control:** Expose only selected columns or rows.
4. **Maintainability:** Reuse query definitions across reports and applications.

Views can help limit exposed data, but proper database permissions and application authorization are still necessary.

## 3. Views Using JOIN

Views can combine information from multiple tables.

Example:

```sql
CREATE VIEW customer_order_details AS
SELECT
    o.order_id,
    c.customer_name,
    o.total_amount,
    o.status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
```

## 4. Views Using Aggregate Functions

Views can contain aggregate functions such as `SUM()` and `COUNT()`.

Example:

```sql
CREATE VIEW restaurant_revenue AS
SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'COMPLETED'
GROUP BY restaurant_id;
```

## 5. Modifying a View

Use `CREATE OR REPLACE VIEW` to replace an existing view definition.

```sql
CREATE OR REPLACE VIEW completed_orders AS
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE status = 'COMPLETED'
  AND total_amount > 500;
```

Another option is `ALTER VIEW`.

## 6. Updating Data Through a View

Some views are updatable.

Example:

```sql
CREATE VIEW customer_basic_details AS
SELECT
    customer_id,
    customer_name,
    city
FROM customers;
```

Update through the view:

```sql
UPDATE customer_basic_details
SET city = 'Hyderabad'
WHERE customer_id = 1;
```

This updates the corresponding record in the original `customers` table.

### Important: Not Every View Is Updatable

Views containing certain constructs such as the following are generally not updatable in MySQL:

- `GROUP BY`
- Aggregate functions
- `DISTINCT`
- `UNION`

For example, a revenue summary view using `SUM()` and `GROUP BY` is not an updatable view.

## 7. WITH CHECK OPTION

`WITH CHECK OPTION` ensures that changes made through a view continue to satisfy the view's filtering condition.

Example:

```sql
CREATE VIEW completed_orders_only AS
SELECT
    order_id,
    total_amount,
    status
FROM orders
WHERE status = 'COMPLETED'
WITH CHECK OPTION;
```

### Can we update through this view?

Yes!

**Allowed example:**

```sql
UPDATE completed_orders_only
SET total_amount = 600
WHERE order_id = 101;
```

The row still satisfies:

```sql
status = 'COMPLETED'
```

Therefore, the update is allowed, assuming other database constraints are satisfied.

**Rejected example:**

```sql
UPDATE completed_orders_only
SET status = 'CANCELLED'
WHERE order_id = 101;
```

The resulting row no longer satisfies:

```sql
status = 'COMPLETED'
```

Therefore, MySQL rejects the update.

### Without CHECK OPTION vs With CHECK OPTION

| Without CHECK OPTION | With CHECK OPTION |
|---|---|
| Update may cause a row to disappear from the view | Update violating the view condition is rejected |
| No view-condition validation is enforced | View-condition validation is enforced |
| Some updates can move rows outside the view | Rows must continue satisfying the view condition |

**Important:** `WITH CHECK OPTION` does not make a view read-only. It allows valid updates and rejects updates that violate the view condition.

## 8. Understanding WITH CHECK OPTION Using Amounts

Suppose we create:

```sql
CREATE VIEW expensive_orders AS
SELECT
    order_id,
    total_amount
FROM orders
WHERE total_amount > 1000
WITH CHECK OPTION;
```

An order has an amount of 1500.

**Case A: 1500 → 2000**

Allowed because:

```sql
2000 > 1000
```

**Case B: 1500 → 800**

Rejected because:

```sql
800 < 1000
```

The resulting row does not satisfy the view condition.

## 9. DROP VIEW

Remove a view:

```sql
DROP VIEW completed_orders;
```

Safer option:

```sql
DROP VIEW IF EXISTS completed_orders;
```

Dropping a view does not delete the original table or its data.

## 10. Do Changes in the Original Table Reflect in a View?

Yes!

A regular MySQL view retrieves data from its underlying tables when queried.

If a customer's name changes in the `customers` table, a view that displays `customer_name` will show the updated name when queried again.

## Practice Questions Completed

1. Create a completed orders view.
2. Create a high-value orders view.
3. Create a customer order details view using JOIN.
4. Create a restaurant revenue summary view.
5. Replace an existing view.
6. Update customer information through a view.
7. Create a view using WITH CHECK OPTION.
8. Drop a view.
9. Drop a view using IF EXISTS.
10. Understand the difference between a table and a view.
