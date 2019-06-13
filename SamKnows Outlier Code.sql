/*
============================================================================================
Use of Outlier Algorithim to define data point anomalies in Samknows dataset
============================================================================================
Outliers are extreme values that deviate from other observations on data , they may indicate a variability in a measurement
, experimental errors or a novelty. In other words, an outlier is an observation that diverges from an overall pattern on a sample.
The algorithm utilizes the data point thresholding to identfy anomalies in data
< Q1-(1.5*IQR) As Lower threshold
> Q3 +(1.5*IQR) As Upper threshold
*/

/*
============================================================================================
Execute the create DB and table structures on your SQL server express
Using the SQLCMD command
============================================================================================
*/

sqlcmd -S myServer\instanceName -i C:\Project\Samknows\samknows_createDB.sql

/*
============================================================================================
Execute the Upload CSV file into and table structures on your SQL server express
Using the SQLCMD command
============================================================================================
*/

sqlcmd -S myServer\instanceName -i C:\Project\Samknows\samknows_loadcsv.sql

/*
============================================================================================
Use the uploaded sample to generate available data points from Samknows dataset for the 
implementation of Univariate data points processing
============================================================================================
*/

With source as(
 SELECT 
  convert(varchar(10),measurement_datetime,112) measurement_datetime, Sum(bytes_total) Occurances
  FROM [samknows].[dbo].[data_engineering1]
 group by
 convert(varchar(10),measurement_datetime,112))
 
select ROW_NUMBER() OVER(ORDER BY Occurances ASC) AS Row#,* into #tmpDatapoints from source order by Occurances

/*Implement code data variables*/
Declare @maxdatapoints int , @Halfway_Data_point int, @Q1_Data_point_Strt int, @Q3_Data_point_Strt int
Select  @maxdatapoints = max(Row#) from #tmpDatapoints
Select  @Halfway_Data_point = (@maxdatapoints/2)+(@maxdatapoints%2) --Halfway_Data_point
Select  @Q1_Data_point_Strt= (@Halfway_Data_point/2)
select @Q3_Data_point_Strt =29-@Q1_Data_point_Strt


/*Determine Q1 data point Vaule*/
Declare @Q1_Data_point_Val float
Select @Q1_Data_point_Val = Convert(float, sum(Occurances)/2.0)
from (select top 2 * from #tmpDatapoints where Row#>=@Q1_Data_point_Strt) as t

/*Determine Q3 data point Vaule*/
Declare @Q3_Data_point_Val float
Select @Q3_Data_point_Val= Convert(float, sum(Occurances)/2.0)
from (select top 2 * from #tmpDatapoints where Row#>=@Q3_Data_point_Strt)-- order by Row# 
as t

/*Determine IQR data point Vaule*/
Declare @IQR_Val as float
Select  @IQR_Val= @Q3_Data_point_Val - @Q1_Data_point_Val

/*Determine Outlier Lower and upper thresholds */
Declare @Lower_threshold float, @Upper_threshold float
Select @Lower_threshold = @Q1_Data_point_Val-(1.5*@IQR_Val) , @Upper_threshold = @Q3_Data_point_Val+(1.5*@IQR_Val) 

/*Identify and list Outlier based anomalies in samknows data samples*/
Select *, isAnomaly=1 from #tmpDatapoints where occurances < @Lower_threshold 
Union all
Select *, isAnomaly=1 from #tmpDatapoints where occurances >@Upper_threshold order by 2