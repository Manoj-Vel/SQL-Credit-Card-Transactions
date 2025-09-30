select * from credit_card_transactions

--1-write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

with cte1 as (
select city,sum(amount) as total_spend
from credit_card_transactions
group by city)
,total_spent as (select sum(cast(amount as bigint)) as total_amount from credit_card_transactions)
select top 5 cte1.*, round(total_spend*1.0/total_amount * 100,2) as percentage_contribution from 
cte1 inner join total_spent on 1=1
order by total_spend desc;

--2- write a query to print highest spend month and amount spent in that month for each card type

with cte_1 as (select year(transaction_date) as yr , month(transaction_date) as mnth, card_type, sum(amount) as total_amount_spend
from credit_card_transactions 
group by year(transaction_date), month(transaction_date), card_type)

select * from (select *, RANK() over (partition by card_type order by total_amount_spend desc) as rn
from cte_1) a
where rn = 1;

--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte_1 as
(select *, sum(amount) over (partition by card_type order by transaction_date,transaction_id) as total_spend 
from credit_card_transactions),
cte_2 as (select *, RANK() over (partition by card_type order by total_spend) as rn
from cte_1
where total_spend >= 1000000)
select * from cte_2
where rn = 1;

--4- write a query to find city which had lowest percentage spend for gold card type

with cte_1 as (select city,card_type, sum(amount) as gold_card_spends from credit_card_transactions
where card_type = 'Gold'
group by city,card_type),

cte_2 as (select city, sum(amount) as total_amount from credit_card_transactions
group by city)

select top 1 a.city, (gold_card_spends*1.0)/total_amount * 100 as perc_contri_per_city
from cte_1 b inner join cte_2 a
on b.city = a.city
order by perc_contri_per_city asc

--5- write a query to print 3 columns: city, highest_expense_type, lowest_expense_type (example format : Delhi , bills, Fuel)

with cte_1 as (select city, exp_type, sum(amount) as total_expense from credit_card_transactions
group by city, exp_type),

cte_2 as (select *, 
rank() over (partition by city order by total_expense desc) as high_rn,
rank() over (partition by city order by total_expense asc) as least_rn
from cte_1)

select city,
max(case when high_rn = 1 then exp_type end) as lowest_expense_type,
max(case when least_rn = 1 then exp_type end) as highest_expense_type
from cte_2
group by city

--6- write a query to find percentage contribution of spends by females for each expense type

with cte_1 as (select exp_type, sum(amount) as total_female_spend
from credit_card_transactions
where gender = 'F'
group by exp_type),

cte_2 as (select exp_type, sum(amount) as total_spend
from credit_card_transactions
group by exp_type)

select c.exp_type, total_female_spend, total_spend, (total_female_spend*1.0/total_spend) * 100 as perc_female_spends
from cte_1 c inner join cte_2 d
on c.exp_type=d.exp_type
order by perc_female_spends desc;

--7- which card and expense type combination saw highest month over month growth in Jan-2014

with cte_1 as (select card_type, exp_type, year(transaction_date) as yr, month(transaction_date) as mth, sum(amount) as total_amount
from credit_card_transactions
group by card_type, exp_type, year(transaction_date), month(transaction_date)),

cte_2 as (select *, lag(total_amount) over (partition by card_type, exp_type order by yr, mth) as prev_mth_amount from cte_1)

select top 1 *, (total_amount - prev_mth_amount) as mom_growth
from cte_2
where yr = 2014 and mth = 1
order by mom_growth desc;

--8- during weekends which city has highest total spend to total no of transcations ratio

select top 1 city,sum(amount) as total_spend, count(city) as city_counts, sum(amount)/count(city) as ratio_per_transactions
from credit_card_transactions
where datepart(weekday,transaction_date) in (1,7)
group by city
order by ratio_per_transactions desc

--9- which city took least number of days to reach its 500th transaction after the first transaction in that city

with cte_1 as (select *, row_number() over (partition by city order by transaction_date, transaction_id) as rn
from credit_card_transactions),

cte_2 as (select *, FIRST_VALUE (transaction_date) over (partition by city order by transaction_date, transaction_id) as first_transaction
from cte_1)

select top 1 *, datediff(DAY, first_transaction, transaction_date) as day_counts from cte_2
where rn = 500
order by day_counts asc
























