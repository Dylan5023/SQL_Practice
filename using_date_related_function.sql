 --Using date-related functions
 
 --Basic phrase for today
select now()
;

select current_date
;

select current_timestamp
;



--Convert from date format to character format

select to_char(now(), 'yyyymmdd')
;

select to_char(now(), 'yyyy-mm-dd') 
;

--Add/Subtract Dates
select now() + interval  '1 month'
;

select now() - interval '1 day'
;

--Get year, month, week from date

select date_part('month',now())
;

select date_part('year', now())
;

--Check your sales for the last year
select *
from gmv_trend gt
where cast(yyyy as varchar) || cast(mm as varchar)
>= cast(date_part('year', now() - interval '1 year') as varchar) || cast(date_part('month', now() - interval '1 year') as varchar)
order by 2,3
;


--Calculate discount rate, selling price, and profit margin
select c.cate1 ,
round(sum(cast(discount as numeric)) / sum(gmv) * 100) || '%' as discount_rate, 
sum(gmv - discount) as paid_amount,
round(sum(cast(product_profit as numeric))  / sum(gmv) * 100) || '%' as product_magin,
round(sum(cast(total_profit as numeric)) / sum(gmv) * 100) || '%'  as total_margin
from online_order oo 
join item i on oo.itemid = i.id 
join category c on i.category_id = c.id 
group by 1
order by 3 desc
;
--Analysis from the perspective of customers (average purchase quantity per person / average purchase amount per person)

--100 customers made a purchase, total sales of 200
--Average purchase quantity per person = total sales quantity / total number of customers
--Average purchase amount per person = total purchase amount / total number of customers

--What products have the highest number of purchases per person?

select i.item_name 
, sum(unitsold) as unitsold 
, count(distinct  userid) as user_count
, round(sum(cast(unitsold as numeric)) / count (distinct userid), 2) as avg_unitsold_per_customer
, round(sum(cast(gmv  as numeric)) / count (distinct userid)) as avg_gmv_per_customer
from online_order oo 
join item i on oo.itemid  = i.id 
group by 1
order by 4 desc
;

--Which gender/age group has the highest purchase amount per person?

select gender, age_band, 
sum(gmv) as gmv,
count(distinct oo.userid) as user_count,
sum(gmv) / count(distinct oo.userid) as avg_gmv_per_customer
from online_order oo 
join user_info ui on oo.userid = ui.userid 
group by 1, 2
order by 5 desc
;




















