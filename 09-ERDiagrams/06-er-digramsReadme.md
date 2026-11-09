# Day 9: ER Diagrams (Entity Relationship Diagrams)

## 1. What is an ER Diagram?

An Entity Relationship Diagram (ERD) is a visual representation of a database.

It describes:
- Entities (tables)
- Attributes (columns)
- Relationships between entities
- Primary keys
- Foreign keys
- Cardinality and optionality

An ER diagram acts as a blueprint before implementing a database.

## 2. Components of an ER Diagram

### Entity
An entity represents something about which we store information.

Examples:
- Customer
- Restaurant
- Order
- Menu Item

### Attribute
An attribute describes an entity and becomes a column in a relational database.

Example: Customer attributes:
- customer_id
- customer_name
- email
- city

### Relationship
A relationship describes how two entities are associated.

Examples:
- Customer places Order.
- Restaurant offers Menu Items.
- Order contains Menu Items.

## 3. Traditional ER Diagram Symbols

| Symbol | Meaning |
|---|---|
| Rectangle | Entity |
| Oval | Attribute |
| Diamond | Relationship |
| Underlined attribute | Primary Key |
| Double rectangle | Weak Entity |
| Lines | Connections |

## 4. Crow's Foot Notation

Crow's Foot notation is commonly used in practical database design.

| Symbol | Meaning |
|---|---|
| `||` | Exactly one |
| `o|` | Zero or one |
| `o{` | Zero or many |
| `|{` | One or many |

Example:

`CUSTOMER ||--o{ ORDERS`

Meaning:
- One customer can have zero or many orders.
- Each order belongs to exactly one customer.

## 5. Food Delivery Database Relationships

| Entity A | Entity B | Relationship |
|---|---|---|
| Customer | Orders | One-to-Many |
| Restaurant | Menu Items | One-to-Many |
| Restaurant | Orders | One-to-Many |
| Orders | Order Items | One-to-Many |
| Menu Items | Order Items | One-to-Many |
| Orders | Menu Items | Many-to-Many through Order Items |

## 6. Junction Table

A junction table resolves a Many-to-Many relationship.

Example: `order_items`

It stores:
- order_id — Foreign Key
- menu_item_id — Foreign Key
- quantity — Attribute describing the relationship

The combination of order_id and menu_item_id can form a composite primary key.

## 7. Steps to Design an ER Diagram

1. Understand the business requirement.
2. Identify entities.
3. Identify attributes for each entity.
4. Select primary keys.
5. Identify relationships.
6. Determine cardinality.
7. Determine optionality.
8. Resolve Many-to-Many relationships using junction tables.
9. Identify foreign keys.
10. Translate the design into SQL tables.

## 8. ER Diagram vs SQL Tables

An ER diagram is a visual design representation.

SQL tables are the actual database structures created using commands such as `CREATE TABLE`.

Foreign keys and other constraints enforce the designed relationships in the database.

## Day 9 Summary

Today I learned:
- What an ER diagram is.
- Entities, attributes and relationships.
- Traditional ER diagram symbols.
- Crow's Foot notation.
- Cardinality and optionality in ER diagrams.
- How to identify entities from business requirements.
- How to map ER diagrams into relational tables.
- How junction tables resolve Many-to-Many relationships.

## Practice Project

Design an ER diagram for the food delivery application using:

- Customers
- Restaurants
- Orders
- Menu Items
- Order Items
- Payments

Then translate the design into MySQL CREATE TABLE statements.