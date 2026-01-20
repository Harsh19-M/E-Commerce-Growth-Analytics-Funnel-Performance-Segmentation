
				/*FINAL AGGREGATE TABLE - DONE BELOW*/

With 
sessions_clean as (

	
	select session_id, session_date, user_id, experiment_id, version_seen, pages_viewed, 
	clicked_product, added_to_cart, completed_purchase, order_id,
	count(*) over(partition by user_id) as "How many sessions"
	from ecom.sessions 
	where experiment_id is not null 

),


users_clean as (

	select user_id, customer_name, signup_date, country, city, state, postal_code
	from ecom.users
),


orders_clean as (

	select order_id, user_id, order_date_dt, order_value, profit
	from ecom.orders
),


experiments_clean as (

	select experiment_id, element_tested, start_date, end_date, effect_on_conv
	from ecom.experiments 
)


select Ec.experiment_id, Ec.element_tested, Sc.version_seen as "Experiment Version", Uc.user_id, 
Uc.customer_name, Uc.signup_date, Uc.country, Uc.city, Uc.state, Uc.postal_code, 
count(distinct Sc.session_id) as "Total Sessions", /*each session must have a distinct session_id*/
count(*) filter(where clicked_product = true) as "Total clickedProduct", 
/*COUNT(clicked_product) counts non-NULL values, not the number of 1’s. So using sum()*/
count(*) filter(where added_to_cart = true) as "Total added to cart", 
count(*) filter(where completed_purchase = true) as "Total completed Purchases",
sum(Sc.pages_viewed) as "Total Pages Viewed",
count(distinct Oc.order_id) as "Total Orders(Total Order IDs)",
coalesce(sum(order_value), 0) as "Total Order_Value", 
coalesce(sum(profit), 0) as "Total Profit", 
Ec.start_date, Ec.end_date, Ec.effect_on_conv

from sessions_clean as Sc 
left join users_clean as Uc on Sc.user_id = Uc.user_id
left join orders_clean as Oc on Sc.order_id = Oc.order_id
left join experiments_clean as Ec on Sc.experiment_id = Ec.experiment_id

group by Ec.experiment_id, Ec.element_tested, Sc.version_seen, Uc.user_id, Uc.customer_name, Uc.signup_date, Uc.country, Uc.city, Uc.state, Uc.postal_code, 
Ec.start_date, Ec.end_date, Ec.effect_on_conv

order by Ec.experiment_id, Sc.version_seen, Uc.user_id asc;

/*-------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------*/


			/* CREATING THE AGGREGATED TABLE */

create table ecom.Agg_ExpDetailsTable  as 

		
With 
sessions_clean as (

	
	select session_id, session_date, user_id, experiment_id, version_seen, pages_viewed, 
	clicked_product, added_to_cart, completed_purchase, order_id,
	count(*) over(partition by user_id) as "How many sessions"
	from ecom.sessions 
	where experiment_id is not null 

),


users_clean as (

	select user_id, customer_name, signup_date, country, city, state, postal_code
	from ecom.users
),


orders_clean as (

	select order_id, user_id, order_date_dt, order_value, profit
	from ecom.orders
),


experiments_clean as (

	select experiment_id, element_tested, start_date, end_date, effect_on_conv
	from ecom.experiments 
)


	select Ec.experiment_id, Ec.element_tested, Sc.version_seen as "Experiment Version", Uc.user_id, 
	Uc.customer_name, Uc.signup_date, Uc.country, Uc.city, Uc.state, Uc.postal_code, 
	count(distinct Sc.session_id) as "Total Sessions", /*each session must have a distinct session_id*/
	count(*) filter(where clicked_product = true) as "Total clickedProduct", 
	/*COUNT(clicked_product) counts non-NULL values, not the number of 1’s. So using sum()*/
	count(*) filter(where added_to_cart = true) as "Total added to cart", 
	count(*) filter(where completed_purchase = true) as "Total completed Purchases",
	sum(Sc.pages_viewed) as "Total Pages Viewed",
	count(distinct Oc.order_id) as "Total Orders(Total Order IDs)",
	coalesce(sum(order_value), 0) as "Total Order_Value", 
	coalesce(sum(profit), 0) as "Total Profit", 
	Ec.start_date, Ec.end_date, Ec.effect_on_conv
	
	from sessions_clean as Sc 
	left join users_clean as Uc on Sc.user_id = Uc.user_id
	left join orders_clean as Oc on Sc.order_id = Oc.order_id
	left join experiments_clean as Ec on Sc.experiment_id = Ec.experiment_id
	
	group by Ec.experiment_id, Ec.element_tested, Sc.version_seen, Uc.user_id, Uc.customer_name, Uc.signup_date, Uc.country, Uc.city, Uc.state, Uc.postal_code, 
	Ec.start_date, Ec.end_date, Ec.effect_on_conv
	
	order by Ec.experiment_id, Sc.version_seen, Uc.user_id asc;

		/* DONE WE HAVE STORED IT IN THIS - CURRENT SCHEMA */



		/* NAME WAS TOO LONG SO CHANGED TO */
alter table ecom.agg_expdetailstable
rename to Agg_Etable



		/* QUICK CHECK */
select *
from ecom.agg_etable;













