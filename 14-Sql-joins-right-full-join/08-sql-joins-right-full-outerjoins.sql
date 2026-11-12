
USE join_practice_db;

-- Create demonstration customers
CREATE TABLE right_join_customers_demo (
                                           customer_id INT PRIMARY KEY,
                                           customer_name VARCHAR(50)
);

-- Create demonstration orders
-- No foreign key here, so we can deliberately
-- demonstrate an order without a matching customer.
CREATE TABLE right_join_orders_demo (
                                        order_id INT PRIMARY KEY,
                                        customer_id INT,
                                        amount DECIMAL(10,2)
);

INSERT INTO right_join_customers_demo
VALUES
    (1, 'Ananya'),
    (2, 'Rahul'),
    (3, 'Priya');

INSERT INTO right_join_orders_demo
VALUES
    (101, 1, 450.00),
    (102, 2, 300.00),
    (103, 4, 900.00);


-- Q1. RIGHT JOIN: preserve all orders.
SELECT
    c.customer_name,
    o.order_id,
    o.amount
FROM right_join_customers_demo c
         RIGHT JOIN right_join_orders_demo o
                    ON c.customer_id = o.customer_id;


-- Q2. Find orders without a matching customer.
SELECT
    o.order_id,
    o.customer_id,
    o.amount
FROM right_join_customers_demo c
         RIGHT JOIN right_join_orders_demo o
                    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;


-- Q3. FULL OUTER JOIN simulation in MySQL.
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
FROM right_join_customers_demo c
         LEFT JOIN right_join_orders_demo o
                   ON c.customer_id = o.customer_id

UNION ALL

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
FROM right_join_customers_demo c
         RIGHT JOIN right_join_orders_demo o
                    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;
