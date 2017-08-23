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
names(features) <- c('feat_id', 'feat_name')
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
x <- x[, index_features] 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))
## 3. Uses descriptive activity names to name the activities in the data set:
## 4. Appropriately labels the data set with descriptive activity names:
activities <- read.table("C:/Users/krogers1/Documents/R/UCI HAR Dataset/activity_labels.txt")
names(activities) <- c('act_id', 'act_name')
y[, 1] = activities[y[, 1], 2]
names(y) <- "Activity"
names(s) <- "Subject"
tidyDataSet <- cbind(s, y, x)
# 5. Create a 2nd, independent tidy data set with the average of each variable for each activity and each subject:
p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)
names(tidyDataAVGSet) <- "Subject"
names(tidyDataAVGSet) <- "Activity"
write.table(tidyDataSet, tidyDataFile, row.name=FALSE)
write.table(tidyDataAVGSet, tidyDataFileAVGtxt, row.name=FALSE)
