

--
update ipl_results
set result='Chennai Super Kings'
where match_no=17;

update ipl_results
set result='Mumbai Indians'
where match_no=5;

update ipl_results
set result='Delhi Capitals'
where match_no=20;

update ipl_results
set result='Punjab Kings'
where match_no=27;

update ipl_results
set result='Rajasthan Royals'
where match_no=32;

update ipl_results
set result='Lucknow Super Giants'
where match_no=43;

update ipl_results
set result='Rajasthan Royals'
where match_no=60;

update ipl_results
set result='Sunrisers Hyderabad'
where match_no=65;



with cte_teams as(
	select home_team as teams from ipl_results
	union
	select away_team as teams from ipl_results
	),
cte_joined as
	(select 
	 	match_no,concat(home_team,' vs ',away_team) as match,teams,result,dates,
	    row_number () over (partition by teams order by teams,dates) as rn
	 from cte_teams t1
	 join ipl_results t2 on t2.home_team=t1.teams or t2.away_team=t1.teams
	 order by teams,dates
	),
cte_2 as 
	(select *,rn- row_number () over (partition by teams order by teams,dates) as diff from cte_joined
	where teams=result),
cte_final as
	(select 
		match,teams,result,rn,diff,
		count(diff) over (partition by teams,diff order by teams,dates range between unbounded preceding and unbounded following)
	from cte_2)
	
select teams,max(count) as streak from cte_final 
group by teams
order by max(count) desc;

