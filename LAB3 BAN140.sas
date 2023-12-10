*/Using IF and ELSE IF statements, create two new variables as follows: 
Grade (numeric), with a value of 6 if Age is 12, and a value of 8 if Age is 13.
Then create another variable named quizgrade. quizgrades have numerical equivalents as follows: 
A = 95, B = 85, C = 75, D = 70, and F = 65.;



data school;

  input Age Quiz : $1. Midterm Final;

datalines;

12 A 92 95

12 B 88 88

13 C 78 75

13 A 92 93

12 F 55 62

13 B 88 82

;
run;

data school;
 input Age Quiz : $1. Midterm Final;
 if age eq 12 then gradevalue=6 ;
  else if age eq 13 then gradevalue=8;
  if quiz eq 'A' then quizgrade=95;
  else if quiz eq 'B' then quizgrade=85;
  else if quiz eq 'C' then quizgrade=75;
  else if quiz eq 'D' then quizgrade=70;
  else if quiz eq 'F' then quizgrade=65;
  
  datalines;

12 A 92 95

12 B 88 88

13 C 78 75

13 A 92 93

12 F 55 62

13 B 88 82

;
run;
  
  
  title "MIDTERM DATA" ;
  PROC PRINT DATA=school;
  run;
  
  
  
  
/*2*/ 
 
 libname learn '/home/u63416648/seneca 110';

data learn.veggie;
  input ID $ fnumber snumber tnumber;
  datalines;
B 55 30 195
C 56 30 225
D 68 1500 395
E 55 1500 225
F 75 200 295
G 80 200 395
H 66 200 295
I 70 30 225
;

/* Using OR operators in WHERE statement */
data veggie_55_75_or;
  set learn.veggie;
  where fnumber = 55 or fnumber = 75;
run;

/* Print the resulting dataset */
proc print data=veggie_55_75_or;
run;

 
 /* Using the IN operator in WHERE statement */
data veggie_55_75_in;
  set learn.veggie;
  where fnumber in (55, 75);
run;

/* Print the resulting dataset */
proc print data=veggie_55_75_in;
run;
 

3.Using the following dataset (vitals), create a new data set (NewVitals) with the following new variables:

For subjects less than 50 years of age:

If Pulse is less than 70, set PulseGroup equal to Low; otherwise, set PulseGroup equal to High.



If SBP is less than 130, set SBPGroup equal to Low;

otherwise, set SBPGroup equal to High.;



data vitals;

  input ID  : $3.

     Age    

     Pulse   

     SBP

     DBP;

  label SBP = "Systolic Blood Pressure"

     DBP = "Diastolic Blood Pressure";

datalines;

001 23 68 120 80

002 55 72 188 96

003 78 82 200 100

004 18 58 110 70

005 43 52 120 82

006 37 74 150 98

007 . 82 140 100

;
 run;




/*here age is les than 50 and no missing is thr*/


data newvitals;  
set vitals;  
if Age lt 50 and not missing(Age) then do;    
   if Pulse lt 70 then PulseGroup = 'Low ';    
   else PulseGroup = 'High';    
   if SBP lt 130 then SBPGroup = 'Low ';    
   else SBPGroup = 'High';  
end;  

run;

title "Listing of NEWVITALS";
proc print data=newvitals noobs;
run;


/*4.Using the SAS data set vitals, create two temporary SAS data sets called Subset_A and Subset_B.

Include in both of these data sets a variable called Combined equal to .001 times WBC plus RBC.



Subset_A should consist of observations from Blood where Gender is equal to Female and

BloodType is equal to A. 



Subset_B should consist of all observations from Blood where Gender

is equal to Female, BloodType is equal to A, and Combined is greater than or equal to 14.; */
LIBNAME MYLIB '	/home/u63416648/seneca 110';

data MYLIB.vitals;
  input ID $
    Gender $
    BloodType $
    AgeType $
    WBC
    RBC
    Age;
  datalines;
1  Female AB Young 7710  7.4 14
2  Male  AB Old  6560  4.7 .
3  Male  A Young 5690  7.53 18
4  Male  B Old  6680  6.85 .
5  Male  A Young .   7.72 17
6  Male  A Old  6140  3.69 12
7  Female A Young 6550  4.78 29
8  Male  O Old  5200  4.96 15
9  Male  O Young .   5.66 31
10  Female O Young 7710  5.55 .
11  Male  B Young .   5.62 15
12  Female O Young 7410  5.85 24
13  Male  O Young 5780  4.37 .
14  Female O Old  5590  6.94 15
15  Female A Old  6520  6.03 27
16  Female O Young 7210  5.17 13
;

RUN;
LIBNAME BLOOD  "/home/u63416648/vitals.sas7bdat"

data VITALS ;

  input ID $

     Gender $

     BloodType $

     AgeType $    

     WBC   

     RBC

     Age;



datalines;

1  Female AB Young 7710  7.4 14

2  Male  AB Old  6560  4.7 .

3  Male  A Young 5690  7.53 18

4  Male  B Old  6680  6.85 .

5  Male  A Young .   7.72 17

6  Male  A Old  6140  3.69 12

7  Female A Young 6550  4.78 29

8  Male  O Old  5200  4.96 15

9  Male  O Young .   5.66 31

10  Female O Young 7710  5.55 .

11  Male  B Young .   5.62 15

12  Female O Young 7410  5.85 24

13  Male  O Young 5780  4.37 .

14  Female O Old  5590  6.94 15

15  Female A Old  6520  6.03 27

16  Female O Young 7210  5.17 13

;

RUN;



data subset_a;  
set BLOOD.vitals;  
where Gender eq 'Female' and bloodgroup='A';  
Combined = .001*WBC + RBC; run;


title "Listing of SUBSET_A";
proc print data=subset_a noobs;
run;


data subset_b;  
set mozart.blood;  
Combined = .001*WBC + RBC;  
if Gender eq 'Female' and bloodgroup='A' and Combined ge 14;
run;

title "Listing of SUBSET_B";
proc print data=subset_b noobs;

run;











data vitals;
  input ID $ Gender $ BloodType $ AgeType $ WBC RBC Age;
  datalines;
1  Female AB Young 7710  7.4 14
2  Male  AB Old  6560  4.7 .
3  Male  A Young 5690  7.53 18
4  Male  B Old  6680  6.85 .
5  Male  A Young .   7.72 17
6  Male  A Old  6140  3.69 12
7  Female A Young 6550  4.78 29
8  Male  O Old  5200  4.96 15
9  Male  O Young .   5.66 31
10  Female O Young 7710  5.55 .
11  Male  B Young .   5.62 15
12  Female O Young 7410  5.85 24
13  Male  O Young 5780  4.37 .
14  Female O Old  5590  6.94 15
15  Female A Old  6520  6.03 27
16  Female O Young 7210  5.17 13
;

/* Subset_A: Gender = Female and BloodType = A */
data Subset_A;
  set vitals;
  where Gender = 'Female' and BloodType = 'A';
  Combined = 0.001 * WBC + RBC;
run;

/* Subset_B: Gender = Female, BloodType = A, and Combined >= 14 */
data Subset_B;
  set vitals;
  where Gender = 'Female' and BloodType = 'A' and Combined >= 14;
  Combined = 0.001 * WBC + RBC;
run;
