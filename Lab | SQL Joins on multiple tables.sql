-- Lab | SQL Joins on multiple tables
-- In this lab, you will be using the Sakila database of movie rentals.

-- Write a query to display for each store its store ID, city, and country.
select store.store_id, city.city, country.country
from store, address, city, country
where address.address_id=store.address_id 
and city.city_id=address.city_id
and country.country_id=city.country_id ; 

-- Write a query to display how much business, in dollars, each store brought in.
select staff_id as store, concat('$',sum(amount)) as business 
from payment 
group by staff_id ; 

-- What is the average running time of films by category?
select category.name, avg(film.length) as avg_time
from film_category, film, category
where film_category.film_id=film.film_id
and film_category.category_id=category.category_id
group by film_category.category_id ; 

-- Which film categories are longest?
select category.name, avg(film.length) as avg_time
from film_category, film, category
where film_category.film_id=film.film_id
and film_category.category_id=category.category_id
group by film_category.category_id 
order by avg(film.length) desc 
limit 1; 

-- Display the most frequently rented movies in descending order.
select film.title, count(rental.rental_id) as frequence_rented
from rental, inventory, film
where rental.inventory_id=inventory.inventory_id
and inventory.film_id=film.film_id
group by inventory.film_id
order by count(rental.rental_id) desc 
limit 10; 

-- List the top five genres in gross revenue in descending order.
select category.name, concat('$',sum(amount)) as business 
from category, film_category, payment, rental, inventory
where category.category_id=film_category.category_id
and payment.rental_id=rental.rental_id
and rental.inventory_id=inventory.inventory_id
and inventory.film_id=film_category.film_id
group by category.name 
order by business desc 
limit 5 ; 

-- Is "Academy Dinosaur" available for rent from Store 1?
select distinct inventory.store_id, film.title
from inventory, film
where inventory.film_id=film.film_id
and inventory.store_id=1
and title like 'Academy Dinosaur';