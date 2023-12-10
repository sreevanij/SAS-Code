/*task 1*/
/*printing the database of both the tasks*/
/*data of parda(italy)*/

data parda;

input time ;

datalines;
12.9 
12.5 
11.0 
13.3 
11.2 
11.4 
11.6 
12.3 
14.2 
11.3
;
run;


/*run the dataset for parda*/
proc print data=parda;
run;

/*data of oracle*/

data oracle;

input time ;

datalines;
14.1
14.1 
14.2 
17.4 
15.8 
16.7 
16.1 
13.3 
13.4 
13.6 
10.8 
19.0
;
run;

/*run the dataset for oracle*/

proc print data=oracle;
run;

/*descriptive analysis time*/

proc means data=parda mean median mode std max min range; 
var time ;
run;

proc means data=oracle mean median mode stddev max min range std;
var time ;
run;

/*hypothesis testing */
h0 = mu = 13
h1 <> 13;

proc ttest data=parda side = 2 alpha = 0.05 h0=13;
run;

proc ttest data=oracle side = 2 alpha = 0.05  h0=13;
run;


/*task 2*/
/* Create the dataset with the sample data */
data customer_spending;
  input amount;
  datalines;
17.58 
19.73 
12.61 
17.79 
16.22 
15.82 
15.40 
15.86 
11.82 
15.85 
18.19 
20.22
17.38 
17.96 
23.92 
15.87 
16.47 
15.96 
16.79 
16.74 
21.40 
20.57 
19.79 
14.83
;
run;

proc print data=customer_spending;
run;

proc means data=customer_spending mean median mode min max std  stddev min max;
var amount ;
run;

proc ttest data=customer_spending side = 2 alpha =0.05 h0=15;
var amount;
 
run;


task 3 







