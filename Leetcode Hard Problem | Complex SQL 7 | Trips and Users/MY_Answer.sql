with unbanned_users as(
  select t.*
from trips t
join users u 
	on t.client_id = u.users_id
join users d 
	on t.driver_id = d.users_id
where u.banned = 'No' and d.banned = 'No'
order by id
  )
,cancelled_trips as(
select 
	request_at
    , sum(case when status like 'cancelled_by_%'then 1 else 0 end) as cancelled_trips
    ,count(*) as total_count

from unbanned_users
group by 1
  )
  select
  	request_at,round(cancelled_trips*1.0/total_count,2)*100 as cancellation_rate
  from cancelled_trips
