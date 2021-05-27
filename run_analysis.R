##download Data
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1, destfile="C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset.zip")
unzip(zipfile = "UCI-HAR-Dataset.zip", exdir = "C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset", unzip = "internal")

##need more address limit
memory.limit(4000)

##Features
feat <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\features.txt", col.names = c("n", "functions"))

##Activities
act <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\activity_labels.txt", col.names = c("code", "activity"))

##merge Training- and Testsets into new Dataset
xtrain <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\train\\X_train.txt", col.names = feat$functions)
ytrain <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\train\\y_train.txt", col.names = "code")
strain <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\train\\subject_train.txt", col.names = "subject")

xtest <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\test\\X_test.txt", col.names = feat$functions)
ytest <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\test\\y_test.txt", col.names = "code")
stest <- read.table("C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\test\\subject_test.txt", col.names = "subject")


install.packages("plyr")
library(plyr)
install.packages("dplyr")
library(dplyr)

X <- rbind(xtrain, xtest)
Y <- rbind(ytrain, ytest)
S <- rbind(strain, stest)
Merged_Data <- cbind(S, Y, X)


##extract measurments "mean, std"
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


##Labels the Dataset with descriptive Variable Names
TidyData$code <- act[TidyData$code, 2]

names(TidyData)[2] = "act"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

##create independent tidy Dataset with mean of each variable, activity and subject
FinalData <- TidyData %>%
  group_by(subject, act) %>%
  summarise_all(funs(mean))
write.table(FinalData, "C:\\1. Sven\\Uni\\R - Data Science\\Test\\getting-and-cleaning-Data-Course-Project\\UCI-HAR-Dataset\\UCI HAR Dataset\\FinalData.txt", row.name=FALSE)


##End of File