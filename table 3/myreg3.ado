********************************************************************
*The program export a set of regression results
*the basic syntax is myreg3
*four set-ups are needed before running the command
*global groupvar, xvar, covar, model 
*example myreg3
*it will export cofficients (95%CI) for the sepcified xvar 
*! Author: Zumin Shi, Qatar University, zumin.shi@gmail.com
*********************************************************************

capture program drop myreg3
program myreg3      //Version of mgreg3.ado
version 17      //stata version 17
*syntax args first second  
syntax  , dp(real) ci(string)
*create my own table style
qui collect clear
*collect style use table-reg1-fv1
*collect style use table-reg3-fv1 //Concise format, without CI
qui collect style header result, level(hide)   //hide coef 95%CI
qui collect style column,dups(center)
qui collect style autolevels result _r_b _r_ci,clear

capture collect composite drop myci
qui collect composite define myci = _r_lb _r_ub, delimiter("`ci'") 
qui collect style cell result[myci], nformat(%9.2f) sformat("(%s)")

capture collect composite drop coefci2
qui collect composite define coefci2 = _r_b myci, trim override 
qui collect style cell result[coefci2], nformat(%9.2f)

*qui collect style cell result[_r_ci], sformat("(%s)") cidelimiter(" -")
qui collect style cell, border(right, pattern(nil)) 
qui collect style cell, nformat(%5.2f) font(times new roman)
quiet collect style save myreg, replace

*create subgroup anaylses tables
foreach xv in $groupvar {
 qui table (`xv') (colname[`xvar']), command($model) style(myreg) nototal name(`xv')
	
}


*combine three tables into one
qui collect combine newca = $groupvar 
qui collect layout ($groupvar) ((colname[$xvar])#result[coefci2])   //format the layout of the results
*collect layout (region race sex) ((colname[2.iron4c 3.iron4c 4.iron4c])#result) //remove the reference group: Q1

*qui collect label levels result _r_b "OR", modify
*qui collect label levels result _r_ci "(__LEVEL__% CI)", modify

*add header of stratification variables
foreach xvar in $groupvar {
	collect style header `xvar', title(label)
}


*export to word
qui putdocx clear 
qui putdocx begin,landscape
qui putdocx paragraph
qui putdocx text (" ")
collect style cell, nformat(%9.`dp'f)
collect style putdocx, layout(autofitcontents) 
collect preview
putdocx collect

capture erase myreg.stjson
end