fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Assignment/data.zip", method = "auto")
unzip("data.zip", exdir = ".")
setwd("./Coursera/Getting and Cleaning Data/Week 3/Assignment")

features <- read.table("./UCI HAR Dataset/features.txt")

mycols <- rep("NULL", 561)
mycols[grep("mean", features[,2])] <- "numeric"
mycols[grep("std", features[,2])] <- "numeric"

trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = mycols)
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = mycols)
trainAct <- read.table("./UCI HAR Dataset/train/y_train.txt")
testAct <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainSet <- cbind(trainSet, trainAct, trainSub)
testSet <- cbind(testSet, testAct, testSub)
dataSet <- rbind(trainSet, testSet)

colnames(dataSet) <- c(grep("mean", features[,2], value = T), grep("std", features[,2], value = T), "Activity", "Subject")

actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "ActivityDescriptive"))
merged <- merge(dataSet, actLabels, by = "Activity", all.x = T)

library(plyr)
meansAct <- ddply(merged[,-c(1,81)], .(Descriptive), colwise(mean))
meansSub <- ddply(merged[,-c(1,82)], .(Subject), colwise(mean))

write.table(meansAct, file = "meansAct.txt", row.name = F)
write.table(meansSub, file = "meansSub.txt", row.name = F)