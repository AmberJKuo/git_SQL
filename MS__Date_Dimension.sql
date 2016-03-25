Drop table 

CREATE TABLE [Ref]. [dbo].[date_dimension] (
[Calendar_Dt] Date
,[Day_Num] Tinyint
,[Freq_bitmask] Tinyint
,[Dt_year] Smallint
,[Dt_month] Tinyint
,[Dt_day] Tinyint
,[Base_Day_Offset] Integer
,[Base_Week_Offset] Integer
,[Julian_Day] Smallint
,[Julian_Week] Smallint
,[Dt_Month_End_Offset] Tinyint

);


/*Insert into table*/
INSERT INTO [Ref].[dbo] .[date_dimension](
[Calendar_Dt] 
,[Day_Num] 
,[Freq_bitmask] 
,[Dt_year] 
,[Dt_month] 
,[Dt_day] 
,[Base_Day_Offset] 
,[Base_Week_Offset] 
,[Julian_Day] 
,[Julian_Week] 
,[Dt_Month_End_Offset] 
)

select * from openquery (TERADATA_BMJ , '

select 
Calendar_Dt 
,Day_Num
,Freq_bitmask
,Dt_year
,Dt_month
,Dt_day
,Base_Day_Offset 
,Base_Week_Offset 
,Julian_Day 
,Julian_Week 
,Dt_Month_End_Offset 
from co_prod_vmdb.date_dimension
')
;
  

