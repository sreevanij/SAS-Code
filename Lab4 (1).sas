/*4.1. Using PROC MEANS to Detect Invalid and Missing Values
By default, PROC MEANS lists the minimum and maximum values, along with the n, mean, and standard deviation.

Program 2-1: Using PROC MEANS to Detect Invalid and Missing Values*/

/**********************************************************************************/
/*********************************************************************************/

LIBNAME clean "/home/u56456355/my_shared_file_links/u56456355/BAN110";

title "Checking numeric variables in the patients data set";
proc means data=Clean.patients n nmiss min max mean maxdec=3;
   var HR SBP DBP;
run;

/**********************************************************************************/
/*********************************************************************************/

/*4.2. Using PROC UNIVARIATE to Examine Numeric Variables
As mentioned in the class, a good first step is to run PROC UNIVARIATE.

Covered here: Listing Output Objects Using the Statement TRACE ON
use ODS SELECT output-object-name;
Program 4.1: Running PROC UNIVARIATE on HR, SBP, and DBP*/

/**********************************************************************************/
/*********************************************************************************/
ods trace on;
ods graphics on;
title "Running PROC UNIVARIATE on HR, SBP, and DBP";
ODS Select ExtremeObs Quantiles;
proc univariate data=Clean.Patients;
   id Patno;
   var HR SBP DBP;
  histogram / normal; 
run;
ods trace off;

/**********************************************************************************/
/*********************************************************************************/


/*4.3. Using a PROC UNIVARIATE Option to List More Extreme Values 
If you have a large data set and you expect a lot of errors, you might elect to see more than the five lowest and highest observations. To change the number of extreme observations in the output, add the following procedure option:

NEXTROBS=number

where number is the number of extreme observations to include in the list. 
For example, to see the 10 lowest and highest values for your variables, 
submit the following program. This program includes both the ODS SELECT statement
 as well as the NEXTROBS= option.

Program 4.2: Adding the NEXTROBS= Option to PROC UNIVARIATE*/

title "Running PROC UNIVARIATE on HR, SBP, and DBP";
ods select ExtremeObs;
proc univariate data=Clean.Patients nextrobs=10;
   id Patno;
   var HR SBP DBP;
   histogram / normal;
run;
/**********************************************************************************/
/*********************************************************************************/

/*4.4.Presenting a Program to List the 10 Highest and Lowest Values 
The previous section described how to use PROC UNIVARIATE with the NEXTROBS= option to list 
the top and bottom n values of a variable. This section presents an alternative—a program 
that performs the same task. The purpose of the program is to demonstrate some SAS programming 
techniques as well as to set the groundwork for developing a macro to print the n highest and 
lowest values of a variable.

There are several ways to determine how many observations are in a SAS data set. 
The method presented here is the classic method and probably the most straightforward
 one—using the SET option NOBS=. The program presented below will list the 10 lowest and highest
 values of HR in the Patients data set:

Program 4.3: Listing the 10 Highest and Lowest Values of a Variable*/

proc sort data=Clean.Patients(keep=Patno HR 
                              where=(HR is not missing))
                              out=Tmp;
   by HR;
run;

data _null_;
   if 0 then set Tmp nobs=Number_of_Obs; *2;
   High = Number_of_Obs - 9;
   call symputx('High_Cutoff',High); *3;
   stop; *4;
run;

title "Ten Highest and Lowest Values for HR";
data _null_;
   set Tmp(obs=10)                      /* 10 lowest values */ 
       Tmp(firstobs=&High_Cutoff); *5; /* 10 highest values */
   file print; *6;
   if _n_ le 10 then do; *7;
      if _n_ = 1 then put / "Ten Lowest Values"; *8;
      put "Patno = " Patno @15 "Value = " HR;
   end;
   else if _n_ ge 11 then do; *9;
      if _n_ = 11 then put / "10 Highest Values";
      put "Patno = " Patno @15 "Value = " HR;
   end;
run;

/**********************************************************************************/
/*********************************************************************************/

/*4.5 Describing a program to List the Highest and Lowest Values by Percentage 
You have seen several ways to list the top and bottom n values of a variable.
 As an alternative, you might want to see the top and bottom n percentage of data values.

Using PROC UNIVARIATE
One approach uses PROC UNIVARIATE to output the cutoff values for the desired percentiles

Program 4.5: Listing the Top and Bottom 5% for HR (Using PROC UNIVARIATE)*/

PROC univariate data=clean.patients noprint; 
    var HR;
    id Patno;
    output  out=Tmp  pctlpts=5 95 pctlpre=Percent_; 
run; 

proc print data=Tmp; 
run;

/**********************************************************************************/
/*********************************************************************************/

data HighLowPercent;
    set Clean.patients (keep = Patno HR); 
    * bring in upper and lower cutoffs for variable HR; 
    if _n_=1 then set Tmp ; 
    if HR le Percent_5 and not missing (HR) then do ; 
        Range= 'Low '; 
        output; 
    end; 
    else if HR ge Percent_95 then do; 
     Range= 'High'; 
    output; 
    end; 
run; 

proc sort data=HighLowPercent; 
by HR; 
run; 

proc print data=HighLowPercent; 
run;


/**********************************************************************************/
/*********************************************************************************/


/*4.6. Using Pre-Determined Ranges to Check for Possible Data Errors 
Using PROC PRINT with a WHERE Statement to List Invalid Data Values ¶
The PROC PRINT step in Program 2-12 (cody's 2008) reports all patients with 
out-of-range values for heart rate, systolic blood pressure, or diastolic blood pressure.
Program 2-12: Using a WHERE Statement with PROC PRINT to List Out-of-Range Data*/

