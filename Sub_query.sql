--Sub query

--What kind of product did the customer who purchased more than one product in one day mainly purchase?

select oo.userid , count(distinct itemid) as item_cnt
from online_order oo 
join user_info ui on oo.userid = ui.userid 
group by 1
having count(distinct itemid) > 1
;


select cate3, i.item_name, price
, count(distinct oo.userid) as user_cnt, sum(gmv) as gmv 
from online_order oo 
join item i on oo.itemid = i.id 
join category c on i.category_id = c.id 
join 
(
select oo.userid , count(distinct itemid) as item_cnt
from online_order oo 
join user_info ui on oo.userid = ui.userid 
group by 1
having count(distinct itemid) > 1
) user_list on oo.userid = user_list.userid
group by 1,2,3
order by 4 desc 
;


-- What other products did the customer who bought product A purchase in addition to product A?

select distinct oo.userid 
from online_order oo 
join user_info ui on oo.userid = ui.userid 
join item i on oo.itemid = i.id  
where item_name = '올여름 필수템! 청반바지 필수템'
;


select item_name, count(distinct oo.userid) as user_cnt
from online_order oo 
join item i on oo.itemid = i.id
join 
(
select distinct oo.userid 
from online_order oo 
join user_info ui on oo.userid = ui.userid 
join item i on oo.itemid = i.id  
where item_name = '올여름 필수템! 청반바지 필수템'
) user_list
on oo.userid = user_list.userid
group by 1
;






