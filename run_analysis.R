library(dplyr)

## loads in all required data files
labels <- read.table("features.txt", colClasses = "character")
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
trainY <- read.table("train/y_train.txt")
testY <- read.table("test/y_test.txt")
train_subj <- read.table("train/subject_train.txt")
test_subj <- read.table("test/subject_test.txt")

## combines measurements with activity and suspect data
traindata <- cbind(trainY, train_subj, train)
testdata <- cbind(testY, test_subj, test)

## combines everything into one dataset and names the variables
merged_data <- rbind(data.frame(matrix(nrow = 0, ncol = 563)), traindata, testdata)
colnames(merged_data) <- c("activity", "testsubject", labels$V2)

## adds descriptive activity labels
activity_labels <- c("walking","walkingupstairs","walkingdownstairs","sitting","standing", "laying")
merged_data$activity <- factor(merged_data$activity, labels = activity_labels)

## extracts only the mean and standard deviation measurements
means <- grepl("-mean()", colnames(merged_data), fixed = TRUE)
stds <- grepl("-std()", colnames(merged_data), fixed = TRUE)
filtered_data <- cbind(merged_data[,1:2], merged_data[,means|stds])

## makes variable names more readable
colnames(filtered_data) <- gsub("Acc","Accelerometer",colnames(filtered_data))
colnames(filtered_data) <- gsub("Gyro","Gyroscope",colnames(filtered_data))
colnames(filtered_data) <- gsub("Mag","Magnitude",colnames(filtered_data))

## makes a dataset with averages for each activity and subject, and writes this to file
avg_data <- filtered_data %>% group_by(activity, testsubject) %>% summarise_each(funs(mean))
write.table(avg_data, file = "avg_data.txt", row.names = FALSE)
