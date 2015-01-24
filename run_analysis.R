tidy_data <- function(){
  

  
# import libraries tidyr and dplyr 
  library(tidyr)
  library(dplyr)
  

  a <- read.table("X_train.txt")
  b <- read.table("X_test.txt")
  c <- read.table("y_train.txt")
  d <- read.table("y_test.txt")
  e <- read.table("subject_train.txt")
  f <- read.table("subject_test.txt")

  a <- tbl_df(a)
  b <- tbl_df(b)
  c <- tbl_df(c)
  d <- tbl_df(d)
  e <- tbl_df(e)
  f <- tbl_df(f)

  x_merge <- rbind(a,b)
  y_merge <- rbind(c,d)
  z_merge <- rbind(e,f)


# read the variables names from the features.txt and assign then to variable features
  features <- read.table("features.txt")

# transform to the variables names read in the last step 

  names <- as.vector(features[["V2"]])

# makes valid names from the vector name

  valid_names <- make.names(names, unique = TRUE)
 
 # assign the values defined in the last step 
  
  colnames(x_merge) <- valid_names 

  x_select <- select(x_merge, contains("mean"), contains("std"), -contains("angle"))

  
# read data from the activity_lebels.txt file

  activities <-read.table("activity_labels.txt") 

# assign the name of the column activity to the the z_merge variable 

  colnames(y_merge) <- "activitycode"

  colnames(activities) <-c("activitycode", "activitynames")

# assign the names subject to the data of z_merge 

  colnames(z_merge) <- "subject"

# asignment of the activity name to the activity value associated

  y_join <- left_join(y_merge, activities, by = "activitycode")

# change the name of the y_join columns to activity_code and activity names

  
  colnames(y_join) <-c("activitycode", "activitynames")

"join variables, columns to indicate person and activity"

 dataset <- cbind(z_merge, y_join, x_select)
 #dataset <- cbind(z_merge, y_merge, x_select)
 dataset <- tbl_df(dataset)
  
 clean_data <- tolower(names(dataset))
 
  
 #join_dataset <- left_join(dataset, activities, by = "activity_code")

 # transforming variables names in more descriptive and understandible character names
 
  
 clean_data <- sub("^t","time", clean_data)
 clean_data <- sub("^f","freq", clean_data)
 clean_data <- gsub("[.]","", clean_data) 
 clean_data <- sub("bodybody","body", clean_data)

 colnames(dataset) <- clean_data 

 
# calculate the mean of each variable for each subject and each activity

 group_sub <- group_by(dataset, subject, activitynames)
 final_data <- summarise_each(group_sub, funs(mean))

# export the tidy data 

write.table(final_data, file = "tidy_data.txt", row_names=FALSE)

print("tidy_data.csv has been created in your working directory")

}

