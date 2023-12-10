



/**************************************************************************/
/*Problem 3*/
/* Create the Voter data set */
data Voter;
input Age Party : $1. (Ques1-Ques4) ($1. +1);
datalines;
 23 D 1 1 2 2
 45 R 5 5 4 1
 67 D 2 4 3 3
 39 R 4 4 4 4
 19 D 2 1 2 1
 75 D 3 3 2 3
 57 R 4 3 4 4
 ;
run;
/* Add formats */
proc format;

value agefmt 0 - 30='0-30' 31 - 50='31-50' 51 - 70='51-70' 71 - high='71+';
value $ partyfmt 'D'='Democrat' 'R'='Republican';
value $ quesfmt 1='Strongly Disagree' 2='Disagree' 3='No Opinion' 4='Agree'
5='Strongly Agree';
run;
PROC PRINT noobs;
RUN;
/* Add variable labels */
proc datasets lib=work nolist;
modify Voter;
label Age='Age' Party='Party' Ques1='The president is doing a good job'
Ques2='Congress is doing a good job' Ques3='Taxes are too high'
Ques4='Government should cut spending';
run;
/* Print the observations with variable labels*/
proc print data=Voter label;
run;
/* Calculate frequencies for the four questions */
proc freq data=Voter;
format age agefmt. party $partyfmt. Ques1-Ques4 $quesfmt.;
run;
/*****












