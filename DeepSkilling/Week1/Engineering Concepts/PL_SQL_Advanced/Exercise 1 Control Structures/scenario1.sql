SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, MONTHS_BETWEEN(SYSDATE, DOB) / 12 AS Age
        FROM Customers;
        
    v_discount CONSTANT NUMBER := 1.0;
    v_loans_updated NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting Scenario 1: Applying interest rate discounts for customers above 60...');
    
    FOR r_cust IN c_customers LOOP
        IF r_cust.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - v_discount
            WHERE CustomerID = r_cust.CustomerID;
            
            IF SQL%ROWCOUNT > 0 THEN
                v_loans_updated := v_loans_updated + SQL%ROWCOUNT;
                DBMS_OUTPUT.PUT_LINE('Applied ' || v_discount || '% discount for Customer: ' || 
                                     r_cust.Name || ' (ID: ' || r_cust.CustomerID || ', Age: ' || ROUND(r_cust.Age, 1) || ').');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Customer: ' || r_cust.Name || ' (ID: ' || r_cust.CustomerID || 
                                     ', Age: ' || ROUND(r_cust.Age, 1) || ') is over 60 but has no active loans.');
            END IF;
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Interest rate discount update completed. Total loans updated: ' || v_loans_updated);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in Scenario 1: ' || SQLERRM);
END;
/
