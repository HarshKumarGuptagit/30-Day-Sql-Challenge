-- Given table showcases details of pizza delivery order for the year of 2023.
-- If an order is delayed then the whole order is given for free. Any order that takes 30 minutes more than the expected time is considered as delayed order. 
-- Identify the percentage of delayed order for each month and also display the total no of free pizzas given each month.


DROP TABLE IF EXISTS pizza_delivery;
CREATE TABLE pizza_delivery 
(
	order_id 			INT,
	order_time 			TIMESTAMP,
	expected_delivery 	TIMESTAMP,
	actual_delivery 	TIMESTAMP,
	no_of_pizzas 		INT,
	price 				DECIMAL
);


-- Data to this table can be found in CSV File
COPY pizza_delivery(order_id, order_time, expected_delivery, actual_delivery, no_of_pizzas, price) 
FROM 'D:\practice\30 days sql\Video_Q19_Scripts\Video_Q19_Scripts\Video_Q19_Dataset_CSV_FILE.csv' 
DELIMITER ',' CSV HEADER;
select * from pizza_delivery;

-- my sol

select
	to_char(order_time,'Mon-YYYY') as period,
	round(sum(case when to_char(actual_delivery-order_time,'MI')::int>30 then 1 else 0 end)::decimal*100/count(1),1) as time_taken_flag,
	sum(case when to_char(actual_delivery-order_time,'MI')::int>30 then no_of_pizzas else 0 end) as no_of_pizzas
from pizza_delivery
where actual_delivery is not null
group by to_char(order_time,'Mon-YYYY')
order by extract(month from to_date(to_char(order_time,'Mon-YYYY'),'Mon-YYYY'))