title "Out-of-range values for numeric variables";

proc print data=Clean.patients; 
    where ( HR not between 40 and 100 and HR is not missing) 
    or 
    (SBP not between 80 and 200 and SBP is not missing) 
    or 
    (DBP not between 60 and 120 and DBP is not missing); 
    id patno; 
    var HR SBP DBP; 
run; 

/**********************************************************************************/
/*********************************************************************************/
/*Q1. Activity 
Using a DATA Step to Check for Out-of-Range Values: A simple DATA NULL step can also be 
used to produce a report on out-of-range values.

Complete the program for SBP and DBP out of range values check. Valid values for SBP are
 between 80 and 200. Valid values for DBP are between 60 and 120
Program 2-13: Using a DATA NULL Step to List Out-of-Range Data Values*/





/**********************************************************************************/
/*********************************************************************************/

/*Identifying Invalid Values versus Missing Values 
Program 4.11: Identifying Invalid Numeric Data*/


*Program to Demonstrate How to Identify Invalid Data;
title "Listing of Invalid Data for HR, SBP, and DBP";
data _null_;
   file print;
   input @1  Patno $3.
         @4  HR $3.
         @7  SBP $3.
         @10 DBP $3.;
   
   if notdigit(trimn(HR)) and not missing (HR) then 
       put "invalid value " HR  " for HR in patient " Patno ; 
    if notdigit(trimn(SBP)) and not missing (SBP) then 
       put "invalid value " SBP  " for SBP in patient " Patno ;
   if notdigit(trimn(DBP)) and not missing (DBP) then 
       put "invalid value " DBP  " for DBP in patient " Patno ;
   
/**********************************************************************************/
/*********************************************************************************/

*Program to Demonstrate How to Identify Invalid Data;
title "Listing of Invalid Data for HR, SBP, and DBP";
data _null_;
   file print;
   input @1  Patno $3.
         @4  HR $3.
         @7  SBP $3.
         @10 DBP $3.;

X= input(HR, 3.); 
if _error_ then do ;
 put "Invalid Value  " HR  "for HR in patient" patno; 
 _error_ =0;
 end; 

X= input(SBP, 3.); 
if _error_ then do ;
 put "Invalid Value  " SBP  "for SBP in patient" patno; 
 _error_ =0;
 end;
 
X= input(DBP, 3.); 
if _error_ then do ;
 put "Invalid Value  " DBP  "for DBP in patient" patno; 
 _error_ =0;
 end;

/**********************************************************************************/
/*********************************************************************************/


/*4.7. Checking Ranges for Several Variables and Generating a Single Report 
Most of the programs and macros you have seen so far test out-of-range values 
for individual variables. The two macros described here will test several variables 
for out-of-range values and produce a consolidated report. To make the macro more flexible,
 you can decide to treat missing values for each variable as valid or invalid. The macro is 
 listed first, followed by a step-by-step explanation:

Program 4.13: Checking Ranges for Several Variables*/


/*Program Name: Errors.Sas
 Purpose: Accumulates errors for numeric variables in a SAS
         data set for later reporting/
         This macro can be called several times with a
         different variable each time. The resulting errors
         are accumulated in a temporary SAS data set called
         errors.
         */

/*Macro variables Dsn and IDvar are set with %Let statements 
before  the macro is run; */

%macro Errors(Var=,    /* Variable to test     */
              Low=,    /* Low value            */
              High=,   /* High value           */
              Missing=ignore
                       /* How to treat missing values         */
                       /* Ignore is the default. To flag     */
                       /* missing values as errors set        */
                       /* Missing=error                       */);



data Tmp; 
    set &Dsn (keep= &Idvar &Var ); 
    length Reason $ 10 Variable $ 32; 
    Variable= "&Var"; 
    value= &Var; 
    
    if &Var lt &Low and not missing(&Var) then do;
      Reason='Low';
      output;
       end;
   
   else if &Var gt &High then do;
        Reason='High';
      output;
      end;
    
   %if %upcase(&Missing) ne IGNORE %then %do; 
   else if missing(&Var) then do;
      Reason='Missing';
      output;
   end;
    %end;

data Tmp (drop=&Var); 
set Tmp; 
run;

 proc append base=errors data=Tmp;
   run;


%mend errors;



%macro report;

   
     proc sort data=Errors;
      by &Idvar;
   run;

   proc print data=errors;
   title "Error Report for Data Set &Dsn";
      id &Idvar;
      var Variable Value Reason;
   run;



   
   proc datasets library=work nolist;
      delete errors;
      delete tmp;
   run;
   quit;

%mend report;


/**********************************************************************************/
/*********************************************************************************/

***Set two macro variables;
    %let Dsn=Clean.Patients;
    %let IDvar = Patno;

    %Errors(Var=HR, Low=40, High=100, Missing=error)
    %Errors(Var=SBP, Low=50, High=240, Missing=ignore)
    %Errors(Var=DBP, Low=35, High=130)
    ***Generate the report;
    %report
    
    
/*Conclusions:
Ensuring accurate data:

to use PROC UNIVARIATE (with or without the NEXTROBS= option) and look at the highest and 
lowest data values.
define reasonable ranges for your variables.
If ranges are not reasonable for some variables, proceed on to the next 
chapter to explore methods that use the distribution of data values to automatically 
identify possible data errors.*/

