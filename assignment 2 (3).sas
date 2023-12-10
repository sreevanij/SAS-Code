
/*Question1.
- What is the null and alternate hypotheses?
Answer:
Null Hypothesis (H0): Parental level of education and lunch do not affect math scores.
Alternate Hypothesis (H1): Parental level of education and/or lunch affect math scores.*/
/* Import the dataset */
options validvarname=v7;
proc import datafile="/home/u63416648/assignment 2 ban100/exams.csv" dbms=csv
out=exams_hq replace;
getnames=yes;
run;
/*convert math_score to numeric*/
data exams_hq;
set exams_hq;
math_score_numeric=input(math_score, best12.);
drop math_score;
rename math_score_numeric=math_score;
run;
/*perform ANOVA test*/
proc glm data=exams_hq;
class parental_level_of_education lunch;
model math_score=parental_level_of_education lunch
parental_level_of_education*lunch;
means parental_level_of_education lunch;
run;

/*- What are the results from the test or tests and what is your conclusion?
Answer:


1. The analysis shows that the parental level of education has a significant effect on math scores as indicated by a p-value less than 0.05. 
Therefore, we reject the null hypothesis and conclude that parental level of education significantly influences math scores.

2. Based on the results, it can be concluded that lunch significantly impacts math scores since the p-value is less than 0.05, 
leading to the rejection of the null hypothesis regarding the effect of lunch on math scores.

3. The analysis suggests that there is no significant interaction between parental level of education and lunch regarding their effect on math scores.
 This conclusion is drawn from a p-value greater than 0.05, failing to reject the null hypothesis. 
 Therefore, we do not find evidence to support a significant interaction between parental level of education and lunch in relation to math scores.
........................................................................................................................................

*2Q*/

Data sales_vg;
Infile "/home/u63416648/assignment 2 ban100/vgsales.csv" dlm=',' firstobs=2;


input rank $
name $
platform $
year $
genre $
publisher $
na_sales ??
eu_sales ??
jp_sales ??
other_sales ??
global_sales ??;
run;



/*perform ANOVA test*/
proc glm data=sales_vg;
class platform year;
model global_sales=platform year platform*year;
means platform year;
run;

/*What are the null and alternate hypotheses (which groups did you pick from what
variable)?
Answer: The null hypothesis (H₀) states that there is no significant difference in global sales when considering different platforms, years, or their interaction. 
The alternate hypothesis (H₁) states that there is a significant difference in global sales across different platforms, years, or their interaction. 
In this test, the independent variables chosen are platform and year, while the dependent variable is global sales.



- How did you test for interaction between groups and what are the results?
Answer: To assess the interaction between groups (platform and year) and its impact on the dependent variable (global sales),
 a two-way ANOVA was conducted. The purpose of this analysis was to determine 
 if there is a statistically significant relationship between global sales and the groups (platform and year). 
 The results of the analysis would provide insight into whether the interaction between platform, year, and global sales is significant or not.
 
 What are the results from the test and what is your conclusion?
According to the output, the p-value for the interaction term (platformyear) is greater than 0.05. 
Therefore, we fail to reject the null hypothesis, 
indicating that there is no significant interaction between platform and year in their effect on the dependent variable (global sales).

Based on this result, we conclude that the combined effect of platform and year does not have a significant impact on global sales. 
The individual main effects of platform and year on global sales may still be significant, 
but their interaction does not contribute significantly to the variation in global sales.
 */













