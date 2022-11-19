{smcl}
{* 	*! version 1.0  23 May Dec2022}{...}
{cmd:help myreg3} 
{hline}

{title:Title}

{p2colset 5 12 16 2}{...}
{p2col :{hi:myreg3} {hline 2}}Table 3 in epidemiological journal{p_end}
{p2colreset}{...}


{title:Syntax}
{p 8 16 2}{cmd:myreg3}, dp({it:decimal points}) ci({it:symbom for CI}) 

{p 4 4 2}{it:dp} refers to the decimal points you want. {it:ci} refers to the symbol of 95%CI (such as , -, to).


{title:Description}

{pstd}
{cmd:myreg3} exports regression results to a Word document after the collection command in Stata 17. It is designed for creating Table 3 in epidemiological journals. 
It produces a table of subgroup analyses results from regression model. To run myreg3, there are four global macros need to be defined first: 1. groupvar (subgroup variables); 2. xvar (main exposure variable); 3. covar (covariates used in the model); 4. model (The model should be built based on the previous three global macros. It can be any model which stores results in etable, such as linear regresion, logistic regression, Cox regression etc).   

{title:Remarks}

{pstd}
It is designed for creating Table 3 in nutritional epidemiological research.


{title:Example: Basic use}

{pstd}The following syntax create a subgroup analyses table for the association between quartiles of serum iron and diabetes {p_end}
{tab}{cmd:. webuse nhanes2, clear}
{tab}{cmd:. xtile  iron4c = iron, nq(4)}
{tab}{cmd:. lab define qtl 1 "Q1" 2 "Q2" 3 "Q3" 4 "Q4"}
{tab}{cmd:. lab val iron4c qtl}
{tab}{cmd:. lab var iron4c "Quartiles of iron" }

{pstd}Setup four global macros to be used in myreg3 {p_end}
{tab}{cmd:. global groupvar "race sex region"}
{tab}{cmd:. global xvar      "iron4c"}
{tab}{cmd:. global covar    "age sex bmi i.highbp "  }
{tab}{cmd:. global model    "logistic diabetes i.$xvar $covar" }

{pstd}Generate Table3 {p_end}
{tab}{cmd:. myreg3,dp(2) ci(-)}
{pstd}Save Table3 to a word document {p_end}
{tab}{cmd:. putdocx save MyTable3.docx, replace}



{title:Author}

{pstd}
Professor Zumin Shi, 
Department of Human Nutrition, 
College of Health Sciences, QU Health, 
Qatar University, Qatar. 
(zumin.shi@gmail.com)
