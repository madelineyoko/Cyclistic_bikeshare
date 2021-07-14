CREATE TABLE [dbo].[trip_data_clean]
(
[ride_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[user_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bike_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_station_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end_station_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[started_at] [datetime] NULL,
[ended_at] [datetime] NULL,
[duration] [datetime] NULL,
[duration_days] [int] NULL,
[duration_months] [int] NULL
) ON [PRIMARY]
GO
