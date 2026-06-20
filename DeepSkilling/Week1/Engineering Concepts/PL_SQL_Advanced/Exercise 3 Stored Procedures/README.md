# Exercise 3: PL/SQL Stored Procedures

This directory contains the database schema, sample data, and PL/SQL stored procedures implementing the banking business logic for monthly interest, employee bonuses, and safe fund transfers.

## Stored Procedures Summary

### Scenario 1: `ProcessMonthlyInterest`
* **Objective:** Processes monthly interest for all savings accounts by calculating and updating the balance applying a 1% interest rate.
* **Implementation (`procedure1.sql`):** Opens an updateable cursor (`FOR UPDATE OF Balance`) on all savings accounts (`AccountType = 'Savings'`), updates the balance by adding 1% of the current balance, prints the transactions, and commits.

### Scenario 2: `UpdateEmployeeBonus`
* **Objective:** Updates employee salaries for a given department by adding a specified bonus percentage.
* **Implementation (`procedure2.sql`):** Accepts parameters `p_department` and `p_bonus_percentage`. Validates that the bonus percentage is non-negative and updates the salaries in the `Employees` table by the corresponding multiplier.

### Scenario 3: `TransferFunds`
* **Objective:** Safe transfer of funds between two accounts, checking source balance sufficiency.
* **Implementation (`procedure3.sql`):** Accepts `p_source_account`, `p_destination_account`, and `p_amount`. Enforces validations:
  1. Amount must be positive.
  2. Accounts must be distinct.
  3. Both accounts must exist (locking rows with `FOR UPDATE`).
  4. Balance of source account must be greater than or equal to transfer amount.
  Updates balances on success and commits. On any failure, rolls back the transaction and throws a custom exception.

---

## File Structure

- [schema.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%203%20Stored%20Procedures/schema.sql): Schema definition and sample data.
- [procedure1.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%203%20Stored%20Procedures/procedure1.sql): Implementation of `ProcessMonthlyInterest`.
- [procedure2.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%203%20Stored%20Procedures/procedure2.sql): Implementation of `UpdateEmployeeBonus`.
- [procedure3.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%203%20Stored%20Procedures/procedure3.sql): Implementation of `TransferFunds`.
- [test_run.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%203%20Stored%20Procedures/test_run.sql): Script to run and test success/failure cases.

---

## Running the Procedures and Tests

1. Ensure your local Oracle database instance is started.
2. In your terminal/SQL shell, navigate to this folder and connect to your SQL*Plus instance:
   ```cmd
   sqlplus username/password@XE
   ```
3. Run the unified test script:
   ```sql
   @test_run.sql
   ```

---

## Expected Outputs

### Initial Seed Data State
* **Accounts**:
  - 1001 (Savings, Balance: $5,000.00)
  - 1002 (Savings, Balance: $10,000.00)
  - 1003 (Checking, Balance: $2,500.00)
  - 1004 (Checking, Balance: $500.00)
* **Employees**:
  - 201 (IT, Salary: $60,000.00)
  - 202 (IT, Salary: $80,000.00)
  - 203 (HR, Salary: $55,000.00)
  - 204 (Sales, Salary: $70,000.00)

### Execution Output & Final State
1. **Scenario 1 Output:**
   - Savings Account 1001 balance increases to **$5,050.00** (+$50.00 interest).
   - Savings Account 1002 balance increases to **$10,100.00** (+$100.00 interest).
   - Checking accounts remain unchanged.
2. **Scenario 2 Output:**
   - Employees in 'IT' department receive 10% bonus:
     - Alice Smith's salary increases to **$66,000.00**
     - Bob Jones's salary increases to **$88,000.00**
   - Testing negative bonus raises error: `ORA-20001: Bonus percentage cannot be negative.`
3. **Scenario 3 Output:**
   - Transfer $1,500.00 from Account 1001 to 1003 succeeds:
     - Account 1001 becomes **$3,550.00** ($5,050.00 - $1,500.00)
     - Account 1003 becomes **$4,000.00** ($2,500.00 + $1,500.00)
   - Transferring $10,000 from 1001 fails: `ORA-20007: Insufficient balance...`
   - Transferring to Account 9999 fails: `ORA-20006: Destination account 9999 does not exist...`
