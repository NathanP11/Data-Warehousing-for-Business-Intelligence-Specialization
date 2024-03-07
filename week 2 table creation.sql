DROP TABLE EVENTPLANLINE;
DROP TABLE EVENTPLAN;
DROP TABLE EVENTREQUEST;
DROP TABLE LOCATION;
DROP TABLE FACILITY;
DROP TABLE RESOURCETBL;
DROP TABLE CUSTOMER;
DROP TABLE EMPLOYEE;



CREATE TABLE Customer
( custno VARCHAR(8),
custname VARCHAR(50) CONSTRAINT custnameReq NOT NULL,
address VARCHAR(50) CONSTRAINT addressReq NOT NULL,
Internal CHAR(1) DEFAULT 'Y' CONSTRAINT InternalReq NOT NULL,
contact VARCHAR(35) CONSTRAINT contactReq NOT NULL,
phone VARCHAR(11) CONSTRAINT phoneReq NOT NULL,
city VARCHAR(30) CONSTRAINT cityReq NOT NULL,
state CHAR(2) CONSTRAINT stateReq NOT NULL,
zip VARCHAR(10) DEFAULT '80202' CONSTRAINT zipReq NOT NULL,
CONSTRAINT PKcustno PRIMARY KEY(custno) 
);



CREATE TABLE Employee
( empno VARCHAR(8),
empname VARCHAR(50) CONSTRAINT empnameReq NOT NULL,
department VARCHAR(25) CONSTRAINT departmentReq NOT NULL,
email VARCHAR(30) CONSTRAINT emailReq NOT NULL,
phone VARCHAR(11) CONSTRAINT phoneReq_ NOT NULL,
MrgNo VARCHAR(8),
CONSTRAINT PKempno PRIMARY KEY(empno),
CONSTRAINT UniqueEmail UNIQUE(email),
CONSTRAINT FKMrgNo FOREIGN KEY(MrgNo) REFERENCES Employee(empno)
);


CREATE TABLE Facility
( facno VARCHAR(8),
facname VARCHAR(30) CONSTRAINT facnameNotNullReq NOT NULL,
CONSTRAINT PKfacno PRIMARY KEY(facno),
CONSTRAINT Uniquefacname UNIQUE(facname)
);



CREATE TABLE Location
( locno VARCHAR(8),
facno VARCHAR(8) CONSTRAINT facnoNullReq NOT NULL,
locname VARCHAR(30) CONSTRAINT locnameNotNullReq NOT NULL,
CONSTRAINT PKlocno PRIMARY KEY(locno),
CONSTRAINT FKfacno FOREIGN KEY(facno) REFERENCES Facility (facno)
);



CREATE TABLE ResourceTbl
( resno VARCHAR(8),
resname VARCHAR(30) CONSTRAINT resnameNullReq NOT NULL,
rate DECIMAL(8,2) DEFAULT 1 CONSTRAINT rateNotNullReq NOT NULL,
CONSTRAINT PKresno PRIMARY KEY(resno),
CONSTRAINT Uniqueresname UNIQUE(resname)
);



CREATE TABLE EventRequest
( eventno VARCHAR(8),
dateheld DATE CONSTRAINT dateheldReq_eventrequest NOT NULL,
datereq DATE DEFAULT CURRENT_DATE CONSTRAINT datereqReq NOT NULL,
facno VARCHAR(8) CONSTRAINT facnoReq_eventrequest NOT NULL,
custno VARCHAR(250) CONSTRAINT custnoReq_eventrequest NOT NULL,
dateauth DATE  ,
status VARCHAR(30) DEFAULT 'PENDING' CONSTRAINT statusReqNotNull_eventrequest NOT NULL,
estcost DECIMAL(16,2) CONSTRAINT estcostNotNullReq_eventrequest NOT NULL,
estaudience INT CONSTRAINT estaudienceNotNullReq_eventrequest NOT NULL,
budno VARCHAR(10),
CONSTRAINT statusreqValid_eventrequest CHECK( status IN( 'PENDING', 'APPROVED', 'DENIED')  ),
CONSTRAINT estaudiencePositiveReq_eventrequest CHECK(estaudience > 0),
CONSTRAINT dateauthValid_eventrequest CHECK( dateauth > datereq ),
CONSTRAINT PKeventno_eventrequest PRIMARY KEY(eventno),
CONSTRAINT FKfacno_eventrequest FOREIGN KEY(facno) REFERENCES Facility(facno),
CONSTRAINT FKcustno_eventrequest FOREIGN KEY(custno) REFERENCES Customer(custno)
);




CREATE TABLE EventPlan
( planno VARCHAR(8),
eventno VARCHAR(8) CONSTRAINT eventnoReq NOT NULL,
workdate DATE CONSTRAINT workdateReq NOT NULL,
notes VARCHAR(50) CONSTRAINT NotesNotNullReq NOT NULL,
activity VARCHAR(50) CONSTRAINT activityReq NOT NULL,
empno VARCHAR(8),
CONSTRAINT PKplanno PRIMARY KEY(planno),
CONSTRAINT FKEventNo FOREIGN KEY(EventNo) REFERENCES EventRequest(EventNo) ON DELETE CASCADE,
CONSTRAINT FKEmpNo FOREIGN KEY(EmpNo) REFERENCES Employee(EmpNo)
);


CREATE TABLE EventPlanLine
( planno VARCHAR(8),
LineNo INT,
TimeStart DATE CONSTRAINT TimeStartReq_EventPlanLine NOT NULL,
TimeEnd DATE CONSTRAINT TimeEndReq_EventPlanLine NOT NULL,
ResourceCnt INTEGER CONSTRAINT ResourceCntReq_EventPlanLine NOT NULL,
ResNo VARCHAR(8) CONSTRAINT ResNoReq_EventPlanLine NOT NULL,
LocNo VARCHAR(8) CONSTRAINT LocNoReq_EventPlanLine NOT NULL,
CONSTRAINT FKplanno_EventPlanLine FOREIGN KEY(planno) REFERENCES EventPlan(planno) ON DELETE CASCADE,
CONSTRAINT PKLineNo_EventPlanLine PRIMARY KEY(LineNo,planno),
CONSTRAINT FKResNo_EventPlanLine FOREIGN KEY(ResNo) REFERENCES Resourcetbl(ResNo),
CONSTRAINT FKLocNo_EventPlanLine FOREIGN KEY(LocNo) REFERENCES Location(LocNo)
);
