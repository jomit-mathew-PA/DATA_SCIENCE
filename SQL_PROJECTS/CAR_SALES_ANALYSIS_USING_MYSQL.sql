create database CAR;
USE CAR;
create table car1(year date,make varchar(30),model varchar(50),trim varchar(30),body varchar(30),transmission char,vin varchar(40),state varchar(30),condition_type float,odometer int,color varchar(30),interior varchar(40),seller varchar(50),mmr float,sellingprice float,saledate datetime);
use car;
# Level 1 – Basic SQL
 -- Display all records from the car_sales table.
 desc car1;
select * from car1;
-- Find the total number of cars sold.
select count(make) from car1;
-- Find all distinct car manufacturers (make) available in the dataset.
select distinct make from car1;
-- Display all cars manufactured in the year 2015 or later.
select distinct make from car1 where year=2015;
-- Find all cars with a selling price greater than 20,000.
select distinct make from car1 where sellingprice>20000;
# Level 2 – Filtering and Aggregation
# Find the average selling price of cars for each manufacturer.
select make,round(avg(sellingprice),0) AVERAGE_SELLING_PRICE from car1 group by make;
# Find the total number of cars sold in each state.
select state,count(make)TOTAL_NUMBER_OF_CARS from car1 group by state;
select state from car1;
# Find the top 10 most expensive cars based on selling price.
with c1 as(select  make,sellingprice,dense_rank() over(order by sellingprice desc) TOP_10_CARS from car1)
select * from c1 where TOP_10_CARS in(1,2,3,4,5,6,7,8,9,10);
# Find the average odometer reading for each car manufacturer.
select make,round(avg(odometer),0) AVERAGE_ODOMETER_READING from car1 group by make;
# Find the number of cars for each transmission type.
select transmission,count(make) from car1 group by transmission;
# Level 3 – Intermediate SQL
# Find the top 5 car manufacturers with the highest average selling price.
with c1 as(select make,avg(sellingprice) as AVERAGE_SELLING_PRICE,dense_rank() over(order by avg(sellingprice)desc)TOP_5_CARS from car1 group by make )
select * from c1 where TOP_5_CARS in(1,2,3,4,5);
# Calculate the difference between MMR and selling price for each car.
select  make,(sellingprice-mmr) as DIFFERENCE_BETWEEN from car1;
# Find cars where the selling price is greater than MMR.
select make,sellingprice,(sellingprice-mmr)as difference from car1 where sellingprice>mmr order by sellingprice desc;
# Find the average selling price for each car condition.
select make,condition_type,round(avg(sellingprice),0) from car1 group by make,condition_type;
# Find the manufacturers whose average selling price is greater than 15,000.
select make,round(avg(sellingprice),0) as AVERAGE_SELLING_PRICE FROM CAR1 group by make having  AVERAGE_SELLING_PRICE>15000;
use car;
# Display body types that have more than 100 cars.
select body from car1;
select body,count(make) from car1 group by body having count(make)>100;
# Find manufacturers whose total selling price exceeds 1,000,000.
select make,sum(sellingprice)as TOTAL_SELLING_PRICE from car1 group by make having TOTAL_SELLING_PRICE>1000000;
# Find condition types where the average condition value is greater than 30.
select condition_type,avg(condition_type) AVERAGE_CONDITION_VALUE from  car1 group by condition_type having AVERAGE_CONDITION_VALUE>30;
# Find cars whose sellingprice is greater than the overall average selling price.
select make,sellingprice from car1 where sellingprice>(select avg(sellingprice) from car1);
# Find the car or cars with the highest sellingprice.
select make,max(sellingprice) from car1 group by make;
# Find cars whose sellingprice is greater than the average selling price of their respective make.
select make from car1 where sellingprice>(select avg(sellingprice)as average_selling_price from car1)group by make;
# Categorize cars based on their manufacturing year:
#- Before 2010 → Old
#- 2010–2015 → Moderate
#- After 2015 → New
use car;
select make,year,
CASE
WHEN year<2010 THEN "OLD"
WHEN year between 2010 and 2015 THEN "MODERATE"
WHEN year>2025 THEN "NEW"
END AS CAR_AGE_CATEGORY from car1;
# 11. Categorize cars based on their sellingprice:
#- Below 10,000 → Budget
#- 10,000–25,000 → Mid Range
# Above 25,000 → Premium
select make,sellingprice,
CASE 
WHEN sellingprice<10000 THEN "BUDGET"
WHEN sellingprice between 10000 and 25000 THEN "MID_RANGE"
WHEN sellingprice>25000 THEN "PREMIUM"
END AS CAR_PRICE_CATEGORY from car1;
# Display cars with a new column called PRICE_DIFFERENCE:
#- Selling price greater than MMR → Above MMR
#- Selling price less than MMR → Below MMR
#- Equal → Equal to MMR
select make,(sellingprice-mmr)as PRICE_DIFFERENCE,
CASE
WHEN sellingprice>mmr THEN "ABOVE_MMR"
WHEN sellingprice<mmr THEN "BELOW_MMR"
WHEN sellingprice=mmr THEN "EQUAL_TO_MMR"
END AS MMR_STATUS from car1;
# Find the second-highest distinct sellingprice.
with c1 as(select distinct sellingprice,dense_rank() over(order by sellingprice desc)SECOND_HIGHEST from car1)
select * from c1 where SECOND_HIGHEST=2;
# Display each car's make, sellingprice, and the difference between its selling price and the overall average selling price.
select make,sellingprice,(sellingprice-(select round(avg(sellingprice),2) from car1 ))as DIFF_BW_SELLING_PRICE_AND_OVERALL_AVERAGE from car1;
# 20. Rank cars based on sellingprice from highest to lowest using DENSE_RANK().
select make,sellingprice,dense_rank()over(order by sellingprice desc) from car1;










