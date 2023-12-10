/*3.	You are working for a Tv streaming service, and your manager claims that the average user spends about 56$ on monthly subscriptions. Your manager wants you to test if this is true using a 1% level of significance.

The data you collect is a sample of monthly spending from the local population. The dataset is found in “subscription.csv” file. Design a test which you will use to test this hypothesis in SAS, display the relevant output, and interpret the findings.
-	State the question you are trying to answer.
-	What is the null and alternate hypothesis?
-	What are the results from the test and what is your conclusion? (post screenshots and a description of the code)*/

/*null hypothesis h0=56 and
h1<>56*/


options validvarname=v7;
PROC IMPORT DATAFILE="/home/u63416648/easy/subscription.csv" DBMS=csv
OUT=SUBSCRIPTION_R replace;
run;

proc ttest data=SUBSCRIPTION_R side = 2 alpha =0.01 h0=56;

 
run;

/*the p-value is less than the chosen alpha (0.01), 
it would indicate that there is evidence to reject the null hypothesis and 
conclude that customers, on average, spend more than $56 more than planned*/

/*as null hypthesis is the averge buyers spend 56$