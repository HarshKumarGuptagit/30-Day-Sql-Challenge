-- Find length of comma seperated values in items field

drop table if exists item;
create table item
(
	id		int,
	items	varchar(50)
);
insert into item values(1, '22,122,1022');
insert into item values(2, ',6,0,9999');
insert into item values(3, '100,2000,2');
insert into item values(4, '4,44,444,4444');

select * from item;

-- my sol
with cte as
	(select *,length(unnest(string_to_array(items,',')))
	from item)
select 
id,string_agg(length::text,',')
from cte
group by id
order by id











