#This markdown summarizes the purpose and functionality of run_analysis.R, a script written as a homework project for a Coursera course on Getting and Cleaning Data.

==================================================================
Hao Wang
about.me/haow
==================================================================

This script reads, cleans, and processes data from the following source: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In order to fulfill the following goals:
 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set created from the training and test sets, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script assumes that the unzipped folder called 'UCI HAR Dataset', which contains the relevant data and txt files, is accessible from the working directory.

Additionally, the script utilizes the 'dplyr' and 'data.table' packages.

To run the script from the R command line:

source("run_analysis.R")
run("test", "train")

==================================================================

The script creates a function that first reads the data keys for activities and for variable names.  It then reads the test data from txt files provided from the zip folders, and consolidates them into a data frame, applying column/variable names and filtering out columns of data that are related to means and standard deviations.  It then reads the training data set in the same way, and combines the two data sets into one single data set.

From there, the script calculates the average of each available variable grouped by activities and by subject, and then proceeds to write these results to a txt file, saved to the working directory.


