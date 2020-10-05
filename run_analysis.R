library(data.table)
library(dplyr)

#Reading data

featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


## 1)Merging the training and the test sets to create one data set

#Naming columns in the features dataset
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#Merging data
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
InitialTidySet <- cbind(features,activity,subject)


## 2)Extracting only the measurements on the mean and standard deviation for each measurement

tidyset_mean_std <- select(tInitialTidySet, contains("mean"), contains("std"))


## 3)Using descriptive activity names to name the activities in the data set

ActivityNames <- merge(tidyset_mean_std, activityLabels, by='activityId', all.x=TRUE)


## 4)Labeling the data set with descriptive variable names

names(ActivityNames)

## 5)Creating a second, independent tidy data set with the average of each variable for each activity and each subject

TidyDataSet <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
	TidyDataSet <- TidyDataSet[order(TidyDataSet$subjectId,TidyDataSet$activityId),]

# Saving TidyDataSet txt file
		write.table(TidyDataSet, file= "TidyDataSet.txt", row.name=FALSE)















