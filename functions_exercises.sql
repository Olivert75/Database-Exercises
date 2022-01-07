use employees;

#Write a query to to find all employees whose last name starts and ends with 'E'
select concat (first_name, ' ', last_name) as full_name from employees where last_name like 'e%e';

#Convert the names produced in your last query to all uppercase.
select upper (concat (first_name, ' ', last_name)) as full_name from employees where last_name like 'e%e';

#Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
select * , datediff (now(),hire_date) as total_working_date from employees where birth_date like '%-12-25' and hire_date between '1990-01-01' and '1999-12-31';

#Find the smallest and largest current salary from the salaries table.
select min(salary) as minimun_salary, max(salary) as maximum_salary from salaries;

#Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
select concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), '_', date_format(birth_date, '%m%y')) as user_name, first_name, last_name, birth_date from employees;
