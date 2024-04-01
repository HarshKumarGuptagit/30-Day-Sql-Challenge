
select token_num from tokens
group by token_num
having count(distinct customer)=1
order by 1
limit 1
;