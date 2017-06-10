# Get_Clean_Data

Getting and Cleaning Data Course Projectless 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The Analysis consists of 6 steps which are

# 0. Load files
      
      # data subdirectory in working directory gets created if not existed

      # download URL setting and zip file download
      
      # data file unzip and load into working directory
      
      ## Set directory for file reading (UCI HAR Dataset/test and UCI HAR Dataset/train)
      
      ## Read all files
      

# 1.  Merges the training and the test sets to create one data set.
      
      # merge the x (values), y (activities 1-6) and subjects (1-30) files
      
      # load the features and activity labels
      
      # create one dataset with all data
      

# 2.  Extracts only the measurements on the mean and standard deviation for each measurement.

      # give feature file names to dataset column names
      
      # filter for mean and standard variation in datasetfile
      
      # bind also subjects and activities back to dataset
      

# 3.  Uses descriptive activity names to name the activities in the data set.

      # create a new column with the real activity name with activity_labels
      
      # change column name to "activity"
      

# 4.  Appropriately labels the data set with descriptive variable names.
      
      # activities are changed from number to activity full name
      
      # column name change for subject column
      
      # delete column with activity number


# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      
      # 30 subjects x 6 activities = 180 rows
      
      # 79 columns with mean and standard deviation values
      
      # 1 column "activities" and 1 column "subject"
      
      # write tidydata textfile
