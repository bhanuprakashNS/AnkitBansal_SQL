select request_at
    , sum(case when status like 'cancelled_by_%'then 1 else 0 end) as cancelled_trips
    ,count(1) as total_count
    ,round(sum(case when status like 'cancelled_by_%'then 1 else 0   end)*100.0/count(1),2) cancellation_rate
from trips t
join users u 
	on t.client_id = u.users_id
join users d 
	on t.driver_id = d.users_id
where u.banned = 'No' and d.banned = 'No'
group by 1

