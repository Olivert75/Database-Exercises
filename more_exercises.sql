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

use sakila;

/*SELECT statements

Select all columns from the actor table.
Select only the last_name column from the actor table.
Select only the following columns from the film table.*/
select * from actor;
select last_name from actor;

/*DISTINCT operator

Select all distinct (different) last names from the actor table.
Select all distinct (different) postal codes from the address table.
Select all distinct (different) ratings from the film table.*/
select distinct last_name from actor;
select distinct postal_code from address;
select distinct rating from film;

/*WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
Select all columns minus the password column from the staff table for rows that contain a password.
Select all columns minus the password column from the staff table for rows that do not contain a password.*/
select title, description, rating, length from film where length > (3*60);
select payment_id, amount, payment_date from payment where payment_date >= 05272005;
select payment_id, amount, payment_date from payment where payment_date = 05272005;
select * from customer where last_name like 's%' and first_name like '%n';
select * from customer where active = '1' or last_name like 's%';
select * from category where category_id > 4 and name like 'c%' or name like 's%' or name like 't%';
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update from staff where password is not null;
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update from staff where password is null;


/*IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
Select all columns from the film table for films rated G, PG-13 or NC-17.*/
select phone, district from address where district in('California', 'England', 'Taipei','West Java');
select payment_id, amount, payment_date from payment where date(payment_date) in ('2005-05-25', '2005-05-27',  '2005-05-29');
select * from film where rating in ('g', 'pg-13', 'nc-17');
describe payment;
/*BETWEEN operator

Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.*/
select * from payment where payment_date between '2005-05-25 00:00:01' and '2005-05-26 00:00:00';
select film_id, title, description from film where length between (1*100) and (2*60);

/*LIKE operator

Select the following columns from the film table for rows where the description begins with "A Thoughtful".
Select the following columns from the film table for rows where the description ends with the word "Boat".
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.*/
select * from film where description like 'a%';
select * from film where description like '%boat';
select * from film where description like '%database%' and length > (3*60);

/*LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.*/
select * from payment limit 20;
select payment_date, amount from payment where amount > 5 limit 1000 offset 1000 ;
select * from payment limit 100 offset 100 ;

/*ORDER BY statement

Select all columns from the film table and order rows by the length field in ascending order.
Select all distinct ratings from the film table ordered by rating in descending order.
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.*/
select * from film order by length asc;
select * from film order by rating desc;


/*JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 620
Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200
Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43
Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600
Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows
Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2  */

select customer.first_name, customer.last_name, actor.first_name, actor.last_name 
from customer 
left join actor using (last_name);

select customer.first_name, customer.last_name, actor.first_name, actor.last_name 
from customer 
right join actor using (last_name);

select customer.first_name, customer.last_name, actor.first_name, actor.last_name 
from customer 
join actor using (last_name);

select city, country from city left join country using (country_id);

select title, description, release_year, name as language from film left join language using (language_id);

#What is the average replacement cost of a film? Does this change depending on the rating of the film?
select avg(replacement_cost) from film;

select rating, avg(replacement_cost) from film group by rating;

#How many different films of each genre are in the database?
select name, count(*) from film
join film_category using (film_id)
join category using (category_id)
group by name;

#What are the 5 frequently rented films?
select title, count(*)
from film
join inventory using (film_id)
join rental using (inventory_id)
group by title
order by count(*) desc limit 5;

#What are the most most profitable films (in terms of gross revenue)?
select title, sum(amount) as total
from film
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
group by title order by total desc;

#Who is the best customer?
select concat(customer.first_name, ' ', customer.last_name) as name, sum(payment.amount) as revenue
from film 
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
join customer on customer.customer_id = payment.customer_id
group by concat(customer.first_name, ' ', customer.last_name);

#Who are the most popular actors (that have appeared in the most films)?
select concat(first_name, ' ', last_name) as actor_name, count(*)
from film
join film_actor using (film_id)
join actor using (actor_id)
group by concat(first_name, ' ', last_name)
order by count(*) desc;

#What are the sales for each store for each month in 2005?
select substr(payment_date, 1, 7) as month, store_id, sum(amount) as total
from payment 
join store on staff_id = manager_staff_id
where substr(payment_date, 1, 7)
group by substr(payment_date, 1, 7), store_id;

-- or 
select date_format(payment_date, '%Y%m') as month, store_id, sum(amount) as total
from payment 
join store on staff_id = manager_staff_id
where date_format(payment_date, '%Y%m')
group by date_format(payment_date, '%Y%m'), store_id;

#Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
select title, first_name, last_name, phone from film
join inventory using (film_id)
join rental using (inventory_id)
join customer using (customer_id)
join address using (address_id)
where return_date is null;
