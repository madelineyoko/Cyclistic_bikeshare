# Cleaning Report
A descriptive report of cleaning and manipulations performed on the dataset.
  
## Areas of Concern:
* Duplications
* Null data cells
* Misspelled words
* Mistyped numbers
* Mismatched datypes
* Messy/Inconsistent strings
* Messy/Inconsistent date formats
* Misleading variable labels
* Business Logic

#### Duplications
Quering to find duplicates:
```SQL
SELECT 
	ride_id, 
	COUNT(ride_id), 
	start_station_name, 
	end_station_name
FROM 
	trip_data
GROUP BY 
	ride_id, 
	start_station_name, 
	end_station_name
HAVING 
	COUNT(ride_id) > 1
```
Query returned 209 rows of duplicated data.
Data was removed from table through use of `DISTINCT` regaring ride_id  
`SELECT DISTINCT ride_id`  
  
#### Nulls
Multiple null cells found in columns:
  * `start_station_name`
  * `end_station_name`
  * `start_station_id`
  * `end_station_id`
  * `start_lat`
  * `start_lng`
  * `end_lat`
  * `end_lng`
No way to supplement data. Geographical locations not necessary.  
Rows with Nulls account for less than 10% of the data, will remove.
 
#### Misspelled Words
7 total station_names found with (\*) as a suffix. Appears to be intentional rather than separate inconsistent format. Will not exclude rows.  
   
Station_name 'WATSON TESTING - DIVVY' appears, wide range of start and end times, as well as duration. All rideable_type listed as `electric_bike` , and all member_casual listed as `casual`. Account for less than 1% of data. Will remove rows.  
  
#### Misspelled Numbers
Only geographical coordinates are listed as number datatypes.  
Coordinates are irrelevant to analysis and will be excluded from the cleaned table.  
  
 
#### Mismatched datypes
String data inconsistent - 2020 data accepted as `nvarchar(50)`, 2021 data accepted as `nvarchar(MAX)`  
`start_station_name`, `end_station_name` altered to `nvarchar(100)`. Remaining string variables all `nvarchar(50)`
 
Date format consistent `datetime`.

#### Misleading variable labels
`user_type <- member_casual`  
* `member_casual` narrow in it's description. Variable changed to `user_type`.  
  
`bike_type <- rideable_type`  
* Only bikes are offered to ride. Makes variable more clear.  
  
#### Business Logic
Looking for variables which will point to key behavioural differences between casual riders and annual members.  
Necessary variables appear to be, `ride_id`, `user_type`, `bike_type`, `start_station_name`, `end_station_name`, `started_at`, `ended_at`, `duration_minutes`.  
All remaining variables unneccesary for analysis and will be excluded from final table.

### Current Clean Data Query
#### updated 2021-07-16 -- trip_data_clean_v3 
  
```SQL
SELECT * INTO trip_data_clean_v3 FROM (
	SELECT
		DISTINCT ride_id,
		member_casual AS user_type,
		rideable_type AS bike_type,
		start_station_name,
		end_station_name,
		started_at,
		ended_at,
		DATEDIFF(minute, started_at, ended_at) AS duration
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
		AND
			DATEDIFF(second, started_at, ended_at) < 86400
		AND 
			DATEDIFF(second, started_at, ended_at) > 59
) as temp;
```
