------------------1. Select ---------------------------
SELECT EventRequest.EventNo, DateHeld, COUNT(*) AS CntEventPlans
FROM EventRequest, EventPlan
WHERE EventRequest.EventNo = EventPlan.EventNo
    AND workdate BETWEEN '1-JAN-2020' AND '31-DEC-2023'
GROUP BY eventrequest.EventNo, DateHeld
HAVING COUNT(*) > 1;

-- 2
Select PlanNo, EventPlan.eventno, WorkDate, activity
FROM EventPlan, EventRequest, Facility
WHERE workdate BETWEEN '1-JAN-2020' AND '31-DEC-2023'
    AND EventPlan.EventNo = EventRequest.EventNo
    AND EventRequest.FacNo = Facility.Facno
    AND facname = 'Basketball arena';

-- 3
Select EventRequest.EventNo, dateheld, status, estcost
From EventRequest, EventPlan, Employee, Facility
Where EventRequest.EventNo = EventPlan.EventNo
    AND EventPlan.empno = Employee.empno
    AND empname = 'Mary Manager'
    AND EventRequest.facno = Facility.facno
    AND facname = 'Basketball arena'
    AND dateheld between '1-Oct-2022' AND '31-DEC-2022'
;

-- 4
Select EventPlanLine.planno, lineno, resname , ResourceCnt, locname, TimeStart, TimeEnd
From EventPlanLine, ResourceTbl, Location, Facility, EventPlan
Where workdate BETWEEN '1-OCT-2022' AND '31-DEC-2022'
    AND EventPlanLine.resno = ResourceTbl.resno
    AND EventPlanLine.LocNo = Location.LocNo
    AND Location.facno = Facility.facno
    AND facname = 'Basketball arena'
    AND EventPlanLine.planno = EventPlan.planno
    AND activity = 'Operation';
	
-- 5
Select EventPlanLine.PlanNo , SUM(ResourceCnt * rate ) as SumResourceCost
From EventPlan, ResourceTbl, EventPlanLine
Where EventPlan.PlanNo = EventPlanLine.PlanNo
    AND workdate between '1-Oct-2022' AND '31-DEC-2022'
    AND EventPlanLine.ResNo = ResourceTbl.resno
GROUP BY EventPlanLine.PlanNo
Having SUM(ResourceCnt * rate ) > 50
;

----- insert
--1
INSERT INTO  Facility (Facno, FacName)
Values ('F104','Swimming Pool');
--2
INSERT INTO  Location (Locno, Facno, locName)
Values ('L107','F104','Door');
--3
INSERT INTO  Location (Locno, Facno, locName)
Values ('L108','F104','Locker Room');
commit
--4
UPDATE Location
SET locname = 'gate'
WHERE locname = 'Door'
;
--5
DELETE Location
WHERE LocNo = 'L107';
DELETE Location
WHERE LocNo = 'L108';

---------------------------- practice --------------
SELECT Customer.custno, Customer.custname, SUM( estcost ) AS SumCostCustomer
FROM EventRequest, Customer, Facility
WHERE EventRequest.custno = Customer.custno
    AND EventRequest.Status = 'Approved'
    AND EventRequest.facno = Facility.facno
    AND EventRequest.dateheld BETWEEN '1-Jan-2022' AND '31-Dec-2022'
    AND (estcost / estaudience) < 0.2
GROUP BY EventRequest.custno;

----------------

SELECT EventPlan.empno, empname, EXTRACT(MONTH FROM WorkDate) as WorkDateMonth, count(*) as NumPlans, sum(EstCost) as SumEstCost
FROM EventPlan, Employee, EventRequest
WHERE EventPlan.empno = Employee.empno
    AND EventPlan.EventNo = EventRequest.EventNo
    AND EventPlan.WorkDate BETWEEN '1-Jan-2022' AND '31-Dec-2022'
GROUP BY EventPlan.empno, empname, EXTRACT(MONTH FROM WorkDate)
;