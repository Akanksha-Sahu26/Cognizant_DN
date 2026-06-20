SET SERVEROUTPUT ON;
SET PAGESIZE 50;
SET LINESIZE 120;

PROMPT ==============================================================
PROMPT STEP 1: INITIALIZING SCHEMA AND SEED DATA
PROMPT ==============================================================
@schema.sql;

PROMPT ==============================================================
PROMPT STATE BEFORE RUNNING SCENARIOS
PROMPT ==============================================================
PROMPT Customers Table:
SELECT CustomerID, Name, TO_CHAR(DOB, 'YYYY-MM-DD') AS DOB, Balance, IsVIP FROM Customers;

PROMPT Loans Table:
SELECT LoanID, CustomerID, LoanAmount, InterestRate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate FROM Loans;

PROMPT ==============================================================
PROMPT STEP 2: RUNNING SCENARIO 1 (Age-based Loan Rate Discount)
PROMPT ==============================================================
@scenario1.sql;

PROMPT ==============================================================
PROMPT STEP 3: RUNNING SCENARIO 2 (Balance-based VIP Promotion)
PROMPT ==============================================================
@scenario2.sql;

PROMPT ==============================================================
PROMPT STEP 4: RUNNING SCENARIO 3 (Loan Repayment Reminders)
PROMPT ==============================================================
@scenario3.sql;

PROMPT ==============================================================
PROMPT STATE AFTER RUNNING SCENARIOS
PROMPT ==============================================================
PROMPT Customers Table (VIPs updated for balance > 10000):
SELECT CustomerID, Name, Balance, IsVIP FROM Customers;

PROMPT Loans Table (Interest rates reduced by 1% for customers over 60):
SELECT LoanID, CustomerID, LoanAmount, InterestRate FROM Loans;
