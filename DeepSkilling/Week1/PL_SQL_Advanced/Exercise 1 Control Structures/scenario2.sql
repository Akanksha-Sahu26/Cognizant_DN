SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance, IsVIP
        FROM Customers;
        
    v_vip_threshold CONSTANT NUMBER := 10000.00;
    v_promoted_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting Scenario 2: Promoting customers to VIP status based on balance...');
    
    FOR r_cust IN c_customers LOOP
        IF r_cust.Balance > v_vip_threshold THEN
            IF r_cust.IsVIP != 'TRUE' THEN
                UPDATE Customers
                SET IsVIP = 'TRUE'
                WHERE CustomerID = r_cust.CustomerID;
                
                v_promoted_count := v_promoted_count + 1;
                DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' (ID: ' || r_cust.CustomerID || 
                                     ', Balance: $' || TRIM(TO_CHAR(r_cust.Balance, '999,999.99')) || ') promoted to VIP.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' (ID: ' || r_cust.CustomerID || 
                                     ') is already VIP.');
            END IF;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('VIP promotions completed. Total customers promoted: ' || v_promoted_count);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in Scenario 2: ' || SQLERRM);
END;
/
