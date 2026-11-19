
-- Q1. Find all customers who have placed orders.
-- Use IN.

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);


-- Q2. Find all customers who have never placed orders.
-- Use NOT IN.

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);


-- Q3. Find all customers who have placed orders.
-- Use EXISTS.

SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- Q4. Find all customers who have never placed orders.
-- Use NOT EXISTS.

SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- Q5. Find restaurants that have received orders.
-- Use IN.

SELECT *
FROM restaurants
WHERE restaurant_id IN (
    SELECT restaurant_id
    FROM orders
);


-- Q6. Find restaurants that have never received orders.
-- Use NOT EXISTS.

SELECT *
FROM restaurants r
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.restaurant_id = r.restaurant_id
);


-- Q7. Find products that belong to categories
-- having at least one product.
-- Use EXISTS.

SELECT *
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM products p2
    WHERE p2.category_id = p.category_id
);


-- Q8. Find customers who have placed orders
-- worth more than ₹500.
-- Use EXISTS.

SELECT c.customer_id
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.total_amount > 500
);


-- Q9. Find customers who have not placed
-- any orders above ₹500.
-- Use NOT EXISTS.

SELECT c.customer_id
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.total_amount > 500
);


-- Q10. Explain IN vs EXISTS.

-- IN:
-- Checks whether a value matches any value
-- in a list or subquery result.

-- EXISTS:
-- Checks whether the subquery returns
-- at least one row.


-- Q11. Can NOT IN produce unexpected results
-- when the subquery returns NULL?

-- Yes. NULL can cause comparisons to evaluate
-- to UNKNOWN instead of TRUE.
-- NOT EXISTS is generally safer for
-- finding unmatched records.
