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

-- 7a
select title 
from film
where 
(title like ('K%') 
or title like ('Q%')) and
(select language_id
from language 
where language_id = 1);

-- 7b
select CONCAT(first_name, ' ', last_name) As Actor_Name
from actor
where actor_id in
(
  select actor_id
  from film_actor
  where film_id = 17
);

-- 7c
select first_name, last_name, email 
from customer
inner join address on address.address_id = customer.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id
where country.country_id = 20;

-- 7d
select title
from film 
where film_id in 
(
  select film_id
  from film_category
  where category_id = 
    (select category_id
     from category
     where name = 'Family'
	)
);

-- 7e 
select film.title as 'Film', count(film.title) as 'Rentals'
from rental
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on film.film_id = inventory.film_id
group by film.title
order by count(film.title) desc;

-- 7f
select store.store_id as 'Store_Number', sum(payment.amount) as 'Total (in Dollars)'
from store
inner join inventory on store.store_id = inventory.store_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on payment.rental_id = rental.rental_id
group by store.store_id;

-- 7g
select store.store_id, city.city, country.country
from store
inner join address on store.address_id = address.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id;

-- 7h
select category.name as category, sum(payment.amount) as gross_sales
from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on inventory.film_id = film_category.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
inner join payment on payment.rental_id = rental.rental_id
group by category.name
order by gross_sales desc
limit 5;

-- 8a
create view Top_5_Genre_by_Revenue as 
  (select category.name as category, sum(payment.amount) as gross_sales
   from category
   inner join film_category on category.category_id = film_category.category_id
   inner join inventory on inventory.film_id = film_category.film_id
   inner join rental on rental.inventory_id = inventory.inventory_id
   inner join payment on payment.rental_id = rental.rental_id
   group by category.name
   order by gross_sales desc
   limit 5
   );
   
-- 8b
select * from Top_5_Genre_by_Revenue;

-- 8c
drop view Top_5_Genre_by_Revenue;