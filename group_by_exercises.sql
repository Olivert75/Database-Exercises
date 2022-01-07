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

select concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), '_', date_format(birth_date, '%m%y')) as user_name, first_name, last_name, birth_date from employees group by first_name, last_name, birth_date; # yes, there are 6 duplicates user_name