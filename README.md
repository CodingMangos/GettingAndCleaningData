===============================================================================
Getting And Cleaning Data (John's Hopkins Data Science Coursera Specialization)
===============================================================================

R script for Samsung's Human Activity Recognition Using Smartphones Dataset (V. 1.0)

===============================================================================

Purpose: 
1. Produce a tidy dataset from merged training and test data...
2. Containing the averages of the mean and standard deviations for each measurment...
3. Grouped by the 6 activities performed by each of the 30 particpants.

===============================================================================
Procedures:
===============================================================================

Loading datasets from the UCI HAR Dataset with read.table
- features.txt provides the names of the 561 variable, of which we will only use 66 
- activity_labels.txt provides the names and corresponding id's to the 6 activities
- X_train.txt and X_test.txt provides measurements of the 561 variables (The HAR directory split the dataset into training and test data)
- y_train.txt and y_test.txt provides the activity codes of for each of the 7352 observations 
- subject_train.txt  and subject_test.txt provides the subject id's for each of the 30 participants

Pre-processing:
1. Convert X_train, X_test, activity_labels into datatables for easier manipulation
2. Merge the activity codes (y_train, y_test) and subject_id's (subject_train, subject_test) to the measurements in their respective datatables by adding their values as new columns
3. Merge the training and test datasets, which is done using rbind
4. Merge the activity_labels with the dataset, pairing activity codes with one another and their respective activity labels.
5. Remove the unecessary activity_id column, that was used to merge the two data tables together
6. Apply the variable names listed in the features vector to their respective variables in the dataset
7. Use regular expressions to extract the variables for each measurements that contained either Mean ("[mM]ean")or standard deviation ("std"). 
8. Remove variables with the name "[aA]ngle" and "[fF]req" as they are not measurements but calculations based on other measurements.
9. Calculate the averages of these mean and standard deviation measurements using aggregate, grouped by activity and subject_id leaving 180 rows with 68 columns (including the two labels for the groups)
10. write the table to a file called "tidydata.txt"


===============================================================================

Notes:
- For each measurement (e.g. tBodyAcc) both the mean and standard deviation is included
- The average of each variable is given, and grouped by the 6 activities that the Samsung researchers recordered 30 participants doing while carrying their smartphone 