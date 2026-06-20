CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
    CURSOR c_savings IS
        SELECT AccountID, Balance
        FROM Accounts
        WHERE AccountType = 'Savings'
        FOR UPDATE OF Balance;
        
    v_interest_rate CONSTANT NUMBER := 0.01;
    v_interest_applied NUMBER;
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Executing ProcessMonthlyInterest...');
    
    FOR r_acc IN c_savings LOOP
        v_interest_applied := r_acc.Balance * v_interest_rate;
        
        UPDATE Accounts
        SET Balance = Balance + v_interest_applied
        WHERE CURRENT OF c_savings;
        
        v_updated_count := v_updated_count + 1;
        DBMS_OUTPUT.PUT_LINE('Savings Account ID: ' || r_acc.AccountID || 
                             ' | Old Balance: $' || TRIM(TO_CHAR(r_acc.Balance, '999,999.99')) || 
                             ' | Interest: $' || TRIM(TO_CHAR(v_interest_applied, '999,999.99')) || 
                             ' | New Balance: $' || TRIM(TO_CHAR(r_acc.Balance + v_interest_applied, '999,999.99')));
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('ProcessMonthlyInterest completed. Total accounts updated: ' || v_updated_count);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in ProcessMonthlyInterest: ' || SQLERRM);
        RAISE;
END;
/
