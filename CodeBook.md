# Code book for a subset of the UCI HAR Dataset

## Original dataset
Data source: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

Description: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Code book
The tidy csv-file "tidy_data.csv" contains 181 rows and 68 columns:

* ```subject``` the id of the subject, as specified in the files subject_test.txt and subject_train.txt in the original dataset
* ```activity``` indicates the activity of the subject as specified in activity_labels.txt in the original dataset
  * There are six activity levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* the remaining columns are means and standard deviations as described in the README.txt file included in the zip file containing the original dataset.
