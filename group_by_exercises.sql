use employees;

#Use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been?
select distinct title from titles; # 7 unique title returned

#Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY
select last_name from employees where last_name like 'e%e' group by last_name;

#Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'
select concat(first_name,' ', last_name) as first_and_last_name from employees where last_name like 'e%e' group by last_name, first_name;

#Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
select last_name from employees where last_name like '%q%' and last_name not like '%qu%' group by last_name; #Chelq, Lindqvist, Qiwen

#Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
select last_name, count(last_name) as number_employee_same_last_name from employees where last_name like 'e%e' group by last_name;

#Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
select gender, count(gender) as count_gender from employees where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya' group by gender;

#Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
select concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), '_', date_format(birth_date, '%m%y')) as user_name, first_name, last_name, birth_date from employees;

select concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), '_', date_format(birth_date, '%m%y')) as user_name, first_name, last_name, birth_date, count(*) as same_username from employees group by user_name, first_name, last_name, birth_date having same_username > 1; # yes, there are 6 duplicates user_name but the output doesnt show

#Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
select dept_no, count(*) as number_employees from dept_emp where to_date > now() group by dept_no;

#Determine how many different salaries each employee has had. This includes both historic and current.
select emp_no, count(salary) as employees_salaries from salaries group by emp_no;

#Find the maximum salary for each employee.
select emp_no, max(salary) as max_salaries_each_employees from salaries group by emp_no;

#Find the minimum salary for each employee.
select emp_no, min(salary) as min_salaries_each_employees from salaries group by emp_no;

#Find the standard deviation of salaries for each employee.
select emp_no, format(std(salary), 2) as deviation_salaries_each_employees from salaries group by emp_no;

#Now find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max_salaries_each_employees from salaries group by emp_no having max_salaries_each_employees > 150000;

#Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no, format(avg(salary), 2) as average_salaries_each_employees from salaries group by emp_no having 80000 >= average_salaries_each_employees <= 90000;
