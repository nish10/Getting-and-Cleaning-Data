# CODE BOOK

This book describes the variables, the data, and any transformations or work that I performed to clean up the data.

1. Merges the training and the test sets to create one data set
  - `X_merge_data`
  - `y_merge_data`
  - `subject_merge_data`
2. Extracts only the measurements on the mean and standard deviation for each measurement
  - `extract`
3. Uses descriptive activity names to name the activities in the data set.
  - `y_merge_name_data`
4. Appropriately labels the data set with descriptive variable names.
  - `names(y_merge_name_data)[1]<- "activities"` **activities** : The type of activity performed when the corresponding measurements were taken.
  - `names(subject_merge_data)[1]<- "subject"` **subject** : The ID of the subject.
  - `names(extract)<- sliced[[2]]`
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - `tidy_data<- ddply(merged_data, .(subject, activities), function(x){colMeans(x\[,3:length(names(merged_data))\])})` : to create tidy data with w.r.t to activity and subject
  - `write.table(tidy_data, "tidy_averages_data.txt", row.name=FALSE)` : writing data
  
`run_analysis.R` : is the anaylsis R script created by me.
`tidy_averages_data.txt` : is the tidy data output created after running **run_analysis.R** script.








