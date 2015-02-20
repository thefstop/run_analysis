---
title: "ReadMe for run_analysis"
author: "thefstop"
date: "Thursday, February 19, 2015"
output: html_document
---

This markdown document serves as a ReadMe for the run_analysis.r program.  This program was written for the "Getting and Cleaning Data" Coursera course, and can be used to process untidy data, producing a result of a 'tidy' database.  

####This program assumes that the Samsung data used for this assignment is present and located in a folder named "Dataset" within the user's working directory.

To run the program, simply source the run_analysis file and run using the 'run_analysis()' command. 

The analysis file will then do the following: 

1. Merge the training and test data sets to create one data set.
2. Extract only the measurements related to the mean and standard deviation for each measurement
3. Assign descriptive names to the activities that describe the activity taking place (i.e., walking)
4. Appropriately label the variables, or columns, with descriptive variable names
5. Finally, create an independent tidy data set with the average of each variable for each combination of activity and subject

The database is output to a file named 'tidydb.txt' in the user's working directory.  The text file will not be very pleasing to the eyes when opened in a text editor, but can be loaded back into R using the command 

```
data <- read.table("tidydb.txt", header = TRUE)
> View(data)
```

####This is especially helpful when attempting to determine whether or not the dataset adheres to the principles of tidy data ;)
