SELECT product_id,day_indicator,dates 
FROM 
	(select 
		*,
		Case when 
		substring(day_indicator,extract('isodow' from dates)::int,1)='1'
		THEN 1 Else 0
		end as flag
	from day_indicator)
WHERE flag=1;
