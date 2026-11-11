
USE join_practice_db;

-- Q1. Display all customers and their orders,
-- including customers who have no orders.
SELECT
    c.customer_name,
    o.order_id,
    o.amount
FROM practice_customers c
         LEFT JOIN practice_orders o
                   ON c.customer_id = o.customer_id;


-- Q2. Find customers who have never placed an order.
SELECT
    c.customer_id,
    c.customer_name
FROM practice_customers c
         LEFT JOIN practice_orders o
                   ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Q3. Display all orders and their payment statuses,
-- including orders that have no payment.
SELECT
    o.order_id,
    o.amount,
    p.payment_status
FROM practice_orders o
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id;


-- Q4. Display all customers, their orders,
-- and their payment statuses.
SELECT
    c.customer_name,
    o.order_id,
    p.payment_status
FROM practice_customers c
         LEFT JOIN practice_orders o
                   ON c.customer_id = o.customer_id
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id;


-- Q5. Display every order and its successful payment, if available.
SELECT
    o.order_id,
    o.amount,
    p.payment_status
FROM practice_orders o
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id
                       AND p.payment_status = 'SUCCESS';


-- Q6. Compare: display only orders with successful payments.
SELECT
    o.order_id,
    o.amount,
    p.payment_status
FROM practice_orders o
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id
WHERE p.payment_status = 'SUCCESS';


-- Q7. Find customers who have no matching payment
-- through their orders.
SELECT
    c.customer_id,
    c.customer_name
FROM practice_customers c
         LEFT JOIN practice_orders o
                   ON c.customer_id = o.customer_id
         LEFT JOIN practice_payments p
                   ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;
