#1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
#2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
#3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
#4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
#5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

use sakila;
select * from film limit 2;
select title, length, dense_rank() over (order by length asc) as new_ranking from film
where length is NOT NULL and length > 0;
select title, length, rating, dense_rank () over (partition by rating order by length asc) 
as ranking from film where length is NOT NULL and length > 0;
select * from film_category limit 3;
select * from category limit 2;

select a.actor_id, a.first_name, a.last_name, count(f.film_id) as movies_total from actor as a 
join film_actor as f
on a.actor_id = f.actor_id
group by a.actor_id
order by movies_total desc limit 1;
select c.first_name, c.last_name, COUNT(r.rental_id) as movies_rented from rental as r
join customer as c
on r.customer_id = c.customer_id 
group by r.customer_id
order by movies_rented desc limit 1;