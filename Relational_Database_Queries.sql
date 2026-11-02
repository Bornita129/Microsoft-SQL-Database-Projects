create database Labfinal_Assingment;
use Labfinal_Assingment;
create table Salesman(
Salesman_ID int Primary key,
  Name varchar(50),
  City varchar(50),
  Commission decimal(4,2)
);
insert into Salesman(Salesman_ID,Name,City,Commission)
values
(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14);

select * from Salesman;


create table Orders(
Order_No int primary key,
    Purchase_Amount decimal(10,2),
    Order_Date date,
    Customer_ID int,
    Salesman_ID int,
    foreign key (Salesman_ID)
    references Salesman(Salesman_ID)
);

insert into Orders(Order_No,Purchase_amount,Order_Date,Customer_ID,Salesman_ID)
values
(70001,150.5,'2025-10-04',3005,5002),
(70009,270.65,'2026-03-11',3001,5005),
(70002,65.26,'2026-05-05',3002,5001),
(70005,2400.6,'2026-02-27',3007,5001);

select * from Orders;

--Question-1:
Create view Sales_Report as
select
    O.Order_No as ord_no,
    S.Name as salesman_Name,
    O.Purchase_Amount as purch_amt
from Orders O
inner join Salesman S on O.Salesman_ID = S.Salesman_ID;

select * from Sales_Report;
 
--Question-2:
create unique nonclustered index idx_Salesman_ID
on Salesman(Salesman_ID);

--Question-3:
create procedure spGetOrdersByCity
@City varchar(50) as
begin
select
  S.Name,
  O.Purchase_Amount as purch_amt
  from Salesman S
  inner join Orders O 
  on S.Salesman_ID = O.Salesman_ID
  where S.City = @City;
end;

exec spGetOrdersByCity 'London';

--Question-4:
create procedure spCountHighCommission
@Threshold decimal(4,2),
@TotalSalesmen int output as
begin
  select @TotalSalesmen=COUNT(*)
  from Salesman
  where Commission>@Threshold;
end;

declare @Count int;
exec spCountHighCommission
@Threshold=0.13,
@TotalSalesmen=@Count OUTPUT;
select @Count as Total_Salesmen;

--Question-5:
delete from Orders
where Purchase_Amount<100;
select * from Orders;