getting-and-cleaning
====================
This readme explains what do you need to do to sucessfully run the run_analysis.R script in order to clean the data download related to the study of human activity recognition using smartphones Data Set.

The run_analysis.R script performs a series of operation aiming to convert the raw data collected in the human activity recognition using smartphones Data Set experiment available on internet in tidy data ready to perform exploratory analysis and stadistics test on it. Basically script merge the training and test data of the experiment creating one dataset. Then, extract the mean and standard deviation of each variable. After, the activity code was associated with its descriptive activity name and approapiate labels readable for R were created. Finally, the average of each variable for each activity an each subject was calculated and the results were export into a txt file.  

To run the script follow the next steps:

1) first you need to download the data from the following address:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2) You need to unzip the file. As a result you will find a main directory called UCI HAR Dataset with 2 subdirectories inside, test and train. You need to copy the files subject_train.txt, X_train.txt and y_train.txt from the train folder to the main folder UCI HAR Dataset and files subject_test.txt, X_test.txt and y_test.txt from the subdirectory test to the main directory UCI HAR Dataset.

3) This UCI HAR Dataset will be our working directory and finally we need to copy the run.analysis.R script into it.

4) We need to source the script in R and run the tidy_data() function.

5) As a result we will get a tidy_data.txt files with the results asked of point five asked in this assignment located in your working directory. In this case the UCI HAR Dataset folder.

