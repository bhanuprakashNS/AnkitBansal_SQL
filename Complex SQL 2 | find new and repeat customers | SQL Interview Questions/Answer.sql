with
start_date as (
  select 
  	customer_id
  	,min(order_date) ord_date
  from customer_orders
  group by customer_id
)
,customer_data as (
  select
  	order_date
    ,count(case when co.order_date = sd.ord_date then 1 end) as num_new_customers
    ,count(case when co.order_date != sd.ord_date then 1 end) as num_repeat_customers
  	,sum(case when co.order_date = sd.ord_date then co.order_amount end) as new_customer_revenue
    ,sum(case when co.order_date != sd.ord_date then co.order_amount end) as repeat_customer_revenue
  from customer_orders co
  join start_date sd
  	on co.customer_id = sd.customer_id
  group by order_date
)
select * from customer_data


  
   
