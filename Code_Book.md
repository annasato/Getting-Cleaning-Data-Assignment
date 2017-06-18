# Getting and Cleaning Data Week 4 Assignment Code Book
=========================================================

## Variables 

Raw files were imported from a local folder called "data" into R with prefix "raw.", e.g. raw.activitylabels and raw.features. For the test data, the prefix was "raw.test" (raw.testsubject, raw.testdata, raw.testlabel) and for the training data, the prefix was "raw.train" (raw.trainsubject, raw.traindata, raw.trainlabel)

The data came in two randomly partioned sets - a training dataset (70% of total data) and a test dataset (30%). Dataframes suffixed "subject" include 1 column containing the subject number/ID; dataframes suffixed "data" contained 561 columns including all of the experiment metrics conducted by Jorge L. Reyes-Ortiz, et. al; dataframes suffixed "label" include 1 column containing the activity label/name (e.g. walking, standing, laying)

Some analyses were done (unique, dim) to get a sense of the data contents.

The test and train datasets were merged to form three separate dataframes suffixed "merge" (subjectmerge, labelmerge, datamerge), basically adding the test data below the train data, using rbind().

data.mean.sd is the main body of the total data (from datamerge) that does not include the subject or activity label, but has extracted just the column variables in that dataset that represent mean and standard deviation (using grep()).

data.labeled and its iterations are the merged data after column names/headers were added and activity labels were mapped.

In step 4, the header names were modified to remove the parentheses () from the names


## Summaries calculated

tidy2 is the dataframe that calculates the average of each of the data columns by subject and activity. i.e., the data has 35 rows for the 35 subjects-activity combinations, column 1 has the subject number, column 2 has the activity, and the rest of the columns are averages for the given metric (mean of means, mean of standard deviations)

tidy2 is exported in the last line of code as a .txt file into a folder called data


## Units

The following text comes from the README file associated with the original raw data:


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
