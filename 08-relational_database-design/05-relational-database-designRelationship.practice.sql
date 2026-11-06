
-- DAY 8: RELATIONAL DATABASE DESIGN
-- Practice: One-to-Many and Many-to-Many relationships

CREATE DATABASE IF NOT EXISTS food_delivery_db;
USE food_delivery_db;

-- Clean up only these practice tables if rerunning the script
DROP TABLE IF EXISTS practice_order_items;
DROP TABLE IF EXISTS practice_orders;
DROP TABLE IF EXISTS practice_menu_items;
DROP TABLE IF EXISTS practice_customers;

-- 1. Parent table: Customers
CREATE TABLE practice_customers (
                                    customer_id INT PRIMARY KEY,
                                    customer_name VARCHAR(100) NOT NULL
);

-- 2. Parent table: Menu Items
CREATE TABLE practice_menu_items (
                                     menu_item_id INT PRIMARY KEY,
                                     item_name VARCHAR(100) NOT NULL,
                                     price DECIMAL(10,2) NOT NULL
);

-- 3. Child table: Orders
-- One customer can have many orders.
CREATE TABLE practice_orders (
                                 order_id INT PRIMARY KEY,
                                 customer_id INT NOT NULL,
                                 order_amount DECIMAL(10,2),

                                 CONSTRAINT fk_practice_order_customer
                                     FOREIGN KEY (customer_id)
                                         REFERENCES practice_customers(customer_id)
);

-- 4. Junction table: Order Items
-- Connects Orders and Menu Items.
CREATE TABLE practice_order_items (
                                      order_id INT NOT NULL,
                                      menu_item_id INT NOT NULL,
                                      quantity INT NOT NULL,

                                      PRIMARY KEY (order_id, menu_item_id),

                                      CONSTRAINT fk_practice_item_order
                                          FOREIGN KEY (order_id)
                                              REFERENCES practice_orders(order_id),

                                      CONSTRAINT fk_practice_item_menu
                                          FOREIGN KEY (menu_item_id)
                                              REFERENCES practice_menu_items(menu_item_id)
);

-- 5. Insert customers
INSERT INTO practice_customers
(customer_id, customer_name)
VALUES
    (1, 'Ananya'),
    (2, 'Rahul');

-- 6. Insert menu items
INSERT INTO practice_menu_items
(menu_item_id, item_name, price)
VALUES
    (1, 'Pizza', 250.00),
    (2, 'Burger', 150.00),
    (3, 'Pasta', 200.00);

-- 7. Insert orders
INSERT INTO practice_orders
(order_id, customer_id, order_amount)
VALUES
    (101, 1, 400.00),
    (102, 1, 450.00),
    (103, 2, 350.00);

-- 8. Insert order items (junction table)
INSERT INTO practice_order_items
(order_id, menu_item_id, quantity)
VALUES
    (101, 1, 1),
    (101, 2, 1),
    (102, 1, 1),
    (102, 3, 1),
    (103, 2, 1),
    (103, 3, 1);

-- 9. View all tables
SELECT * FROM practice_customers;
SELECT * FROM practice_orders;
SELECT * FROM practice_menu_items;
SELECT * FROM practice_order_items;

-- 10. Display each order with its customer
SELECT
    o.order_id,
    c.customer_name,
    o.order_amount
FROM practice_orders o
         JOIN practice_customers c
              ON o.customer_id = c.customer_id;

-- 11. Display orders with their menu items
SELECT
    oi.order_id,
    m.item_name,
    oi.quantity
FROM practice_order_items oi
         JOIN practice_menu_items m
              ON oi.menu_item_id = m.menu_item_id
ORDER BY oi.order_id;

-- 12. Try an invalid customer ID.
-- Uncomment and run separately to observe the foreign key error.
-- INSERT INTO practice_orders
--     (order_id, customer_id, order_amount)
-- VALUES
--     (104, 99, 300.00);

-- 13. Try inserting the same order-item combination twice.
-- Uncomment and run separately to observe the duplicate primary key error.
-- INSERT INTO practice_order_items
--     (order_id, menu_item_id, quantity)
-- VALUES
--     (101, 1, 2);
