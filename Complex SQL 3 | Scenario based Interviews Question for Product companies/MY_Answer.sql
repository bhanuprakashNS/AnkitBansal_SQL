with details as (select *
	,count(floor) over( partition by name,floor) name_floor_count
from entries
)
, distinct_resources as (
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
, floor_visit_details as(
  select 
      name
      ,count(floor) total_floors_visited
      ,case when name_floor_count = max(name_floor_count) then floor end as most_visited_floor
  from details 
  group by name
)
select 
	fvd.name
    ,total_floors_visited
    ,most_visited_floor
    ,resources_used
from floor_visit_details fvd
join agg_resources ar on fvd.name = ar.name
