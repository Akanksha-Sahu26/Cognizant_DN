BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Loans';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    DOB DATE NOT NULL,
    Balance NUMBER(15, 2) DEFAULT 0.00,
    IsVIP VARCHAR2(5) DEFAULT 'FALSE'
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER(15, 2) NOT NULL,
    InterestRate NUMBER(5, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (1, 'John Doe', TO_DATE('1950-05-15', 'YYYY-MM-DD'), 5000.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (2, 'Jane Smith', TO_DATE('1960-03-10', 'YYYY-MM-DD'), 15000.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (3, 'Bob Johnson', TO_DATE('1985-08-22', 'YYYY-MM-DD'), 12000.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (4, 'Alice Brown', TO_DATE('1995-12-01', 'YYYY-MM-DD'), 3000.00, 'FALSE');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (101, 1, 10000.00, 8.0, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2026-12-31', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (102, 2, 25000.00, 7.5, TO_DATE('2025-06-01', 'YYYY-MM-DD'), SYSDATE + 15);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (103, 3, 50000.00, 6.0, TO_DATE('2025-02-15', 'YYYY-MM-DD'), SYSDATE + 45);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (104, 4, 5000.00, 9.0, TO_DATE('2025-03-01', 'YYYY-MM-DD'), SYSDATE + 25);

COMMIT;
/
