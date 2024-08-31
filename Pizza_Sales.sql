
--Total Revenue

Select sum(total_price) Total_Revenue	
from PizzaSales

--Average Order Value

select sum(total_price) / count(distinct order_id) Average_Order_Value
from PizzaSales

--Total Pizza Sold

select sum(quantity) TotalPizza_Sold
from PizzaSales

--Total Orders

select count(distinct order_id) Total_Orders
from PizzaSales

--Average Pizza per Order

select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as AvgPizzasPer_Order
from PizzaSales

--Hourly Trend for Total Pizzas Sold

select DATEPART(hour, order_time) as Order_hour, sum(quantity) as TotalPizza_Sold
from PizzaSales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time) 

--Weekly Trend for Total Orders

select datepart(iso_week, order_date) as week_number, year(order_date) as Order_year, count(distinct order_id) as Total_Orders
from PizzaSales
group by datepart(iso_week, order_date), year(order_date)
order by datepart(iso_week, order_date), year(order_date)

--Percentage of Sales by Pizza Category

select pizza_category, sum(total_price) as Total_Sales,
sum(total_price)*100/(select sum(total_price) from PizzaSales where MONTH(order_date) = 1) as PercentTotal_Sales
from PizzaSales
where MONTH(order_date) = 1
group by pizza_category


--Percentage of Sales by Pizza Size

select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales,
cast(sum(total_price)*100/(select sum(total_price) from PizzaSales where datepart(quarter, order_date)=1) as decimal(10,2)) as PercentTotal_Sales
from PizzaSales
where datepart(quarter, order_date)=1
group by pizza_size
order by PercentTotal_Sales desc

--Top5 Best Sellers by Revenue

select top 5 pizza_name, sum(total_price) as total_revenue
from PizzaSales
group by pizza_name
order by  total_revenue desc


--Bottom5 Best Sellers by Revenue

select top 5 pizza_name, sum(total_price) as total_revenue
from PizzaSales
group by pizza_name
order by total_revenue 