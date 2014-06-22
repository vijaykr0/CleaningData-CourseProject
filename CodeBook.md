Download and unzip the project data file. And change the working directory to the root folder of the unzipped data.
Read the feature and activity data into featuresData and Activities table.
Read the test data into testSetData, test activity into testActivity, test subject into testSubjectInfo tables.
Read the training data into trainingSetData, training activity into trainingActivity, training subject into trainingSubjectInfo tables.
Get the columns indices containing the mean and standard deviation data and create the subset of test and training data only for those columns and store them in testDataSubset and trainingDataSubset.
Merge the three tables for test data and do the same for the training data and store them in testData and trainingData data frame.
Merge the test and training data into a mergedData data frame.
Order the merged data based on the subject id and store them in orderedData data frame.
Clean up the column headers. 
Write orderedData into a file. 
