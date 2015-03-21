# Script description

This script generates two datasets: 
a) first contains all the training and test observations (rows) for all the features (columns) selected to the initial database, but only for mean values and standard deviations, 
b) the tables with averages of each variable for each activity and subject. 

The script first downloads initial database, then unzips the downloaded zip file. The working directory is set in the way, that all the needed files are available. 

Then the table with all variable names is read. The idea was not to read the whole initial dataset (it was very time-consuming), but to load just the columns, that were needed for the anlysis (with mean and standard deviation variables). The way to do that was using colClass argument of read.table function. When class of the column is set to "NULL", the column is skipped and not loaded. 

So the script is generating the vector of 561 (no of variables in dataset) "NULLs". Then generates indices of columns with "mean" or "std" in its name and changes this values from "NULL" to "numeric". This vector is used in colClasses argument when building trainSet and testSet tables. This trick helps to skip almost 500 unnecessary columns. 

Then also tables with subjects and activities data are read to the test/trainAct and test/trainSub tables. Then the trainSet and tesSet tables are build - these are binded tables with base data, activities and aubjects. Then test and training data are binded in one dataSet table. 

The names of dataSet columns are assigned. 

Next operation is changing activity names from abbreviated (1 to 6), to full descriptive names (like WALKING). The first thing is loading the actLabels table with assignment of descriptive names to the numbers. Then the dataSet and actLabels are merged, so that only dataSet rows are listed (all.x) and activity numeric labels are exchanged to descriptive.

After that the plyr library is launched. ddply tool turned out to be very useful for this analysis. The tables with means of all the variables by activities and subjects are generted and exported to txt files. This files contain the final output of the assignment - requested datasets. 

# Code book describing the variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

In this dataset the variables of mean and standard deviation are provided. 

Moreover there are two additional columns. 
- "Descriptive" contains the descriptive names of one of six activities for given observation (like walking). 
- "Subject" column provides identifiers of the subjects who carried out the experiment (ranges from 1 to 30). 
