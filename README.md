# Getting and Cleaning data Assignment

## Code workflow

The R code run_analysis.R does the following data processingsteps using the Samsung wearable data
  
* Appropriately labels the data set with descriptive variable names
* Extract only the measurements on the mean and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set
* Merge the training and the test sets to create one data set.
* From the data set, create a second, independent tidy data set with the average of each variable for each activity and each subject

The output is the data file tidy_data.txt


## Libraries required
data.table, reshape2, dplyr: All are installed as part of the code in case they aren't installed earlier

## Data & file locations semantics 
Create a folder to place the following two peice of content
* The R code run_analysis.R 
* UCI HAR Dataset folder

This folder needs to be made the working directory in R. Then, run source("run_analysis.R") in this working directory to generate a new file tiny_data.txt
