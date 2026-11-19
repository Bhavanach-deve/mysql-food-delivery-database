# Day 21 – IN, NOT IN, EXISTS & NOT EXISTS

## Objective

Understand membership and existence operators in MySQL and learn how to use them to retrieve matching and non-matching records through subqueries.

## Topics Covered

- IN operator
- NOT IN operator
- EXISTS operator
- NOT EXISTS operator
- NULL behavior with NOT IN
- Correlated subqueries
- Membership checking vs existence checking
- SQL interview practice

## Key Concepts

### 1. IN

The IN operator checks whether a value matches any value in a list or subquery result.

Example:

```sql
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
```

### 2. NOT IN

NOT IN checks whether a value does not match any value in the provided list or subquery result.

Example:

```sql
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);
```

**Important:** NOT IN can produce unexpected results if the subquery returns NULL.

### 3. EXISTS

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

### 4. NOT EXISTS

NOT EXISTS checks whether the subquery returns no matching rows.

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

### 5. IN vs EXISTS

| IN | EXISTS |
|---|---|
| Checks whether a value matches any value in a result | Checks whether a subquery returns at least one row |
| Membership-based comparison | Existence-based comparison |
| Commonly used with lists and subqueries | Commonly used with correlated subqueries |

### 6. NULL Trap with NOT IN

If the subquery returns NULL, comparisons using NOT IN can evaluate to UNKNOWN.

NOT EXISTS is often safer when searching for records without matching rows.

## Practice Queries

1. Find customers who have placed orders using IN.
2. Find customers who have never placed orders using NOT IN.
3. Find customers who have placed orders using EXISTS.
4. Find customers who have never placed orders using NOT EXISTS.
5. Find restaurants that have received orders using IN.
6. Find restaurants that have never received orders using NOT EXISTS.
7. Find products whose category has at least one product using EXISTS.
8. Find customers who have placed orders above ₹500 using EXISTS.
9. Find customers who have not placed any orders above ₹500 using NOT EXISTS.
10. Explain the difference between IN and EXISTS.
11. Understand the NULL trap associated with NOT IN.
