with score_details as
(select f.personid
 , sum(p.score) as total_friend_score
 , count (1) as no_of_friends 
 from friend f
	inner join person p on f.friendid=p.personid
group by f.personid
having sum(p.score) > 100
 )
select s.*,p.name as person_name
from person p
inner join score_details s on p.personid=s.personid
