/*1.Fran's Convenience Marts are located throughout a metropolitan area. Fran, the owner, would like to expand into other communities. As part of her presentation to the local bank, she would like to better understand the factors that make a particular outlet profitable. She must do all the work herself, so she will not be able to study all her outlets. She selects a random sample of 15 marts and records the average daily sales (y), the floor space (area), the number of parking spaces, 
and the median income of families in each region. The sample information is provided in the table on the left:

a. Generate the regression output and the residual output
b. Determine the regression equation
c. Provide detailed explanation of the coefficients of the independent variables
d.What is the value of the Coefficient of Correlation?  Comment on the value.
e. What is the value of the Coefficient of Determination? Comment on the value.*/



/* Sample Data */
data convenience_marts;
input Outlet DailySales StoreArea ParkingSpaces Income;
datalines;
1 1840 532 6 44000
2 1746 478 4 51000
3 1812 530 7 45000
4 1806 508 7 46000
5 1792 514 5 44000
6 1825 556 6 46000
7 1811 541 4 49000
8 1803 513 6 52000
9 1830 532 5 46000
10 1827 537 5 46000
11 1764 499 3 48000
12 1825 510 8 47000
13 1763 490 4 48000
14 1846 516 8 45000
15 1815 482 7 43000
;
run;

/* Linear Regression Analysis */
proc reg data=convenience_marts;
  model DailySales = StoreArea ParkingSpaces Income / clb;
  output out=reg_output p=predicted r=residual;
run;

/* Print Regression Output */
proc print data=reg_output;
run;

/*b. Determine the regression equation:

 

The regression equation can be derived from the coefficients obtained 
in the regression output. It will be in the form:

 

y= b0 + b1 * store_area + b2 * parking_spaces + b3 * income

 

1480.74461 is the intercept coefficient (b0)
0.73150 is the coefficient for store_area (b1)
9.99149 is the coefficient for parking_spaces (b2)
-0.00231 is the coefficient for income (b3)

 

c. Provide detailed explanation of the coefficients of the independent variables

 

1.The intercept coefficient (b0) represents the average daily sales when all other 
independent variables are zero. It may not have a direct practical interpretation 
in this context.
2.The coefficient for store area (b1) indicates how much the average daily sales change 
for a one-unit increase in floor space, holding other variables constant.
3.The coefficient for parking spaces (b2) represents the change in average daily sales 
for a one-unit increase in the number of parking spaces, while keeping other 
variables constant.
4. The coefficient for income (b3) indicates the change in average daily sales 
for a one-unit increase in median income, holding other variables constant.

 

d.What is the value of the Coefficient of regression?  Comment on the value.

 

The regression coefficients predict the change in the response for one unit 
change in an explanatory variable while holding the other variables at a constant 
value.

 

0.73150 is the coefficient for store_area (b1)
9.99149 is the coefficient for parking_spaces (b2)
-0.00231 is the coefficient for income (b3)

 

e. What is the value of the Coefficient of Determination? Comment on the value.

 

The coefficient of determination (R square = 0.8354) is a statistical measure that
represents the proportion of the variance in the dependent variable (y) that can 
be explained by the independent variables. It's an indicator of the goodness of 
fit of the model. It ranges from 0 to 1, with higher values indicating a better fit. 
A value closer to 1 suggests that a larger proportion of the variance in the 
dependent variable is explained by the independent variables. */


































2./*Use the HR-Comma-Sep.CSV to answer the following questions:

a. Generate the regression output and the residual output
b. Determine the regression equation
c. Provide detailed explanation of the coefficients of the independent variables
*/


FILENAME REFFILE '/home/u63416648/assignment 2 ban100/HR_comma_sep.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;
PROC CONTENTS DATA=WORK.IMPORT; RUN;
PROC PRINT WORK.IMPORT;
RUN;


PROC REG DATA=WORK.IMPORT;
    MODEL satisfaction_level = last_evaluation number_project time_spend_company Work_accident promotion_last_5years average_montly_hours / STB;
    OUTPUT OUT=WORK.Reg_Out PREDICTED=Pred_Residual;
RUN;

