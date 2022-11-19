********************************************************************
*The program export a set of regression results
*the basic syntax is myreg2 xvar,dp(2) ci(-)
*example myreg2 iron4c,dp(2) ci(-)
*it will export regression results for iron4c 
*! Author: Zumin Shi, Qatar University, zumin.shi@gmail.com
*********************************************************************



capture program drop myreg2

program myreg2, rclass      //Version of myreg2.ado
syntax varlist , dp(real) ci(string)

version 17      //stata version 17

* di "`varlist'"
* di `dp'

*syntax args first second

*collect style use table-reg3-fv1

qui collect style autolevels result _r_b _r_ci,clear

capture collect composite drop myci

collect composite define myci = _r_lb _r_ub, delimiter("`ci'") 

collect style cell result[myci], nformat(%9.2f) sformat("(%s)")

capture collect composite drop coefci2

collect composite define coefci2 = _r_b myci, trim override 

collect style cell result[coefci2], nformat(%9.2f)

qui collect style header result, level(hide)   //hide coef 95%CI

qui collect style column,dups(center)

qui collect style cell, border(right, pattern(nil)) font(times new roman)

qui collect label values cmdset 1 "Model 1" 2 "Model 2" 3 "Model 3" 4 "Model 4" 5 "Model 5"

*collect layout (cmdset#result)(colname[cmegg4c])

qui collect layout (cmdset)(colname[`varlist']#(result[coefci2]))  

*export to word

qui putdocx clear

qui putdocx begin,landscape

qui putdocx paragraph

qui putdocx text (" ")

collect style putdocx, layout(autofitcontents)

collect style cell, nformat(%9.`dp'f)

putdocx collect

collect preview

end