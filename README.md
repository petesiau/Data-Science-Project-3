# Data-Science-Project-3

        ## Program Name: run_analysis.R
        ## Author      : Siau Yen Phin
        ## Date Created: 24 July 2015
        ##
        ## Project     : Module 3 Project

        ## Set working directory ---
        ## --- Load required R packages: data.table, dplyr

        ## --- Capture the feature and activity labels
        ## --- Read in the given tables from the training set
        ## --- Read in the given tables from the test set
        ## --- Part 1. Merge the Training and Test data sets to create 1 data set
        ## --- Part 2. Extracts only the measurements on the mean and standard deviation for each measurement
        ## --- Part 3. Uses descriptive activity names to name the activities in the data set
        - Append additional columns for activity & subject
        - Create a new merged dataset with 2 addition columns appended
        - Change the activity column from numeric to character
        - Replace the Activity column with description

        ## --- Part 4. Appropriately labels the data set with descriptive variable names.
                - Use gsub() function replaces all matches of a string

        ## --- Part 5. From the data set in step 4, creates a second, independent tidy data set with
        the average of each variable for each activity and each subject.
                - Write the tidy data set
