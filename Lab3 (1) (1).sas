
/*********************************************************************************/
/* Chapter 16: Transformations of Interval-Scaled Variables
/*********************************************************************************/
/* 16.1 Introduction:

In this chapter we will deal with transformations of interval variables. With interval variables 
we mean variables such as age, income, and number of children, which are measured on an interval
or ratio scale. The most obvious transformation of interval variables is to perform 
a calculation such as addition or multiplication on them. However, we will also see in this
chapter that the transformations are not restricted to simple calculations.

In this tutorial, the following topics are covered:

1. Simple derived variables, where we will look at simple calculations between interval variables and the creation of interactions.

2. Relative derived variables, where we will consider the creation of ratios and proportions 
by comparing a value to another value.

3. Binning observations into groups, where we will show that an interval value can be grouped 
with IF_THEN/ELSE clauses or formats.

4. Replacement of missing values, where we will deal with replacing missing values with 
the mean of other variables.

Transformation of variables, where we will show mathematical or statistical transformations of
variables.

/************************************************************************************************/
/* 16.2 Simple Derived Variables
/************************************************************************************************/
/* The rationale for derived variables is that we create variables that hold information that is 
more suitable for analysis or for interpretation of the results.

Derived variables are created by performing calculations on one or more variables and 
creating specific measures, sums, ratios, aggregations, or others.

Derived variables can be a simple calculation on one or more variables. For example, we can create
the body mass index (BMI) with the following expression if WEIGHT is measured in kilograms 
and HEIGHT is measured in centimeters:

BMI = Weight / Height **2;


16.2.1 Interactions and Quadratic Terms
An interaction is a term in a model in which the effect of two or more factors is not simply 
additive. In the case of two binary input factors, the effect of the co-occurrence of both 
factors can be higher or lower than the sum of the sole occurrence of each factor. 
If the business rationale suggests that interactions exist between variables, 
the interactions will be included in the analysis.

Variables that contain an interaction between two variables can be easily built by a 
simple multiplication of the variables. The following code computes an interaction 
variable of AGE and WEIGHT:

INT_AGE_WEIGHT = AGE * WEIGHT;

Note that by definition the interaction is missing if one of its components is missing,
which is true for our expression. In some procedures, e.g., PROC REG, interactions 
cannot be created in the MODEL statement but need to be present in the input data.

A quadratic term and cubic term for AGE can be easily created by the following statement:

AGE_Q = AGE ** 2;
AGE_C = AGE ** 3;

Note that it is up to the programmer to name the AGE variable. 
AGE2 and AGE3 are also common to express the quadratic and cubic terms. 
When creating derived variables, the consecutive numbering of variables is very common. 
Although this "quick and dirty" approach is not the best programming style, we have to consider 
that the name AGE2 as the quadratic term can be easily confused with an age variable that is 
created with a different definition.

Resources:
To know more about interaction terms, 
have a look at this example: https://www.theanalysisfactor.com/interpreting-interactions-in-regression/

/************************************************************************************************/

proc print data=sashelp.class; 
run; 

/*********************************************************************************/
/*16.3.3 Coding Relative Variables Based on Population Means*/

/*********************************************************************************/

DATA class;
 FORMAT ID 8.;
 SET sashelp.class(KEEP = weight);
 ID = _N_;
 Weight_Shift = Weight-100.03;
 Weight_Ratio = Weight/100.03;
 Weight_CentRatio = (Weight-100.03)/100.03;
RUN;

proc standard data=class (keep= id weight) out=class2 mean=0 std=1; 
    var weight; 
run;
 
Data class; 
    MERGE class class2(RENAME= (weight=weight_Std));
    By id; 
Run; 

proc rank data=class out=class Ties=low descending; 
    var weight; 
    ranks weight_Rnk; 
run; 

proc sort data=class; 
by weight; 
run; 


proc print data=class; 
run;

/*********************************************************************************/

