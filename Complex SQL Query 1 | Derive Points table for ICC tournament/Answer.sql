select team,count(team), sum(win_flag) as no_wins, count(team)-sum(win_flag) as no_losses from
(
select 
	team_1 as team
    , case when team_1 = winner then 1 else 0 end as win_flag
from icc_world_cup
group by team_1
union all
select 
	team_2 as team
    , case when team_2 = winner then 1 else 0 end as win_flag	
from icc_world_cup
group by team_2
)
group by team
order by sum(win_flag) desc,4
