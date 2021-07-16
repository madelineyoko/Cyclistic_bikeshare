# Analytics Journal
Record of thoughts and observations during analysis of dataset

### Business Task
__Identify key behavioural differences between members and casual riders.__  
  
## 2021-07-14
### Pursuit: Bike_types
Is there a significant difference between the usage of bike type from casual riders and annual members?

#### Process:
In order to determine the whether or not there was a difference in the preference of ebikes between casuals and members I first had to examine the attributes of the dataset available to me.  
  
Significant attributes appear to be:
* `started_at` (the date of the ride)
* `bike_type`
* `user_type`
  
Certain variables required slight examination and manipulation in order to answer my question.  
##### `started_at`
I decided to use the date of the ride as factor in measuring the preference of bike_types.  
On the assumption that preference for certain bikes would vary throughout the year, I chose to use individual months as the timespan by which to measure preference. The `started_at` attribute is then represented by distinct values in a new table, renamed `year_month`.  
  
##### `bike_type`
This attribute has undergone a type of data validation. Only the values `docked_bike`, `electric_bike`, and `classic_bike` can exist in this column.  
I have made certain assumptions about the conditions under each value is present.  
* In the month 2020-06, ebikes have not yet been introduced, and there is no need for the distinction of a classic bike, hence the `docked_bike` is the only available value
* In the span of 2020-07 to 2020-11, ebikes are offered to riders, so `docked_bike` and `electric_bike` are the two available values
* In the span of 2020-12 to 2021-05, a distinguishment is made between `docked_bike` and `classic_bike`. By researching the company, I have learned that while casual riders must pay a fee to begin their rider and unlock the bicycle, this fee is waived for annual members. Therefore, I have assumed that `docked_bike`, `classic_bike` and `electric_bike` are present for casual riders to track the number of rides preceded by an unlock fee and all three values are available to casual riders. Likewise, `docked_bike` is no longer applicable to annual members and is not a valid value.  
  
##### `user_type`
Two possible values exist for this attribute, `member` and `casual`, representing annual members and casual riders in that order.  
  
#### Temporary Table
In order to examine this data easily, I created a temporary table using these three attributes.  
Additionally, I used the COUNT() function to count the number of rides, grouped first by the month and year, bike type, and then user type.
```SQL
SELECT * INTO #rides_per_type FROM (
	SELECT
		DISTINCT DATEADD(MONTH, DATEDIFF(MONTH, 0, started_at), 0) AS year_month,
		bike_type,
		user_type,
		COUNT(*) AS no_of_rides
	FROM
		trip_data_clean_v2
	GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, started_at), 0),
		bike_type,
		user_type
) AS temp
ORDER BY DATEADD(MONTH, DATEDIFF(MONTH, 0, temp.year_month), 0),
		bike_type,
		user_type
;
```
I then transfered this data to a spreadsheet for ease of calculations.  
Here, I calculated the percentage of casual user rides that used ebikes out of all the rides for casual users. Likewise, I calculated the percentage of member rides that used ebikes out of all member user rides.  
  

