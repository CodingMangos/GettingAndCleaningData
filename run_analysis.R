require(data.table)
library(data.table)

## Load features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Load training dataset
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Load test dataset
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Convert X_train/X_test from a data.frame into a data.table
train <- as.data.table(X_train)
test <- as.data.table(X_test)
activity_labels_dt <- as.data.table(activity_labels)

## Add subject_id to datasets
train[,subject_id:=subject_train]
test[,subject_id:=subject_test]

## Add activity_id to datasets
train[,activity_id:=y_train]
test[,activity_id:=y_test]

## Combine datasets by rows
data <- rbind(train, test)

## Merge activity_labels with datasets
colnames(activity_labels_dt) <- c("activity_id", "activity")
data <- merge(data, activity_labels_dt, by="activity_id")

## Remove "activity_id" column
data[, activity_id:=NULL]

## Apply the feature vector as column names to the datasets
names(data) <- c(as.vector(features$V2, mode="character"), "subject_id", "activity")

## Select relevant columns containing mean and std data
data <- data[, grep("std|[mM]ean|activity|subject_id", names(data)), with=FALSE]
data <- data[, -grep("[aA]ngle|[fF]req", names(data)), with=FALSE]
data_agg <- data[, -grep("activity|subject_id", names(data)), with=FALSE]
averages <- aggregate(data_agg, by=list(actvity=data$activity, subject_id=data$subject_id), FUN=mean, simplify=TRUE)

## Produce a tidy data set
write.table(averages, file="tidydata.txt")

## Write a CodeBook.md file describing the variables, data, and
##      transformations/work performed on cleaning up the data

## Write a README.md file explaining how the script works in GitHub Repo