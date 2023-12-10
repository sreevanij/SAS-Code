/*Use the "SONGS.CSV" dataset to answer the following questions:


a.  Build a logistic regression model to predict Top10 using the training data. 
b. Songs with heavier instrumentation tend to be louder (have higher values in the variable "loudness"). By inspecting the coefficient of the variable "loudness", what does our model suggest?
c. What is the accuracy of our model on the test set?
d.What is the value of the Coefficient of Correlation?  Comment on the value.
*/


FILENAME REFFILE '/home/u63416648/assignment 2 ban100/songs.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.SONGS;
	GETNAMES=YES;
RUN;

PROC PRINT DATA=SONGS;
RUN;


/* Build the logistic regression model */


PROC LOGISTIC DATA=WORK.;
   CLASS Top10; /* Assuming Top10 is a binary categorical variable */
   MODEL Top10 = loudness other_predictors; /* Replace other_predictors with your actual predictor variables */
RUN;
