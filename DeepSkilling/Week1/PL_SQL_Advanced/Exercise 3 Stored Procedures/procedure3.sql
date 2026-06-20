CREATE OR REPLACE PROCEDURE TransferFunds(
    p_source_account IN NUMBER,
    p_destination_account IN NUMBER,
    p_amount IN NUMBER
) AS
    v_source_balance Accounts.Balance%TYPE;
    v_dest_exists NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Executing TransferFunds: $' || TRIM(TO_CHAR(p_amount, '999,999.99')) || 
                         ' from Account ' || p_source_account || ' to Account ' || p_destination_account);
    
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Transfer amount must be positive.');
    END IF;
    
    IF p_source_account = p_destination_account THEN
        RAISE_APPLICATION_ERROR(-20004, 'Source and destination accounts must be different.');
    END IF;
    
    BEGIN
        SELECT Balance INTO v_source_balance
        FROM Accounts
        WHERE AccountID = p_source_account
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Source account ' || p_source_account || ' does not exist.');
    END;
    
    BEGIN
        SELECT 1 INTO v_dest_exists
        FROM Accounts
        WHERE AccountID = p_destination_account
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'Destination account ' || p_destination_account || ' does not exist.');
    END;
    
    IF v_source_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20007, 'Insufficient balance. Account ' || p_source_account || 
                                ' has $' || TRIM(TO_CHAR(v_source_balance, '999,999.99')) || 
                                ', but tried to transfer $' || TRIM(TO_CHAR(p_amount, '999,999.99')) || '.');
    END IF;
    
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_source_account;
    
    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_destination_account;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer successful. Funds transferred: $' || TRIM(TO_CHAR(p_amount, '999,999.99')));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
        RAISE;
END;
/
