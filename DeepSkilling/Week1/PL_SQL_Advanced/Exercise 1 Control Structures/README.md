# Exercise 1: PL/SQL Control Structures

This directory contains the database schema, sample data, and PL/SQL blocks implementing the control structures exercise.

## Scenario Breakdown

### Scenario 1: Age-Based Loan Interest Rate Discount
* **Objective:** Loop through all customers, check their age, and if they are above 60 years old, apply a 1% discount to their current loan interest rates.
* **Implementation (`scenario1.sql`):** Uses a cursor to loop through all customers, computes their age via `MONTHS_BETWEEN(SYSDATE, DOB) / 12`, and updates the corresponding record in the `Loans` table if the age exceeds 60.

### Scenario 2: Balance-Based VIP Promotion
* **Objective:** Iterate through all customers and set the `IsVIP` flag to `'TRUE'` for those with a balance over $10,000.
* **Implementation (`scenario2.sql`):** Uses a cursor to iterate through all customers, checks if `Balance > 10000`, and updates `IsVIP` to `'TRUE'` if not already set.

### Scenario 3: Loan Due Date Reminders
* **Objective:** Fetch all loans due in the next 30 days and print a reminder message for each customer.
* **Implementation (`scenario3.sql`):** Uses a cursor that joins the `Loans` and `Customers` tables. It filters loans where the due date (`EndDate`) falls within `SYSDATE` and `SYSDATE + 30`, and prints a formatted reminder using `DBMS_OUTPUT.PUT_LINE`.

---

## File Structure

- [schema.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%201%20Control%20Structures/schema.sql): Schema creation and sample data seeding script.
- [scenario1.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%201%20Control%20Structures/scenario1.sql): PL/SQL block for the age-based discount logic.
- [scenario2.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%201%20Control%20Structures/scenario2.sql): PL/SQL block for promoting high-balance customers to VIP.
- [scenario3.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%201%20Control%20Structures/scenario3.sql): PL/SQL block for the 30-day loan repayment reminders.
- [test_run.sql](file:///d:/Cognizant_DN/DeepSkilling/Week1/Engineering%20Concepts/PL_SQL_Advanced/Exercise%201%20Control%20Structures/test_run.sql): Unified script to run all files and output results before/after.

---

## Running the Tests

To run the unified test suite, follow these steps:

1. Ensure your local Oracle database instance (`OracleServiceXE` and listener `OracleXETNSListener`) is running.
2. Open a command prompt or terminal in this folder and connect to your SQL*Plus instance:
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
* **John Doe** (Age: 76, Balance: $5,000, IsVIP: 'FALSE', Loan: Interest 8.0%)
* **Jane Smith** (Age: 66, Balance: $15,000, IsVIP: 'FALSE', Loan: Interest 7.5%, Due in 15 days)
* **Bob Johnson** (Age: 40, Balance: $12,000, IsVIP: 'FALSE', Loan: Interest 6.0%, Due in 45 days)
* **Alice Brown** (Age: 30, Balance: $3,000, IsVIP: 'FALSE', Loan: Interest 9.0%, Due in 25 days)

### Execution Output & Final State
1. **Scenario 1 Output:**
   - Applied 1% discount to loans for Customer: John Doe
   - Applied 1% discount to loans for Customer: Jane Smith
2. **Scenario 2 Output:**
   - Customer Jane Smith promoted to VIP.
   - Customer Bob Johnson promoted to VIP.
3. **Scenario 3 Output:**
   - REMINDER: Jane Smith has a loan due in 15 days.
   - REMINDER: Alice Brown has a loan due in 25 days.
4. **Final Customers State:**
   - Jane Smith: IsVIP = 'TRUE'
   - Bob Johnson: IsVIP = 'TRUE'
   - John Doe: IsVIP = 'FALSE'
   - Alice Brown: IsVIP = 'FALSE'
5. **Final Loans State:**
   - John Doe: Interest rate reduced to **7.0%** (was 8.0%)
   - Jane Smith: Interest rate reduced to **6.5%** (was 7.5%)
   - Bob Johnson: Interest rate remains **6.0%**
   - Alice Brown: Interest rate remains **9.0%**
