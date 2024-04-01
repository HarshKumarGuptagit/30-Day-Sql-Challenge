select cust_name,email from feedback
where email ~ '^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z]+\.[a-zA-Z]{2,3}$'

-- MYSQL
-- select cust_name,email from feedback
-- where email regexp '^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z]+\.[a-zA-Z]{2,3}$';