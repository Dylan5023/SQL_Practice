-- Order data analysis
-- Orders made for one day on June 1, 2021

-- Data Exploration------------------------------------------------ -------------

--order table
select *
from online_order
;

--item table
select *
from item
;

--category table
select *
from category
;

--user_info table
select *
from user_info
;

--Check sales of TOP products----------------------------------------------------- -------------------



--After counting sales by product, sort them in order of highest sales

select itemid, sum(gmv) as gmv
from online_order
group by 1
;


--Check the sales by product at a glance by putting the product name side by side with the product ID

select item_name , sum(gmv) as gmv
from online_order oo
join item i on oo.itemid = i.id 
group by 1
order by 2 desc
;

--What will be the sales by category?

select c.cate1 , c.cate2 , c.cate3 , sum(gmv) as gmv 
from online_order oo 
join item i on oo.itemid  = i.id 
join category c on i.category_id = c.id 
group by 1,2,3
order by 4 desc
;


--What will be the sales by gender/age?

select ui.gender , ui.age_band , sum(gmv) as gmv 
from online_order oo 
join user_info ui  on oo.userid  = ui.userid 
group by 1,2
order by 1,2
;



--What items do men buy?

select item_name, sum(gmv) as gmv 
from online_order oo 
join item i on oo.itemid = i.id 
join user_info ui on oo.userid  = ui.userid 
where gender = 'M'
group by 1
order by 2 desc
;
