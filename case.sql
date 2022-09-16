-- Manipulate the column in the desired format.

-- convert number to string.

select dt, cast(dt as varchar) as yyymmdd
from online_order oo 
;

-- Cut part of string column.

select dt, left(cast(dt as varchar), 4) as yyyy, 
substring(cast(dt as varchar), 5, 2) as mm,
right(cast(dt as varchar), 2) as dd
from online_order oo 
;

-- Concatenate in yyyy-mm-dd format.

select dt, 
concat(left(cast(dt as varchar), 4), '-',
substring(cast(dt as varchar), 5, 2), '-',
right(cast(dt as varchar), 2) ) as yyyymmdd
from online_order oo 
;

select dt, 
left(cast(dt as varchar), 4) || '-' ||
substring(cast(dt as varchar), 5, 2) || '-' ||
right(cast(dt as varchar), 2)  as yyyymmdd
from online_order oo 
;

-- If it is a null value, replace it with a random value.

select coalesce (ui.gender, 'NA') as gender, coalesce (ui.age_band, 'NA') as age_band,
sum(oo.gmv) as gmv 
from online_order oo 
left join user_info ui  on oo.userid  = ui.userid 
group by 1,2
order by 1,2
;
-- Add the columns i want.

select distinct  case   when gender  = 'M' then '남성' 
						when gender = 'F' then '여성' 
						else 'NA' end as gender 
from user_info ui 
;


-- Create an age group (20's, 30's, 40's)

select
case  	when ui.age_band = '20~24' then '20s'
		when ui.age_band = '25~29' then '20s'
		when ui.age_band = '30~34' then '30s'
		when ui.age_band = '35~39' then '30s'
		when ui.age_band = '40~44' then '40s'
		when ui.age_band = '44~49' then '40s'
		else 'NA'
		end as age_group
,sum(gmv) as gmv
from online_order oo 
left join user_info ui on oo.userid = ui.userid 
group by 1
order by 1
;


-- Compare sales of TOP3 categories and other products

select 
case when cate1 in ('스커트', '티셔츠', '원피스') then 'Top 3'
else '기타' end as item_type
, sum(gmv) as gmv 
from online_order oo 
join item i on oo.itemid = i.id
join category c on i.category_id = c.id 
group by 1
order by 2 desc 
;

-- Compare sales of products with specific keywords.

select item_name,
case when item_name like '%깜찍%' then '깜찍 컨셉'
	 when item_name like '%시크%' then '시크 컨셉'
	 when item_name like '%기본%' then '기본 컨셉'
	 when item_name like '%청순%' then '청순 컨셉'
	 else '미분류'
	 end as item_concept
from item i 
;

select case when item_name like '%깜찍%' then '깜찍 컨셉'
	 when item_name like '%시크%' then '시크 컨셉'
	 when item_name like '%청순%' then '청순 컨셉'
	 when item_name like '%기본%' then '기본 컨셉'
	 else '미분류'
	 end as item_concept,
	 sum(gmv) as gmv 
from online_order oo 
join item i on oo.itemid = i.id 
group by 1
order by 2 desc 
;
