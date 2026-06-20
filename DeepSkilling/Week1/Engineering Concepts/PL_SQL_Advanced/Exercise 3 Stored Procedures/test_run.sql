SET SERVEROUTPUT ON;
SET PAGESIZE 50;
SET LINESIZE 120;

PROMPT ==============================================================
PROMPT STEP 1: INITIALIZING SCHEMA AND SEED DATA
PROMPT ==============================================================
@schema.sql;

PROMPT ==============================================================
PROMPT STEP 2: COMPILING STORED PROCEDURES
PROMPT ==============================================================
PROMPT Compiling ProcessMonthlyInterest...
@procedure1.sql;

PROMPT Compiling UpdateEmployeeBonus...
@procedure2.sql;

PROMPT Compiling TransferFunds...
@procedure3.sql;

PROMPT ==============================================================
PROMPT STATE BEFORE RUNNING TESTS
PROMPT ==============================================================
PROMPT Accounts Table:
SELECT AccountID, CustomerID, AccountType, Balance FROM Accounts;

PROMPT Employees Table:
SELECT EmployeeID, Name, Department, Salary FROM Employees;

PROMPT ==============================================================
PROMPT STEP 3: TESTING PROCESSMONTHLYINTEREST (Scenario 1)
PROMPT ==============================================================
EXEC ProcessMonthlyInterest;

PROMPT Accounts Table after ProcessMonthlyInterest (Savings balances should be +1%):
SELECT AccountID, CustomerID, AccountType, Balance FROM Accounts;

PROMPT ==============================================================
PROMPT STEP 4: TESTING UPDATEEMPLOYEEBONUS (Scenario 2)
PROMPT ==============================================================
PROMPT Case A: Apply 10% bonus to 'IT' department (Alice and Bob salaries should increase)
EXEC UpdateEmployeeBonus('IT', 10);

PROMPT Employees Table after 10% IT bonus:
SELECT EmployeeID, Name, Department, Salary FROM Employees;

PROMPT Case B: Attempt negative bonus (should fail validation)
BEGIN
    UpdateEmployeeBonus('IT', -5);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught expected exception for negative bonus:');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

PROMPT ==============================================================
PROMPT STEP 5: TESTING TRANSFERFUNDS (Scenario 3)
PROMPT ==============================================================
PROMPT Case A: Transfer $1,500.00 from Account 1001 to Account 1003 (Success case)
EXEC TransferFunds(1001, 1003, 1500);

PROMPT Accounts Table after successful transfer:
SELECT AccountID, CustomerID, AccountType, Balance FROM Accounts;

PROMPT Case B: Attempt to transfer $10,000.00 from Account 1001 to Account 1003 (should fail due to insufficient funds)
BEGIN
    TransferFunds(1001, 1003, 10000);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught expected exception for insufficient funds:');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

PROMPT Case C: Attempt to transfer $100.00 to non-existent Account 9999 (should fail due to non-existent destination)
BEGIN
    TransferFunds(1001, 9999, 100);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught expected exception for invalid account:');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

PROMPT ==============================================================
PROMPT FINAL TABLE STATES AFTER ALL TESTS
PROMPT ==============================================================
PROMPT Final Accounts State:
SELECT AccountID, CustomerID, AccountType, Balance FROM Accounts;

PROMPT Final Employees State:
SELECT EmployeeID, Name, Department, Salary FROM Employees;
