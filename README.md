## Run_Analysis

This repository contains one main script - `run_analysis.R` that can be run from within
any working directory.
The script's procedures are automated as much as possible, so no additional input from 
the user is required.

As script is automated, there is no need to download the data or prepare any specific
folders: analysis is run simply by running the script from anywhere.

The script downloads the zip file, unzips it and processes the downloaded data, following
the steps indicated in the assignment, to finally produce the tidy data dataset 
`tidy_data.txt` (a csv file), as required by the assignment.