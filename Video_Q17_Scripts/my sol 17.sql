drop table if exists user_login;
create table user_login
(
	user_id		int,
	login_date	date
);
insert into user_login values(1, to_date('01/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('02/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('03/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('04/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('06/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('10/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('11/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('12/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('13/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('14/03/2024','dd/mm/yyyy'));

insert into user_login values(1, to_date('20/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('25/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('26/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('27/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('28/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('29/03/2024','dd/mm/yyyy'));
insert into user_login values(1, to_date('30/03/2024','dd/mm/yyyy'));

insert into user_login values(2, to_date('01/03/2024','dd/mm/yyyy'));
insert into user_login values(2, to_date('02/03/2024','dd/mm/yyyy'));
insert into user_login values(2, to_date('03/03/2024','dd/mm/yyyy'));
insert into user_login values(2, to_date('04/03/2024','dd/mm/yyyy'));

insert into user_login values(3, to_date('01/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('02/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('03/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('04/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('04/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('04/03/2024','dd/mm/yyyy'));
insert into user_login values(3, to_date('05/03/2024','dd/mm/yyyy'));

insert into user_login values(4, to_date('01/03/2024','dd/mm/yyyy'));
insert into user_login values(4, to_date('02/03/2024','dd/mm/yyyy'));
insert into user_login values(4, to_date('03/03/2024','dd/mm/yyyy'));
insert into user_login values(4, to_date('04/03/2024','dd/mm/yyyy'));
insert into user_login values(4, to_date('04/03/2024','dd/mm/yyyy'));


select * from user_login;


-- my solution 
with cte as(
	select 
		*,
		login_date - (dense_rank() 
					over(partition by user_id order by user_id,login_date))::int
		as date_group 
	from user_login 
	)
select 	
	user_id,
	min(login_date) start_date,
	max(login_date) end_date,	
	max(login_date)-min(login_date)+1 as consecutive_days
from cte
group by user_id,date_group
having max(login_date)-min(login_date)+1>4;
