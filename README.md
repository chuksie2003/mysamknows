# mysamknows
data point anomaly
============================================================================================
Use of Outlier Algorithim to define data point anomalies in Samknows dataset
============================================================================================
Outliers are extreme values that deviate from other observations on data , they may indicate a variability in a measurement
, experimental errors or a novelty. In other words, an outlier is an observation that diverges from an overall pattern on a sample.
The algorithm utilizes the data point thresholding to identfy anomalies in data

The TSQL code leverages existing algorithm investigate data sets and identify anomalies.

The listed requirements are needed to implement this process

1, Create local folder C:\Project\Samknows\
2, Move the files samknows_createDB.sql, samknows_loadcsv.sql into the folder
3. install SQL server express 
4. Run SQL CMD against the SQL server express to create the database and associated table
5. Run SQL CMD against the SQL server express to upload data into the database and associated table
5. Run SQL CMD against the SQL server express to review data and list out the anomaly data points

