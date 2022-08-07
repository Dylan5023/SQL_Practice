--practice 1) data from KOSIS

select *
from gmv_trend
;

select category, yyyy, mm, gmv
from gmv_trend 
;

--Extracting specific columns without duplicate values
select distinct category 
from gmv_trend 
;


--Explore sales for a specific year

select distinct yyyy, mm  
from gmv_trend gt 


--When there is only one condition More Example
------Number string (between, Daeseikyo)

select *
from gmv_trend 
where yyyy = 2021
;

select *
from gmv_trend 
where yyyy >= 2019
;

------ between 
select *
from gmv_trend 
where yyyy between 2018 and 2020
;

------ !=
select *
from gmv_trend 
where yyyy != 2021
;

------ <> this is same with !=
select *
from gmv_trend 
where yyyy <> 2021
;

------String (=, !=, like, in, not in)

select *
from gmv_trend 
where category = '컴퓨터 및 주변기기'
;

------ !=
select *
from gmv_trend 
where category != '컴퓨터 및 주변기기'
;

------ in
select *
from gmv_trend
where category in ('컴퓨터 및 주변기기', '생활용품')
;

------ not in
select *
from gmv_trend
where category not in ('컴퓨터 및 주변기기', '생활용품')
;

------ like
select *
from gmv_trend
where category like '%패션%'
;

------ not like
select *
from gmv_trend
where category not like '%패션%'
;

--When there are multiple conditions

------and 
select *
from gmv_trend 
where category = '컴퓨터 및 주변기기'
and yyyy = 2021
;
------ or 
select *
from gmv_trend 
where gmv > 100000 or gmv  < 10000
;


------a) use and, or together 
select *
from gmv_trend 
where (gmv > 150000 or gmv  < 10000) and yyyy  = 2021
;


--Sales analysis by category

--Example) Sales by category and year

select category, yyyy, sum(gmv) as total_gmv
from gmv_trend 
group by category, yyyy 
;

select category, yyyy, sum(gmv) as total_gmv
from gmv_trend 
group by 1,2
;

select category, yyyy, sum(gmv) as total_gmv
from gmv_trend 
group by 1,2
;

select yyyy, mm, platform_type, sum(gmv) as total_gmv
from gmv_trend 
group by 1,2,3
;

--Total


----- no group by
select sum(gmv) as gmv, min(yyyy), max(yyyy), avg(gmv)
from gmv_trend 
;


--Types of aggregate functions

sum
min
max
avg


--Example of using group by + where 

select category, yyyy, sum(gmv) as total_gmv
from gmv_trend 
where category = '컴퓨터 및 주변기기'
group by 1,2
;

--Check out only key categories with high sales

select category , sum(gmv) as gmv 
from gmv_trend 
group by 1
having sum(gmv) >= 50000000
;

--use where with group by
select category , sum(gmv) as gmv 
from gmv_trend 
where yyyy = 2020
group by 1
having sum(gmv) >= 10000000
;

--Sort categories by highest sales

select *
from gmv_trend
order by category , yyyy , mm , platform_type 
;

select category , sum(gmv) as gmv
from gmv_trend
group by 1
order by gmv desc 
;

--Descending Example

select category , yyyy ,  sum(gmv) as gmv
from gmv_trend
group by 1,2 
order by 1,2 desc
;

select category , yyyy ,  sum(gmv) as gmv
from gmv_trend
group by 1,2 
order by 1,3 desc
;

select category , yyyy ,  sum(gmv) as gmv
from gmv_trend
group by 1,2 
order by 1  desc ,2 desc
;


--Sort by multiple columns

select yyyy , mm, sum(gmv) as gmv 
from gmv_trend
group by 1,2
order by 3 desc
;


