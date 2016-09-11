## File:    run_analysis.R
## Date:    11-09-2016
## Author:  bartvdt
## Version: 1
##
## 
library(dplyr)
##
WorkingDirectory <- getwd()
WorkingDirectory <- paste(WorkingDirectory,"/data-cleaning",sep="")
setwd(WorkingDirectory)
## Read files
## Assumption data was downloaded in directory tree as described below
## Root directory is called data-cleaning
##
## data-cleaning
##   UCI HAR Dataset
##     test
##       Inertial Signals
##     train
##       Inertial Signals
##
## Reading Activity data
ActivityLabels <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/activity_labels.txt",sep=""))
colnames(ActivityLabels)[1]="Activity"
colnames(ActivityLabels)[2]="ActivityDescription"
##
## Reading Features data
Features <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/features.txt",sep=""))
colnames(Features)[1]="FeatureId"
colnames(Features)[2]="FeatureDescription"
##
## Reading test data
DataTestX <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/test/X_test.txt",sep=""))
DataTestY <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/test/Y_test.txt",sep=""))
DataTestSubject <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/test/subject_test.txt",sep=""))
DataTest <- cbind(DataTestSubject,DataTestY)
colnames(DataTest)[2]="Activity"
colnames(DataTest)[1]="Subject"
DataTest <- cbind(DataTestX,DataTest)
## DataTest[,"source"] <- "test"
##
## Reading training data
DataTrainX <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/train/X_train.txt",sep=""))
DataTrainY <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/train/Y_train.txt",sep=""))
DataTrainSubject <- read.table(paste(WorkingDirectory,"/UCI HAR Dataset/train/subject_train.txt",sep=""))
DataTrain <- cbind(DataTrainSubject,DataTrainY)
colnames(DataTrain)[2]="Activity"
colnames(DataTrain)[1]="Subject"
DataTrain <- cbind(DataTrainX,DataTrain)
##DataTrain[,"source"] <- "train"
##
## Combine all test and training data in one frame.
DataAll <- rbind(DataTrain,DataTest)
##
## Columns that contain relevant data: the measurements on the mean and standard deviation for each measurement
## Information from features_info.txt
##
## V1..V6 tBodyAcc-[mean()|std()]-XYZ
RelevantColumns <- c(1:6)
## V41..V46 tGravityAcc-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(41:46))
## V81..V86 tBodyAccJerk-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(81:86))
## V121..V126 tBodyGyro-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(121:126))
## V161..V166 tBodyGyroJerk-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(161:166))
## V201..V202 tBodyAccMag-[mean()|std()]
RelevantColumns <- c(RelevantColumns,c(201:202))
## V214..V215 tGravityAccMag-[mean()|std()]
RelevantColumns <- c(RelevantColumns,c(214:215))
## V227..V228 tBodyJerkMag-[mean()|std()]
RelevantColumns <- c(RelevantColumns,c(227:228))
## V240..V241 tBodyGyroMag-[mean()|std()]
RelevantColumns <- c(RelevantColumns,c(240:241))
## V253..V254 tBodyGyroJerkMag-[mean()|std()]
RelevantColumns <- c(RelevantColumns,c(253:254))
## V266..V271 fBodyAcc-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(266:271))
## V345..V350 fBodyAccJerk-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(345:350))
## V424..V429 fBodyGyro-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(424:429))
## V503..V504 fBodyAccMag-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(503:504))
## V515..V516 fBodyBodyAccJerkMag-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(515:516))
## V529..V530 fBodyBodyGyroMag-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(529:530))
## V542..V543 fBodyBodyGyroJerkMag-[mean()|std()]-XYZ
RelevantColumns <- c(RelevantColumns,c(542:543))
## Add columns for Subject and Y (activity)
RelevantColumns <- c(RelevantColumns,c(which( colnames(DataAll)=="Subject"),which( colnames(DataAll)=="Activity")))
##RelevantColumns <- c(RelevantColumns,"Subject","Activity")
##
## Add activity description by merging with ActivityLabels
## As conseqence Activity appears
DataAll <- merge(DataAll[,RelevantColumns],ActivityLabels,by="Activity")
## Columns Activity and ActivityDescription are 1:1, Activity (column 1) can be removed 
DataAll <- DataAll[,-1]
## 
## Change column names and replace by names in Features; 
## The last 2 elements of RelevantColumns (Subject and ActivityDescription) are no member of features
names(DataAll) <- Features$FeatureDescription[RelevantColumns[1:(length(RelevantColumns)-2)]]
colnames(DataAll)[length(RelevantColumns)-1] <- "Subject"
colnames(DataAll)[length(RelevantColumns)] <- "ActivityDescription"
##
## Calculate mean per column grouped by Subject and Activity(Description)
## Result is stored in new separate dataframe
DataAllMean <- DataAll %>% 
    group_by(Subject,ActivityDescription) %>%
    summarise_each(funs(mean(., na.rm=TRUE)))
##
## Result is stored in file DataAllMean.txt in working directory
write.table(DataAllMean,file="DataAllMean.txt",row.names = FALSE)
##