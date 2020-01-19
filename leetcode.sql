



-- 197. Rising Temperature
# Write your MySQL query statement below
#SELECT Id FROM Weather Where
#Id.Temperature(INT) > 
Select a.Id from weather a, weather b
where 
a.Temperature > b.Temperature
AND a.RecordDate = DATE_SUB(b.RecordDate,INTERVAL -1 DAY)