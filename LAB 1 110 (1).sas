LIBNAME NEW "/home/u63416648/seneca 110";


DATA NEW.PATIENTS;
	INFILE "/home/u63416648/seneca 110/Patients.txt";
	INPUT @1 PATNO    $3.
         @4 GENDER   $1.
         @5 VISIT MMDDYY10.
         @15 HR 3.
         @18 SBP 3.
         @21 DBP 3.
         @24 DX       $3.
         @27 AE       $1.;
	LABEL PATNO="Patient Number" GENDER="Gender" VISIT="Visit Date" 
		HR="Heart Rate" SBP="Systolic Blood Pressure" DBP="Diastolic Blood Pressure" 
		DX="Diagnosis Code" AE="Adverse Event?";
	FORMAT VISIT MMDDYY10.;
RUN;

proc sort data=NEW.PATIENTS;
	by Patno Visit;
run;

proc print data=NEW.PATIENTS;
	/*id Patno;*/
run;
.....................................ANSWER FOR THE FIRST QUESTION.....................................

data Check_Char;
	set NEW.Patients(keep=Patno Gender);
run;

title "Frequencies for Gender";

proc freq data=Check_Char;
	tables Gender;
run;


......................................................................................................................................

/* Create a new dataset to check character variables Dx and AE */
data Check_Char2;
  set NEW.Patients(keep=Patno Dx AE);
run;

title "Frequencies for Dx (Diagnosis Code)";
proc freq data=Check_Char2;
  tables Dx;
run;

title "Frequencies for AE (Adverse Event?)";
proc freq data=Check_Char2;
  tables AE;
run;

................................................................................................................................

libname NEW '/home/u63416648/seneca 110'; 
data NEW.Patients_Caps;
   set NEW.Patients;
   array Chars[*] _character_; *1;
   do i = 1 to dim(Chars); *2;
      Chars[i] = upcase(Chars[i]); *3;
   end;
   drop i;
run;

title "Listing the First 10 Observations in Data Set Patients_Caps";
proc print data=clean.Patients_Caps(obs=10) noobs; *4;
run;

./............................................................SOLUTION FOR SECOND QUESTION ..................................................................................................................................
data NEW.Patients_Caps;
	set NEW.Patients;
	array Chars[*] _character_;
	

	do i=1 to dim(Chars);
		
		Chars[i]=upcase(Chars[i]);
		
	end;
	drop i;
run;


data NEW.Patients_Caps;
    set NEW.Patients;
    array Chars[*] _character_;
    var_count = dim(Chars);
    put var_count=;
run;


Proc contents data=NEW.Patients; 
run; 


............./THERE ARE 4 VARIABLES IN ARRAY CHAR WHICH IS AE , DX ,GENDER AND PATNO/................................

..........................................................................................................................





libname NEW '	/home/u63416648/seneca 110'; 
title "Listing of invalid patient numbers and data values";

data NEW.PAITENTS;
    set NEW.patients; 
     file print;
    *check patno; 
    if  missing(patno) then put 
        "patno missing obs" _n_; 
    if notdigit(Patno)  then put
        patno= "is not digit"; 
    
    * check gender; 
    if  missing(gender) then put 
        patno= "is missing"; 
    else if gender not in ('M', 'F') then put 
        patno= "has an invalid gender value: " 
        gender= ; 
        
   *check Dx; 
   if missing(Dx) then put 
       patno= "has a missing value for Dx"; 
    
    if notdigit(trim(Dx)) and not missing(Dx)
    then put Patno= "has invalid Dx value"
            Dx= ; 
   *check AE; 
   if missing(AE) then put 
        patno= "has a missing value for AE"; 
    
    if AE not in ('0', '1') then put 
        Patno= "has invalid AE value"
            AE= ;
    
    
run;




libname Clean '/folders/myfolders/lectures';
title "Using PROC Print to Identify Data Errors";

proc print data=NEW.patients; 
    id Patno; 
    var Gender; 
    var AE; 
    where notdigit(Patno) or 
        gender not in ('M', 'F') or 
        AE not in ('0', '1');
                   
run;




/.................ANSWER FOR THE THIRD QUESTION ...............................................


data _null_;
	set NEW.patients;
	file print;
	*check patno;

	if patno="003" then
		put patno_obs= _n_;

	if notdigit(Patno) then
		put patno="is not digit" _n_;
	
run;


.....................................................................................................................

...............ANS FOR THE FORTH QUESTION .............................................


proc print data=NEW.patients;
	id Patno;
	var Gender;
	where Patno="010" and Gender="f";
run;


..................................................................................................................................



libname NEW '/home/u63416648/seneca 110'; 
*Using formats to identify data errors;
title "Listing Invalid Values of Gender";

* define a gender format; 
proc format; 
 value $gender_check 'M', 'F'= 'valid'
                       ' '   = ' missing'
                       other = 'Error'; 
run; 

* use proc freq to compute frequencies on the formatted values; 
proc freq data=NEW.patients; 
    tables Gender / nocum nopercent missing; 
    format Gender $gender_check.; 
run; 





libname NEW '/home/u63416648/seneca 110'; 

*Using formats to identify data errors;

title "Listing Invalid Values of Gender";
proc format;
   value $Gender_Check 'M','F' = 'Valid'
                       ' '     = 'Missing'
                       other   = 'Error';
run;

data _null_; 
    set NEW.patients (keep=patno Gender); 
    file print; 
    if put(Gender, $gender_check.) = 'Missing' then 
    put 
    " Missing value for Gender for patient" Patno ; 
    else if put(Gender, $gender_check.) = 'Error' then 
    put 
        "missing value of gender=" Gender "for patient" patno; 
    
run; 





NEW.Patients_Capslibname NEW '/home/u63416648/seneca 110'; 

title "Checking Missing Character Values";

Proc format;
    value $count_missing  ' '= 'missing'
                            other= 'Nonmissing'; 
run; 

proc freq data=NEW.patients; 
 tables _character_ / nocum missing; 
 format _character_  $count_missing. ; 
 run; 
 
 
 ...................................ANSWER FOR THE FIFTH QUESTION..............................................................
 
 
 A MISSING VALUE FOR A CATEGORICAL VARIABLE IS REPRESENTED WITH A SPECIAL VALUE CALLED A MISSING VALUE INDICATOR.
 IN OTHER WORDS IT IS CALLED MISSING VALUE CODE IT IS USUALLY REPRESENTED BY A PERIOD (.) OR BLANK SPACE .