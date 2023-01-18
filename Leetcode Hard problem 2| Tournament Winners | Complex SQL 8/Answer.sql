with scores as 
(
select first_player as player
	,first_score as score
from matches

union all

select second_player as player
	,second_score as score
from matches
  )
,player_scores as (
select p.group_id
  	,s.player
	,sum(score) as total_score
from scores s
join players p
	on p.player_id = s.player
group by 1,2
  )
select group_id,player from
(
select 
*
,rank() over(partition by group_id order by total_score desc, player) rn
from player_scores
)
where rn = 1
