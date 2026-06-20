SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_due_loans IS
        SELECT l.LoanID, c.CustomerID, c.Name, l.EndDate, l.LoanAmount
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND (SYSDATE + 30);
        
    v_reminder_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting Scenario 3: Sending reminders for loans due within the next 30 days...');
    
    FOR r_loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('REMINDER: Dear ' || r_loan.Name || ' (ID: ' || r_loan.CustomerID || '), ' ||
                             'your loan (ID: ' || r_loan.LoanID || ') with amount $' || TRIM(TO_CHAR(r_loan.LoanAmount, '999,999.99')) || 
                             ' is due on ' || TO_CHAR(r_loan.EndDate, 'YYYY-MM-DD') || '. Please ensure sufficient funds for repayment.');
        v_reminder_count := v_reminder_count + 1;
    END LOOP;
    
    IF v_reminder_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reminder dispatch completed. Total reminders printed: ' || v_reminder_count);
    END IF;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in Scenario 3: ' || SQLERRM);
END;
/
