# datasciencecoursera
Repository for DataScientist courses

## Cleaning Data - Course Project

### Introduction

The goal of the run_analysis.R script is to prepare a tidy data set that can be used for later analysis.
The original dataset is related to "Human Activity Recognition Using Smartphones"
Resumed description of original dataset:
- Group of 30 persons wearing a smartphone.
- Each person performed 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
- Each record provided: a 561-feature vector with variables.

See details in Course Project page.

Description of final dataset:
Average of selected variables for each subject and activity.
See the var names in file "vars_analysis.txt"

### Assignment

In order to complete this assignment, I did the following:

0. Load data from files 
   Using read.table() 
   note: if colnames is omitted, columns (variables) are loaded as V1, V2, V3...

1. Combine train+test datasets (by rows)
   Using rbind()
   note: delete partial sets for release memory 
   
2. Extract the measurementes of mean and standard deviation
   Using subsetting and %like% (data.table)
   Read the names (and ids) of vars from features file,
   then select the vars using subset and %like%.
   After that, subset the complete dataset using,
   var.id 1, 2 ... <=> number of column V1, V2...

3. Uses descriptive activity names
   Using cbind() and merge(()
   Add activity label column to dataset and then 
   join dataset and activities by activity id.
   note: delete activity.id from merged data
   
4. Label dataset with descriptive variable names
   Using names() and subsetting
   
5. Create a tidy dataset with average of each var by activity and subject
   Using cbind(), aggregate()
   Add subject column to data set and then
   aggregate the merged data by activity and subjetc.
   note: use write.table to generate a text file