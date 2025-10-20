select * 
from pizzasales p 

--revenue 
select sum(total_price) as revenue
from pizzasales 

--AOV(average total value) total pendapatan / jumlah pesanan
select (sum(total_price) / count(distinct order_id)) as average_total_value
from pizzasales p 

--total pizza terjual 
select sum(quantity) as total_sales
from pizzasales p 

--total order
select count(distinct order_id)
from pizzasales p 

--average pizza per order 
select cast(
cast(sum(quantity) as decimal (10,2)) / 
cast(count(distinct order_id) as decimal(10,2))
as decimal (10,2)) as avg_pizza_per_order
from pizzasales p 

--daily trend for total order 
select to_char(order_date::date, 'day') as order_day, count(distinct order_id) as total_orders
from pizzasales p 
group by to_char(order_date :: date, 'day')

--hourly trend for total order 
select extract (hour from order_time :: time) as order_hour, count(distinct order_id) as total_orders
from pizzasales p 
group by extract (hour from order_time :: time)

--% of sales by pizza category
select pizza_category, cast(sum(total_price) as decimal (10,2)) as total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from pizzasales) as decimal (10,2)) as percentage --mencari % kontribusi
from pizzasales p 
group by pizza_category

--% of sales by pizza size
select pizza_size, cast(sum(total_price) as decimal (10,2)) as total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from pizzasales) as decimal (10,2)) as percentage --mencari % kontribusi
from pizzasales p 
group by pizza_size
order by pizza_size

--total pizza sold by pizza category 
select pizza_category, sum(quantity) as total_sold
from pizzasales p 
group by p.pizza_category 
order by total_sold desc

--top 5 best seller pizza 
select pizza_name, sum(quantity) as total_sold
from pizzasales p 
group by pizza_name 
order by total_sold desc
limit 5 

--bottom 5  seller pizza 
select pizza_name, sum(quantity) as total_sold
from pizzasales p 
group by pizza_name 
order by total_sold 
limit 5 




