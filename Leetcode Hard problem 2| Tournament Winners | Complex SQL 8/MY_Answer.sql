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
select player
	,sum(score) as total_score
from scores  
group by 1
  )
select group_id, min(player) from
(
select 
 	player
    ,group_id
    ,total_score
    ,max(total_score) over(partition by group_id) max_score
from player_scores ps
join players p
	on p.player_id = ps.player
)
where total_score = max_score
group by 1
