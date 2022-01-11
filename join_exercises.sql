use employees;

#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select dept_name as departments_name, concat(first_name,' ',last_name) as manager_name 
from departments 
inner join dept_manager using (dept_no)
inner join employees using (emp_no)
where to_date > now() 
order by dept_name;

#Find the name of all departments currently managed by women.
select dept_name as departments, concat(first_name, ' ', last_name) as employee_name 
from dept_manager 
inner join departments using (dept_no)
inner join employees using (emp_no)
where gender = 'F' and to_date > now()
order by dept_name;

#Find the current titles of employees currently working in the Customer Service department.
select title as title_name, count(emp_no) as count
from titles 
inner join employees using (emp_no)
inner join dept_emp using (emp_no)
inner join departments using (dept_no)
where dept_name = 'customer service' and dept_emp.to_date > now() and titles.to_date > now()
group by title
order by title;

#Find the current salary of all current managers.
select dept_name as departments_name, concat(first_name,' ', last_name) as manager_name, salary
from departments 
inner join dept_manager using (dept_no)
inner join employees using (emp_no)
inner join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
order by dept_name;

#Find the number of current employees in each department.
select dept_no, dept_name, count(emp_no) as num_employees
from departments
inner join dept_emp using (dept_no)
inner join employees using (emp_no)
where to_date > now()
group by dept_no, dept_name
order by dept_no;

#Which department has the highest average salary? Hint: Use current not historic information
select dept_name, format(avg(salary), 2) as average_salary
from departments
join dept_emp using (dept_no)
inner join salaries using (emp_no)
where salaries.to_date > now()
group by dept_name
order by average_salary desc 
/*limit 1*/;

#Who is the highest paid employee in the Marketing department?
select concat(first_name, ' ', last_name) as employee_name
from employees 
inner join salaries using (emp_no)
inner join dept_emp using (emp_no)
inner join departments using (dept_no)
where salaries.to_date > now() and dept_name like '%marketing%'
order by salary desc;

#Which current department manager has the highest salary?
select concat(first_name, ' ', last_name) as manager_name, salary, dept_name as departments_name
from departments
inner join dept_manager using (dept_no)
inner join employees using (emp_no)
inner join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
order by salary desc;

#Determine the average salary for each department. Use all salary information and round your results.
select format(avg(salary), 2) as avg_salary, dept_name
from salaries
join dept_emp using (emp_no)
join departments using (dept_no)
group by dept_name
order by avg_salary desc;

#Bonus Find the names of all current employees, their department name, and their current manager's name.
select concat (first_name, ' ', last_name) as employee_name, dept_name as departments_name, managers.manager_name
from departments
inner join dept_emp using (dept_no)
inner join employees using (emp_no)
inner join (
select dept_name, concat(first_name, ' ', last_name) as manager_name
from dept_manager
inner join employees using (emp_no)
inner join departments using(dept_no)
where dept_manager.to_date > now()
order by dept_name) as managers
using (dept_name)
where dept_emp.to_date > now();

#Bonus Who is the highest paid employee within each department.
select concat(first_name, ' ', last_name) as employee_name, dept_name, highest_salary.salary
from employees 
inner join salaries using (emp_no)
inner join (
select dept_name, max(salary) as salary
from salaries 
inner join employees using (emp_no)
inner join dept_emp using (emp_no)
inner join departments using (dept_no)
where salaries.to_date > now()
group by dept_name) as highest_salary
using (salary);