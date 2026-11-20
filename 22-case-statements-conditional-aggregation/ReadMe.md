# Day 22 – CASE Statements & Conditional Aggregation

## Objective

Learn how to implement conditional logic in MySQL using CASE statements and perform conditional calculations using aggregate functions.

## Topics Covered

- CASE statement
- WHEN, THEN, ELSE and END
- Multiple conditional expressions
- CASE with aggregate functions
- COUNT(CASE WHEN...)
- SUM(CASE WHEN...)
- Conditional aggregation
- CASE with GROUP BY
- Percentage calculations
- Restaurant-level performance reporting

## 1. CASE Statement

The CASE statement allows us to implement conditional logic in SQL, similar to if-else statements in Java.

### Syntax

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

Example:

```sql
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 1000 THEN 'High Value'
        WHEN total_amount >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM orders;
```

**Important:** SQL evaluates WHEN conditions sequentially and returns the result of the first matching condition.

If no condition matches and ELSE is omitted, CASE returns NULL.

## 2. CASE with Aggregate Functions

CASE can be combined with aggregate functions such as:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

### COUNT(CASE WHEN...)

Counts rows satisfying a particular condition.

```sql
SELECT
    COUNT(
        CASE
            WHEN status = 'COMPLETED' THEN 1
        END
    ) AS completed_orders
FROM orders;
```

COUNT(expression) counts non-NULL values.

### SUM(CASE WHEN...)

Performs conditional summation.

```sql
SELECT
    SUM(
        CASE
            WHEN status = 'COMPLETED' THEN total_amount
            ELSE 0
        END
    ) AS completed_revenue
FROM orders;
```

Only completed orders contribute their amounts to the total.

## 3. Conditional Aggregation

Conditional aggregation combines CASE expressions with aggregate functions to calculate multiple metrics in one query.

Example:

```sql
SELECT
    restaurant_id,

    SUM(CASE
        WHEN status = 'COMPLETED' THEN 1
        ELSE 0
    END) AS completed_orders,

    SUM(CASE
        WHEN status = 'CANCELLED' THEN 1
        ELSE 0
    END) AS cancelled_orders

FROM orders
GROUP BY restaurant_id;
```

## 4. CASE with GROUP BY

GROUP BY groups rows based on common column values.

Combining GROUP BY with conditional aggregation allows us to generate separate metrics for each restaurant.

## 5. Percentage Calculations

Completion percentage can be calculated using:

**Completion Percentage = (Completed Orders / Total Orders) × 100**

Example:

```sql
SELECT
    restaurant_id,
    ROUND(
        SUM(CASE
            WHEN status = 'COMPLETED' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS completion_percentage
FROM orders
GROUP BY restaurant_id;
```

## 6. Interview Concepts

| Concept | Explanation |
|---|---|
| CASE | Implements conditional logic |
| WHEN | Specifies a condition |
| THEN | Specifies the result when a condition is true |
| ELSE | Provides a default result |
| COUNT(CASE...) | Counts qualifying non-NULL results |
| SUM(CASE...) | Adds conditionally returned values |
| Conditional Aggregation | Combines conditions with aggregate functions |
| GROUP BY | Groups rows for separate aggregate calculations |
