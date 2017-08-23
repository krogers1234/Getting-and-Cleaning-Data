# CodeBook.md

Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The original files are available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: ======- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

## 1. Merges the training and the test sets to create one data set:
x_train <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_test <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x <- rbind(x_train, X_test)
y <- rbind(y_train, y_test)
s <- rbind(subject_train, subject_test)
## 2. Extracts the measurements on the mean and standard deviation for each measurement:
features <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/features.txt")
names(features) <- c('feat_id', 'feat_name')index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
x <- x[, index_features] 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))
## 3. Uses descriptive activity names to name the activities in the data set:
## 4. Appropriately labels the data set with descriptive activity names:
activities <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/activity_labels.txt")names(activities) <- c('act_id', 'act_name')y[, 1] = activities[y[, 1], 2]names(y) <- "Activity"names(s) <- "Subject"tidyDataSet <- cbind(s, y, x)
# 5. Create a 2nd, independent tidy data set with the average of each variable for each activity and each subject:
p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)names(tidyDataAVGSet)[1] <- "Subject"names(tidyDataAVGSet)[2] <- "Activity"# Created csv (tidy data set) in directorywrite.table(tidyDataSet, tidyDataFile, row.name=FALSE)write.table(tidyDataAVGSet, tidyDataFileAVGtxt, row.name=FALSE)



