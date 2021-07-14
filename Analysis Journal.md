# Analytics Journal
Record of thoughts and observations during analysis of dataset

### Business Task
__Identify key behavioural differences between members and casual riders.__  
  
## 2021-07-14
### Pursuit: Bike_types
Is there a significant difference between the preferred bike type of casual riders and annual members?

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
		trip_data_clean
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
![no_of_riders pivot table](https://user-images.githubusercontent.com/87314229/125673635-848a68c7-e6c1-40c1-98af-7eb5fbec4813.PNG)
  
  
From September 2020 to May 2021, casual riders report a stronger rate of use for ebikes than annual members, accounting for 9 out of the 11 months ebikes have been available.  The remaining two months with a lower usage, July 2020 and August 2020, represent the month of the ebikes release and the immediate following month.  
  
The highest usage for ebikes in both populations peaks in Novemeber 2020. 37.19% of rides by casual riders in this month were had on ebikes, and 29.80% for members. This peak occurs in the middle of the highest percentages for ebike use, September 2020 to January 2021. In Feburary 2021 A sharp drop in percentage occurs in both populations and steadily varies by ~3% each month, averaging at 20.90% usage for casual riders, and 18.42% for members.  
  
The difference between rate of ebike use between casual riders and annual members is maximum of 9.02%, averaging at about a 3.77% difference per month. 

#### Thoughts:
Casual riders maintain higher usage of ebikes than annual members, particularly near the winter months. I can make assumptions based off the bikeshares pricing plans for this observation.  
Annual members have access to unlimited 45min rides. They are charged only once annually for $108, or $9 per month. However, these unlimited rides account only for use of the classic bikes. Use of an ebike for both casual riders and members is considered an upgrade, and both classes of riders are charged additional fees upon use. For an annual member who has already paid a large fee for the use of the service, this additional fee may incentivise them to choose the classic bike over an ebike more often.  
This fee is mostly likely not as strong a deterent for casual riders. While ebikes also require additional fees, the casual rider had not already spent any money in order to ride a bicycle and would be more likely to spend the money for the single use of the ebike.  
  
Potential a larger discount on ebike usage for members, as currently it is only $0.05 cheaper for members to upgrade, might incentivise more casual riders to pay for a membership, but this seems unlikely. It may incentivise those who are already members to make more use of ebikes, but does not seem strong enough to convince many people to buy a membership as even the highest rate of usage is below 40% for a month.
