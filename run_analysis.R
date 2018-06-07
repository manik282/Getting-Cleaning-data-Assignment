
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

library("dplyr")
library("data.table")
library("reshape2")



  # IMPORTING FILES 
  # Training set
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
  # Training labels
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
  # Test set
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
  # Test labels
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
  # List of all features
  features <- read.table("./UCI HAR Dataset/features.txt")[,2]
  # labels
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  names(activity_labels) = c("V1","activity_label")
  
  #subjects
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  names(subject_train) = "subject"
  names(subject_test) = "subject"

# --------------------------------------------------------------------
  # 4.Appropriately labels the data set with descriptive variable names.
  names(X_train)  =   features
  names(X_test)  =   features

# --------------------------------------------------------------------
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
  
  extract_subset <- features[grepl("mean|std", features)]
  X_train_extract = X_train[extract_subset]
  X_test_extract = X_test[extract_subset]
  
# --------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
  
  y_train = merge(y_train,activity_labels, all.x = T)
  y_test = merge(y_test,activity_labels, all.x = T)
  y_train$V1 = NULL
  y_test$V1 = NULL
  
# --------------------------------------------------------------------
# 1. Merge the training and the test sets to create one data set.
  train_data = cbind(subject_train,X_train_extract,y_train)
  train_data$source = "train"
  test_data = cbind(subject_test,X_test_extract,y_test)
  test_data$source = "test"
  
  master_data = rbind(train_data,test_data )

# --------------------------------------------------------------------
# 5. From the data set, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  temp_data = melt (master_data, c("subject","source","activity_label"), names(master_data)[!names(master_data) %in% c("subject","source","activity_label")] )
  tidy_data   = dcast(temp_data, subject + source + activity_label ~ variable, mean)

# Export the data if needed
  
  write.table(tidy_data, file = "./UCI HAR Dataset/tidy_data.txt", row.names = F)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  