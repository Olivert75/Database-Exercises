use employees;

#Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select emp_no, dept_no, dept_name, hire_date,
if (to_date > now(), 1, 0) as still_working
from employees
join dept_emp using (emp_no)
join departments using (dept_no)
group by emp_no, dept_name;

#Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select last_name,
case 
when substr(last_name, 1, 1) between 'A' and 'H' then 'A-H'
when substr(last_name, 1, 1) between 'I' and 'Q' then 'I-Q'
else 'R-Z'
end as 'Alpha Group'
from employees order by last_name;

#How many employees (current or previous) were born in each decade?
select count(emp_no) as num_employees,
case
when birth_date like '195%' then 'Born in the 50s'
when birth_date like '196%' then 'Born in the 60s'
end as Born_decade
from employees group by Born_decade;

#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
/*+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+*/
select case
when dept_name = 'Finance' or 'Human Resource' then 'Finance & HR'
when dept_name = 'Sales' or 'Marketing' then 'Sales & Marketing'
when dept_name = 'Production' or 'Quality Management' then 'Prod & QM'
when dept_name = 'Research' or 'Development' then 'R&D'
else 'Customer Service'
end as dept_group, avg(salary) as avg_salary
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where dept_emp.to_date > now() and salaries.to_date > now()
group by dept_group
order by avg_salary;