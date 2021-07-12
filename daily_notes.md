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
> The amount of null start station + end stations together probably account for ~7-8% of the dataset.  
> While the latitude and longitude values are missing as well for all the end_station data, they are present for the start stations.  
> Current potential solution is to alter the tables once again. I currently will plan to split the trip_data table into two separate tables, trip_data and station_data. 
>    
> trip_data will contain:
>  * ride_id (char)
>  * rideable_type (char)
>  * started_at (dt)
>  * ended_at (dt)
>  * start_station_id (int)
>  * end_station_id (int)
>  * member_casual (char)  
>    
> station_data will contain:
> * station_id (int)
> * station_name (char)
> * station_lat (float)
> * station_lng (float)
