
select * from vacation_plans;
select * from leave_balance;
with recursive r_tb as(
		with main_tb as
			(with cte as (select id,emp_id,from_dt,to_dt,count(weekdays)::int as vacation_days from vacation_plans vp
				cross join lateral(
				select to_char(dates::date,'Day') as weekdays from
					generate_series(vp.from_dt,vp.to_dt,'1 Day') dates
				)
				where trim(weekdays) not in ('Saturday','Sunday')
				group by id,emp_id,from_dt,to_dt)
			select cte.*,lb.balance,ROW_NUMBER() over (partition by cte.emp_id order by cte.from_dt) rn
			from cte inner join leave_balance lb on cte.emp_id=lb.emp_id
			)
		select main_tb.*,balance-vacation_days as remain_days
		from main_tb
		where rn=1
	
		union all
		select  mt.*,(rt.remain_days-mt.vacation_days) as remain_days
		from r_tb rt inner join main_tb mt on mt.rn=rt.rn+1 and mt.emp_id=rt.emp_id
	)
select 
	emp_id,
	from_dt,
	to_dt,
	vacation_days,
	case when remain_days<0 then 'Insufficient Leave Balance' else 'Approved'   end as status
from r_tb;