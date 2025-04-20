CREATE TABLE Employee_Address ( 
	empID char(10),
    address varchar(150),
    city varchar(150),
    postalcode varchar(5),
    PRIMARY KEY (empID), 
    FOREIGN KEY (empID) REFERENCES Employee (empID)
    ON UPDATE CASCADE
);