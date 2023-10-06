
/* 16. From the following table write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city.
*/
--select * from Person.BusinessEntityAddress
  --select * from Person.Address

    select 
       City, 
	   count( b.AddressID) as NumberOfEmployees
	from 
	    Person.BusinessEntityAddress b
   join Person.Address a 
        on b.AddressID  = a.addressid
		group by city
	    order by 1



 /* 18. From the following table write a query in SQL to retrieve the total sales for each year. 
 Filter the result set for those orders where order year is on or before 2016. 
 Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.*/

--select *  from Sales.SalesOrderHeader

select
     year(orderdate) as OrderYear,
    sum(Totaldue) as Totaldue
from
   Sales.SalesOrderHeader
   where year(orderdate) <2016
   group by  year(orderdate) 
   order by year(orderdate) 
   


 not done /* 21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero.
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
*/
 --select * from Sales.SalesPerson
 --select * from Person.Person
 --select * from Person.Address

 1- sales person by zip code 

 select 
      Lastname,
	  salesytd,
	  postalcode
from 
     Sales.SalesPerson s
join Person.Person p
     on s.
	    


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
    weekly_salary =(rate * 40) -- salary based on 40 hrs a week
from  
     person.Person  p 
join HumanResources.EmployeePayHistory e
     on p.BusinessEntityID = e.BusinessEntityID
order by fullname



/*24. From the following tables 
write a query in SQL to calculate and display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees
Sort the output in ascending order on NameInFull.
*/
--select * from HumanResources.EmployeePayHistory
--select * from person.Person

-- using row nuber and cte


WITH LatestPayHistory AS (
    SELECT
        BusinessEntityID,
        MAX(RateChangeDate) AS MaxRateChangeDate
    FROM
        HumanResources.EmployeePayHistory
    GROUP BY
        BusinessEntityID
)

SELECT
    CONVERT(DATE, e.RateChangeDate, 101) AS RateChangeDate,
    CONCAT(p.LastName, ' ', p.FirstName, ' ', p.LastName) AS FullName,
    rate * 40 AS WeeklySalary
FROM
    person.Person AS p
JOIN
    HumanResources.EmployeePayHistory AS e
    ON p.BusinessEntityID = e.BusinessEntityID
JOIN
    LatestPayHistory AS l
    ON p.BusinessEntityID = l.BusinessEntityID
    AND e.RateChangeDate = l.MaxRateChangeDate
ORDER BY
    FullName;


  -- using subquery 

  select 
   convert(date,e.RateChangeDate,101) RateChangeDate,
   concat(lastname, + ' ', firstname,+' ',lastname) fullname,
   weekly_salary =(rate * 40)
from  
     person.Person  p 
join HumanResources.EmployeePayHistory e
     on p.BusinessEntityID = e.BusinessEntityID
where RateChangeDate=
	   (select 
	        max(ratechangedate) 
 from 
	      HumanResources.EmployeePayHistory 
	   WHERE
	      BusinessEntityID = e.BusinessEntityID)
order by fullname


/*
25. From the following table write a query in SQL to 
find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.

*/
--select * from Sales.SalesOrderDetail

select 
     SalesOrderID,
	 ProductID,
	 OrderQty,
	 count(orderqty) cnt,
	sum(orderqty) summ,
	 Avg(orderqty)avgg,
	 min(orderqty) minn,
	 max(orderqty) maxx
from 
    Sales.SalesOrderDetail
where 
   SalesOrderID in (43659,43664)
group by 
      SalesOrderID,
	  ProductID,
	  OrderQty
 

 not done  /*
 26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders 
 whose ids are 43659 and 43664 and product id starting with '71'.
 Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

*/
--Sample table: Sales.SalesOrderDetail

select 
     SalesOrderID,
	-- OrderNumber,
	 ProductID,
	 OrderQty,
	 count(orderqty) cnt,
	sum(orderqty) summ,
	 Avg(orderqty)avgg,
	 min(orderqty) minn,
	 max(orderqty) maxx
from 
    Sales.SalesOrderDetail
where 
     SalesOrderID in (43659,43664) and productId LIKE '71%'
group by 
      SalesOrderID,
	 -- OrderNumber,
	  ProductID,
	  OrderQty


/*  
27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000.
Return SalesOrderID, total cost.
*/
--select * from  Sales.SalesOrderDetail

select 
    salesorderid,
	sum(linetotal) as Tol
from 
   Sales.SalesOrderDetail
group by 
      SalesOrderID
having sum(linetotal) > 100000


/*
28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'.
Return product ID, and name and order the result set in ascending order on product ID column.
*/

--select * from Production.Product 

select 
    productid,
    [name]
from 
   Production.Product
where 
   [name] like 'Lock Washer%'
order by 
    productid

/*
29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. 
Return product ID, name, and color of the product.
*/
--select * from  Production.Product

	select 
	    productid,
		[name],
		color
	from 
	   Production.Product
	order by 
	      listprice 

 /*
 30. From the following table write a query in SQL to retrieve records of employees. 
 Order the output on year (default ascending order) of hiredate. 
 Return BusinessEntityID, JobTitle, and HireDate.
*/
-- select * from HumanResources.Employee

select 
    Businessentityid,
	jobtitle,
	hiredate
from 
	HumanResources.Employee
order by 
     year(hiredate)

 /*
31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

*/
--select * from  Person.Person

	 select
	     lastname,
		 firstname
	from 
	   Person.Person
	where 
	    lastname like 'R%'
	order by 
	      firstname,
		  lastname


 not done          
/*
33. From the following table write a query in SQL to set the result in order by the 
column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.

Sample table: Sales.SalesPerson

*/
--select * from Sales.SalesPerson

--select *
--from 
--   Sales.vSalesPerson
   

SELECT 
     BusinessEntityID,
     LastName, 
     TerritoryName, 
      CountryRegionName  
FROM 
    Sales.vSalesPerson  
WHERE  
    TerritoryName IS NOT NULL  
ORDER BY 
      CASE CountryRegionName WHEN 'United States' THEN TerritoryName  
      ELSE CountryRegionName END;