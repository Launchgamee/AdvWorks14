/* 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero.
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
*/

 Sales.SalesPerson
 Person.Person





/* 22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. 
Filter the output for those who have 100 or more contacts. 
Return ContactTypeID and ContactTypeName and BusinessEntityContact.
Sort the result set in descending order on number of contacts.
*/

--select * from Person.BusinessEntityContact
-- select * from Person.ContactType


 select 
    c.contacttypeid,
    c.[Name],
    count(*) cnt
 from 
      person.ContactType c 
 join Person.BusinessEntityContact b
      on c.ContactTypeID=b.ContactTypeID
 group by 
      c.contacttypeid,c.[name]
 having count(*)  >= 100
 order by 3 desc



/* 23 From the following table write a query in SQL to retrieve the RateChangeDate, full name
(first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
*/

--select * from [HumanResources].[Employee]
--select * from HumanResources.EmployeePayHistory
--select * from person.Person


select 
    convert(date,e.RateChangeDate,101) RateChangeDate,
    concat(firstname, + ' ', middlename,+' ',lastname) fullname,
    weekly_salary =(rate * 40)
from  
     person.Person  p 
join HumanResources.EmployeePayHistory e
     on p.BusinessEntityID = e.BusinessEntityID
order by fullname




/*
24. From the following tables 
write a query in SQL to calculate and display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees
Sort the output in ascending order on NameInFull.
*/

--select * from HumanResources.EmployeePayHistory
--select * from person.Person



select 
   convert(date,e.RateChangeDate,101) RateChangeDate,
   concat(firstname, + ' ', middlename,+' ',lastname) fullname,
   weekly_salary =(rate * 40)
from  
     person.Person  p 
join HumanResources.EmployeePayHistory e
     on p.BusinessEntityID = e.BusinessEntityID
order by 2

with me as
(
select *, 
   row_number() over (partition by businessentityid order by ratechangedate) as parrtitioned
from 
    HumanResources.EmployeePayHistory
)  
 select * from me where parrtitioned=1