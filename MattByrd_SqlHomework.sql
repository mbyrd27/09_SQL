/* 
Matt Byrd
SQL Homework
November 1, 2018
*/

-- 1a
select first_name, last_name from actor;

-- 1b
select CONCAT(first_name, ' ', last_name) As Actor_Name
from actor;

-- 2a
select actor_id, first_name, last_name from actor
where first_name = 'Joe';

-- 2b
select * from actor where last_name like ('%GEN%');

-- 2c
select * from actor where last_name like ('%LI%')
order by last_name, first_name;

-- 2d
select country_id, country from country where
country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor 
ADD description BLOB;

-- 3b
ALTER TABLE actor
DROP description;

-- 4a
select last_name, count(last_name) as last_name_count
from actor
group by last_name;


-- 4b
select last_name, count(last_name) as last_name_count
from actor
group by last_name
having last_name_count > 1
order by last_name_count desc;

-- Part of 4c
select * from actor where first_name = 'HARPO' and last_name = 'WILLIAMS';
-- 4c
update actor
set first_name = 'HARPO' 
where first_name = 'GROUCHO' and
last_name = 'WILLIAMS';

-- 4d
update actor 
set first_name = 'GROUCHO' where 
first_name = 'HARPO';

-- 5a
show create table address;

-- 6a 
select staff.first_name, staff.last_name, address.address
from staff
inner join address on staff.address_id = address.address_id;

-- 6b
select staff.first_name, staff.last_name, sum(payment.amount) as August_2005_Total
from staff
inner join payment on staff.staff_id = payment.staff_id
where payment.payment_date >= '2005-08-01 00:00:00' AND
payment.payment_date <= '2005-08-31 23:59:59'
group by staff.first_name;

-- 6c
select film.title, count(film_actor.actor_id) as No_Actors
from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.title;

-- 6d
select film.title, count(inventory.film_id) as No_Titles
from film
inner join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- 6e
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
from customer
inner join payment on customer.customer_id = payment.customer_id
group by customer.customer_id
order by last_name asc;