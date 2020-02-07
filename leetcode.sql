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


-- 1294. Weather Type in Each Country
SELECT country_name, 
(case when avg(weather_state)<=15 then 'Cold' when avg(weather_state)>=25 then 'Hot' else 'Warm' end  ) as weather_type
FROM Weather a
LEFT Join Countries b
ON a.country_id = b.country_id
where month(day)=11
group by a.country_id

-- 1113. Reported Posts
SELECT extra as report_reason, 
COUNT(DISTINCT post_id) AS report_count
FROM Actions
where action = 'report' AND action_date = '2019-07-04'
Group By extra

-- 1322. Ads Performance
select ad_id, 
round(ifnull(sum(case when action='Clicked' then 1 else 0 end)/sum(case when action='Clicked' or action= 'Viewed' then 1 else 0 end)*100,0) ,2) as ctr
from ads
group by ad_id
order by ctr desc,ad_id

-- 1084. Sales Analysis III
SELECT p.product_id, product_name
FROM Product AS p
JOIN Sales AS s
USING (product_id)
GROUP BY s.product_id
HAVING SUM(IF(sale_date BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = COUNT(*)

-- 1141. User Activity for the Past 30 Days I
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB(DATE("2019-07-27"), INTERVAL 29 DAY) AND DATE("2019-07-27") 
GROUP BY activity_date;

-- 1083. Sales Analysis II
SELECT distinct buyer_id
FROM Sales s
JOIN Product p ON s.product_id = p.product_id
WHERE product_name = 'S8 ' AND buyer_id NOT IN (SELECT buyer_id
FROM Sales sp
JOIN Product ps ON sp.product_id = ps.product_id
WHERE product_name = 'iPhone')

-- 1142. User Activity for the Past 30 Days II 
-- DO IT AGAIN!!!!!!!!!
select ifnull(round(sum(cnt)/count(user_id),2),0) AS average_sessions_per_user
from
(select user_id, count(distinct session_id) cnt
from activity
where activity_date<='2019-07-27'
and activity_date>='2019-06-28'
group by user_id) temp

-- 178. Rank Scores
-- ？？？？
select Score, rank
from Scores a
left join
    (select dscore, @rank := @rank + 1 as rank
    from 
        (select distinct Score as dscore
        from Scores
        order by dscore desc) s,
        (select @rank := 0) r
     ) as b
on a.Score = b.dscore
order by Score desc

-- 1212. Team Scores in Football Tournament
-- 三层比较与赋值
select team_id, team_name,
sum(case when team_id = host_team then if (host_goals < guest_goals,0,if(host_goals = guest_goals,1,3))
else if (host_goals < guest_goals,3,if(host_goals = guest_goals,1,0) )
end
) AS num_points
from teams
left join matches
on team_id = host_team or team_id = guest_team
group by team_id
order by num_points desc, team_id asc

-- 608. Tree Node
-- 树状图
select id, 
case 
when p_id is null then 'Root'
when id in (select distinct p_id from tree) then 'Inner'
else 'Leaf'  
end 
AS Type        
from tree 
order by id

-- 1270. All People Report to the Given Manager
-- 不同层级的传递
select employee_id from employees where employee_id!=1 and manager_id =1
union

select employee_id from Employees where manager_id in
(select employee_id from employees where employee_id!=1 and manager_id =1) 
union 

select employee_id from Employees where manager_id in
(select employee_id from Employees where manager_id in
(select employee_id from employees where employee_id!=1 and manager_id =1) )

-- 1308. Running Total for Different Genders
-- 做以上所有的和
select a.gender,a.day,sum(b.score_points) as total
from scores a
left join scores b
on a.gender=b.gender
and a.day>=b.day
group by 1,2
order by 1,2

-- 1285. Find the Start and End Number of Continuous Ranges
-- 连续数组的挑选
select
log_id as "start_id", 
(
    select log_id from logs n 
    where n.log_id >= l.log_id 
    and not exists (
        select log_id from logs p where p.log_id = n.log_id + 1)
    order by log_id limit 1
) as "end_id"
from logs l 
where not exists (
    select log_id from logs m 
    where l.log_id = m.log_id + 1)

-- 1077. Project Employees III
select p.project_id, p.employee_id
from project p
inner join 
employee e
on p.employee_id = e.employee_id
where (p.project_id, e.experience_years ) in 
(
select p.project_id, max(e.experience_years)
from project p
inner join 
employee e
on p.employee_id = e.employee_id
group by p.project_id
)

-- 534. Game Play Analysis III
SELECT a.player_id, a.event_date, 
sum(b.games_played)
AS games_played_so_far
FROM Activity a
LEFT Join Activity b
ON a.player_id = b.player_id AND a.event_date >= b.event_date
group by player_id,event_date

-- 1126. Active Businesses
select b.business_id from Events as b
inner join (select event_type,avg(occurences) as occurences
from Events
group by 1) as c
on b.occurences>c.occurences and b.event_type=c.event_type
group by b.business_id
having count(b.business_id)>1