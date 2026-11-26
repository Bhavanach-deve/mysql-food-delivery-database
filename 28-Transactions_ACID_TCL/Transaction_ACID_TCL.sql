
-- ============================================================
-- DAY 28: TRANSACTIONS, ACID AND TCL
-- MySQL 8.0+ | InnoDB
-- ============================================================


-- ============================================================
-- SECTION 1: TCL COMMANDS
-- ============================================================

-- START TRANSACTION:
-- Begins a transaction.

-- COMMIT:
-- Commits the changes made in the transaction.

-- ROLLBACK:
-- Undoes uncommitted changes made in the current transaction.

-- SAVEPOINT:
-- Establishes a rollback boundary inside a transaction.

-- ROLLBACK TO SAVEPOINT:
-- Undoes changes made after a specified savepoint,
-- without ending the transaction.


-- ============================================================
-- SECTION 2: CREATE A DEMONSTRATION TABLE
-- ============================================================

-- We use a separate table for transaction exercises.
-- ENGINE=InnoDB is important because it supports transactions.

CREATE TABLE IF NOT EXISTS transaction_demo_accounts (
                                                         account_id INT PRIMARY KEY,
                                                         account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_demo_balance CHECK (balance >= 0)
    ) ENGINE = InnoDB;


-- Insert demonstration records only if the IDs do not exist.
-- This makes the setup repeatable without resetting balances.

INSERT INTO transaction_demo_accounts
(account_id, account_name, balance)
VALUES
    (1, 'Account A', 5000.00),
    (2, 'Account B', 2000.00)
    ON DUPLICATE KEY UPDATE
                         account_name = VALUES(account_name);

-- Verify the initial balances.
SELECT *
FROM transaction_demo_accounts
ORDER BY account_id;


-- ============================================================
-- Q1. TRANSFER ₹1000 FROM ACCOUNT A TO ACCOUNT B
-- ============================================================

-- Initial balance:
-- Account A = ₹5000
-- Account B = ₹2000

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE transaction_demo_accounts
SET balance = balance + 1000
WHERE account_id = 2;

-- Verify before committing.
SELECT *
FROM transaction_demo_accounts
ORDER BY account_id;

-- If both operations are correct:
COMMIT;

-- Verify committed balances.
SELECT *
FROM transaction_demo_accounts
ORDER BY account_id;

-- Expected:
-- Account A = ₹4000
-- Account B = ₹3000


-- ============================================================
-- Q2. DEMONSTRATE FULL ROLLBACK
-- ============================================================

-- This transaction will be undone.

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE transaction_demo_accounts
SET balance = balance + 500
WHERE account_id = 2;

-- Check the temporary changes before rollback.
SELECT *
FROM transaction_demo_accounts
ORDER BY account_id;

-- Undo both uncommitted operations.
ROLLBACK;

-- Verify that balances return to their pre-transaction state.
SELECT *
FROM transaction_demo_accounts
ORDER BY account_id;


-- ============================================================
-- Q3. WHAT IF THE SECOND OPERATION IS NOT EXECUTED?
-- ============================================================

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 1000
WHERE account_id = 1;

-- Suppose an error occurs here and the credit operation
-- is not executed.

-- Undo the uncommitted deduction.
ROLLBACK;

-- Verify the balance.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;


-- ============================================================
-- Q4. DEMONSTRATE SAVEPOINT
-- ============================================================

-- Initial balance example:
-- Account A = ₹4000

START TRANSACTION;

-- Operation 1: Deduct ₹500.
UPDATE transaction_demo_accounts
SET balance = balance - 500
WHERE account_id = 1;

-- Create a savepoint after the first deduction.
SAVEPOINT S1;

-- Operation 2: Deduct another ₹200.
UPDATE transaction_demo_accounts
SET balance = balance - 200
WHERE account_id = 1;

-- Temporary balance would be ₹3300.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;

-- Undo changes made after S1.
ROLLBACK TO SAVEPOINT S1;

-- Balance is now ₹3500, still uncommitted.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;

-- Commit the remaining transaction.
COMMIT;

-- Final balance = ₹3500.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;


-- ============================================================
-- Q5. ROLLBACK TO SAVEPOINT AND THEN FULL ROLLBACK
-- ============================================================

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 500
WHERE account_id = 1;

