# Changelog
All notable changes to the project will be documented here.  
  
In addition I am treating this file as a journal of sorts, just to record more personal notes about the process, my frustrations, complications and *hopefully* my solutions. I am doing so in case other students might take a look, maybe find solutions to their own problems or just see that someone else is having as hard a time as they are with their very first solo project.  
  
### 2021 - 07 - 09
Began the project
* Downloaded past 12 months of data 'Cyclystic' bike share data
* Created 'cyclistic_bikeshare' database in SQL Server
* Added 12 tables into database format 'td_year_mo'
* Altered each tables columns to have compatible datatypes
* Created 'trip_data' table, union of the 12 months tables
* __Sort and filter:__
  *  ordered by started_at datetime ASC
  *  ~6% of rows missing end location data

> ### word vomit  
>Today was lots of figuring out software before getting to the data.  
>  
>First step was just figuring out what tools I wanted to use. I had decided on SQL; I had more experience with it prior to the course and wanted to try cleaning a large dataset using it. However, BigQuery sandbox which they teach in the course  didn't seem to have enough storage to even hold some of the single table csv's. So I set about installing and learning to use Microsoft SQL Server with a lot of time and a lot of trouble. [Alex the Analyst](https://www.youtube.com/watch?v=RSlqWnP-Dy8&ab_channel=AlexTheAnalyst) was a saving grace I eventually found for getting started.  
>  
>I individually imported each table but had trouble on the 2021 months with all the nvarchar data types and couldn't get a successful upload until changing all string datatypes to nvarchar(MAX). I failed to look ahead on this one and ran into datatype problems again when trying to use union with all the tables and their mismatched datatypes.  
>  
>One 'going through and altering all the datatypes to match' later, and I could finally sort through the data all together. No nulls in columns other than those regarding certain end locations. There doesn't seem to be a way to supplement the info, but because it is less than 20% the solution may be just leaving out the null rows.
