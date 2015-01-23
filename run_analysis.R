tidy_data <- function(){
  

  
 
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



  features <- read.table("features.txt")

# transformacion a vector de las variables leidas en el paso anterior

  names <- as.vector(features[["V2"]])

# makes valid names from the vector name

  valid_names <- make.names(names, unique = TRUE)
 
 # asignacion de los valores definidos en el paso anterior
  
  colnames(x_merge) <- valid_names 

  x_select <- select(x_merge, contains("mean"), contains("std"), -contains("angle"))

  
# leer datos del archivo 

  activities <-read.table("activity_labels.txt") 

# asignacion de la columna activity al archivo z_merge

  colnames(y_merge) <- "activitycode"

  colnames(activities) <-c("activitycode", "activitynames")

# asignacion del nombre subject a los datos de z_merge

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

write.csv(dataset, file ="dataset.csv")
write.csv(final_data, file = "tidy_data.csv")

print("dataset.csv and tidy_data.csv has been created in your working directory")

}

