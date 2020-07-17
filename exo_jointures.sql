use sakila;
 # 1. Lister les 10 premiers films ainsi que leur langues:
 
 
 
 # 2. Afficher les films dans les quel:
 
SELECT DISTINCT title, first_name, last_name FROM actor as a
JOIN film_actor as fa
	ON a.actor_id = fa.actor_id
JOIN film 
	ON fa.film_id = fa.film_id
WHERE a.last_name = 'DAVIS'
	AND a.first_name = 'JENNIFER'
	AND film.release_year = 2006;
    
# Afficher le noms des clients ayant emprunté "ALABAMA DEVIL"

SELECT first_name, last_name, film.title FROM customer as client
JOIN rental
	ON client.customer_id = rental.customer_id
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
WHERE film.title = 'ALABAMA DEVIL';

# 4. Afficher les films louer par des personne habitant à « Woodridge ».#	
#	 Verifie s’il y a des films qui n’ont jamais ete emprunte.


select film.title from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join customer on rental.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
where city.city = 'Woodridge'
union
select film.title from film 
join inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;




# Quel sont les 10 films dont la durée d’emprunt à été la plus courte ?

SELECT title, datediff(return_date, rental_date) as duree_location 
FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
    where datediff(return_date, rental_date) is not null
order by duree_location
LIMIT 10;

# 6. Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

select title, category.name FROM film 
JOIN film_category
	ON film.film_id =  film_category.film_id
JOIN category
	ON film_category.category_id = category.category_id 
WHERE category.name = 'Action';

# 7. Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?

USE sakila;

SELECT DISTINCT film.title, datediff(rental.return_date, rental.rental_date)
FROM rental
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
WHERE datediff(rental.return_date, rental.rental_date) <2 ;


select datediff(return_date, rental_date) from rental;

SELECT F.title, timediff(R.return_date, R.rental_date)
FROM film as F
JOIN inventory as I
	ON F.film_id = I.film_id
JOIN rental as R
	ON I.inventory_id = R.inventory_id
WHERE timediff(R.return_date, R.rental_date) < '47:00:00'
AND timediff(R.return_date, R.rental_date) IS NOT NULL;