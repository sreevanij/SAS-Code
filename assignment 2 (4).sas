/*********************************************
 * Assignment 2								 *
 ************/
/******************************************
 *                Part 1                   *
 ******************************************/
/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 1 */
/* Import the csv data into SAS */
options validvarname=v7;

/* Handles special characters in variable names */
proc import 
		datafile='/home/u63416648/seneca 110/FuelEfficiency.csv' 
		out=fueleff dbms=csv replace;
	getnames=yes;
run;

/* PROC MEANS to summarize numerical attributes */
proc means data=fueleff;
	title "Part 1 - Solution 1";
	var Eng_Size Cylinders MSRP City_L_100km Highway_L_100km Weight_in_Pounds;
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 2 */
/* Calculate the correlation matrix */
proc corr data=fueleff;
	title "Part 1 - Solution 2";
run;

/* Scatter plot for Eng_Size vs. Cylinders */
proc sgplot data=fueleff;
	scatter x=Eng_Size y=Cylinders;
	title "Scatter Plot: Eng_Size vs. Cylinders";
run;

/* Scatter plot for MSRP vs. Highway_L_100km */
proc sgplot data=fueleff;
	scatter x=MSRP y=Highway_L_100km;
	title "Scatter Plot: MSRP vs. Highway_L_100km";
run;

/* Justification: "Eng_Size" and "Cylinders" are the most strongly correlated variables*
"MSRP" and "Highway_L_100km" are the most weakly correlated variables*/
/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 3 */
/* Generate summary statistics for Weight_in_Pounds */
proc means data=fueleff;
	var Weight_in_Pounds;
	title "Part 1 - Solution 3";
run;

/* Histogram for Weight_in_Pounds */
proc sgplot data=fueleff;
	histogram Weight_in_Pounds;
	title "Histogram: Weight_in_Pounds";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 4 */
/* Add a column to the existing dataset */
data fueleff;
	set fueleff;

	/* Create the Weight_Filter column */
	if Weight_in_Pounds < 4000 then
		Weight_Filter=1;
	else
		Weight_Filter=0;
run;

/* Printing the new dataset */
proc print data=fueleff(obs=10);
	/* Just printing first 10 Obs. to reduce the output */
	title "Part 1 - Solution 4";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 5 */
/* Calculate the original correlation */
proc corr data=fueleff noprint outp=corr_results_original;
	var Highway_L_100km Weight_in_Pounds;
run;

/* Create a subset of the data within the weight range */
data weight_restricted;
	set fueleff;
	where 3000 <=Weight_in_Pounds <=4000;
run;

/* Calculate the correlation within the weight-restricted subset */
proc corr data=weight_restricted noprint outp=corr_results_restricted;
	var Highway_L_100km Weight_in_Pounds;
run;

/* Compare the correlations */
data correlation_comparison;
	merge corr_results_original(rename=(Highway_L_100km=Original_Highway 
		Weight_in_Pounds=Original_Weight)) 
		corr_results_restricted(rename=(Highway_L_100km=Restricted_Highway 
		Weight_in_Pounds=Restricted_Weight));
	correlation_diff=abs(Original_Highway - Restricted_Highway);
run;

/* Print the results */
proc print data=correlation_comparison noobs;
	title "Part 1 - Solution 5";
	var _type_ Original_Highway Restricted_Highway correlation_diff;
	format _type_ $20.;
run;

/* Justification: The correlation between highway fuel consumption and weight is slightly weaker*
within the weight range of 3000-4000 pounds compared to the entire dataset,   *
indicating a slightly less strong positive relationship                       */

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/

/* Part 1 - Solution 6 */
/* Impute Missing values for cylinders using the mean of non-missing cylinder*/
proc stdize data=fueleff out=Imputed
      oprefix=Orig_  /*prefix of original variables*/
      reponly        /* only replace*/
      method=mean;
      var Highway_L_100km;
run;

data fueleff;
set Imputed;
drop Orig_Highway_L_100km;
run;

proc print data=fueleff;
title "Part 1 - Solution 6";
run;


