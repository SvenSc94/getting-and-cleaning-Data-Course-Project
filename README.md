# getting-and-cleaning-Data-Course-Project
Coursera Course Project Week 4 - getting and cleaning Data

The Code starts Downloading and unzip the raw Data-Files. 
Then, it reads all important tables while also creates col-Names

to merge the Datasets, the Packages plyr and dplyr were used. 
In the first Step, the following Datasets were merged: xtrain + xtest, ytrain + ytest, strain + stest
After that, all merged Datasets were merged with cbind into one big Dataset named Merged_Data

Next, the Measurments for "mean" and "std" were extradet in Tidy Data.
Then, the Dataset was labeled by using descriptive variable Names with the Information from the features.txt and features_info.txt

In the last Step, an independent tidy Dataset was created with the Mean of each variable, each activity and each subject.
