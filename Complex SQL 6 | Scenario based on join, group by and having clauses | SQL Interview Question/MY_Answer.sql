with score as
(
select 
  f.personid
  ,friendid
  ,name
  ,score
from person p
join friend f 
  on f.friendid = p.personid
)
select
	s.personid
    ,p.name
    ,count(s.friendid) as num_friends
    ,sum(s.score)  as total_score
from score s
join person p
	on s.personid = p.personid
group by 1,2
having sum(s.score) > 100
