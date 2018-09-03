# Getting-cleaningdata

The code does the following:

Download the dataset if it does not already exist in the working directory

Load the activity and feature info

Selects the columns in feature that contains only the mean and standard deviation information

Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation (step 2)

Merges the activity and feature columns with the datasets

Merges the two datasets (step 1)

Converts the activity into descriptive names rather than numbers (step 3)

Gathers the values of the features to create a tidy dataset (step 4)

Creates a tidy dataset that consists of the mean of each variable for each subject and activity pair (step 5)
