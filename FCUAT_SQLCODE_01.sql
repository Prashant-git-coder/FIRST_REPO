select  employee_id,department_id,salary 
from employees 
where salary in 
    (
    select max(salary) from employees where salary < 
    (select max(salary) from employees )
    );

--DENSE_RANK
select *
from (
    select employee_id,department_id,salary,  dense_rank() over  
    (order by salary desc ) as  rank_salary 
    from  employees 
     )
where rank_salary=2 ;


--ROWNUM
SELECT  *
FROM (
    SELECT  employee_id,department_id,salary
    FROM employees a
    ORDER BY salary DESC
    ORDER BY salary DESC
    )   
WHERE ROWNUM <= 2;

--DEPARTMENT WISE = 2N HIGHSET SALARY WITH ,DENSE_RANK WITH PARTITION 


SELECT  department_id, salary
FROM (
    SELECT 
           department_id,
           salary,
           DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
    FROM employees
    )
WHERE dept_rank = 2 ORDER BY department_id DESC;4



---CODE DEPLOYED ON UAT SANITY COMPLETED SUCCESSFUL 

