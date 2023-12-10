/*a. Write a DATA step to read in these values. Choose your own variable names. Be sure that the

value for Gender is stored in 1 byte and that the four test scores are numeric.*/




data subjectscores;

infile"/home/u63416648/score/scores.txt" ;
input @1 gender $1.
      @2 english
      @5 history 
      @8 math 
      @11 science ;
      
      run;
      
      
/*    @n is the coloumn position of the variable*/.  


/*b. Include an assignment statement computing the average of the four test scores*/
  
proc print data=subjectscores;
run;  


  
data subjectscores ;
set subjectscores;
 english =coalesce(english,0);
 history =coalesce(history,0);
 math = coalesce(math,0);
 science=coalesce(science,0);
 average= mean(english,history,math,science);
 run;
 
proc print data=subjectscores;

run; 
 
      /*here we are using the coalesce for handling missing values. It replaces missing values with 0 for the variables mentioned;
      mean is the function used for taking averages*/
     
     

/*c. Write the appropriate PROC PRINT statements to list the contents of this data set.*/
proc contents    data=subjectscores;
run; 
/*proc contents is used to display the contents of the dataset*/


/*problem 2*/


DATA Company;
  INFILE '/home/u63416648/score/company2.txt' delimiter="$" dsd;
  INPUT LastName $ EmpNo $ Salary;
  if salary ='' then salary=0;
  if  EmpNo ='' then EmpNo =0;
RUN;

proc print data=company;
run;

/*here we used delimiter function to read the data as separate by sign $
  */


/*problem3*/





DATA output;
  INPUT X Y;
  Z = 100 + 50*X + 2*X**2 - 25*Y + Y**2;
DATALINES;
1 2
3 6
5 9
9 11
;
RUN;

PROC PRINT data=output;
RUN;






      
      
      
      
      
      