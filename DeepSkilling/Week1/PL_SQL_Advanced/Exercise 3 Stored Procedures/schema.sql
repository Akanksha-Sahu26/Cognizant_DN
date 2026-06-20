BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    AccountType VARCHAR2(20) NOT NULL,
    Balance NUMBER(15, 2) DEFAULT 0.00
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Department VARCHAR2(50) NOT NULL,
    Salary NUMBER(15, 2) NOT NULL
);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1001, 1, 'Savings', 5000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1002, 2, 'Savings', 10000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1003, 1, 'Checking', 2500.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1004, 3, 'Checking', 500.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (201, 'Alice Smith', 'IT', 60000.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (202, 'Bob Jones', 'IT', 80000.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (203, 'Charlie Brown', 'HR', 55000.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (204, 'Diana Prince', 'Sales', 70000.00);

COMMIT;
/
