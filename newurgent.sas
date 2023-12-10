data 
/*data of both parda and oracle*/
/*data of parda(italy)*/

data boatsdata;

input boats $ times ;

datalines;
1 12.9 
1 12.5 
1 11.0 
1 13.3 
1 11.2 
1 11.4 
1 11.6 
1 12.3 
1 14.2 
1 11.3
2 14.1
2 14.1 
2 14.2 
2 17.4 
2 15.8 
2 16.7 
2 16.1 
2 13.3 
2 13.4 
2 13.6 
2 10.8 
2 19.0
;
run;

/*task 1 */
/*printing of data base of two boats prada and*/
proc print data=boatsdata;
run;

/*task1b*/
/*descriptive dataanalysis*/

proc means data=boatsdata mean median mode std max min range;

run;


/*task1c */

proc ttest data=boatsdata sides=2 alpha=0.05 h0=0;
class boats;
var times;
run;
/*based on the p value which is less than alpha value ,so null hypothesis is rejected */









