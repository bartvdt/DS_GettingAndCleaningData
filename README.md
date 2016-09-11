File:   README.md
Author: bartvdt
Date:   11-09-2016

Subject:
Scripts for Cousera Data Science course "Getting and Cleaning Data", Week 4, Course project

Files:
- README.md (this file)
- Codebook.md (file)
- DataAllMean.txt - result of running script run_analysis.R
- run_analysis.R: script for collecting data and creating output file - see below for further explanation

Running script run_analysis.R

This script performs the follwowing actions

DIRECTORIES
Obtains the working directory and creates a subdirectory data-cleaning
Then the scripts works in this data-cleaning directory and assumes the following directory structure:

../data-cleaning 

../data-cleaning/UCI CHAR Dataset
  this directoy contains information about features(.txt) and activity_lables(.txt)

../data-cleaning/UCI CHAR Dataset/test
  this directory contains the test data
  
../data-cleaning/UCI CHAR Dataset/train
  this directory contains the training data
  
LOADING DATA
The following data is loaded
- Activity labels
- Features
- Test data
- Train data

PROCESSING
Test and train data are combined in one dataframe: DataAll
Based on the information in features.txt, only columns numbers with mean or standard deviation are selected
These column numbers are stored in a list RelevantColumns and this list is used to filter in DataAll the columns with mean 
or standard deviation only
Additional the ActivityDescription is added to the DataAll, the ActivityNumber is removed
The column names are replaced by the description in the file features.txt

The next step is to calculate the mean values for each column (variable) per subject per activity(description)
Technical spoken a group by subject,activitydescription.
This result is stored in dataframe DataAllMean. 

OUTPUT
The contents of DataAllMean is stored in a file DataAllMean.txt
