# Google Data Analytics: Capstone Project
### Cyclistic Bike Share

## Project Overview
A fictional bike-sharing company, **Cyclistic**, has hypothesized that maximizing the number of annual members, versus casual riders, is the key to their future growth. In order to build a new marketing strategy aimed to convert casual riders into annual members, the marketing analyst tems wants to know:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would causal riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

I will be answering the first question using the 6 steps of data analysis taught in the Google Data Analytics course; ask, prepare, process, analyze, share, and act.


## Ask
  
The Cyclistic executive team is concerned with maximizing their future growth as a company. Lily Moreno, the director of marketing, is concerned with ensuring this growth by creating a marketing strategy designed to convert casual riders of Cyclistic into annual members. The marketing analytics team, which I am a member of, are concered with using our data to answer the three above questions, and use the answers to guide the marketing program.  
  
The current task is to analyze the data and identify key behavioural differences between casual riders and annual members in order to present reccomended next steps to the company.  
  
## Prepare
  
The data used in the project comes is stored in AWS (Amazon Web services). I am using only the past 12 months of trip data, beginning in 2020-06 and ending in 2021-05.
The data is collected directly from Cyclistic and has been made available by Motivate Internation Inc. under [this license](https://www.divvybikes.com/data-license-agreement). The data has been anonymized and no personally identifiable information has been included in the data.  While this will prevent analysis which would examine specific personal traits of individual riders, such as individual history or areas of residence, there is still enough data to identify certain behaviours.  
  
## Process (Data Cleaning)
  
The primary tools for my analysis are Microsoft SQL Server, and Google Sheets.  
  
The extensive report for the cleaning process can be found [here](https://github.com/madelineyoko/Cyclistic_bikeshare/blob/main/Cleaning_Report.md).  
In summary I made the following changes:  
  
* Removed duplicate rows
* Removed rows with null values concerning start and end stations
* Excluded rows reporting electric bike testing
* Excluded geographical coordinates
* Ensured consistency in datatypes across variables
* Altered variable names
  * bike used during ride = `bike_type`
  * user membership status = `user_type`
* Created a column to report duration of each ride
* Excluded trips lasting less than 1 minute, or over 24 hours
  
  
## Analyze
