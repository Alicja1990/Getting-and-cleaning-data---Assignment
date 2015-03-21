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




