
# Day 3 - SQL Keys and Constraints

## 1. What are Constraints?

Constraints are rules applied to table columns to maintain data integrity and prevent invalid data from being inserted or updated.

## 2. Types of Keys

### Primary Key (PK)
- Uniquely identifies every row in a table.
- Cannot contain NULL values.
- A table has one primary key constraint.
- It can consist of multiple columns (composite primary key).

### Foreign Key (FK)
- Establishes a relationship between two tables.
- References a key in another table.
- Enforces referential integrity.

### Candidate Key
A minimal set of columns that can uniquely identify a record.

### Alternate Key
A candidate key that was not selected as the primary key.

### Composite Key
Two or more columns used together to uniquely identify a record.

### Unique Key
A constraint that prevents duplicate non-NULL values.

## 3. SQL Constraints

| Constraint | Purpose |
|---|---|
| PRIMARY KEY | Unique and non-NULL identification |
| FOREIGN KEY | Maintains valid relationships |
| UNIQUE | Prevents duplicate values |
| NOT NULL | Requires a value |
| CHECK | Validates a condition |
| DEFAULT | Supplies a default value |

## 4. Foreign Key Relationships

Example:

- restaurants.restaurant_id is the parent primary key.
- menu_items.restaurant_id is the child foreign key.

A menu item cannot reference a restaurant that does not exist.

## 5. ON DELETE Actions

### CASCADE
Automatically deletes dependent child records when a referenced parent record is deleted.

### RESTRICT
Prevents deletion of a parent record while dependent child records exist.

## 6. Naming Constraints

Example:

CONSTRAINT fk_menu_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES restaurants(restaurant_id);

The constraint name helps identify and manage the constraint.

## 7. Important Learning

- Primary key identifies a record.
- Foreign key establishes a relationship.
- Composite key uses multiple columns.
- Constraints protect data integrity.
- Foreign keys help prevent orphan records.
