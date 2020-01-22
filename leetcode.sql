-- 197. Rising Temperature
# Write your MySQL query statement below
#SELECT Id FROM Weather Where
#Id.Temperature(INT) > 
Select a.Id from weather a, weather b
where 
a.Temperature > b.Temperature
AND a.RecordDate = DATE_SUB(b.RecordDate,INTERVAL -1 DAY)

-- 511. Game Play Analysis I
SELECT player_id, min(event_date) AS first_login
from Activity
GROUP BY player_id

-- 597. Friend Requests I: Overall Acceptance Rate

-- 512. Game Play Analysis II
SELECT player_id, device_id
FROM Activity
WHERE 
(player_id, event_date) IN 
(SELECT player_id, MIN(event_date) 
FROM Activity
GROUP BY player_id)

-- 534
SELECT player_id, event_id, 
add(SELECT games_played where ) 
AS games_played_so_far
FROM Activity

-- 577. Employee Bonus
SELECT e.name, b.bonus 
FROM Employee as e
Left join Bonus as b
ON e.empId = b.empId WHERE b.bonus < 1000 or b.bonus is null
Order By e.name

-- 603. Consecutive Available Seats
select distinct c.seat_id
from cinema c
where c.free = 1
and exists (select 1
               from cinema
               where free = 1
                 and (seat_id = c.seat_id - 1 or seat_id = c.seat_id + 1))
order by c.seat_id

-- 607. Sales Person
select name from salesperson
where sales_id not in 
(select sales_id from orders 
 join company using(com_id)
 where company.name ='RED')
 
--  586. Customer Placing the Largest Number of Orders
 SELECT customer_number
FROM
    (SELECT customer_number, COUNT(customer_number) AS total
    FROM orders 
    GROUP BY customer_number
    ORDER BY total DESC LIMIT 1) tem
WHERE customer_number = tem.customer_number

-- 610. Triangle Judgement
select *,
(case when x+y <= z or  y+z <= x or x+z <= y then 'No' 
 else 'Yes' end) 
 as  triangle
from 
triangle

-- 613. Shortest Distance in a Line
SELECT min(abs(p1.x-p2.x)) as shortest
FROM point p1, point p2
WHERE p1.x != p2.x

-- 619. Biggest Single Number
-- SELECT num from my_numbers GROUP BY num having count(num)=1 order by num desc limit 1  THIS IS WRONG
select max(num) as num
from (select num, count(num) as ct
       from my_numbers
       group by num) as temp
where temp.ct = 1

-- 1050. Actors and Directors Who Cooperated At Least Three Times
SELECT actor_id, director_id from ActorDirector
GROUP BY actor_id,director_id Having Count(timestamp)>=3

-- 1068. Product Sales Analysis I
SELECT p.product_name, s.year, s.price
FROM Sales as s
INNER Join Product as p ON p.product_id = s.product_id

-- 1069. Product Sales Analysis II
SELECT 
    product_id, 
    SUM(quantity) AS total_quantity
FROM Sales 
GROUP BY product_id

-- 1070. Product Sales Analysis III
SELECT product_id, year as first_year, quantity, price from sales
where
(product_id, year) in
(select product_id, min(year) from sales group by product_id)   ##这个是对的

SELECT product_id, min(year) as first_year, quantity, price from sales group by product_id  ##这个不对 why？

-- 1075. Project Employees I
SELECT p.project_id, 
round(SUM(e.experience_years)/count(p.project_id),2) AS average_years
from project as p
Left Join employee as e 
ON p.employee_id = e.employee_id
GROUP BY p.project_id

-- 1076. Project Employees II
SELECT project_id
FROM Project 
GROUP BY project_id
HAVING COUNT(employee_id) >= ALL (
    SELECT COUNT(employee_id)
    FROM Project
    GROUP BY project_id)
