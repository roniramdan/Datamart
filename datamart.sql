with raw_data as (
	select 
	p.payment_id
	,p.rental_id
	,p.payment_date
	,f.film_id
	,f.title as film_title
	,f.rating as film_rating
	,fc.category_id as film_category
	,p.amount
from payment p 
	left join rental r on p.rental_id = r.rental_id
	left join inventory i on i.inventory_id = r.inventory_id
	left join film f on f.film_id = i.film_id
	left join film_category fc on fc.film_id = f.film_id
)

select 
	concat(payment_date,'_', film_title) as ident
	,date_trunc('month',payment_date):: date as payment_month
	,film_title
	,film_rating
	,film_category
	,sum(amount) as total_revenue 
from raw_data
	group by 1,2,3,4,5
	order by 3