
# Read in the data
features     = read.table('./features.txt',header=FALSE); #imports features.txt
activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTest        = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest        = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
subjectTest  = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt

# Assign column names 
colnames(activityType)  = c('activityId','activityType')
colnames(yTrain)        = "activityId"
colnames(xTrain)        = features[,2] 
colnames(subjectTrain)  = "subjectId"
colnames(yTest)       = "activityId"
colnames(xTest)       = features[,2]
colnames(subjectTest) = "subjectId"

# Merges the training and the test sets to create one data set
trainingData = cbind(yTrain,subjectTrain,xTrain)
testData = cbind(yTest,subjectTest,xTest)

# Combine training and test
Data = rbind(trainingData,testData)

# Extracts only the measurements on the mean and standard deviation for each measurement.
colNames = colnames(Data) 

Vector = (grepl("activity..",colNames) | grepl("subject..",colNames)
                 | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) &
                         !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                         !grepl("-std()..-",colNames))

# Subset Data table based on the logicalVector to keep only desired columns
Data = Data[Vector==TRUE]

# Merge the Data set with the actitivityType table to include descriptive activity names
Data = merge(Data,activityType,by='activityId',all.x=TRUE)

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData) 

# Assigning the descriptive column names to the Data set
colnames(Data) = colNames

# Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 

# Create a new table without the activityType column
ActivityType  = Data[,names(Data) != 'activityType']

# Summarizing table for the mean of each variable for activity and subject
tdata = aggregate(ActivityType[,names(ActivityType) 
                != c('activityId','subjectId')],
                by=list(activityId=ActivityType$activityId,subjectId = 
                ActivityType$subjectId),mean)

# Merging the data with activityType 
tdata = merge(tdata,activityType,by='activityId',all.x=TRUE)

# Export the Data set 
write.table(tdata, './tdsavg.txt',sep='\t',row.names=FALSE)


