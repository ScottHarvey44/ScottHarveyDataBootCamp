# 1a. Display the first and last names of all actors from the table `actor`.

SELECT first_name, last_name
FROM actor;

# 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

SELECT UPPER(CONCAT(first_name,' ', last_name)) AS `Actor Name`
FROM actor;

# 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

# 2b. Find all actors whose last name contain the letters `GEN`:

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';


# 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

# 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# 3a. You want to keep a description of each actor. You dont think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).

ALTER TABLE actor
ADD description BLOB;

# 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

ALTER TABLE actor
DROP description;

# 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, count(last_name) AS '# of Actors'
FROM actor
GROUP BY last_name;

# 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.

SELECT last_name, count(last_name) AS 'Actors'
FROM actor
GROUP BY last_name 
HAVING Actors > 1;

# 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.

UPDATE actor
SET first_name ='HARPO'
WHERE first_name ='GROUCHO' AND last_name = 'WILLIAMS';

# 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

UPDATE actor
SET first_name ='GROUCHO'
WHERE first_name ='HARPO';

# 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

SHOW CREATE TABLE address;

# 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

SELECT staff.first_name, staff.last_name, address.address
FROM address
JOIN staff ON
address.address_id=staff.address_id;

# 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

SELECT staff.staff_id, staff.first_name, staff.last_name, sum(payment.amount)
FROM payment
JOIN staff ON
payment.staff_id=staff.staff_id
WHERE (payment.payment_date >= '2005-08-01 12:00:00' AND 
       payment.payment_date <= '2005-08-31 11:59:59') 
GROUP BY staff_id;

# 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

SELECT film.film_id, film.title, count(film_actor.actor_id) as 'actors'
FROM film
INNER JOIN film_actor ON
film.film_id=film_actor.film_id
GROUP BY film.film_id;

# 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

SELECT film.film_id, film.title, count(inventory.inventory_id) AS 'inventory_count'
FROM film
INNER JOIN inventory ON
film.film_id=inventory.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY film_id;

# 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:

  ![Total amount paid](Images/total_payment.png)

SELECT customer.customer_id, customer.first_name,customer.last_name, sum(payment.amount) AS 'Total Amount Paid'
FROM payment
JOIN customer ON
payment.customer_id=customer.customer_id
GROUP BY customer_id
ORDER BY last_name;

# 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

SELECT *
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id = 
(
SELECT language_id
FROM language
WHERE name = 'English'
)
;

# 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
SELECT actor_id
FROM film_actor
WHERE film_id =
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
)
)
;

# 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON
customer.address_ID = address.address_ID
WHERE address.address_id IN
(
SELECT address_id
FROM address
WHERE city_id IN
(
SELECT city_id
FROM city
WHERE country_id IN
(
SELECT country_id
FROM country
WHERE country = 'canada'
)
)
)
;

# 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

SELECT *
FROM film
WHERE film_id IN
(
SELECT film_id
FROM film_category
WHERE category_id =
(
SELECT category_id
FROM category
WHERE name = 'family'
)
)
;

# 7e. Display the most frequently rented movies in descending order.

SELECT title, count(inventory.film_id) AS 'times_rented'
FROM film
JOIN inventory ON
film.film_id=inventory.film_id
JOIN rental ON
inventory.inventory_id=rental.inventory_id
GROUP BY title
ORDER BY times_rented DESC;

# 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, sum(amount) as 'sales'
FROM store s
INNER JOIN staff st
    on s.store_id = st.store_id
INNER JOIN payment p
    on st.staff_id = p.staff_id
GROUP BY s.store_id;

# 7g. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country
FROM store s
INNER JOIN address a
    on s.address_id = a.address_id
INNER JOIN city c
	on a.city_id = c.city_id
INNER JOIN country co
	on c.country_id = co.country_id;

# 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT c.name, sum(p.amount) AS 'sales'
FROM category c
INNER JOIN film_category f
    on c.category_id = f.category_id
INNER JOIN inventory i
	on f.film_id = i.film_id
INNER JOIN rental r
	on i.inventory_id = r.inventory_id
INNER JOIN payment p
	on r.rental_id = p.rental_id    
GROUP BY c.name
ORDER BY sales DESC
LIMIT 5;

# 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you havent solved 7h, you can substitute another query to create a view.

CREATE VIEW top_five_genres AS
(
SELECT c.name, sum(p.amount) AS 'sales'
FROM category c
INNER JOIN film_category f
    on c.category_id = f.category_id
INNER JOIN inventory i
	on f.film_id = i.film_id
INNER JOIN rental r
	on i.inventory_id = r.inventory_id
INNER JOIN payment p
	on r.rental_id = p.rental_id    
GROUP BY c.name
ORDER BY sales DESC
LIMIT 5)
;

# 8b. How would you display the view that you created in 8a?

SELECT * FROM top_five_genres;

# 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

DROP VIEW top_five_genres;