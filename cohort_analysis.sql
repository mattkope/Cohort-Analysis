IF OBJECT_ID('tempdb..#online_retail_main') IS NOT NULL
    DROP TABLE #online_retail_main

IF OBJECT_ID('tempdb..#cohort') IS NOT NULL
    DROP TABLE #cohort

IF OBJECT_ID('tempdb..#cohort_retention') IS NOT NULL
    DROP TABLE #cohort_retention

IF OBJECT_ID('tempdb..#cohort_pivot') IS NOT NULL
    DROP TABLE #cohort_pivot


--- Cleaning Data

--- Total Records = 541,909

;with online_retail as 
(
	SELECT [InvoiceNo]
		  ,[StockCode]
		  ,[Description]
		  ,[Quantity]
		  ,[InvoiceDate]
		  ,[UnitPrice]
		  ,[CustomerID]
		  ,[Country]
	  FROM [Portfolio].[dbo].[Online Retail]
	  Where CustomerID !=0
)
,quanity_unit_price as 
(
	select * 
	from online_retail
	where Quantity > 0 and UnitPrice > 0
)
, dup_check as
(
	--- duplicate check
	select * , ROW_NUMBER() over (partition by InvoiceNo, StockCode, Quantity order by InvoiceDate)dup_flag
	from quanity_unit_price
) 

select *
into #online_retail_main
from dup_check
where dup_flag = 1

--- Total Records = 392,669
--- Clean Data for Cohert Analysis
select * 
from #online_retail_main

--- Unique Identifier (CustomerID)
--- Intial Start Date (First Invoice Date)
--- Revenue Data

select 
	CustomerID,
	min(InvoiceDate) first_purchase_date,
	DATEFROMPARTS(year(min(InvoiceDate)), month(min(InvoiceDate)),1)Cohort_Date
into #cohort
from #online_retail_main
group by CustomerID

select *
from #cohort

--- Retention Analysis 
--- Creating Cohort Index
select
	mmm.*,
	cohort_index = year_diff * 12 + month_diff + 1
into #cohort_retention
from
	(
		select
			mm.*,
			year_diff = invoice_year - cohort_year,
			month_diff = invoice_month - cohort_month
		from
			(
				select
					m.*,
					c.Cohort_Date,
					year(InvoiceDate) invoice_year,
					month(InvoiceDate) invoice_month,
					year(c.Cohort_Date) cohort_year,
					month(c.Cohort_Date) cohort_month
				from #online_retail_main m 
				left join #cohort c
					on m.CustomerID = c.CustomerID
				)mm
			)mmm
select * from #cohort_retention

---Pivot Data to see the cohort table
select *
---into #cohort_pivot
from(
select distinct
	CustomerID,
	Cohort_Date,
	cohort_index
from #cohort_retention
)tbl
pivot(
	Count(CustomerID)
	for Cohort_Index In
	(
	[1],
	[2],
	[3],
	[4],
	[5],
	[6],
	[7],
	[8],
	[9],
	[10],
	[11],
	[12],
	[13]
	)
)as pivot_table
order by Cohort_Date


select Cohort_Date ,
	(1.0 * [1]/[1] * 100) as [1], 
    1.0 * [2]/[1] * 100 as [2], 
    1.0 * [3]/[1] * 100 as [3],  
    1.0 * [4]/[1] * 100 as [4],  
    1.0 * [5]/[1] * 100 as [5], 
    1.0 * [6]/[1] * 100 as [6], 
    1.0 * [7]/[1] * 100 as [7], 
	1.0 * [8]/[1] * 100 as [8], 
    1.0 * [9]/[1] * 100 as [9], 
    1.0 * [10]/[1] * 100 as [10],   
    1.0 * [11]/[1] * 100 as [11],  
    1.0 * [12]/[1] * 100 as [12],  
	1.0 * [13]/[1] * 100 as [13]
from #cohort_pivot
order by Cohort_Date


-- Determining the amount of cohorts (13)
--	select distinct
--		cohort_index
--	from #cohort_retention

