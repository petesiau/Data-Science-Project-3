## Program Name: run_analysis.R
## Author      : Siau Yen Phin
## Date Created: 24 July 2015
##
## Project     : Module 3 Project

## --- Set working directory ---
setwd("./UCI HAR Dataset")

## --- Load required R packages ---
library(data.table)
library(dplyr)

## --- Capture the feature and activity labels ---
feature_list <- read.table("workdir/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## --- Read in the given tables from the training set ---
training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
training_activities <- read.table("./UCI HAR Dataset/train/Y_train.txt")
training_features <- read.table("./UCI HAR Dataset/train/X_train.txt")

## --- Read in the given tables from the test set ---
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_features <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_activities <- read.table("./UCI HAR Dataset/test/Y_test.txt")

## --- Part 1. Merge the Training and Test data sets to create 1 data set
mergedSubject_ds <- rbind(training_subject, test_subject)
mergedFeatures_ds <- rbind(training_features,test_features)
mergedActivities_ds <- rbind(training_activities,test_activities)

colnames(mergedFeatures_ds) <- t(feature_list[2])
colnames(mergedSubject_ds) <- "Subject"
colnames(mergedActivities_ds) <- "Activity"

mergedDS <- cbind(mergedFeatures_ds, mergedActivities_ds, mergedSubject_ds)

## --- Part 2. Extracts only the measurements on the mean and standard deviation 
## --- for each measurement

column_with_MeanStd <- grep("mean|std", names(mergedDS),ignore.case=TRUE)

## --- Part 3. Uses descriptive activity names to name the activities in the
## --- data set

## --- Append additional columns for activity & subject

additionalColumns <- c(column_with_MeanStd, 562,563)

## --- Create a new merged dataset with 2 addition columns appended

mergedDS2 <- mergedDS[,additionalColumns]

## --- Change the activity column from numeric to character
mergedDS2$Activity <- as.character(mergedDS2$Activity)

## --- Replace the Activity column with description
for (i in 1:6) { 
  mergedDS2$Activity[mergedDS2$Activity ==i] <- as.character(activity_labels[i,2])
}

## --- Part 3. Appropriately labels the data set with 
## --- descriptive variable names.

## --- Use gsub() function replaces all matches of a string
names(mergedDS2) <- gsub("Acc", "Accelerometer", names(mergedDS2))
names(mergedDS2) <- gsub("Gyro","Gyroscope", names(mergedDS2))
names(mergedDS2) <- gsub("Mag","Magnitude", names(mergedDS2))

## --- Part 5. From the data set in step 4, creates a second, 
## --- independent tidy data set with the average of each variable 
## --- for each activity and each subject.

tidyData <- aggregate(. ~Subject + Activity, mergedDS2, mean)
tidyData <- tidyData(order(tidyData$Subject, tidyData$Activity))
write.table(tidyData, file = "Tidydata.txt", row.names = FALSE)
