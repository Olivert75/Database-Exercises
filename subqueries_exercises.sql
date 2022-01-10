use employees;

#Find all the current employees with the same hire date as employee 101010 using a sub-query.
select * from employees 
where hire_date in ( 
select hire_date 
from employees 
where emp_no ='101010');

#Find all the titles ever held by all current employees with the first name Aamod.
select title from titles
where emp_no in ( 
select emp_no from employees 
where first_name like '%aamod%')
group by title;

#How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select count(emp_no) as num_employees_no_longer_working
from employees 
where emp_no not in (
select emp_no from dept_emp 
where to_date > now());

-- alternative way
select concat(first_name, ' ', last_name) as employee_name, to_date
from employees 
inner join dept_emp using (emp_no)
where to_date in (
select to_date from dept_emp 
where to_date < now());

#Find all the current department managers that are female. List their names in a comment in your code.
select concat(first_name, ' ', last_name) as managers_name, gender 
from employees 
inner join dept_manager using (emp_no)
where gender in (
select gender from employees 
where gender = 'f') and to_date > now();

-- alternative way 
select first_name, last_name from employees 
where gender like '%f%' and emp_no in (
select emp_no from dept_manager 
where to_date > now());
 
#Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select * from salaries
where salary > (
select avg(salary) from salaries)
and to_date > now();


#How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

#Hint Number 1 You will likely use a combination of different kinds of subqueries.
#Hint Number 2 Consider that the following code will produce the z score for current salaries.
 select * from salaries 
 where salary > (
 select max(salary) - std(salary) from salaries ) 
 and to_date > now(); #78 salaries???
 
#Find all the department names that currently have female managers.
select dept_name from departments 
where dept_no in (
select dept_no from dept_manager
where to_date > now() and emp_no in (
select emp_no from employees where gender = 'f'));

#Find the first and last name of the employee with the highest salary.
select first_name, last_name from employees 
where emp_no in (
select emp_no from salaries 
where salary = (
select max(salary) from salaries));

#Find the department name that the employee with the highest salary works in.
select dept_name from departments 
where dept_no in ( 
select dept_no from dept_emp where emp_no in (
select emp_no from salaries where salary = (
select max(salary) from salaries)));