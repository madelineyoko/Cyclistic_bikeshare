# Changelog
All notable changes to the project will be documented here.  
  
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
