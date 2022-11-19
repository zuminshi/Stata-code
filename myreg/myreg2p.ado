********************************************************************
*The program export p values of a set of regression results
*the basic syntax is myreg2p xvar
*example myreg2 iron4c
*it will export regression results for iron4c 
*! Author: Zumin Shi, Qatar University, zumin.shi@gmail.com
*********************************************************************

capture program drop myreg2p
program myreg2p      //Version of getnhs.ado
version 17      //stata version 16
*syntax args first second  

collect style autolevels result _r_b _r_ci,clear
collect style cell result[_r_ci], sformat("(%s)") cidelimiter(" -")
collect style column,dups(center)
collect style cell, nformat(%5.3f)
collect style cell result[_r_p], minimum(0.001)
collect style cell, border(right, pattern(nil))
collect label values cmdset 1 "Model 1" 2 "Model 2" 3 "Model 3" 4 "Model 4" 5 "Model 5" 6 "Model 6"

*collect layout (cmdset#result)(colname[cmegg4c]) 
collect layout (cmdset)((colname[`1'])#result[_r_p ])
putdocx clear 
putdocx begin
putdocx paragraph
putdocx text (" ")
collect style putdocx, layout(autofitcontents) 
putdocx collect
end

 