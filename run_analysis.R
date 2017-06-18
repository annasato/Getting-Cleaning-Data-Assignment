# Getting and Cleaning Data Week 4 Assignment

# Install packages
library(plyr)

#Download zipped file, and unzip it
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest = './data/a1.zip')
data <- read.table(unz("./data/a1.zip", "./data/a1.csv"))
unlink(temp)

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### 1. Merge the training and the test sets to create one data set.

# Import Activity labels and features
raw.activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=F)
raw.features <- read.table("./data/UCI HAR Dataset/features.txt", header=F)

# Import Test data
raw.testsubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=F)
raw.testdata <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=F)
raw.testlabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=F)

# Import Train data
raw.trainsubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=F)
raw.traindata <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=F)
raw.trainlabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=F)

#Check dimensions of input data
dim(raw.activitylabels)
dim(raw.features)
dim(raw.testsubject)
dim(raw.testdata)
dim(raw.testlabel)
dim(raw.trainsubject)
dim(raw.traindata)
dim(raw.trainlabel)

#Take a look at data contents 
unique(raw.testsubject)
unique(raw.trainsubject) 
unique(raw.testlabel)
unique(raw.trainlabel) # there are 6 unique labels - matches raw.activitylabels
unique(raw.activitylabels)

# Merge data by type (subject, data, and label)
subjectmerge <- rbind(raw.trainsubject, raw.testsubject)
datamerge <- rbind(raw.traindata, raw.testdata)
labelmerge <- rbind(raw.trainlabel, raw.testlabel)

# Add headers to dataset from the features file
names(subjectmerge) <- "Subject"
names(labelmerge) <- "labelnum"
names(datamerge) <- raw.features[,2]

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### 2. Extract only the measurements on the mean and standard deviation for each measurement.
data.mean.sd <- datamerge[grep(".*mean.*|.*std.*", raw.features[,2], value=T)]
names(data.mean.sd)

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### 3. Use descriptive activity names to name the activities in the data set
data.labeled <- cbind(labelmerge, data.mean.sd)
data.labeled[1:5, 1:5]
# Add headers to activity label data
names(raw.activitylabels) <- c("labelnum", "Activity")
# Attach the Activity label to the big dataset
data.labeled1 <- merge(data.labeled, raw.activitylabels, by.x='labelnum', by.y='labelnum')

# 3.1 Attach subject data column
data.labeled2 <- cbind(subjectmerge, data.labeled1)

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### 4. Appropriately labels the data set with descriptive variable names.
# Headers in general were added previously, in step 1. 
# Cleaning up the names in this step by removing "()" within the variable names
datalabels <- names(data.labeled2)
datalabels1 <- gsub('\\(\\)', "", datalabels)
names(data.labeled2) <- datalabels1

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy2 <- ddply(data.labeled2, .(Subject, Activity), function(x) colMeans(x[, 3:81]))
nrow(tidy2)
View(tidy2)

write.table(tidy2, "./data/tidydata.txt", row.name=FALSE)

