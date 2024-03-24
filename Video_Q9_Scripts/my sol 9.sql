drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

-- solution 

select * from orders;


(select  dates, product_id::text from orders)
union
(SELECT dates, STRING_AGG(product_id::text, ', ') as product_id 
FROM orders 
GROUP BY customer_id,dates)
order by dates,product_id;




