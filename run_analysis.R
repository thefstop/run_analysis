run_analysis <- function() {
  
  
  ##Load the data required for analysis
  
  library(dplyr)
  ##Acts are the possible activities. Used as labels for factors
  acts<- c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")
  
  #Load test data. y_test is loaded as a vector so that it can be
  #conerted to a factor, using the 'acts' variables as label names
  x_test <- read.table("Dataset/test/X_test.txt") 
  y_test<-as.numeric(scan("Dataset/test/y_test.txt", sep="\n"))
  subject_test<-read.table("Dataset/test/subject_test.txt")
  
  x_train <- read.table("Dataset/train/X_train.txt") 
  y_train <- as.numeric(scan("Dataset/train/y_train.txt", sep="\n"))
  subject_train<-read.table("Dataset/train/subject_train.txt")
  
  #Create the factor that contains the activity names,convert to DF
  acts_test <- data.frame(factor(y_test, labels=acts))
  acts_train <- data.frame(factor(y_train, labels=acts))
  
  #Bind the Subject ID, Activity, and all the feature columns
  test_db<-bind_cols(subject_test, acts_test, x_test)
  train_db<-bind_cols(subject_train, acts_train, x_train)
 
    #Load the identifying data for the features to use as column names
  
  features <-read.table("Dataset/features.txt", sep=" ")
  features<-as.vector(features[,2])
  
  #Add descriptive column names, two I've typed in and the rest from the
  #features.txt. The as.vector step strips out the numbers that are a part of features.txt
  colnames(test_db)<-c("Subject_ID", "Activity", features)
  colnames(train_db)<-c("Subject_ID", "Activity", features)
  
  #Combine the test and training databases
  master_db<- bind_rows(test_db, train_db)
  
  #Select only the columns specified,and those that contain mean() or std()
  trim_db<-select(master_db, Subject_ID, Activity, contains("mean()"), contains("std()"))
  
  View(trim_db)
  #Create the separate database, in 'wide view' that contains the avergae
  #for each variable. First use the group_by command to group by subject and
  #activity. Then use sumarise_each to apply the mean to each variable.
  avg_db <- group_by(trim_db, Subject_ID, Activity)
  result_db<-summarise_each(avg_db, funs(mean))
  View(result_db)
  #Output the tidy results for submission 
  write.table(result_db, file="tidydb.txt", row.names= FALSE)
}
  