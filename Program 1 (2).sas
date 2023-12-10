
FILENAME REFFILE '/home/u63416648/assignment 2 ban100/exams.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;


PROC CONTENTS DATA=WORK.IMPORT; RUN;




PROC ANOVA DATA=WORK.IMPORT;





PROC IMPORT DATAFILE="/home/u63416648/assignment 2 ban100/exams.csv"
     OUT=exam
     DBMS=CSV REPLACE;
     GETNAMES=YES;
RUN;

* Display the dataset;
PROC PRINT DATA=exam;
RUN;



...........
PROC GLM DATA=exam;
     CLASS parental_level_of_education lunch;
     MODEL math_score = parental_level_of_education lunch;
     MEANS parental_level_of_education lunch / HOVTEST;
RUN;




PROC ANOVA DATA=exam;
     CLASS parental_level_of_education lunch;
       MODEL math_score = parental_level_of_education lunch parental_level_of_education*lunch  ;
        MEANS parental_level_of_education lunch / tukey cldiff;
        run;
        
        
 * Your Name: John Smith;
* Import the "Exam" dataset;
PROC IMPORT DATAFILE="/home/u63416648/assignment 2 ban100/exams.csv"
     OUT=exam
     DBMS=CSV REPLACE;
     GETNAMES=YES;
    
RUN;


* Your Name: John Smith;

* Create a new dataset with renamed variables;
DATA exam_renamed;
   SET exam(rename=(
      gender = Gender
      "race/ethnicity"N = RaceEthnicity
      "parental level of education"N = ParentalEducation
      lunch = Lunch
      "test preparation course"N = TestPreparationCourse
      "math score"$N = MathScore
      "reading score"N = ReadingScore
      "writing score"N = WritingScore
   ));
RUN;

* Display the dataset with renamed variables;
PROC PRINT DATA=exam_renamed;
RUN;




* Conduct ANOVA to test the impact of parental level of education and lunch on math scores;
PROC anova DATA=exam_renamed;
     CLASS  ParentalEducation lunch;
     MODEL score= ParentalEducation lunch ParentalEducation*lunch;
RUN;
       