SET SERVEROUTPUT ON SIZE UNLIMITED;
SET FEEDBACK ON;
SET ECHO ON;

WHENEVER SQLERROR EXIT FAILURE;

BEGIN
    DECLARE
       V_RC NUMBER;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Applying update ...');
        UPDATE MY_STAGING_TABLE SET CREATED_DATE = SYSDATE;
        V_RC := SQL%ROWCOUNT;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Affected line(s): '|| V_RC);
        DBMS_OUTPUT.PUT_LINE('Execution done.');
    EXCEPTION 
        WHEN OTHERS 
           THEN 
              DBMS_OUTPUT.PUT_LINE('Something wrong! Applying rollback...');
              ROLLBACK;
              RAISE_APPLICATION_ERROR(-20001, SQLERRM);
    END;
END;
/

EXIT;
