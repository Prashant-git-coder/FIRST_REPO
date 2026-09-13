CREATE OR REPLACE PROCEDURE EMP_SALARY_DETAILS
IS

    -- Variables
    v_3rd_highest_salary EMP.EMP_SALARY%TYPE;

BEGIN

    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       ALL EMPLOYEE DETAILS');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 1. Display all employees
    FOR r IN (SELECT * FROM EMP) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'EMP_ID: ' || r.EMP_ID ||
            ' | SALARY: ' || r.EMP_SALARY
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       SALARY DESCENDING');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 2. Salary descending
    FOR r IN (
        SELECT EMP_SALARY
        FROM EMP
        ORDER BY EMP_SALARY DESC
    ) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'SALARY: ' || r.EMP_SALARY
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       TOP 3 EMPLOYEES');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 3. Top 3 employees
    FOR r IN (
        SELECT *
        FROM (
            SELECT *
            FROM EMP
            ORDER BY EMP_SALARY DESC
        )
        WHERE ROWNUM <= 3
    ) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'EMP_ID: ' || r.EMP_ID ||
            ' | SALARY: ' || r.EMP_SALARY
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       TOP 3 SALARY USING DENSE_RANK');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 4. DENSE_RANK
    FOR r IN (
        SELECT EMP_ID,
               EMP_SALARY,
               DENSE_RANK() OVER (
                   ORDER BY EMP_SALARY DESC
               ) AS SALARY_RANK
        FROM EMP
    ) LOOP

        IF r.SALARY_RANK <= 3 THEN

            DBMS_OUTPUT.PUT_LINE(
                'EMP_ID: ' || r.EMP_ID ||
                ' | SALARY: ' || r.EMP_SALARY ||
                ' | RANK: ' || r.SALARY_RANK
            );

        END IF;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       3RD HIGHEST SALARY');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 5. 3rd highest salary using MAX
    SELECT MAX(EMP_SALARY)
    INTO v_3rd_highest_salary
    FROM EMP
    WHERE EMP_SALARY <
    (
        SELECT MAX(EMP_SALARY)
        FROM EMP
        WHERE EMP_SALARY <
        (
            SELECT MAX(EMP_SALARY)
            FROM EMP
        )
    );

    DBMS_OUTPUT.PUT_LINE(
        '3RD HIGHEST SALARY: ' || v_3rd_highest_salary
    );


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       ROW_NUMBER = 3');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 6. ROW_NUMBER
    FOR r IN (
        SELECT EMP_ID,
               EMP_SALARY,
               ROW_NUMBER() OVER (
                   ORDER BY EMP_SALARY DESC
               ) AS SALARY_NUMBER
        FROM EMP
    ) LOOP

        IF r.SALARY_NUMBER = 3 THEN

            DBMS_OUTPUT.PUT_LINE(
                'EMP_ID: ' || r.EMP_ID ||
                ' | SALARY: ' || r.EMP_SALARY ||
                ' | ROW_NUMBER: ' || r.SALARY_NUMBER
            );

        END IF;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       RANK = 3');
    DBMS_OUTPUT.PUT_LINE('======================================');

    -- 7. RANK
    FOR r IN (
        SELECT EMP_ID,
               EMP_SALARY,
               RANK() OVER (
                   ORDER BY EMP_SALARY DESC
               ) AS SALARY_RANK
        FROM EMP
    ) LOOP

        IF r.SALARY_RANK = 3 THEN

            DBMS_OUTPUT.PUT_LINE(
                'EMP_ID: ' || r.EMP_ID ||
                ' | SALARY: ' || r.EMP_SALARY ||
                ' | RANK: ' || r.SALARY_RANK
            );

        END IF;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       PROCEDURE COMPLETED');
    DBMS_OUTPUT.PUT_LINE('======================================');


EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee/salary data found.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: ' || SQLERRM
        );

END EMP_SALARY_DETAILS;
/

----------------------------END