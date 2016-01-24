# CodeBook

## Variables

The variables include various acceleration and velocity measurements taken from the accelerometer and gyroscope of a Samsung Galaxy S smartphone. 
In addition, variables indicating the test subject and the activity performed during the measurement are present.
A more thorough description of the variables can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data

The data contains 7352 training observations and 2947 test observations.
In total, there are 10299 observations for each variable.

## Transformations

The variable names are taken from features.txt.
The activity labels are taken from activity_labels.txt.
The levels for the activity variable are taken from y\_train.txt and y_test.txt.
The levels for the test subject variable are taken from subject\_train.txt and subject_test.txt.
The observations are taken from X\_train.txt and X_test.txt.

All of the above is first combined into train and test datasets, then merged into one (merged_data).
Then, only the columns containing mean and std measurements are extracted (filtered_data).
The column names are made more readable, e.g. Mag -> Magnitude.
Finally, this is grouped by activity and test subject, and means of all observations for each group are calculated.
The output is then written to avg_data.txt.

