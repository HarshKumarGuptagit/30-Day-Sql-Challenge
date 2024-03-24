select * from brands;

-- solution

with cte as
	(select 
		brand1,brand2,year,custom1,custom2,custom3,custom4,
		case when brand1<brand2 then concat(brand1,brand2,year) else concat(brand2,brand1,year) end as brandid
	FROM 
		brands
	),
	cte_rn as (
	select 
		*, row_number() over (partition by brandid ) as rn
	from cte)
	
select 
	brand1,brand2, year, custom1,custom2,custom3,custom4
from cte_rn
where rn=1 or (custom1<>custom3 or custom2<>custom4);
;