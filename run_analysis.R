library(tidyr)
library(reshape2)

filename <- "project.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode="wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
} 
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

activity$V2 <- as.character(activity$V2)
features$V2 <- as.character(features$V2)

features1 <- grep(".*mean|.*std",features$V2)
features2 <- features[features1,2]
features3 <- gsub('[-()]', '', features2)

train <- read.table("UCI HAR Dataset/train/X_train.txt")[features1]
trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainlabel <- read.table("UCI HAR Dataset/train/y_train.txt")
Xtrain <- cbind(trainsub,trainlabel,train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features1]
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt")
testlabel <- read.table("UCI HAR Dataset/test/y_test.txt")
Xtest <- cbind(testsub,testlabel,test)

all <- rbind(Xtest,Xtrain)
colnames(all) <- c("subject","activity",features3)

all$activity <- factor(all$activity, levels=activity[,1], labels=activity[,2])
allcombined <- gather(all,variable,value,3:81)
allmean <- dcast(allcombined, subject + activity ~ variable, mean)

write.table(allmean, "R_project.txt", row.names = FALSE, quote = FALSE)
