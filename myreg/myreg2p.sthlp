{smcl}
{* 	*! version 1.0  1 May Dec2022}{...}
{cmd:help myreg2p} 
{hline}

{title:Title}

{p2colset 5 12 16 2}{...}
{p2col :{hi:myreg2p} {hline 2}}Table 2 in epidemiological journal{p_end}
{p2colreset}{...}


{title:Syntax}
{p 8 16 2}{cmd:myreg2a} {it:indepvars} 



{title:Description}

{pstd}
{cmd:myreg2p} exports p for trend to a Word document after the collection command in Stata 17. It is designed for creating Table 2 in epidemiological journals. 
It combines p for trend of a specific variables from multiple models into one Table.


{title:Remarks}

{pstd}
It is designed for creating Table 2 in nutritional epidemiological research.


{title:Example: Basic use}

{pstd}The following syntax collect odds ratio (95%CI) of smoking for low birth from three logistic regression models{p_end}
{tab}{cmd:. collect: webuse lbw, clear}
{tab}{cmd:. collect clear}
{tab}{cmd:. collect:logistic low i.smoke}
{tab}{cmd:. collect:logistic low i.smoke i.race}
{tab}{cmd:. collect:logistic low i.smoke i.race age}
{tab}{cmd:. myreg2p smoke}
{tab}{cmd:. putdocx save mytable2.docx,append}


{title:Example. Basic use}


{p 4 4 6}You should specify the directory where all the files will be stored when you use putdocx save command. 
{p 4 4 6}You can append the results after using myreg2 command so that it is easy to make a complete Table 2 in Word. 

{p 4 10 8}cd "C:\Users\yourname\Documents\"    /* or whatever your directory may be */{p_end}
{p 4 10 8}{stata webuse lbw,clear}{p_end}
{p 4 10 8}{stata collect clear}{p_end}
{p 4 10 8}{stata collect: logistic low i.smoke}{p_end}
{p 4 10 8}{stata collect: logistic low i.smoke age}{p_end}
{p 4 10 8}{stata myreg2a,dp(2) ci(-)}{p_end}
{p 4 10 8}{stata putdocx save mytable2.docx,append}{p_end}


{title:Author}

{pstd}
Zumin Shi, 
Department of Human Nutrition, 
College of Health Sciences, QU Health, 
Qatar University, Qatar. 
(zumin.shi@gmail.com)
