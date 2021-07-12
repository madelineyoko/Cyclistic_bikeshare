# NOTES

Creating this file to help me keep track of different complications/problems while working with the dataset I come across and recording my solutions. 

I am treating this file as a journal of sorts, just to record more personal notes about the process, my frustrations, complications and *hopefully* my solutions. I am doing so in case other students might take a look, maybe find solutions to their own problems or just see that someone else is having as hard a time as they are with their very first solo project.  

### 2021-07-09
> ### word vomit  
>Today was lots of figuring out software before getting to the data.  
>  
>First step was just figuring out what tools I wanted to use. I had decided on SQL; I had more experience with it prior to the course and wanted to try cleaning a large dataset using it. However, BigQuery sandbox which they teach in the course  didn't seem to have enough storage to even hold some of the single table csv's. So I set about installing and learning to use Microsoft SQL Server with a lot of time and a lot of trouble. [Alex the Analyst](https://www.youtube.com/watch?v=RSlqWnP-Dy8&ab_channel=AlexTheAnalyst) was a saving grace I eventually found for getting started.  
>  
>I individually imported each table but had trouble on the 2021 months with all the nvarchar data types and couldn't get a successful upload until changing all string datatypes to nvarchar(MAX). I failed to look ahead on this one and ran into datatype problems again when trying to use union with all the tables and their mismatched datatypes.  
>  
>One 'going through and altering all the datatypes to match' later, and I could finally sort through the data all together. No nulls in columns other than those regarding certain end locations. There doesn't seem to be a way to supplement the info, but because it is less than 20% the solution may be just leaving out the null rows.


### 2021-07-12

#### Issues
* more Nulls found in the 'start_station_name' and 'start_station_id'  
> The amount of null start station + end stations together account for ~7-8% of the dataset.  
> Data cannot be assumed where the latitude or longitude provided or from past station data  
> Most likely data will be excluded from the analysis

Working on cleaning the dataset, going through checklist
- [x] Sources of errors
- [x] Null data
  * Used subquery to remove rows with NULLS in start and end stations
- [ ] Misspelled words
- [ ] Mistyped numbers
- [ ] Extra spaces and characters
- [x] Duplicates
  * Removing duplicates with the group by function
- [x] Mismatched data types
- [ ] Messy (inconsistent) strings
- [ ] Messy (inconsistent) date formats
- [x] Misleading variable labes(columns)
- [ ] Truncated data
- [ ] Business Logic

> ### word vomit  
> Spent a lot of time trying to see if I could keep any of the rows with Nulls in the start_station_name. Doing so may have taught me the lesson to always double check the data I have before writing anything.  
>  
>So I had created a new temporary table which I had played with a lot. I was trying to isolate just the station information like name, id, and geographical location. I was using a union to avoid duplicates is the start and end columns, rounding the latitude and longitude to make the data more consistent, and dealing with multiple ids for one station.  
>  
>I finally got a table I was happy with and exported it to a csv to manipulate in excel. Except once I import the data and start to filter it, I finally realize that there is virtually no crossover between the lat/long of the Nulls and the Non Nulls. Something I probably could have verified instead of just assuming. 
>  
>  A frustrating way to learn a lesson, but glad I learned it either way.

>  I am midway through creating a temporary table for a clean dataset. Hope to spend a lot more time on it tomorrow and finish up the above list. Have ideas to add a duration column to sort out.
