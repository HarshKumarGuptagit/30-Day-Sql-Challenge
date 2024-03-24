select * from q4_data;

-- output 1
select 
	min(id) as id,
	min(name) as name,
	min(location) as location
FROM q4_data;

-- output 2
select 
	max(id) as id,
	max(name) as name,
	max(location) as location
FROM q4_data;