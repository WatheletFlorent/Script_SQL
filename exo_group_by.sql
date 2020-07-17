use sakila;

select count(*), category.name
from film 
join film_actor ON film_actor.film_id = film.film_id
join actor on actor.actor_id = film_actor.actor_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where actor.first_name = 'JOHNNY' and actor.last_name = 'LOLLOBRIGIDA'
group by category.name;

select count(*) as ap, category.name, actor.first_name, actor.last_name
from film 
join film_actor ON film_actor.film_id = film.film_id
join actor on actor.actor_id = film_actor.actor_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where actor.first_name = 'JOHNNY' and actor.last_name = 'LOLLOBRIGIDA'
group by category.name
having ap >= 3;

select distinct avg(rental_duration), actor.first_name, actor.last_name
from film
join film_actor on film.film_id = film_actor.film_id
join actor on actor.actor_id = film_actor.actor_id
group by actor.first_name, actor.last_name;

select sum(payment.amount) as pa, customer.first_name, customer.last_name
from payment
join customer on payment.customer_id = customer.customer_id
group by customer.first_name, customer.last_name order by pa desc;

select count(rental.return_date) as loue10, film.title
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
group by film.title
having loue10 >= 10;

use sakila;

select distinct actor.first_name , actor.last_name
from actor
join film_actor on film_actor.actor_id = actor.actor_id
join film on film_actor.film_id = film.film_id
where actor.first_name = 'SCARLETT';

select distinct actor.first_name , actor.last_name
from actor
join film_actor on film_actor.actor_id = actor.actor_id
join film on film_actor.film_id = film.film_id
where actor.last_name = 'JOHANSSON';

select count(distinct last_name) from actor;

select last_name 
from actor
group by last_name
having count(last_name) = 1;

select last_name 
from actor
group by last_name
having count(last_name) > 1;

select count(title) as ct, first_name, last_name
from actor
inner join film_actor USING (actor_id)
inner join film using (film_id)
group by actor_id
order by ct desc limit 1;

insert into rental() values