use employees;

#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select departments.dept_name as departments_name,concat(employees.first_name,' ',employees.last_name) as manager_name from departments inner join dept_manager on departments.dept_no = dept_manager.dept_no inner join employees on employees.emp_no = dept_manager.emp_no where dept_manager.to_date > now() order by departments.dept_name;

#Find the name of all departments currently managed by women.
#Find the current titles of employees currently working in the Customer Service department.
#Find the current salary of all current managers.
#Find the number of current employees in each department.
#Which department has the highest average salary? Hint: Use current not historic information
#Who is the highest paid employee in the Marketing department?
#Which current department manager has the highest salary?
#Determine the average salary for each department. Use all salary information and round your results.
#Bonus Find the names of all current employees, their department name, and their current manager's name.
#Bonus Who is the highest paid employee within each department.