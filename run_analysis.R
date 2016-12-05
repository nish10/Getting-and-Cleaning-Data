library(plyr)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.
##################################################################
X_train_data<- read.table("./train/X_train.txt")
y_train_data<- read.table("./train/y_train.txt")
subject_train_data<- read.table("./train/subject_train.txt")


X_test_data<- read.table("./test/X_test.txt")
y_test_data<- read.table("./test/y_test.txt")
subject_test_data<- read.table("./test/subject_test.txt")


X_merge_data<- rbind(X_train_data, X_test_data)

y_merge_data<- rbind(y_train_data, y_test_data)

subject_merge_data<- rbind(subject_train_data, subject_test_data)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###########################################################################################

#reading feature.txt file
feature_data<- read.table("./features.txt")

# slice(dplyr function) only those rows of features that has mean or standard deviation in its variable name
sliced<- slice(feature_data, grep("mean\\(\\)|std\\(\\)", feature_data[[2]]))

#for pasting "V" as a prefix to all the elements of V1 variable in sliced to look alike 
# as the names of variable in merge_data.
# Before doing that we have to convert the sliced[[1]] vector into list

aslist<- as.list(sliced[[1]])
var<- sapply(aslist, function(x){paste("V",x,sep="")})

extract<- X_merge_data[,var]

# 3.Uses descriptive activity names to name the activities in the data set
##########################################################################

activities<- read.table("./activity_labels.txt")

#form a dataframe by joining y_merge_data and activities by= "V1"

join<- inner_join(y_merge_data,activities, by ="V1")

y_merge_name_data<- join[2]


# 4.Appropriately labels the data set with descriptive variable names.
######################################################################

names(y_merge_name_data)[1]<- "activities"
names(subject_merge_data)[1]<- "subject"
names(extract)<- sliced[[2]]

# 4. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
############################################################################

merged_data<- cbind(y_merge_name_data,subject_merge_data,extract)

tidy_data<- ddply(merged_data, .(subject, activities), function(x){colMeans(x[,3:length(names(merged_data))])})

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject 
##############################################################################
write.table(tidy_data, "tidy_averages_data.txt", row.name=FALSE)

################################################################################
