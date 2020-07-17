use sakila;

#1- Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée)
select customer.first_name , customer.last_name, store.store_id as vidéo_club, datediff(rental.return_date, rental.rental_date)
from rental 
join customer on rental.customer_id = customer.customer_id
join store on store.store_id = customer.store_id
order by datediff(rental.return_date, rental.rental_date) desc limit 10;
#2- Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé)
select customer.first_name , customer.last_name, sum(payment.amount) as p
from customer
join payment on customer.customer_id = payment.customer_id
group by payment.customer_id
order by p desc limit 10;
#3- Afficher la durée moyenne de location par film triée de manière descendante
select film.title , avg(datediff(rental.return_date, rental.rental_date)) as d
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
group by film.title
order by d  desc;
#4- Afficher tous les films n'ayant jamais été empruntés
select distinct film.title , datediff(rental.return_date, rental.rental_date) as d
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
where d = 0;
#5- Afficher le nombre d'employés (staff) par video club
select count(staff.first_name), store.store_id as video_club
from staff
join store on staff.store_id = store.store_id
group by store.store_id;
#6- Afficher les 10 villes avec le plus de video clubs
select city.city, count(address.city_id)
from city
join address on address.city_id = city.city_id
join store on store.address_id = address.address_id
group by address.city_id;
#7- Afficher le film le plus long dans lequel joue Johnny Lollobrigida
select  actor.first_name , actor.last_name, film.title, film.length
from film
join film_actor on film.film_id = film_actor.film_id
join actor on actor.actor_id = film_actor.actor_id
where actor.first_name = 'JOHNNY' and actor.last_name = 'LOLLOBRIGIDA'
group by film.title, film.length
order by film.length desc limit 1;
#8- Afficher le temps moyen de location du film 'Academy dinosaur'
select film.title , avg(datediff(rental.return_date, rental.rental_date)) as d
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
where film.title = 'ACADEMY DINOSAUR'
group by film.title
order by d  desc;
#9- Afficher les films avec plus de deux exemplaires en invenatire (store id, titre du film, nombre d'exemplaires)
select store.store_id, film.title, count(film.title) 
from film
join inventory on inventory.film_id = film.film_id
join store on store.store_id = inventory.store_id
group by store.store_id, film.title
having count(film.title) >= 2;
#10- Lister les films contenant 'din' dans le titre
select film.title from film where film.title like '%din%';
#11- Lister les 5 films les plus empruntés
select film.title, rental_duration from film order by rental_duration desc limit 5;
#12- Lister les films sortis en 2003, 2005 et 2006
select film.title, film.release_year from film where film.release_year = 2006 or film.release_year= 2005 or film.release_year= 2006;
#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. Afficher seulement les 10 premiers.
select film.title ,datediff(rental.return_date, rental.rental_date)
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
where datediff(rental.return_date, rental.rental_date) is null limit 10;
#14- Afficher les films d'action durant plus de 2h
select film.title, category.name, film.length
from film
join film_category on film.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name = 'Action' and film.length >120;
#15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17
select film.title, customer.first_name, customer.last_name, film.rating
from film 
join inventory on inventory.film_id = film.film_id
join rental on rental.inventory_id = inventory.inventory_id
join customer on customer.customer_id = rental.customer_id
where film.rating = 'NC-17';
#16- Afficher les films d'animation dont la langue originale est l'anglais
select film.title, category.name , language.name
from language
join film on language.language_id = film.language_id
join film_category on film_category.film_id = film.film_id
join category on film_category.category_id = category.category_id
where language.name = 'English' and category.name = 'Animation';
#17- Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny)
select  actor.first_name , actor.last_name, film.title
	from film
	join film_actor on film.film_id = film_actor.film_id
	join actor on actor.actor_id = film_actor.actor_id
where actor.first_name = 'JENNIFER';
union
select  actor.first_name , actor.last_name, film.title
	from film
	join film_actor on film.film_id = film_actor.film_id
	join actor on actor.actor_id = film_actor.actor_id
where actor.first_name = 'JOHNNY';
#18- Quelles sont les 3 catégories les plus empruntées?
select count(category.name) as ca , category.name
from category
join film_category on film_category.category_id = category.category_id
join film on film.film_id = film_category.film_id
join inventory on inventory.film_id = film.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by category.name
order by ca desc limit 3;
#19- Quelles sont les 10 villes où on a fait le plus de locations?
select count(city.city) as ci , city.city
from city
join address as a on a.city_id = city.city_id
join customer as c on a.address_id = c.address_id
join rental as r on r.customer_id = c.customer_id
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id
group by city.city
order by ci desc limit 10;
#20- Lister les acteurs ayant joué dans au moins 1 film
select count(f.film_id) as cf, a.first_name, a.last_name 
from film as f
join film_actor as fa on fa.film_id = f.film_id
join actor as a on fa.actor_id = a.actor_id
group by a.first_name, a.last_name 
having cf >1;