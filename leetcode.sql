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