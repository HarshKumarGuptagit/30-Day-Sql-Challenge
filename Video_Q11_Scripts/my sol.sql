drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		decimal
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.4);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;


-- my solution

with average_table as(
	select 
		hotel,round(avg(rating),1) as average_rating  
	from hotel_ratings group by hotel
	),
cte as(
	select 
		hotel,year,rating,average_rating,
		abs(rating-average_rating) as difference,
		row_number() over (partition by hotel order by abs(rating-average_rating) desc) as rn
	from average_table 
	natural join hotel_ratings order by hotel
	)	
select hotel,year,rating from cte
where  rn<>1
order by hotel desc,year asc;
