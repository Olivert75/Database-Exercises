-- *******Employees Database******

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

-- ********World Database********

use world;

#What languages are spoken in Santa Monica?
select language, percentage from countrylanguage 
where countrycode in ('USA')
order by percentage;

#How many different countries are in each region?
select region, count(*) as num_countries 
from country 
group by region
order by num_countries;

#What is the population for each region?
select region, sum(population) as total_population
from country 
group by region 
order by total_population desc;

#What is the population for each continent?
select continent, sum(population) as total_population
from country 
group by continent 
order by total_population desc;

#What is the average life expectancy globally?
select avg(lifeexpectancy) as avg_life_expectancy
from country;

#What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
-- Region
select region, avg(lifeexpectancy) as avg_life_expectancy
from country
group by region
order by avg_life_expectancy;

-- Continent
select continent, avg(lifeexpectancy) as avg_life_expectancy
from country
group by continent
order by avg_life_expectancy;

-- ******Bonus******
#Find all the countries whose local name is different from the official name
select name, localname 
from country 
where name not like localname;

#How many countries have a life expectancy less than x? (pick any country for x)
select count(*) as num_countries_lifeexpectancy_less_than_vietnam from country
where lifeexpectancy < (
select lifeexpectancy
from country 
where name in ('vietnam') order by name);
#What state is city x located in?
select name, district, countrycode
from city 
where name like '%sydney%';

#What region of the world is city x located in? Look at the relation between city and country (connect by code)
select city.name as 'City Name', city.district as 'District', country.name as 'Country Name', country.region as 'Region'
from country
join city on city.countrycode = country.code
where city.name like '%tokyo%';

#What country (use the human readable name) city x located in?
select city.name as 'City Name', country.name as 'Country Name'
from city
join country on country.code = city.countrycode
where city.name like '%Belg%';

#What is the life expectancy in city x?
select lifeexpectancy
from country
join city on city.countrycode = country.code
where city.name like '%tokyo%';

-- *****Sakila Database*****
use sakila;

#Display the first and last names in all lowercase of all the actors.
select lower(concat(first_name, ' ', last_name)) as full_actors_name from actor;

#You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
select actor_id, first_name, last_name from actor where first_name like '%joe%';

#Find all actors whose last name contain the letters "gen":
select concat(first_name, ' ', last_name) as full_actors_name from actor 
where last_name like '%gen%';

#Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
select concat(first_name, ' ', last_name), first_name, last_name as full_actors_name from actor 
where last_name like '%li%'
order by last_name;

#Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country 
where country in ('Afghanistan', 'Bangladesh', 'China');

#List the last names of all the actors, as well as how many actors have that last name.
select last_name, count(*) as num_same_last_name
from actor group by last_name;

#List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(*) as num_same_last_name
from actor group by last_name having num_same_last_name > 1;

#You cannot locate the schema of the address table. Which query would you use to re-create it?
use sakila;

#Use JOIN to display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address from staff
join address using (address_id);

#Use JOIN to display the total amount rung up by each staff member in August of 2005.
select first_name, last_name, sum(amount) as total_amount
from staff
join payment using (staff_id)
where year(payment_date) = 2005 and month(payment_date) = 8
group by staff_id;

#List each film and the number of actors who are listed for that film.
select count(*) as num_film
from inventory
join film using (film_id)
group by film_id;

#How many copies of the film Hunchback Impossible exist in the inventory system?
select count(*) as num_film
from inventory
join film using (film_id)
where title like 'Hunchback Impossible'
group by film_id;

#The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title from(
select title, language_id from film
where title like '%k' or title like '%q') as qk_titles
join language using (language_id)
where language.name like 'English';

#Use subqueries to display all actors who appear in the film Alone Trip.
select concat(first_name,' ', last_name) as actor_name from (
select title, film_id from film
where title like 'alone trip') as title
join film_actor using (film_id)
join actor using (actor_id);
-- Alternative way
select first_name, last_name
from film
join film_actor using (film_id)
join actor using (actor_id)
where title = 'alone trip' ;

#You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
select email, country, first_name, last_name from (
select country, country_id from country 
where country like 'canada') as country
join city using (country_id)
join address using (city_id)
join customer using (address_id);

#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select title from film
join film_category using (film_id)
join category using (category_id)
where category.name like 'family';

#Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) from store
join customer using (store_id)
join payment using (customer_id)
group by store_id;

#Write a query to display for each store its store ID, city, and country.
select store_id, city, country from store 
join address using (address_id)
join city using (city_id)
join country using (country_id);

#List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select category.name, sum(amount) as total_amount from film
join film_category using (film_id)
join category using (category_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
group by category.name order by total_amount desc limit 5;

