select * from footer;
-- solution 1

select car,length,width,height from
(select car from footer where car is not null order by id desc limit 1) a
cross join
(select length from footer where length is not null order by id desc limit 1) b
cross join
(select width from footer where width is not null order by id desc limit 1) c
cross join
(select height from footer where height is not null order by id desc limit 1) d;

-- solution 2
with cte as 
	(select 
		*,
		sum(case when car is null then 0 else 1 end) over (order by id) as car_segment,
		sum(case when length is null then 0 else 1 end) over (order by id) as length_segment,
		sum(case when width is null then 0 else 1 end) over (order by id) as width_segment,
		sum(case when height is null then 0 else 1 end) over (order by id) as height_segment
	from footer)
SELECT 
	first_value(car) over (partition by car_segment order by id) as new_car,
	first_value(length) over (partition by length_segment order by id) as new_length,
	first_value(width) over (partition by width_segment order by id) as new_width,
	first_value(height) over (partition by height_segment order by id) as new_height
FROM cte
order by id desc
limit 1;