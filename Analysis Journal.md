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
