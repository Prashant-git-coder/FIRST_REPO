select  employee_id,department_id,salary 
from employees 
where salary in 
    (
    select max(salary) from employees where salary < 
    (select max(salary) from employees )
    );
