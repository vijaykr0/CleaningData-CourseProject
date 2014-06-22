###################################################################
## Download and unzip the project data file. And change          ##
## the working directory to the root folder of the unzipped data ##
###################################################################
setwd("~")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "projectData.zip")
unzip("projectData.zip")
setwd("~//UCI HAR Dataset")

########################
## Read features data ##
########################
library(data.table)

featuresData <- read.table("features.txt")
setnames(featuresData, "V1", "Index")
setnames(featuresData, "V2", "Features")

activities <- read.table("activity_labels.txt")
setnames(activities, "V1", "Id")
setnames(activities, "V2", "Activity")

#################################################
## Read test data set and update column titles ##
#################################################
testSetData <- read.table("test\\X_test.txt")
testActivity <- read.table("test\\y_test.txt")
testSubjectInfo <- read.table("test\\subject_test.txt")
names(testSetData) <- featuresData$Features
setnames(testActivity, "V1", "Activity")
setnames(testSubjectInfo, "V1", "SubjectId")

#####################################################
## Read training data set and update column titles ##
#####################################################
trainingSetData <- read.table("train\\X_train.txt")
trainingActivity <- read.table("train\\y_train.txt")
trainingSubjectInfo <- read.table("train\\subject_train.txt")
names(trainingSetData) <- featuresData$Features
setnames(trainingActivity, "V1", "Activity")
setnames(trainingSubjectInfo, "V1", "SubjectId")

#############################################################################
## Get the indices of rows containing the mean and standard deviation data ##
## and extract the measurements from the test and training sets for those  ##
## indices.
#############################################################################
mean_sd_index_list <- grep("mean\\(\\)|std\\(\\)", featuresData$Features)
mean_sd_columns <- colnames(testSetData)[mean_sd_index_list]
testDataSubset <- subset(testSetData, select=mean_sd_columns)
trainingDataSubset <- subset(trainingSetData, select=mean_sd_columns)

#####################################################################
## Merge the subject, activity and the activity data to create the ##
## the full test and training set data                             ##
#####################################################################
testData <- cbind(testSubjectInfo, testActivity, testDataSubset)
trainingData <- cbind(trainingSubjectInfo, trainingActivity, trainingDataSubset)

##########################################
## Merge the test and the training data ##
##########################################
mergedData <- rbind(testData, trainingData)

###################################################################################
## Update the activity column to use the activity names from the activities data ##
## and sort the data based on the subject id                                     ##
###################################################################################
activities$Id <- NULL ##Remove the index column from the activities table
mergedData$Activity <- activities[mergedData$Activity, ]
orderedData <- mergedData[order(mergedData$SubjectId),]

##############################
## Write the data to a file ##
##############################
write.csv(orderedData, file = "finalData.csv", row.names=FALSE)
