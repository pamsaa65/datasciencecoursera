################################################################################
## run_analysis.R
## 
#library(...)
## Description of experiment (original data set)
## - Group of 30 persons wearing a smartphone.
## - Each person performed 6 activities: 
##   (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
## - Captured 3-axial linear acceleration and 3-axial angular velocity.
## - Each record provided:
##   - Triaxial acceleration from the accelerometer (total acceleration) 
##     and the estimated body acceleration.
##   - Triaxial Angular velocity from the gyroscope. 
################################################################################
## 0. Load data from files
# files must be in working directory +"/data/UCI HAR Dataset"
# you can change that but... be careful!
path<-"./data/UCI HAR Dataset"

# load test files 
test.data <- read.table(paste(path,"test/X_test.txt",sep="/")
                        ,colClasses="numeric")
                        #note: vars are loaded as V1, V2, V3...
test.activity <- read.table(paste(path,"test/Y_test.txt",sep="/")
                        ,col.names="activity.id") #avoid duplicated V1
test.subject <- read.table(paste(path,"test/subject_test.txt",sep="/")
                        ,col.names="subject.id") #avoid duplicated V1


# load train files
train.data <- read.table(paste(path,"train/X_train.txt",sep="/")
                        ,colClasses = "numeric")
                        #note: vars are loaded as V1, V2, V3...
train.activity <- read.table(paste(path,"train/Y_train.txt",sep="/")
                        ,col.names="activity.id")
train.subject <- read.table(paste(path,"train/subject_train.txt",sep="/")
                        ,col.names="subject.id")

#load features file <=> variables names
features <-read.table(paste(path,"features.txt",sep="/"),
                      ,colClasses=c("numeric","character")
                      ,col.names=c("var.id", "var.name"))

#load activity labels file
activities <-read.table(paste(path,"activity_labels.txt",sep="/")
                        ,col.names=c("activity.id", "activity.name"))


################################################################################
## 1. Merge train+test datasets (by rows)

# There are many options to combine the data set:
#  firt all test.* and after all train.* 
#  or firs all *.data, after *.activity and *.subject
# Finally we will combine all of them in one data set,
# but the order of combinations could determine later instructions...


# we begin with numeric data and keep apart the labels
dataset <- rbind(train.data, test.data)
#N<-nrow(dataset) 

activityset <- rbind(train.activity, test.activity)
#ifelse(nrow(activityset)!=N, "ERROR", "OK" )

subjectset <- rbind(train.subject, test.subject)
#ifelse(nrow(subjectset)!=N, "ERROR", "OK" )

#delete partial sets for release memory 
rm(train.data); rm(test.data) 
rm(train.activity); rm(test.activity) 
rm(train.subject); rm(test.subject) 

################################################################################
## 2. Extract the measurementes of mean and standard deviation

# read the names (and ids) of vars from features 
# transform features to data.table for using %like%
library(data.table); DT<-data.table(features)
# select vars that contains mean() or str()
varSelected <- rbind(DT[var.name %like% "mean\\(\\)"], #escape () with \\(\\) 
                   DT[var.name %like% "std\\(\\)"])
# other option: aux functions of dplyr::select => contains,matches...

### reorder by id!! (to match the columns in dataset) ###
varSelected <- varSelected[order(varSelected$var.id),] 
rm(DT); detach(package:data.table)

# subset using var.id 1, 2 ... <=> number of column V1, V2...
datasubset <- dataset[, varSelected$var.id]
rm(dataset)

################################################################################
## 3. Uses descriptive activity names

# add activity labels to dataset
datasubset<-cbind(activityset,datasubset) # OR data.frame(activityset, datasubset)
rm(activityset)

# join dataset and activities
mergedData <- merge(activities, datasubset,by="activity.id")
rm(datasubset)

maxcol <- ncol(mergedData)
# delete activity.id (subset without column 1)
mergedData <- mergedData[,2:maxcol]


################################################################################
## 4. Label dataset with descriptive variable names

newnames <- as.character(varSelected$var.name)
maxcol <- ncol(mergedData)
# partial renaming (ignore first column)
names(mergedData)[2:maxcol] <- newnames

################################################################################
## 5. Create a tidy dataset with average of each var by activity and subject
## Each row represents an observation: one subject and one activity.
## Each columns represents a variable. See details in codebook.

# add subject to dataset
mergedData <- cbind(subjectset,mergedData)
rm(subjectset)


# aggregate by subject and activity
newDataset <- aggregate(mergedData[3:maxcol],
                        by=list(mergedData$subject.id, mergedData$activity.name),
                        FUN="mean")
names(newDataset)[1:2]<- c("subject","activity") # rename group cols

# write the data set in a text file
write.table(newDataset, file="results_analysis.txt"
            #,col.names=FALSE 
            ,row.names=FALSE)

#write the names of vars in a text file
write.table(varSelected$var.name, file="vars_analysis.txt"
            ,col.names=FALSE 
            ,row.names=FALSE)

## 