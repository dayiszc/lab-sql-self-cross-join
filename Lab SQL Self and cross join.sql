use sakila;

-- Get all pairs of actors that worked together.
select * from film_actor;
select * from actor;

select a1.actor_id, a2.actor_id, a1.film_id 
from film_actor a1
join film_actor a2
on a1.actor_id <> a2.actor_id
and a1.film_id = a2.film_id;

-- Get all pairs of customers that have rented the same film more than 1 times.
select * from rental;
select * from inventory;

create table if not exists multiple_rentals
select r.customer_id, i.film_id, count(r.rental_id) as count
from rental r
join inventory i using(inventory_id)
group by r.customer_id, i.film_id
having count > 1;

select * from multiple_rentals mr1
join multiple_rentals mr2
on mr1.film_id = mr2.film_id and mr1.customer_id < mr2.customer_id;

-- Get all possible pairs of actors and films.
select * from (
  select distinct actor_id from film_actor
) sub1
cross join (
  select distinct film_id from film_actor
) sub2;