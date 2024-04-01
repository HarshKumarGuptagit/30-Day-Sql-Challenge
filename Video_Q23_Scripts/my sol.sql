with recursive cte as (
	select rn,bus_id,capacity,passengers_to_board,
	least(capacity,passengers_to_board) as boarded,
	least(capacity,passengers_to_board) as total_boarded
	from tab_data where rn=1
	
	union all
	
	select d.rn,d.bus_id,d.capacity,d.passengers_to_board,
	least(d.capacity,d.passengers_to_board-cte.total_boarded) as boarded,
	cte.total_boarded + least(d.capacity,d.passengers_to_board-cte.total_boarded) as total_boarded
	from  cte join tab_data d on d.rn= cte.rn+1
	
	
	),
tab_data as
	(select 
	 	row_number() over (order by arrival_time) as rn,
		b.bus_id,
	 	b.capacity,
		(select count(1) from passengers p where p.arrival_time<=b.arrival_time) as passengers_to_board
	from buses b)
select bus_id,boarded from cte
order by bus_id