/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 7 */
/* Use PROC UNIVARIATE to get summary statistics */
proc univariate data=fueleff;
	title "Part 1 - Solution 7";
	var City_L_100km;
	histogram City_L_100km / normal cfill=aquamarine;
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 8 */
data fueleff;
	set fueleff;
	length Eng_cat $6;

	/* Increase the length to 6 characters */
	/* Discretize Eng_Size into categorical variable Eng_cat */
	if 0 <=Eng_Size <=2 then
		Eng_cat="Low";

	/* Range: 0 <= Eng_Size <= 2 */
	else if 2 < Eng_Size <=3.5 then
		Eng_cat="Medium";

	/* Range: 2 < Eng_Size <= 3.5 */
	else if Eng_Size > 3.5 then
		Eng_cat="High";

	/* Range: Eng_Size > 3.5 */
run;

/* Printing the modified original dataset with discretized values */
proc print data=fueleff;
	title "Part 1 - Solution 8";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 1 - Solution 9 */
/* Use PROC FREQ to find the unique names of the Type variable */
proc freq data=fueleff;
	tables Type / out=unique_types(keep=Type);
run;

/* Use PROC PRINT to display the unique values of the Type variable */
proc print data=unique_types;
	title "Unique Values of Type Variable";
run;

data fueleff;
	set fueleff;

	/* Convert Type variable to Type_cat with ordinal values */
	select(Type);
		when ('Miniv') Type_cat=1;
		when ('SUV') Type_cat=2;
		when ('Sedan') Type_cat=3;
		when ('Wagon') Type_cat=4;
		otherwise Type_cat=.;

		/* Handle missing or unexpected values */
	end;
run;

/* Printing the dataset with the new Type_cat variable */
proc print data=fueleff;
	title "Part 1 - Solution 9";
run;

/******************************************
 *                Part 2                  *
 ******************************************/
/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 2 - Solution 1 - a */
/* Import the csv data into SAS */
options validvarname=v7;

/* Handles special characters in variable names */
proc import 
		datafile='/home/u63416648/seneca 110/airquality.csv' 
		out=airquality dbms=csv replace;
	getnames=yes;
run;

/* To count missing values for each variable: */
proc means data=airquality n nmiss;
	var ozone solar_r wind temp;
	title "Part 2 - Solution 1 - a";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 2 - Solution 1 - b */
/* Create a dataset of complete cases */
data complete_cases;
	set airquality;

	/* Check if all variables have non-missing values */
	if not missing(ozone) and not missing(solar_r) and not missing(wind) and not 
		missing(temp);
run;

/* Calculate the mean temperature using listwise deletion */
proc means data=complete_cases mean;
	var temp;
	title "Part 2 - Solution 1 - b";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 2 - Solution 1 - c */
/* Find rows with missing temperature values */
data missing_temp_rows;
	set airquality;

	if missing(temp);
run;

proc print data=missing_temp_rows;
	title "Part 2 - Solution 1 - c";
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/
/* Part 2 - Solution 1 - d */
/* Create box plots for temp variable by month */
proc sgplot data=airquality;
	vbox temp / category=Month;
	title "Part 2 - Solution 1 - d";
run;

/*Interpretation: The box plot visually displays the distribution of temperature values for different *
months. Differences in mean temperature are due to differnt months as summer approaches*
the temperature increases from May to June, and then starts falling down from August. */


/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/

/* Part 2 - Solution 1 - e */
/* Calculate percentiles for identifying outliers */
/* Calculate percentiles for identifying outliers */
proc univariate data=airquality;
	var ozone;
	output out=Outliers pctlpre=PctlPre pctlpts=5 to 95 by 5;
run;

/* Calculate IQR and upper/lower bounds for identifying outliers */
data Outliers;
	set Outliers;
	IQR = PctlPre75 - PctlPre25;
	LowerBound = PctlPre25 - 1.5 * IQR;
	UpperBound = PctlPre75 + 1.5 * IQR;
	drop PctlPre5 PctlPre25 PctlPre75 PctlPre95;
run;

/****************************************************************************************
 *****************************************************************************************
 *****************************************************************************************/

/* Part 2 - Solution 2 - a */






