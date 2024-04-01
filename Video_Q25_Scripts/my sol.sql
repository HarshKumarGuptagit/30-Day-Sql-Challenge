select 
	store_id,
	sum(case when trim(lower(product_1)) like 'apple%' then 1 else 0 end) as cont1,
	sum(case when trim(lower(product_2)) like 'apple%' then 1 else 0 end) as cont2
from product_demo
group by store_id
order by store_id