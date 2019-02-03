#1a
USE sakila;
SELECT first_name, last_name 
FROM actor;
#1b
SELECT CONCAT(first_name,  ' ', last_name) AS ' Actor Name'
FROM actor;
#2a
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'JOE';
#2b
SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%GEN%';
#2c
SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;
#2d
SELECT country_id,  country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
#3a
SELECT * FROM actor;
ALTER TABLE actor
ADD COLUMN  middle_name VARCHAR(50) AFTER first_name;
#3b
ALTER TABLE actor 
MODIFY COLUMN middle_name BLOB;
#3c 
ALTER TABLE actor
DROP COLUMN middle_name;
#4a
SELECT last_name, COUNT(*) AS `Count`
FROM actor
GROUP BY last_name;
#4b 
SELECT last_name, COUNT(*) AS `Count`
FROM actor
GROUP BY last_name
HAVING Count > 2;
#4c
UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';
#4d
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';
#5a
DESCRIBE sakila.address;
#6a
SELECT s.first_name, s.last_name, a.address
FROM staff s LEFT JOIN address a ON s.address_id = a.address_id;
#6b
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s LEFT JOIN payment p  ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;
#6c
SELECT f.title, COUNT(a.actor_id) AS 'TOTAL'
FROM film f LEFT JOIN film_actor  a ON f.film_id = a.film_id
GROUP BY f.title;
#6d 2
#6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'TOTAL'
FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name;
#7a
USE sakila;
SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id=(SELECT language_id FROM language where name='English');
#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id
IN (SELECT actor_id FROM film_actor WHERE film_id 
IN (SELECT film_id from film where title='ALONE TRIP'));
#7c
SELECT first_name, last_name, email 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city cit ON (a.city_id=cit.city_id)
JOIN country cntry ON (cit.country_id=cntry.country_id)
WHERE cntry.country = "CANADA";
#7d
SELECT title from film f
JOIN film_category fcat on (f.film_id=fcat.film_id)
JOIN category c on (fcat.category_id=c.category_id);
#7e
SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;
#7f
SELECT s.store_id, SUM(p.amount) 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;
#7g
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);
#7h
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;
#8a
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;
#8b
SELECT* FROM TopFive;
#8c
DROP VIEW TopFive