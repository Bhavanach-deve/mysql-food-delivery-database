# Day 8: Relational Database Design and Relationships

## 1. What is a Relational Database?

A relational database stores data in multiple tables and establishes relationships between those tables using keys.

Instead of storing everything in one large table, we divide information into logically related tables.

### Benefits

- Reduces unnecessary data redundancy.
- Organizes data logically.
- Makes data easier to maintain.
- Helps maintain data integrity.
- Allows related information to be retrieved using SQL JOINs.

## 2. Primary Key and Foreign Key

### Primary Key (PK)

- Uniquely identifies each row in a table.
- Cannot contain NULL values.
- Must contain unique values.

### Foreign Key (FK)

- References a key in another table.
- Establishes relationships between tables.
- Can contain duplicate values.
- Enforces referential integrity.

Example:

A customer can place multiple orders, so `customer_id` is stored as a foreign key in the `orders` table.

## 3. Types of Relationships

### One-to-One (1:1)

One record in Table A is associated with at most one record in Table B, and vice versa.

Example: User and User Profile.

A UNIQUE constraint on the foreign key can enforce this relationship.

### One-to-Many (1:M)

One record in Table A can be associated with multiple records in Table B.

Example: Customer and Orders.

- One customer can place multiple orders.
- Each order belongs to one customer.

The foreign key is placed in the many-side table.

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
```

### Many-to-Many (M:N)

Multiple records in Table A can be associated with multiple records in Table B.

Example: Orders and Menu Items.

- One order can contain multiple menu items.
- One menu item can appear in multiple orders.

A junction table is used to implement this relationship.

## 4. Junction Table

A junction table (also called a bridge or associative table) connects two tables in a Many-to-Many relationship.

Example: `order_items`

It contains:

- `order_id` — Foreign Key referencing orders.
- `menu_item_id` — Foreign Key referencing menu_items.
- `quantity` — Number of units ordered.

```sql
CREATE TABLE order_items (
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,

    PRIMARY KEY (order_id, menu_item_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (menu_item_id)
        REFERENCES menu_items(menu_item_id)
);
```

## 5. Composite Primary Key

A composite primary key consists of two or more columns that together uniquely identify a row.

Example:

```sql
PRIMARY KEY (order_id, menu_item_id)
```

- `order_id` can repeat.
- `menu_item_id` can repeat.
- Their combination must be unique.

This prevents the same menu item from being stored twice as separate rows for the same order in this design.

## 6. Cardinality and Optionality

### Cardinality

Describes how many records can participate in a relationship.

Examples:
- One-to-One
- One-to-Many
- Many-to-Many

### Optionality

Describes whether participation in a relationship is mandatory or optional.

Example:
- A customer may exist without placing an order.
- An order must have a customer if `customer_id` is NOT NULL.

## 7. Referential Integrity

Referential integrity ensures that a foreign key refers to a valid key in the referenced table.

For example, an order cannot reference customer ID 99 if that customer does not exist.

MySQL enforces this through foreign key constraints.

## 8. SQL JOIN Connection

JOINs allow us to retrieve related information from multiple tables.

Example:

```sql
SELECT
    o.order_id,
    c.customer_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
```

## Day 8 Summary

Today I learned:

- What relational databases are.
- Why data is separated into multiple tables.
- Primary keys and foreign keys in relationships.
- One-to-One, One-to-Many, and Many-to-Many relationships.
- Junction tables.
- Composite primary keys.
- Cardinality and optionality.
- Referential integrity.
- Basic SQL JOIN usage.

## Practice Project

Food Delivery Database:

- `customers` → `orders`: One-to-Many.
- `restaurants` → `menu_items`: One-to-Many.
- `orders` → `menu_items`: Many-to-Many through `order_items`.