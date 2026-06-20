CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Executing UpdateEmployeeBonus for Department: ' || p_department || ' with Bonus: ' || p_bonus_percentage || '%');
    
    IF p_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Bonus percentage cannot be negative.');
    END IF;
    
    IF p_department IS NULL OR TRIM(p_department) IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Department name cannot be null or empty.');
    END IF;
    
    UPDATE Employees
    SET Salary = Salary * (1 + (p_bonus_percentage / 100))
    WHERE Department = p_department;
    
    v_updated_count := SQL%ROWCOUNT;
    
    IF v_updated_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found/updated in department: ' || p_department);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salary update completed. Total employees updated: ' || v_updated_count);
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in UpdateEmployeeBonus: ' || SQLERRM);
        RAISE;
END;
/
