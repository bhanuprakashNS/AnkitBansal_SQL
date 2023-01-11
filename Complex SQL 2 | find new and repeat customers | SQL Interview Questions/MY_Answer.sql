with
start_date as (
  select 
  	customer_id
  	,min(order_date) ord_date
  from customer_orders
  group by customer_id
)
,new_customers as (
  select
  	ord_date
    ,count(customer_id) as num_new_customers
  from start_date
  group by ord_date
)
,repeat_customers as (
  select
  	order_date
  	,count(case when order_date > ord_date then 1 end) repeat_customers
  from customer_orders co
  join start_date sd on co.customer_id = sd.customer_id
  group by order_date
)
select 
	order_date
    , num_new_customers as new_customer_count
    , repeat_customers as repeat_customer_count
from repeat_customers rc
join new_customers nc
	on rc.order_date = nc.ord_date
  
   
