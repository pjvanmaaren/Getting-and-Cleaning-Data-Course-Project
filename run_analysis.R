library(data.table)

datadir="UCI HAR Dataset"
if(!file.exists(datadir)){
	fileURL1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileURL1, destfile="./getdata-projectfiles-UCI HAR Dataset.zip",method="curl")
	unzip("./getdata-projectfiles-UCI HAR Dataset.zip")
}
stopifnot(file.exists(datadir))

setwd(datadir)

	   
tidyoutputfile = "tidy_data.csv"

# only process the data if the outputfile does not exit
if (!file.exists(tidyoutputfile)) {

   # 3. Uses descriptive activity names to name the activities in the data set
   # 4. Appropriately labels the data set with descriptive activity names. 
   # read labels
   tmp = read.table("activity_labels.txt")
   activity.labels = as.character(tmp$V2)
   tmp = read.table("features.txt")
   attribute.names = tmp$V2
   
   # read trainset
   x.train = read.table("train/X_train.txt")
   names(x.train) = attribute.names
   y.train = read.table("train/y_train.txt")
   names(y.train) = "activity"
   y.train$activity = as.factor(y.train$activity)
   levels(y.train$activity) = activity.labels

   subject.train = read.table("train/subject_train.txt")
   names(subject.train) = "subject"
   subject.train$subject = as.factor(subject.train$subject)
   train = cbind(x.train, subject.train, y.train)

   # read testset
   x.test = read.table("test/X_test.txt")
   names(x.test) = attribute.names
   y.test = read.table("test/y_test.txt")
   names(y.test) = "activity"
   y.test$activity = as.factor(y.test$activity)
   levels(y.test$activity) = activity.labels

   subject.test = read.table("test/subject_test.txt")
   names(subject.test) = "subject"
   subject.test$subject = as.factor(subject.test$subject)
   test = cbind(x.test, subject.test, y.test)

   # 1. Merges the training and the test sets to create one data set.
   alldata = rbind(test,train)

   # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   subset <- grep("std()", names(alldata),value=TRUE,fixed=TRUE)
   subset <- append(subset, grep("mean()",names(alldata),value=TRUE,fixed=TRUE))
   subset <- append(subset, "activity",0)
   subset <- append(subset, "subject",0)

   tidydata = alldata[,subset]

   # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
   library(reshape2)

   meltdata <- melt(tidydata, id = c('subject', 'activity'))
   result <- dcast(meltdata, subject + activity ~ variable, mean)

   write.table(result, tidyoutputfile, row.names=FALSE)

}


