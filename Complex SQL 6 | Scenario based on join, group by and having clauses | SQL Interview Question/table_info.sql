create table Person
(
personID int,
Name Varchar(20),
Email Varchar(20),
Score int 
);

INSERT INTO Person values(‘1’,’Alice’,’alice2018@hotmail.com’,88);
INSERT INTO Person values('2','Bob','bob2018@hotmail.com',11);
INSERT INTO Person values('3','Davis','davis2018@hotmail.com',27);
INSERT INTO Person values('4','Tara','tara2018@hotmail.com',45);
INSERT INTO Person values('5','John','john2018@hotmail.com',63);

create table Friend
(
personID int,
FriendID int 
);

INSERT INTO Friend values(1,2);
INSERT INTO Friend values(1,3);
INSERT INTO Friend values(2,1);
INSERT INTO Friend values(2,3);
INSERT INTO Friend values(3,5);
INSERT INTO Friend values(4,2);
INSERT INTO Friend values(4,3);
INSERT INTO Friend values(4,5);