/*Comments:

In the preceding code we artificially created an ID variable from the logical N variable 
in order to have a subject identifier in place.

We needed this subject identifier to merge
the results of PROC STANDARD with the original data because PROC STANDARD does not 
create a new variable but overwrites the existing variables.

/*********************************************************************************/

/*********************************************************************************/
/*  Q1. Activity
use proc sgplot on the "class" dataset and show the histogram of the variable Weight, 
Weight_Shift, Weight_Ratio, Weight_CentRatio and weight_Std







/*********************************************************************************/
/*********************************************************************************/

/*********************************************************************************/
/* 16.5.1 Creating Groups of Equal Number of Observations with PROC RANK
/*********************************************************************************/

proc print data=sashelp.air; 
run; 


proc rank data=sashelp.air out=air groups=10; 
var air; 
ranks air_grp; 
run; 

proc sort data=air; 
by air_grp; 
run;

proc print data=air; 
run;

/*********************************************************************************/

/*********************************************************************************/
/* Q2. Activity
Within a data step, increment the airgrp to have them starting from 1. print the output.*/

data air;
  set air;
  air_grp = air_grp + 1;
run;

proc print data=air;
run;




/*********************************************************************************/

/*********************************************************************************/
/* 16.5.2: Creating Groups of Equal Widths with SAS Functions
/*********************************************************************************/

DATA air;
 SET sashelp.air;
  Air_grp1 = CEIL(air/10);
  Air_grp2=  CEIL(air/10)*10; 
  Air_grp3= CEIL(air/10)*10 -5; 
  Air_grp4= CEIL(air/10)-10;
RUN;


proc sort data=air; 
    by Air_grp1; 
run; 

proc print data=air; 
run;

/*********************************************************************************/


/*********************************************************************************/
/* Q3. Activity
Change the previous code and consider only Air_grp1 to create bins of width=100. 
print the output



/*********************************************************************************/


data air;
  set sashelp.air;
  Air_grp1 = CEIL(air/100) * 100;
run;

proc sort data=air;
  by Air_grp1;
run;

proc print data=air;
run;


/*********************************************************************************/
/* 16.5.3: Creating Individual Groups

/*********************************************************************************/

data air; 
     set sashelp.air; 
     format air_grp $15.; 
     
     if  air= . then air_grp= '00: Missing'; 
     else if air <220 then air_grp = '01: <220'; 
     else if air <275 then air_grp= '02: 220-274'; 
     else                  air_grp= '03: >=275' ; 
     
run; 

proc print data=air; 
run; 

/*********************************************************************************/

/* Note the following:

Formatting the variable that holds the new group names is advisable. Otherwise, 
the length of the variable is determined from the first assignment, which can cause 
truncation of the group names.The group names contain a numbering according to their size. 
This is advisable for a sorted output.The vertically aligned coding has the advantage 
that it is easier to read and to edit.


/*********************************************************************************/
/* Using SAS Formats

The preceding grouping can also be created by defining a SAS format and assigning the format 
to the variable AIR during analysis:*/

PROC FORMAT;
 VALUE air
   .  = '00: MISSING'
   LOW -< 220 = '01: < 220'
   220 -< 275 = '02: 220 - 274'
   275 - HIGH = '03: > 275';
RUN;

Create a new variable in a DATA step by using the format in a PUT function:

DATA air;
 SET sashelp.air;
 Air_grp = PUT(air,air.);
RUN;

/*********************************************************************************/
/* Q4. Activity
adjust the proc format procedure in the previous code to create 5 bins instead of 4 with keeping the first bin 00:MISSING, <100, between 100 and 200, between 200 and 300, and above 300.
create a new varianle in a DATA step, and print the data.
run the code




/*********************************************************************************/


PROC FORMAT;
  VALUE air
    .  = '00: MISSING'
    LOW -< 100 = '01: < 100'
    100 -< 200 = '02: 100 - 199'
    200 -< 300 = '03: 200 - 299'
    300 - HIGH = '04: > 300';
RUN;

DATA air;
  SET sashelp.air;
  Air_grp = PUT(air, air.);
RUN;

PROC PRINT data=air;
RUN;

