# Changelog
All notable changes to the project will be documented here.  
  
### 2021-07-09
Began the project
* Downloaded past 12 months of data 'Cyclystic' bike share data
* Created 'cyclistic_bikeshare' database in SQL Server
* Added 12 tables into database format 'td_year_mo'
* Altered each tables columns to have compatible datatypes
* Created 'trip_data' table, union of the 12 months tables
* __Sort and filter:__
  *  ordered by started_at datetime ASC
  *  ~6% of rows missing end location data  
  
 ### 2021-07-13
 #### Added
 * new table -- trip_data_clean
    * ride_id (nvarchar(50)
    * user_type (nvarchar(50), 'member' | 'casual')
    * bike_type (nvarchar(50), 'electric_bike' | 'classic_bike' | 'docked_bike')
    * start_sation_name (nvarchar(100)
    * end_station_name (nvarchar(100)
    * started_at (datetime)
    * ended_at (datetime)
    * duration (datetime)
    * duration_days (int)
    * duration_months (int)
```SQL
SELECT * INTO trip_data_clean FROM (
	SELECT
		DISTINCT ride_id,
		member_casual AS user_type,
		rideable_type AS bike_type,
		start_station_name,
		end_station_name,
		started_at,
		ended_at,
		(ended_at-started_at) AS duration,
		DATEDIFF(day, started_at, ended_at) AS duration_days,
		DATEDIFF(month, started_at, ended_at) AS duration_months
	FROM
		trip_data
	WHERE
			(start_station_name IS NOT NULL 
			AND end_station_name IS NOT NULL)
		AND
			(start_station_name <> 'WATSON TESTING - DIVVY'
			AND end_station_name <> 'WATSON TESTING - DIVVY')
		AND
			(ended_at - started_at > 0)
) as temp;
```
