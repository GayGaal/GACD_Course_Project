## Step 1 - setting up filenames and downloading data ############################################

## setting the directory for the project
zipDir <- "./UCI"
if (!file.exists(zipDir)) {dir.create(zipDir)}
## setting the download URL
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## setting the file name (path) for the zip file
filename <- paste(zipDir, "uci_data.zip", sep="/")

## downloading the file
#download.file(fileUrl, filename)

## unzipping the file
#unzip(filename, exdir=zipDir)

## setting the new directories
dataDir <- paste(zipDir, "UCI HAR Dataset", sep="/")
testDir <- paste(dataDir, "Test", sep="/")
trainDir <- paste(dataDir, "Train", sep="/")

## setting filenames
stestFile <- paste(testDir, "subject_test.txt", sep="/")
strainFile <- paste(trainDir, "subject_train.txt", sep="/")
xtestFile <- paste(testDir, "X_test.txt", sep="/")
ytestFile <- paste(testDir, "y_test.txt", sep="/")
xtrainFile <- paste(trainDir, "X_train.txt", sep="/")
ytrainFile <- paste(trainDir, "y_train.txt", sep="/")
actFile <- paste(dataDir, "activity_labels.txt", sep="/")
featFile <- paste(dataDir, "features.txt", sep="/")

## Step 2 - Reading the data #####################################################################

## reading the data from files into R
subject_test <- read.table(stestFile, header=FALSE)
x_test <- read.table(xtestFile, header=FALSE)
y_test <- read.table(ytestFile, header=FALSE)
subject_train <- read.table(strainFile, header=FALSE)
x_train <- read.table(xtrainFile, header=FALSE)
y_train <- read.table(ytrainFile, header=FALSE)
activity <- read.table(actFile, header=FALSE)
features <- read.table(featFile, header=FALSE)

## Step 3 - Merging train and test data together #################################################

## merging testing and training data together
subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

## Step 4 - Preparing the single dataset as required: naming the data, filtering, merging ########

## giving names to columns
colnames(subject) <- "subject"
colnames(y) <- "activity"
colnames(activity) <- c("id", "activity")

## factoring needed data for easier calculations 
subject[,1] <- as.factor(subject[,1])
y[,1] <- as.factor(y[,1])

## giving lables to activities and features
y[,1] <- factor(y[,1], labels=activity[,2])
colnames(x) <- features[,2]

## selecting means & stds of measurements
meanFilter <- grep("[Mm][Ee][Aa][Nn]\\(", names(x)) ## selecting ONLY real means, not gravity, etc
stdFilter <- grep("[Ss][Tt][Dd]", names(x))
Filter <- append(meanFilter, stdFilter)
Filter <- sort(Filter)

## filtering measurements
x <- x[,Filter]

## creating the tidy data dataset
data <- cbind(subject, y)
data <- cbind(data, x)

## Step 5 - Renaming measurements with readible English names ####################################

## making & applying desriptive names
descrNames <- colnames(data)
descrNames <- tolower(descrNames)
descrNames <- gsub("-", ".", descrNames[])
descrNames <- gsub("\\(\\)", "", descrNames[])
descrNames <- gsub("std", "sd", descrNames[])
descrNames <- gsub("^t", "time.", descrNames[])
descrNames <- gsub("^f", "frequency.", descrNames[])
descrNames <- gsub("jerk", ".jerk", descrNames[])
descrNames <- gsub("acc", ".acceleration", descrNames[])
descrNames <- gsub("gyro", ".gyroscope", descrNames[])
descrNames <- gsub("mag", ".magnitude", descrNames[])
colnames(data) <- descrNames

## Step 6 - Creating required tidy data dataset with only means per activity & subject ###########

## calculating averages per activity per subject and creating a dataset
means <- aggregate(data[,3:68], by=list(Activity=data[,2],Subject=data[,1]), FUN="mean")

## Step 7 - Writing tidy data to disk ############################################################

## outputting the first and the second datasets
write.csv(means, file="tidy_data.txt")