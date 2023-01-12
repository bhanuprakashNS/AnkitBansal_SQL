with 
distinct_resources as (
  select distinct
  	name
  	, resources
  from entries
  )
, agg_resources as (
	select name
  		,group_concat(resources,",") resources_used
  	from distinct_resources
  	group by name
)
,total_visits as (
	select name
  		,count(floor) total_visits
  from entries
  group by name
)  
, floor_visit_details as(
  select 
  	  name
      ,floor
  	  ,count(1) as no_floor_visits
      ,rank() over(partition by name order by count(1) desc) as rn
  from entries 
  group by name,floor
)
select 
	fvd.name
    ,total_visits
    ,floor as most_visited_floor
    ,resources_used
from floor_visit_details fvd
join total_visits tv on fvd.name = tv.name
join agg_resources ar on fvd.name = ar.name
where fvd.rn = 1
