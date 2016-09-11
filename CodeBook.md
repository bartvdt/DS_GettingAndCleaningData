File:   CodeBook.md
Author: bartvdt
Date:   11-09-2016

References:
activity_labels.txt
Features.txt

Subject:
CodeBook for Cousera Data Science course "Getting and Cleaning Data", Week 4, Course project

The UCI HAR Dataset contains test and train data of experiments with people wearing a Samsung galaxy S II smartphone
The people carried out 6 different activities (mentioned in activity_labesl.txt)

The software described in this code book collects data, removes redundant data 
and calculates the means of the various variables per subject per activity.

Not all variables provided are used, only the mean and standard deviation for each measurement.

The file features.txt contains a lot of measurement types but only those with info about mean and standard deviation are selected

Data frames:
- ActivityLabels: contains all activities, loaded from activity_lables;
- Features: contains all features (561), loaded from features.txt; only a subset is used:
  The features used are described in run_analysis.R while creating the list RelevantColumns.
  Basically these are al features with mean or std in the name
  
- DataTest: Contains all data from tests, loaded from X_test.txt, Y_test.txt and subject_test.txt
- DataTrain: Contains all data from training, loaded from X_test.txt, Y_test.txt and subject_test.txt
Both DataTrain and DataTest have same columns/structure

- DataAll: DataTest and DataTrain are combined in one data frame DataAll

After creating DataAll, the list RelevantColumns is created and this consists of the features
V1..V6 tBodyAcc-[mean()|std()]-XYZ
V41..V46 tGravityAcc-[mean()|std()]-XYZ
V81..V86 tBodyAccJerk-[mean()|std()]-XYZ
V121..V126 tBodyGyro-[mean()|std()]-XYZ
V161..V166 tBodyGyroJerk-[mean()|std()]-XYZ
V201..V202 tBodyAccMag-[mean()|std()]
V214..V215 tGravityAccMag-[mean()|std()]
V227..V228 tBodyJerkMag-[mean()|std()]
V240..V241 tBodyGyroMag-[mean()|std()]
V253..V254 tBodyGyroJerkMag-[mean()|std()]
V266..V271 fBodyAcc-[mean()|std()]-XYZ
V345..V350 fBodyAccJerk-[mean()|std()]-XYZ
V424..V429 fBodyGyro-[mean()|std()]-XYZ
V503..V504 fBodyAccMag-[mean()|std()]-XYZ
V515..V516 fBodyBodyAccJerkMag-[mean()|std()]-XYZ
V529..V530 fBodyBodyGyroMag-[mean()|std()]-XYZ
V542..V543 fBodyBodyGyroJerkMag-[mean()|std()]-XYZ
The numbers correspond with the column numbers
The values are normalized and real numbers between -1 and 1

The list above is used to filter the relevant columns, combined with subject and activity that are also in DataAll
DataAll is updated by filtering the redundant data (columns)

DataAll is enriched by replacing the activity number by the activity description

The technical columns headers V1 .. V 543 are replaced by the descriptions given by features.txt

- DataAllMean contains the mean value of each column in DataAll, grouped by Subject and ActivityDescription
The contents of DataAllMean is written to file: DataAllMean.txt