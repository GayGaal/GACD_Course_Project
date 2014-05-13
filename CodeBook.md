## Run Analysis CodeBook

### Content
1. Data
2. Variables
3. Coding process

### Data
The script uses the data, [downloaded](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from the Machine Learning Repository.  
The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  
A full description is available at the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained.  
The dataset consists of few files, divided into three categories:  

1. Common files:  
  *`activity_labels.txt` - a table containing names for coded activities in the main dataset  
  *`features.txt` - a table containing names for variables in the main dataset  
  *`features_info.txt` - a text file containing information about the variables of the main dataset  
  *`README.txt` - a read me file with general info on the downloaded data    
2. Test files  
3. Train files  

Both 2 and 3 contain:  

*`subject` - identification for respective datasets  
*`X` - respective measurements dataset  
*`y` - identification for the activities carried out for respective measurements  

### Variables
The initial downloaded dataset contains **561** different variables, among them the ones this  
analysis is aimed at:  

*`mean` - containing the data on the mean measurement of a variable  
*`std` - (abbriviated to `sd` in the final dataset) containing the data on the   
standard deviation of a variable  

For the purposes of this analysis, variables `meanFreq` and `gravityMean` were not  
considered, as their measurements are not the ones required by the assignment.  

This leaves the dataset with only **66** variables, that will be used further in the analysis.  

### Coding Process

For the purposes of easier code understanding, the script `run_analysis.R`  
contains all the comments on the processes of the analyis.  

The script is devided into 7 main steps:  

**1. Step 1 - downloading the data and preparing filepaths**  
During this step, a folder for the downloaded data is created, a zip file is downloaded,  
unzipped, and the filepaths for the needed files in the dataset are stored.  

**2. Step 2 - reading the data**    
During this step the data from different (`test` and `train`) datasets is read into R,   
as well as the names of *activities* and *variables*.   

**3. Step 3 - merging train and test data together**  
As the assignment requires, the data from `train` and `test` datasets is merged into   
single datasets for respective data.  

**4. Step 4 - filtering data and creating a single dataset**  
During this step the data is prepared to be merged into a single dataset and then the   
data is merged. The preparation include giving appropriate names to columns in respective   
datasets, factoring `subject` and `activity` data for simplifying future analysis,  
filtering the data to contain only mean and standard deviation for variables, and finally   
creating a single dataset (`data`), containing all the data, required by the assignment.  

**5. Step 5 - renaming variables with legible names**  
During this step variables in the dataset are given legible names, without any unneeded  
abbreviations (the only needed one being `sd` for standard deviation).  

**6. Step 6 - creating fianl tidy data dataset**  
During this step the function `aggregate` is used, as the script was written in a way  
that does not require any external packages to be installed.  
The data is transformed in a following way: for each variable present in the dataset,   
mean and standard deviation are calculated, based on different activities for different  
subjects.   
In this way, the data is skimmed from more than 10000 observations per variable to only  
6 (activities) * 30 (subjects) = 180 oservations of 66 variables.
This data is then stored in a R object `mean`.  

**7. Step 7 - writing the tidy data to disk**  
During this step the content of the object `mean` is written to the file named  
`tidy_data.txt`.  

In this way the assignment is complete and R session might be terminated.

