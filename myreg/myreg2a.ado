

********************************************************************
*The program export a set of regression results
*the basic syntax is myreg2 xvar,dp(2) ci(-)
*example myreg2 iron4c,dp(2) ci(-)
*it will export regression results for iron4c 
*! Author: Zumin Shi, Qatar University, zumin.shi@gmail.com
*********************************************************************

capture program drop myreg2a

program myreg2a, rclass      //Version of myreg2.ado
syntax  , dp(real) ci(string)

version 17      //stata version 17

* di "`varlist'"
* di `dp'

collect style cell result[_r_b ], nformat(%5.`dp'f) halign(center)
collect style cell result[_r_ci], nformat(%9.`dp'f) sformat("(%s)") cidelimiter("`ci'")
qui capture collect composite drop myci
collect composite define myci = _r_lb _r_ub, delimiter("`ci'")
collect style cell result[myci], nformat(%9.`dp'f) sformat("(%s)")
*qui collect style header result, level(hide)   //hide coef 95%CI
qui capture collect composite drop coefci2
collect composite define coefci2 = _r_b myci, trim override
collect label levels result coefci2 "Coef. [__LEVEL__% CI]"
qui collect style cell, border(right, pattern(nil)) font(times new roman)
collect style cell result[_r_p], minimum(0.001) nformat(%5.3f)
collect style column, dups(center)
qui collect style row stack, nobinder delimiter(" x ")
collect label levels cmdset 1 "Model 1" 2 "Model 2" 3 "Model 3" 4 "Model 4" 5 "Model 5"
qui collect layout (colname) (cmdset#result[coefci2 _r_p])
*collect layout (colname) (cmdset#result[coefci2 ])   //without p value
 
 
 
*export to word

qui putdocx clear

qui putdocx begin,landscape

qui putdocx paragraph

qui putdocx text (" ")

collect style putdocx, layout(autofitcontents)

*collect style cell, nformat(%9.`dp'f)

putdocx collect

collect preview

 end