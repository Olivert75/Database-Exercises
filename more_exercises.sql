use employees;

#How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

-- find average for each department and manager salary for that department
select emp_no, dept_no, dept_name, salary, avg_salary_by_departments
from (
select emp_no, dept_no, salary
from dept_manager
join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
) as manager_salary
join (
select dept_no, dept_name, avg(salary) as avg_salary_by_departments
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date > now() and dept_emp.to_date > now()
group by dept_no
) as deparments_avg using(dept_no);

-- using query above to compare department manager get less than the avg salary
select emp_no, dept_no, dept_name, salary, avg_salary_by_departments,
case 
when salary > avg_salary_by_departments then 'Higher than average salary'
when salary < avg_salary_by_departments then 'Lower than average salary'
else 'Same as average'
end as 'Manager salary relation to average salary'
from (
select emp_no, dept_no, salary
from dept_manager
join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
) as manager_salary
join (
select dept_no, dept_name, avg(salary) as avg_salary_by_departments
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date > now() and dept_emp.to_date > now()
group by dept_no
) as deparments_avg using(dept_no);
