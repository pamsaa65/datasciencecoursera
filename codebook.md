# RECORD DESCRIPTION

Each record provided:

- subject.id (int)
  Description: id of the volunteer.
  Values: 1 a 30.
 
- activity.name (factor)
  Description: name of the activity.
  Values: 1 a 6 (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

- variables: averages of 66 selected measurements. Values are normalized.
  The complete list of variables of each feature vector is available in 'vars_analysis.txt'

Feature General Description
===========================
The features come from the accelerometer and gyroscope 3-axial signals (tAcc-XYZ, tGyro-XYZ)
The acceleration signal was separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). 
The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
Also the magnitude of these three-dimensional signals were calculated (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a transform was applied to some signals to produce frequency features fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
Note the prefix 't' denote time and 'f' frequency.

The variables estimated from these signals are: 
mean(): Mean value 
std(): Standard deviation


