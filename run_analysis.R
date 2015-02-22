## Reading all the data from files
## Assuming the files are already downloaded using download.file() to the working directory 
## and existing at corresponding sub-directories 

xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/Y_test.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/Y_train.txt")
features <- read.table("./features.txt")
subtest <- read.table("./test/subject_test.txt")
subtrain <- read.table("./train/subject_train.txt")
activitylabels <- read.table("./activity_labels.txt")

## Merges the training and the test sets to create one data set.

xtotal <- rbind(xtrain,xtest)
ytotal <- rbind(ytrain,ytest)
subtotal <- rbind(subtrain,subtest)

## Assigning features as names of xtotal

names(xtotal) <- features[,2]

## Extracts only the features of the mean and standard deviation for each measurement

reqfeatures <- features$V2[grep("mean\\(\\)|std\\(\\)",features[,2])]

## Extracting the vlaues of the corresponding required features of mean and standard devation

xreq <- subset(xtotal,select=as.character(reqfeatures))

## Uses descriptive activity names to name the activities in the data set

ytotal$V1 <- activitylabels[ytotal$V1,2]

## assigning names activity and subject to ytotal and subtotal respectively

names(ytotal) <- "activity"
names(subtotal) <- "subject"

## Appropriately labels the data set with descriptive variable names

names(xreq) <- gsub("^t", "time", names(xreq))
names(xreq)<-gsub("^f", "frequency", names(xreq))
names(xreq)<-gsub("Acc", "Accelerometer", names(xreq))
names(xreq)<-gsub("Gyro", "Gyroscope", names(xreq))
names(xreq)<-gsub("Mag", "Magnitude", names(xreq))
names(xreq)<-gsub("BodyBody", "Body", names(xreq))

## binding all the required values in a single dataframe 

finaldata <- cbind(subtotal,ytotal,xreq)

## creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject

library(plyr)
avgvals <- ddply(finaldata, c("subject", "activity"), numcolwise(mean))
write.table(avgvals,file="average_values.txt", row.name=FALSE)