SAVEPOINT S1;

UPDATE transaction_demo_accounts
SET balance = balance - 200
WHERE account_id = 1;

-- Undo only the second deduction.
ROLLBACK TO SAVEPOINT S1;

-- The first deduction is still uncommitted.

-- Now undo the entire transaction.
ROLLBACK;

-- Verify that even the first deduction is undone.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;


-- ============================================================
-- Q6. MULTIPLE SAVEPOINTS
-- ============================================================

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 100
WHERE account_id = 1;

SAVEPOINT S1;

UPDATE transaction_demo_accounts
SET balance = balance - 200
WHERE account_id = 1;

SAVEPOINT S2;

UPDATE transaction_demo_accounts
SET balance = balance - 300
WHERE account_id = 1;

-- Undo the changes after S2.
ROLLBACK TO SAVEPOINT S2;

-- The ₹300 deduction is undone.
-- The ₹100 and ₹200 deductions remain uncommitted.

-- If everything remaining is correct:
COMMIT;


-- ============================================================
-- Q7. AUTOCOMMIT
-- ============================================================

-- Check whether autocommit is enabled.
SELECT @@autocommit;

-- In MySQL, autocommit is commonly enabled by default.
-- Individual successful statements outside an explicit
-- transaction are generally committed automatically.

-- Example outside an explicit transaction:
-- This is generally committed automatically when autocommit
-- is enabled and the statement succeeds.

UPDATE transaction_demo_accounts
SET balance = balance + 100
WHERE account_id = 2;

SELECT *
FROM transaction_demo_accounts
WHERE account_id = 2;


-- ============================================================
-- Q8. EXPLICIT TRANSACTION WITH AUTOCOMMIT ENABLED
-- ============================================================

-- Autocommit can still be enabled globally/session-wise
-- while we explicitly manage a transaction.

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE transaction_demo_accounts
SET balance = balance + 100
WHERE account_id = 2;

-- Changes remain uncommitted until the transaction is committed.
COMMIT;


-- ============================================================
-- Q9. CHECK TABLE STORAGE ENGINE
-- ============================================================

SHOW TABLE STATUS
LIKE 'transaction_demo_accounts';

SHOW CREATE TABLE transaction_demo_accounts;


-- ============================================================
-- Q10. TRANSACTION AND CONSTRAINTS
-- ============================================================

-- Our table has a CHECK constraint:
-- balance >= 0

-- This update should fail because it attempts to make
-- Account A's balance negative.

-- Execute this as a separate experiment.
-- If the statement fails, inspect the transaction state.
-- Do not assume that every SQL error automatically
-- rolls back the entire transaction.

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = -100
WHERE account_id = 1;

-- The CHECK constraint should reject the invalid value.
-- If the transaction is still active, explicitly execute:
ROLLBACK;

-- Verify the balance.
SELECT *
FROM transaction_demo_accounts
WHERE account_id = 1;


-- ============================================================
-- Q11. INTERVIEW: TRANSFER MONEY
-- ============================================================

-- Write a transaction that:
-- 1. Deducts ₹1000 from Account A.
-- 2. Credits ₹1000 to Account B.
-- 3. Commits only if both operations succeed.
-- 4. Otherwise, rolls back.

-- ANSWER:

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE transaction_demo_accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;

-- In a real application, the developer must verify that
-- both operations were valid and successful before COMMIT.
-- If an error occurs before COMMIT, ROLLBACK should be
-- performed as appropriate.


-- ============================================================
-- Q12. INTERVIEW: PARTIAL ROLLBACK
-- ============================================================

-- Deduct ₹500.
-- Create savepoint.
-- Deduct ₹200.
-- Roll back to the savepoint.
-- Commit.

-- ANSWER:

START TRANSACTION;

UPDATE transaction_demo_accounts
SET balance = balance - 500
WHERE account_id = 1;

SAVEPOINT S1;

UPDATE transaction_demo_accounts
SET balance = balance - 200
WHERE account_id = 1;

ROLLBACK TO SAVEPOINT S1;

COMMIT;

-- Final deduction = ₹500.


-- ============================================================
-- Q13. CLEANUP (OPTIONAL)
-- ============================================================

-- Only execute if you no longer need this demonstration table.

-- DROP TABLE transaction_demo_accounts;
