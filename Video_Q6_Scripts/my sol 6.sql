select * from student_tests;

-- output 1 (improved marks first test)

with cte as(
	select test_id,marks, 
		lag(marks,1,0) over (order by test_id) as prev_marks
	from student_tests)
select 
	test_id,marks
from cte 
	where prev_marks<marks;
	
-- output 2 ( second test)

with cte as(
	select test_id,marks, 
		lag(marks,1,0) over (order by test_id) as prev_marks
	from student_tests)
select 
	test_id,marks
from cte 
where marks>prev_marks and prev_marks<>0;