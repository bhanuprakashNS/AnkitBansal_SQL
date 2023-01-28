with sales_details as 
(select
    product_name
    ,product_id
    ,round(sum(sales),2) sales_amount
    --,APPROX_PERCENTILE(sum(sales)) percentile
    
from kirby_external_data.superstore_test
group by 1,2 
)
,cumulative_sales_details as
(select 
    product_name
    ,product_id
    ,sales_amount
    ,round(sum(sales_amount) over(order by sales_amount desc range between UNBOUNDED PRECEDING and CURRENT ROW),2) cum_sum
    ,round(sum(sales_amount) over(order by sales_amount desc rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING),2) total_sum
    ,round(sum(sales_amount) over(order by sales_amount desc range between UNBOUNDED PRECEDING and CURRENT ROW)*100.0/sum(sales_amount) over(order by sales_amount desc rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING),2) percent_sales
    ,round(row_number() over(order by sales_amount desc)*100.0/count(product_name) over(rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING),2) product_pct
from sales_details
)
select * from cumulative_sales_details where percent_sales < 80
