USE [samknows]
Truncate table dbo.[data_engineering]  
BULK INSERT dbo.[data_engineering] 
FROM 'C:\Project\Samknows\data_engineering.csv'  WITH (FIRSTROW=2,FORMATFILE='C:\Project\Samknows\data_engineering.fmt');  