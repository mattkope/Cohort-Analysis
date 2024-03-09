# Cohort Analysis ⏱️

## Cohort Analysis using SQL and Tableau Visualization

The purpose of this project is to simulate what it would be like as a data analyst for a online retail company. The task that the company has given the employee is to create a cohort analysis from the companies dataset. The employee must first import, and clean the data in SQL. Then he must create a cohort group, cohort index, and retention table in SQL. The findings must then be pushed and communicated with Tableau. Here are the main components used to create the project:  

- [UC Irvine's Online Retail Data Set](https://archive.ics.uci.edu/dataset/352/online+retail)
- Knowledge of the SQL language
- Microsoft SQL Server 2022
- Tableau Public 

## Here is a Photo of the Finished Tableau Dashboard
![Screenshot 2024-03-09 155359](https://github.com/mattkope/Cohort-Analysis/assets/133834623/cd2a5c2f-b040-4fbf-8177-d17b8cf1c6ba)
[Click here to view the dashboard in Tableau Public](https://public.tableau.com/app/profile/matt.kope/viz/CustomerRetentionDashboard_17030972221780/CohortRenentionDashboard)

## Why Cohort Analysis?

A cohort analysis is identifying the patterns of a given customer base. There are time-based cohorts, size-based cohorts, and segment-based cohorts. The one done in this project was a time-based cohort. We are looking at the time a group of people purchased something on the website. We then look at their behavior after this activity. 

## Project Instructions

1. Importing the data - Import the [UC Irvine Data](https://archive.ics.uci.edu/dataset/352/online+retail) into Microsoft Server 2022, make sure that all of the columns have the correct data type. Open a new sheet, and follow along with the cohort_analys.sql file by typing the following command into your terminal: `git clone https://github.com/mattkope/Cohort-Analysis.git`
2. Clean the data - Before cleaning the data there were 541,909 records. After cleaning the data there were 392,669 records. 
3. Create the Cohort Group - The unique identifier used in creating the group was CustomerID. The initial start date was the first invoice. 
4. Create the Cohort Index - The cohort index is an integer representation of the number of months that have passed since the customers last purchase. 
5. Create the Retention Table - The Cohort Retention table is the lefthand photo in the tableau photo. You are doing the same thing in SQL.  
6. Tableau Dashboard - Once all of the tables have been created in SQL, push the data to Tableau.

## Interpretation of Dashboard to Stakeholders

The following tables indicate the behavior of a customer once they make an initial purchase from the online retail company. For instance, there were 885 new customers that purchased something. After a month, only 324 of those customers bought from the online store again. This means there was a 37% retention rate for that month. This was the behavior for the timeframe 2010-12-01 to 2011-1-01.
