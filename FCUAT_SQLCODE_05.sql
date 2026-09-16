select  employee_id,department_id,salary 
from employees 
where salary in 
    (
----	PRASHANT NARALE 
    select max(salary) from employees where salary < 
    (select max(salary) from employees )
    );
