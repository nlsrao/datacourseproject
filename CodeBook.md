---
title: "CodeBook"
output: html_document
---

##Introduction

This script *run_analysis.R* works on a dataset available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The dataset is about human activity recognition using smartphones.The script reads, merge the data and extract only the required fields from the total data. It also generate a tidy dataset with the average of each variable for each activity and each subject.

##Data Preparation

The script assumes the files are already downloaded at working directory including subdirectories  and available as follows

./test/X_test.txt
./test/Y_test.txt
./train/X_train.txt
./train/Y_train.txt
./features.txt
./test/subject_test.txt
./train/subject_train.txt
./activity_labels.txt

#### Reading Data

*read.table()* is used to read the files. 

#### Merging Data

The test and train data of same type are merged to get the total data of same type by using *rbind()*. The names of each column in X values (*X_train* + *X_test*) are given in features.txt. Hence those values are assigned as names of X values. 

#### Extraction of required Data

Requried features related to mean() and std() values are selected from total features by using grep command and stored in reqfeatures. By using these required features set (*reqfeatures*) the corresponding required values are selected from total values(*xtotal* = *xtrain*+*xtest*) and stored in required features values *xreq*. 

#### Descriptive activity names and Descriptive variable names

The activity codes given in merged *ytotal* (*Y_train* + *Y_test*) are replaced with corresponding description provided in *activity_labels.txt*. The *subject* and *activity* are assigned as names of total subject values (*subtotal* = *subject_train* + *suject_test*) and activity values (*ytotal*) respectively. As part of appropriately labels the data set with descriptive variable name, *t* is replaced with *time* if the name starts with *t*. Similarly *f* is replaced with *frequency*. *Acc*, *Gyro*, *Mag*, and *BodyBody* are replced with *Accelerometer*, *Gyroscope*, *Magnitude* and *Body* recpectively wherever it appears in the label. 

#### Final Merge

Finally, subject (*subtotal*), activity (*ytotal*) and the feature values (*xreq*) are merged by using *cbind()* to get the working dataset.

#### Tidy data set with the average of each variable for each activity and each subject

In order to create an independent tidy data set with the average of each variable for each activity and each subject of the required features mesurements of mean() and std(), *ddply* is used and stored in avgvals. The same is written into *average_values.txt*.


## Variable Names

* ***xtrain*** and ***xtest*** are used to store data of features values from files ***X_train.txt*** and ***X_test.txt*** respectively

* ***features*** variable contains the feature descriptions given in ***features.txt***

* ***ytrain*** and ***ytest*** are used to store activity values from files ***Y_train.txt*** and ***X_test.txt*** respectively

* ***activitylabels*** stores the activity description mentioned in ***activity_labels.txt***

* ***subtrain*** and ***subtest*** store the subject values given in ***subject_train.txt*** and ***subject_test.txt*** respectively

* ***xtotal*** containes the total feature values of ***xtrain*** and ***xtest***

* ***ytotal*** containes the total activity values of ***ytrain*** and ***ytest***

* ***subtotal*** stores the total subject values of ***subtrain*** and ***subtest***

* ***reqfeatures*** containes the features of the mean and standard deviation for each measurement

* ***xreq*** containes the feature values of the features in reqfeatures

* ***finaldata*** containes the data of the required features for all subjects and activities

* ***avgvals*** stores the tidy data set with the average of each variable for each activity and each subject of the required features

* ***average_values.txt*** containes the data of avgvals written into text file.


