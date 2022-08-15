-- What is the gender distribution of customers who purchase two or more products in one day?



select oo.userid , count(distinct itemid) as item_cnt
from online_order oo 
join user_info ui on oo.userid = ui.userid 
group by 1
having count(distinct itmeid) > 1
;




select ui.gender , ui.age_band , count(distinct oo.userid) as user_cnt,
count(distinct case when user_list.userid is not null then user_list.userid else null end) as user_cnt,
round(count(distinct case when user_list.userid is not null then user_list.userid else null end ) :: numeric / count(distinct oo.userid = ui.userid) * 100, 1) as user_percent
from online_order oo 
join user_info ui  on oo.userid = ui.userid 
left join 
(
select oo.userid , count(distinct itemid) as item_cnt
from online_order oo 
join user_info ui on oo.userid = ui.userid 
group by 1
having count(distinct itemid) > 1
) user_list on oo.userid = user_list.userid
group by 1,2
order by 1,2
;