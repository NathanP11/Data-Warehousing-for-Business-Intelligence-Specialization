-- 1.
SELECT DISTINCT city, state, zip
FROM customer;

-- 2.
SELECT empname, department, phone
FROM Employee
WHERE phone LIKE '3-%';

-- 3.
SELECT *
FROM ResourceTbl
WHERE rate BETWEEN  10 AND 20
ORDER BY rate;

-- 4.
SELECT eventno, dateauth, status
FROM EventRequest
WHERE status IN('Pending' , 'Approved')
    AND dateauth BETWEEN '1-Jan-2020' AND '31-Jan-2023';

-- 5.
SELECT locno, locname
FROM Location, Facility
WHERE Location.facno = Facility.facno
    AND Facility.facname = 'Basketball arena';

-- 6.
SELECT planno, Count(*) AS  countPlanLines, SUM(ResourceCnt)
FROM EventPlanLine
GROUP BY planno;

-- 7.
SELECT planno, Count(*) AS  countPlanLines, SUM(ResourceCnt)
FROM EventPlanLine
WHERE TimeStart BETWEEN '1-Jan-2020' AND '31-Jan-2023'
GROUP BY planno
HAVING SUM(ResourceCnt) > 9;
