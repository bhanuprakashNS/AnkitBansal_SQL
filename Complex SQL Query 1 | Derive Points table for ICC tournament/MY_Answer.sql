with number_matches_data as 
	(select team_1 as team, winner
  from icc_world_cup
  union all
  select team_2 as team, winner
  from icc_world_cup)
select 
	team
    ,count(1) as no_of_matches_played
    ,(select count(winner) from icc_world_cup where winner = team) as no_of_wins
    ,count(1) - (select count(winner) from icc_world_cup where winner = team) as no_of_losses
from number_matches_data
group by 1
order by 3 desc,4
