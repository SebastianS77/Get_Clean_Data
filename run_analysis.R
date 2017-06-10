library(readr)
library(dplyr)

# 0. Load files
      
      # data subdirectory in working directory gets created if not existed
      if (!file.exists("data")) {dir.create("data")}

      # download URL setting and zip file download
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, destfile = "./data/data.zip", method = "curl")
      dateDownloaded <- date()
      
      # data file unzip and load into working directory
      unzip("./data/data.zip")
      
      ## Set directory for file reading
      directory <- "./UCI HAR Dataset/"
      directoryTest <- paste(directory,"test/", sep = "")
      directoryTrain <- paste(directory,"train/", sep = "")
      
      ## Read all files
      subject_test <- read.table(paste(directoryTest,"subject_test.txt", sep=""))
      X_test <- read.table(paste(directoryTest,"x_test.txt", sep=""))
      Y_test <- read.table(paste(directoryTest,"y_test.txt", sep=""))
      subject_train <- read.table(paste(directoryTrain,"subject_train.txt", sep=""))
      X_train <- read.table(paste(directoryTrain,"x_train.txt", sep=""))
      Y_train <- read.table(paste(directoryTrain,"y_train.txt", sep=""))
      activityLabels <- read.table(paste(directory, "activity_labels.txt", sep = ""))
      features <- read.table(paste(directory, "features.txt", sep = ""))

# 1.  Merges the training and the test sets to create one data set.
      
      # merge the x, y and subjects files
      
      allx <- rbind.data.frame(X_test, X_train)
      ally <- rbind.data.frame(y_test, y_train)   # activities [1-6]
      allsubjects <- rbind.data.frame(subject_test, subject_train)  # subjects [1-30]
      
      # load the features and activity labels
      
      features <- read.table("~/Privat/Karriere/coursera/Get&Clean Data/UCI HAR Dataset/features.txt", row.names = NULL)
      activity_labels <- read.table("~/Privat/Karriere/coursera/Get&Clean Data/UCI HAR Dataset/activity_labels.txt")
      
      # create one dataset with all data
      
      dataset <- cbind(allx, ally, allsubjects)

# 2.  Extracts only the measurements on the mean and standard deviation for each measurement.

      # give feature file names to dataset column names
      
      names(dataset) <- features[,2]
      
      # filter for mean and standard variation in datasetfile
      
      dataset <- allx[ , grepl("mean", names(dataset)) | grepl("std", names(dataset))]
      
      # bind also subjects and activities back to dataset
      
      dataset <- cbind(dataset, ally, allsubjects)

# 3.  Uses descriptive activity names to name the activities in the data set.

      # create a new column with the real activity name with activity_labels
      
      for (i in 1:length(dataset[,80])){
        dataset[i,82] <- activity_labels$V2[activity_labels$V1==dataset[i,80]]
      }
      
      # change column name to "activity"
      
      names(dataset) [82] <- "activity"

# 4.  Appropriately labels the data set with descriptive variable names.

      for (i in 1:(length(dataset[1,])-3)){
        names(dataset)[i] <- as.character(features$V2[features$V1 == gsub("^.","",names(dataset[i]))])
      }
      
      names(dataset)[81] <- "subject"
      
      # delete column with activity number
      
      dataset <- dataset[,-80]

# 5.  From the data set in step 4, creates a second, independent tidy data set with the
#     average of each variable for each activity and each subject.
      
      dataset[,"subject"] <- as.factor(dataset[,"subject"])
      
      tidydata <- dataset %>% group_by(subject, activity) %>% summarise_each(funs(mean))
      
      write.table(tidydata, file="tidydata.txt", sep=" ", row.names = FALSE)