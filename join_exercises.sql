use employees;

#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select departments.dept_name as departments_name,concat(employees.first_name,' ',employees.last_name) as manager_name 
from departments 
inner join dept_manager on departments.dept_no = dept_manager.dept_no 
inner join employees on employees.emp_no = dept_manager.emp_no 
where dept_manager.to_date > now() 
order by departments.dept_name;

#Find the name of all departments currently managed by women.
select departments.dept_name as departments, concat(employees.first_name, ' ', employees.last_name) as employee_name 
from dept_manager 
inner join departments on dept_manager.dept_no = departments.dept_no
inner join employees on employees.emp_no = dept_manager.emp_no
where employees.gender = 'F' and dept_manager.to_date > now()
order by departments.dept_name;

#Find the current titles of employees currently working in the Customer Service department.
select titles.title as title_name, count(titles.emp_no) as count
from titles 
inner join employees on employees.emp_no = titles.emp_no
inner join dept_emp on dept_emp.emp_no = employees.emp_no
inner join departments on departments.dept_no = dept_emp.dept_no
where departments.dept_name = 'customer service' and dept_emp.to_date > now() and titles.to_date > now()
group by titles.title
order by titles.title;

#Find the current salary of all current managers.
select departments.dept_name as departments_name,concat(employees.first_name,' ',employees.last_name) as manager_name, salary
from departments 
inner join dept_manager on departments.dept_no = dept_manager.dept_no 
inner join employees on employees.emp_no = dept_manager.emp_no 
inner join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date > now() and salaries.to_date > now()
order by departments.dept_name;
#Find the number of current employees in each department.
#Which department has the highest average salary? Hint: Use current not historic information
#Who is the highest paid employee in the Marketing department?
#Which current department manager has the highest salary?
#Determine the average salary for each department. Use all salary information and round your results.
#Bonus Find the names of all current employees, their department name, and their current manager's name.
#Bonus Who is the highest paid employee within each department.