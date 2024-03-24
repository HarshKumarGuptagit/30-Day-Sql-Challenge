
drop table if exists invoice;
create table invoice
(
	serial_no		int,
	invoice_date	date
);
insert into invoice values (330115, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330120, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330121, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330122, to_date('02-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330125, to_date('02-Mar-2024','DD-MON-YYYY'));

select * from invoice;

-- my solution




with recursive cte as(
	(select min(serial_no) as n from invoice)
	union 
	select n+1 from cte where (n+1)< (select max(serial_no) from invoice)
)
select n as missing_serial_no from cte
where n not in (select serial_no from invoice);








