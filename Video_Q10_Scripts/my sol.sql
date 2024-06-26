drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);
insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');

select * from auto_repair;


-- solution
WITH tab_level AS (
    SELECT * 
    FROM auto_repair 
    WHERE indicator = 'level'
),
tab_velocity AS (
    SELECT * 
    FROM auto_repair 
    WHERE indicator = 'velocity'
),
final as (SELECT 
		tl.value as level,
		tv.value as velocity
	FROM 
		tab_level tl
	INNER JOIN 
		tab_velocity tv 
	ON 
		tl.auto = tv.auto and tl.repair_date=tv.repair_date and tl.client=tv.client
)
select 
	velocity,
	sum(case when level='good' then 1 else 0 end) as good,
	sum(case when level='wrong' then 1 else 0 end) as wrong,
	sum(case when level='regular' then 1 else 0 end) as regular
from 
	final
group by velocity;