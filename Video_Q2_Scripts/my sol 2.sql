select * from mountain_huts;
select * from trails;


-- solution
with get_start_next as
	(SELECT 
	 	t.hut1, mh.name as start_hut, mh.altitude as start_altitude,
	 	t.hut2, mh2.name as next_hut, mh2.altitude as next_altitude
	 	
	 FROM trails t 
	 INNER JOIN mountain_huts mh on t.hut1=mh.id
	 INNER JOIN mountain_huts mh2 on t.hut2=mh2.id
	),
cte2 as (
SELECT 
	case when start_altitude>next_altitude then start_hut else next_hut end strpt,
	case when start_altitude>next_altitude then hut1 else hut2 end strpt_id,
	
	case when start_altitude<next_altitude then start_hut else next_hut end middlept,
	case when start_altitude<next_altitude then hut1 else hut2 end middlept_id
from get_start_next
)

select 
	t1.strpt as strpt,
	t1.middlept as middlept,
	t2.middlept as endpt
from cte2 t1 join cte2 t2
on t1.middlept_id=t2.strpt_id 
;