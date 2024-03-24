select * from salary;
select * from income;
select * from deduction;

INSERT INTO emp_transaction 
(
	select 
		emp_id,emp_name,income as trns_type,
		(percentage*base_salary)/100 as amount
	from 
		(select * from salary cross join income 
			union all
		select * from salary cross join deduction) tab
	order by trns_type,emp_name,emp_id asc
);

-- active the crosstab
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- output 2


SELECT 
    emp_name AS employee,
    "Basic",
    "Allowance",
    "Others",
    ("Basic" + "Allowance" + "Others") AS gross,
    "Insurance",
    "Health",
    "House",
    ("Insurance" + "Health" + "House") AS total_deduction,
    ("Basic" + "Allowance" + "Others") - ("Insurance" + "Health" + "House") AS net_pay
FROM crosstab (
    'SELECT emp_name, trns_type, amount FROM emp_transaction ORDER BY emp_name',
    'SELECT DISTINCT trns_type FROM emp_transaction ORDER BY trns_type'
) AS tab ("emp_name" TEXT, "Allowance" NUMERIC, "Basic" NUMERIC, "Health" NUMERIC, "House" NUMERIC, "Insurance" NUMERIC, "Others" NUMERIC);
