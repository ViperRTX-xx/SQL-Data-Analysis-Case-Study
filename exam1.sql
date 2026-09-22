create database onlineretail;
use onlineretail;
select* from synthetic_online_retail_data;
select * from synthetic_online_retail_data  where category_name="Fashion";
select count(*) as total_orders from synthetic_online_retail_data;
select sum(quantity) as total_quantity_sold from synthetic_online_retail_data;
select avg(price) as average_product from synthetic_online_retail_data;
select min(price) as min_price ,max(price) as max_price from synthetic_online_retail_data;
select distinct category_name from synthetic_online_retail_data;
select category_name, count(*) as number_of_orders from synthetic_online_retail_data group by category_name;
select category_name,sum(quantity) as total_quantity_sold from synthetic_online_retail_data group by category_name;
select month(order_date) as order_month ,count(*) total_orders from synthetic_online_retail_data group by month(order_date)
order by(order_month);
select month(order_date) as order_month,count(*)total_orders from synthetic_online_retail_data group by month(order_date)
order by(order_month) desc limit 1;
select payment_method,count(*)  as total_order from synthetic_online_retail_data group by payment_method;
select  product_name,sum(quantity) as total_quantity_sold from synthetic_online_retail_data group by product_name order by 
total_quantity_sold desc limit 10;
#find products whose total sales values is greater than average  product sales values#
select product_name,sum(quantity * price) as total_sales_value from synthetic_online_retail_data group by product_name having
sum(quantity * price)>(select avg (total_sales_value) from (select sum(quantity * price) as total_sales_value from 
synthetic_online_retail_data group by product_name ) as product_sales);
#rank product categories based on total sales values#
select category_name,sum(quantity*price) as total_sales_value ,RANK() over (order by sum(quantity*price) desc) as sales_rank
from synthetic_online_retail_data  group by category_name order by sales_rank;
#find top3 products within each category using ROW_NUMBER#
select category_name,product_name,total_quantity_sold from ( select category_name,product_name,sum(quantity)as total_quantity_sold,
row_number() over (partition by category_name order by sum(quantity)desc) as product_rank from synthetic_online_retail_data
group by category_name,product_name) as ranked_products where product_rank<=3 order by category_name,product_rank;
#categorize products based on price using case#
select product_name,price, case when price<100 then 'low price'
when price between 100 and 400 then 'medium price' else 'high price' end as price_category from synthetic_online_retail_data;



