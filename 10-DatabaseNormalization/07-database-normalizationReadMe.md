# Day 10 – Database Normalization

## Overview

Database normalization is the process of organizing data into related tables to reduce data redundancy and prevent insertion, update, and deletion anomalies.

It helps maintain data consistency and improves database structure.

## Why Do We Need Normalization?

Normalization helps prevent three major anomalies:

1. **Insertion Anomaly:** Difficulty inserting information without unnecessarily inserting other information.
2. **Update Anomaly:** The same information must be updated in multiple rows, which can cause inconsistency.
3. **Deletion Anomaly:** Deleting one record accidentally removes other important information.

## Normal Forms

### 1. First Normal Form (1NF)

Rules:
- Each cell must contain a single atomic value.
- No repeating groups or multiple values in one cell.

Example:

Incorrect:

| order_id | items |
|---|---|
| 101 | Biryani, Coke |

Correct:

| order_id | item_name |
|---|---|
| 101 | Biryani |
| 101 | Coke |

**Key idea:** One cell, one value.

### 2. Second Normal Form (2NF)

Rules:
- Must satisfy 1NF.
- No partial dependency of a non-key attribute on a proper subset of a candidate key.

Example:

Consider a table with the composite primary key `(order_id, menu_item_id)`.

- `order_date` depends only on `order_id`.
- `item_name` depends only on `menu_item_id`.
- `quantity` depends on both columns together.

We separate the information into:

- Orders
- Menu Items
- Order Items

**Key idea:** Every non-key attribute must depend on the whole candidate key.

### 3. Third Normal Form (3NF)

Rules:
- Must satisfy 2NF.
- No transitive dependency of non-key attributes on a candidate key.

Example:

If `customer_id` determines `city_id`, and `city_id` determines `city_name`, we have a transitive dependency.

We separate the information into:

- Customers
- Cities

**Key idea:** Non-key attributes should not depend on other non-key attributes.

## Normalization Summary

| Normal Form | Main Rule |
|---|---|
| 1NF | Atomic values |
| 2NF | Remove partial dependencies |
| 3NF | Remove transitive dependencies |

## Practical Food Delivery Database Examples

- Customers and cities are stored separately.
- Orders and menu items are connected through order_items.
- Composite keys can identify individual order-item combinations.
- Foreign keys maintain relationships between tables.

## Important Concepts Learned

- Database normalization
- Data redundancy
- Insertion anomaly
- Update anomaly
- Deletion anomaly
- Atomic values
- Partial dependency
- Transitive dependency
- 1NF, 2NF and 3NF
- Composite primary keys
- Foreign keys

## Learning Outcome

Understood how to organize relational database tables using 1NF, 2NF and 3NF, identify database anomalies, and remove unnecessary dependencies through appropriate table decomposition.

**Next Topic:** SQL JOIN Fundamentals.