USE [master]
GO

/****** Object:  Database [samknows]    Script Date: 13/06/2019 20:53:43 ******/
CREATE DATABASE [samknows]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'samknows', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\samknows.mdf' , SIZE = 158720KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'samknows_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\samknows_log.ldf' , SIZE = 160384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE [samknows]
GO

/****** Object:  Table [dbo].[data_engineering]    Script Date: 13/06/2019 20:51:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[data_engineering](
	[measurement_datetime] [datetime] NULL,
	[device_identifier] [varchar](50) NULL,
	[bytes_total] [bigint] NULL,
	[bytes_per_second] [nvarchar](50) NULL,
	[successes] [int] NULL,
	[failures] [int] NULL,
	[fetch_time] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