#### Observations:  
![image](https://user-images.githubusercontent.com/87314229/125855793-f98fcfae-0814-4501-ae6c-8e2f07a94258.png)  
*(Pivot table: number of classic, docked, and electric bikes used, casual vs members)*
  
  
From September 2020 to May 2021, casual riders report a stronger rate of use for ebikes than annual members, accounting for 9 out of the 11 months ebikes have been available.  The remaining two months with a lower usage, July 2020 and August 2020, represent the month of the ebikes release and the immediate following month.  
  
The highest usage for ebikes in both populations peaks in Novemeber 2020. 37.27% of rides by casual riders in this month were had on ebikes, and 29.88% for members. This peak occurs in the middle of the highest percentages for ebike use, September 2020 to January 2021. In Feburary 2021 A sharp drop in percentage occurs in both populations and steadily varies by less than 3% each month, averaging at 20.90% usage for casual riders, and 18.42% for members.  
  
The difference between rate of ebike use between casual riders and annual members is maximum of 9.02%, averaging at about a 3.77% difference per month. 

#### Thoughts:
Casual riders maintain higher usage of ebikes than annual members, particularly near the winter months. I can make assumptions based off the bikeshares pricing plans for this observation.  
  
Annual members have access to unlimited 45min rides. They are charged only once annually for $108, or $9 per month. However, these unlimited rides account only for use of the classic bikes. Use of an ebike for both casual riders and members is considered an upgrade, and both classes of riders are charged additional fees upon use. For an annual member who has already paid a large fee for the use of the service, this additional fee may incentivise them to choose the classic bike over an ebike more often.  
  
This fee is mostly likely not as strong a deterent for casual riders. While ebikes also require additional fees, the casual rider had not already spent any money in order to ride a bicycle and would be more likely to spend the money for the single use of the ebike.  
  
Potential a larger discount on ebike usage for members, as currently it is only $0.05 cheaper for members to upgrade, might incentivise more casual riders to pay for a membership, but this seems unlikely. It may incentivise those who are already members to make more use of ebikes, but does not seem strong enough to convince many people to buy a membership as even the highest rate of usage is below 40% for a month.  
  
  
## 2021-07-15
### Pursuit: Month of ride
How does usage of bikes between casuals and members on a month to month basis?

#### Process:
In this analysis I chose to make use of the previous temporary table just slightly altered as I had already calculated the sum of riders on a monthly basis.  
Here I commented out `bike_type` to better see the total number of riders.
```SQL
SELECT * INTO #rides_per_type FROM (
	SELECT
		DISTINCT DATEADD(MONTH, DATEDIFF(MONTH, 0, started_at), 0) AS year_month,
		--bike_type,
		user_type,
		COUNT(*) AS no_of_rides
	FROM
		trip_data_clean_v2
	GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, started_at), 0),
		--bike_type,
		user_type
) AS temp
ORDER BY DATEADD(MONTH, DATEDIFF(MONTH, 0, temp.year_month), 0),
		--bike_type,
		user_type
;
```
  
For ease of comparison, I used a window function to calculated the total number of rides per month. Additionally, I calculated the percentage of rides from each population that made up the total.  
A `WHERE` clause was also added to filter by month
```SQL
SELECT 
	year_month,
	user_type,
	no_of_rides,
	SUM(no_of_rides) OVER
		(PARTITION BY year_month) AS rides_per_month,
	ROUND(CAST(no_of_rides AS float)/SUM(no_of_rides) OVER(PARTITION BY year_month) *100, 2) AS prcnt
FROM 
	#rides_per_type
--WHERE 
	--year_month = '2020-08-01 00:00:00.000'
ORDER BY 
	year_month, 
	user_type
;
```
  
Finally, I transfered the data to a spread sheet.  
Here, I created a pivot table of the two populations number of rides and the total number of rides per month. I also created some visualizations to better see the trends through the year.  Both can be see in the Observations section below.  
  
#### Observations: 
![image](https://user-images.githubusercontent.com/87314229/125858591-e46301ce-eb62-4175-abec-9c0edf9797db.png)  
*(Pivot Table: Number of Riders per month organized by user type)*  
  
![image](https://user-images.githubusercontent.com/87314229/125857057-b8a2cacb-47de-4125-bad9-c9ea3f52ad1e.png)  
*(Stacked Bar Chart: Riders per month, casual vs members)*
  
A year of Cycliystic bike usage seems to follow a general trend upwards from June 2020 to it's highest month of usage in August 2020, where casual riders totaled 277 789, rides, and members 318 269 rides. From this month, usage steadily decreases until Feburary 2021 reaching the lowest total usage of the year, casual rides totaling 8485 rides, and members 33 785 rides.  
  
The greatest difference in usage between the two populations follows a similar trend. In the months of June, July and August, casual riders account for ~2-10% less rides than. annual members. After August, this gap steadily increases, reaching it's maximum range in January, where annual member usage accounted for 64.72% more rides than casual riders.

There is a significant increase in casual riders usage in March, where the difference in usage is 26.26% againt the previous months 59.86% difference. The gap shallows in just two months, with only a 3.6% difference in usage in May 2021.  

#### Thoughts: 
My immediate thoughts about the vast changes in usage through the months all seem related to the weather.  
  
Using [Weather Spark](https://weatherspark.com/y/14091/Average-Weather-in-Chicago-Illinois-United-States-Year-Round), an average year of weather in Chicago reports a typical hot season, from early June until late September, and a cold season, from early December to the early of March. Wind is strongest from October to May, and calmest in the months of June, July and August. Rain persists thoughout the year, though the most occurs in the 31 days surrounding June 1st. Finally, a snowy season is present through the months of December to March.  
  
These specific weather conditions appear to be in correlation with the usage of certain bikes. We might assume then that certain factors which affect bike usage might also be in correlation with the weather.  
* Bike availability/condition
* User desire
* Tourism

###### Bike availability and condition
Rain, snow, and cold are not often optimal for the maintenance of equipment, and bikes seem to be no exception. Bikes which are damaged or in need of repair may result in overall lower usage for winter months.
Upon examining Cyclysitc policy as well, not all bikes are reported to be in the system in winter months. Cyclystic during this time reduces the amount of bicycles available in order to match ridership demands. In severe weather, they also report that bikes may be reduced or entirely unavailable until the weather has cleared.

###### User desire
User desire for biking may also change with the weather. Extreme heat or extreme cold may be deterrants for usage and might encourage users to find other means of transportation. While extreme heat would not seem to have as strong an effect, extreme cold may arise potential safety concerns for cyclists, especially for those less experienced riding in poorer weather conditions.  
This may factor in the greater gap between members and casual riders during the winter season. Additionally, members have already paid for the entire year in order to ride, including the winter months. This may incentivise members to make more use of the bikes, even in poorer weather.

###### Tourism
Weather Spark also reports a tourism score, favouring clear rainless days with temperatures between 18-27 degrees Celcius.  In the city of Chicago, the tourism score falls to a 0 in the months of December to Feburary. The months of June to September report the highest scores, the highest being 7.2. Tourism may also be a factor in the high number of casual riders during the summer season, as non residents seem very unlikely to purchase an annual membership.  
  
### Pursuit: Days of the week
Is there a difference in usage depending on the day of the week between casual riders and members?

#### Process:
In order to amount of rides in each population separated by the days of the week, I wrote a query.
```SQL
SELECT
	DATENAME(dw, started_at) AS day_of_week,
	user_type,
	COUNT(*) AS no_of_rides
FROM 
	trip_data_clean_v2
GROUP BY
	DATENAME(dw, started_at),
	user_type
ORDER BY
	user_type,
	COUNT(*) DESC,
	DATENAME(dw, started_at);
```

This query returns a table for 3 columns and 14 rows. There are two instances of each day of the week, one for casual riders and the second for members. Each row returns the number of rides by each population per day of the week. 

#### Observations:
![image](https://user-images.githubusercontent.com/87314229/125858224-5f19606d-bb88-4c47-94c6-c5649921299f.png)  
*(Pivot table: Number of Rides organized by user type and day of the week)*  
  
![image](https://user-images.githubusercontent.com/87314229/125858247-ca162172-4a33-4470-ac47-4dc1437f6154.png)  
*(Column chart: Number of rides per day of the week, casual vs. member)*  
  
For casual rides, the bikes are most used on Saturday, making up for 23.44% of total casual rides. Sunday is the second highest day (19.52%), followed by Friday (14.34%). The remaining four weekdays are close to evenly split, each making up ~10% of usage.  
  
Members are much more evenly split. While Saturday sees the highest amount of usage at 15.25%, the lowest day for usage, Sunday is just 2.2% lower, making up 13.05% of total usage.  
  
#### Thoughts:
It is not deeply surprising that for casual users the weeekends see the most usage of bikes.  
From this information one could assume that for the majority of casual riders, biking is not incorporated into their regular schedule. While a casual member may be more inclined to ocassionally use a bike for transportation or an entertaining activity, an annual member likely uses the bike regularly in their day to day like, whether for commuting to work, for exercising, or running errands.

## 2021-07-16
### Pursuit: Length of ride
Do casual riders and annual members tend to ride for the same length of time?

#### Process:
In order to examine durations for rides among casual riders and annual members, I altered the table once more. Rather than observe the duration of rides in seconds, I chose to obeserve them in minutes. Ride length in minutes gives a more immediate understanding of the length, and the specificity of seconds would mostly likely not provide any additional insight.  
  
The query for the working table:  
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
  
From this table I created a query to pull a table of descriptive statistics. This query makes heavy use of window functions, specifically `AVG()` and `PERCENTILE_CONT()` to retrieve the minimum and maximum ride lengths, the 1st and 3rd quartiles, the median and the mean of ride lengths. These measures are also distinguished by user type.  
```SQL
SELECT 
	DISTINCT user_type,
	PERCENTILE_CONT(0)
		WITHIN GROUP(ORDER BY duration) OVER (PARTITION BY user_type) AS min_drtn,
	PERCENTILE_CONT(0.25)
		WITHIN GROUP(ORDER BY duration) OVER (PARTITION BY user_type) AS [25%],
	PERCENTILE_CONT(0.5)
		WITHIN GROUP(ORDER BY duration) OVER (PARTITION BY user_type) AS median,
	AVG(DATEDIFF(MINUTE, started_at, ended_at)) OVER
		(PARTITION BY user_type) AS mean_drtn,
	PERCENTILE_CONT(0.75)
		WITHIN GROUP(ORDER BY duration) OVER (PARTITION BY user_type) AS [75%],
	PERCENTILE_CONT(1)
		WITHIN GROUP(ORDER BY duration) OVER (PARTITION BY user_type) AS max_drtn
FROM trip_data_clean_v3
;
```  
  
#### Observations 
![image](https://user-images.githubusercontent.com/87314229/125954596-e07de6f9-366d-49ac-b216-f89d0a0fc10a.png)  
*(Table: descriptive statistics for duration of rides, casual vs members)  

The range of ride durations included in the analysis extended from a minimum of 1 minute to 24 hours. The maximum and minimum ranges for both user types reflect this.  
  
Each measure for duration is longer in the casual user. On average, rides by casual users seem to last 20 minutes longer than rides by annual members. Member rides are notably still shorter at the 3rd quartile than the casual ride average. 
  
#### Thoughts  
  
