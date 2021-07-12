CREATE TABLE [dbo].[td_2020_12]
(
[ride_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rideable_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[started_at] [datetime2] NULL,
[ended_at] [datetime2] NULL,
[start_station_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_station_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end_station_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end_station_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_lat] [float] NULL,
[start_lng] [float] NULL,
[end_lat] [float] NULL,
[end_lng] [float] NULL,
[member_casual] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