/*last_evaluation: Numerical variable representing the last performance evaluation score of an employee.
number_project: Numerical variable indicating the number of projects an employee has worked on.
time_spend_company: Numerical variable representing the number of years an employee has spent at the company.
Work_accident: Binary variable (0 or 1) indicating whether an employee has had a work accident.
promotion_last_5years: Binary variable (0 or 1) indicating whether an employee has been promoted in the last 5 years.
average_montly_hours: Numerical variable representing the average number of hours worked per month.
Assuming you've already conducted the regression analysis, let's interpret the coefficients in detail:

last_evaluation (b1): A positive coefficient (e.g., b1 = 0.3) implies that as an employee's last evaluation score increases, 
their satisfaction level tends to increase as well.
 This suggests that employees who are evaluated more positively tend to be more satisfied with their jobs.
 For every one-unit increase in the "last_evaluation" score, the satisfaction level is predicted to increase by 0.3 units, 
 assuming all other variables remain constant.

number_project (b2): A negative coefficient (e.g., b2 = -0.15) indicates that as the number of projects an employee works on increases, their satisfaction level tends to decrease. This suggests that higher project workload might lead to lower job satisfaction. For every additional project an employee works on, their satisfaction level is predicted to decrease by 0.15 units, assuming other variables are held constant.

time_spend_company (b3): Another negative coefficient (e.g., b3 = -0.25) suggests that as the number of years an employee 
spends at the company increases, their satisfaction level tends to decrease. 
This could indicate potential issues related to job stagnation or dissatisfaction that might emerge over time. 
For each additional year an employee spends at the company,
 their satisfaction level is predicted to decrease by 0.25 units, holding other variables constant.

Work_accident (b4): A positive coefficient (e.g., b4 = 0.1) suggests that employees
 who have experienced a work accident tend to have slightly higher satisfaction levels compared to those who haven't had accidents.
 This could be due to better workplace safety measures or increased attention after an accident.
 Employees who had a work accident are predicted to have a satisfaction level around 0.1 units higher than those who didn't,
 assuming other variables are constant.

promotion_last_5years (b5): A positive coefficient (e.g., b5 = 0.2) indicates that employees who have been promoted in the last 5 years tend to have higher satisfaction levels compared to those who haven't been promoted. This suggests that promotions positively impact employee satisfaction. Those who were promoted are predicted to have a satisfaction level around 0.2 units higher, assuming other variables are constant.

average_montly_hours (b6): A negative coefficient (e.g., b6 = -0.05) suggests that as the average number 
of hours worked per month increases, satisfaction levels tend to decrease. 
This implies that excessive workload might lead to decreased job satisfaction.
 For each additional hour worked per month, the satisfaction level is predicted to decrease by 0.05 units, 
 assuming other variables remain constant*/




/*Use the "SONGS.CSV" dataset to answer the following questions:


a.  Build a logistic regression model to predict Top10 using the training data. 
b. Songs with heavier instrumentation tend to be louder (have higher values in the variable "loudness").
 By inspecting the coefficient of the variable "loudness", what does our model suggest?
c. What is the accuracy of our model on the test set?
d.What is the value of the Coefficient of Correlation?  Comment on the value.
*/

FILENAME REFFILE '/home/u63416648/assignment 2 ban100/songs.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT1; RUN;


/* Splitting the data into training and test sets */

data songs_train songs_test;
    set WORK.IMPORT1;
    if ranuni(0) < 0.7 then output songs_train;
    else output songs_test;
run;

/* Building the logistic regression model */
proc logistic data=songs_train;
    model Top10 = loudness energy;
    /* You can include more variables in the MODEL statement if needed */
run;
/*
B.
Coefficient for "loudness": The coefficient for the "loudness" variable in your logistic regression output is 0.00167.

Interpretation of Coefficient:

The coefficient of 0.00167 indicates how much the log odds of the "Top10" outcome change for a
 one-unit increase in the "loudness" variable while holding other variables constant.
The log odds represent the logarithm of the odds of an event occurring. In this case, it refers
 to the log of the odds that a song is in the "Top10" category.
Magnitude of Coefficient: The coefficient's value of 0.00167 is quite small. 
This suggests that even a relatively large change in the "loudness" variable doesn't 
result in a significant change in the log odds of a song being in the "Top10" category.

Significance of Coefficient:

The p-value associated with the coefficient for "loudness" is 0.8934.
A p-value measures the evidence against a null hypothesis. In this case,
 the null hypothesis is that the coefficient for "loudness" is equal to zero (no effect).
A high p-value (e.g., greater than 0.05) suggests
 that there is not enough evidence to reject the null hypothesis. 
 In other words, the coefficient for "loudness" is not statistically significant.
Odds Ratio:

The odds ratio estimate for "loudness" is 1.002.
The odds ratio represents the factor by which the odds of being in the "Top10" category change for a one-unit increase in "loudness."
An odds ratio close to 1 indicates that the change in odds is minimal, 
further supporting the idea that "loudness" has a limited impact on predicting whether a song will be in the "Top10."
Conclusion:

The coefficient for "loudness" is close to zero, indicating a very small effect on the log odds of the "Top10" outcome.
The high p-value suggests that the coefficient is not statistically significant, 
implying that the observed relationship between "loudness" and the "Top10" outcome could likely be due to chance.
Overall, based on the model and dataset,
 the evidence does not support a strong association between "loudness" and the likelihood of a song being in the "Top10" category.
 these interpretations are specific to the current logistic regression model and dataset. 
The lack of significance for "loudness" in this model doesn't mean it's not relevant in other contexts;
 it could still be valuable when considered alongside other variables or with different modeling techniques.

C.*/
/* Applying the model to the test set and calculating accuracy */

proc logistic data=songs_test;
    model Top10 = loudness energy;
    /* You can include more variables in the MODEL statement if needed */
    output out=TestPredicted predicted=p;
run;

data TestAccuracy;
    set TestPredicted;
    if p >= 0.5 then PredictedTop10 = 1;
    else PredictedTop10 = 0;
run;

proc freq data=TestAccuracy;
    tables Top10*PredictedTop10 / nocum nopercent;
run;

/*D.*/
/* Applying the model to the test set and calculating predicted probabilities */
proc logistic data=songs_test;
    model Top10 = loudness energy;
    output out=TestPredicted predicted=p;
run;

data TestResiduals;
    set TestPredicted;
    Residual = Top10 - p;
run;

/* Calculate the correlation of residuals with "loudness" */
proc corr data=TestResiduals;
    var Residual loudness;
    pearson;
run;
