
//summarystastic and regression
//table1
use ASIF,clear
drop if lnrd==.
logout,word save(table1) replace : ///
su lnrd lnTFP lnTFP_domshare lnTFP_acf lnTFP_acf_domshare markup age subsidy_dum lnsize lnprofit ex_dum finance_dum lndebt ,format
//table2
use ASIF,clear
xtset id year
xtreg lnrd lnTFP dom10 dom11, fe r nonest
est sto a1
xtreg lnrd lnTFP subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a2
xtreg lnrd lnTFP markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a3
xtreg lnrd lnTFP_domshare dom10 dom11, fe r nonest
est sto a4
xtreg lnrd lnTFP_domshare subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a5
xtreg lnrd lnTFP_domshare markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a6
esttab a1 a2 a3 a4 a5 a6, replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP_domshare lnTFP markup markup_sq subsidy_dum) drop(dom*) compress nogaps,using table2.rtf

//table3
xtreg lnrd  lnTFP markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a1
xtdpdsys lnprofit lnTFP markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , lags(1)
est sto a2
xtreg lnrd  lnprofit lnTFP markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a3
xtreg lnrd  lnTFP_domshare markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a4
xtdpdsys lnprofit lnTFP_domshare markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , lags(1)
est sto a5
xtreg lnrd  lnprofit lnTFP_domshare markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a6
esttab a1 a2 a3 a4 a5 a6, replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnprofit lnTFP_domshare lnTFP markup markup_sq subsidy_dum) drop(dom*) compress nogaps,using table3.rtf

//table4
drop if lnrd==.
xtset id year
xtreg lnrd lnTFP c.markup#c.lnTFP  c.markup_sq#c.lnTFP age age2 lnsize ex_dum finance_dum lndebt dom10 dom11,fe r nonest 
est sto a1
xtreg lnrd lnTFP markup markup_sq c.subsidy_dum#c.lnTFP  age age2   lnsize ex_dum finance_dum lndebt dom10 dom11,fe r nonest   
est sto a2
xtreg lnrd  lnTFP_domshare c.markup#c.lnTFP_domshare  c.markup_sq#c.lnTFP_domshare age age2 lnsize ex_dum finance_dum lndebt dom10 dom11,fe r nonest 
est sto a3
xtreg lnrd  lnTFP_domshare markup markup_sq c.subsidy_dum#c.lnTFP_domshare  age age2   lnsize ex_dum finance_dum lndebt dom10 dom11,fe r nonest  
est sto a4
esttab a1 a2 a3 a4,replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order( lnTFP lnTFP_domshare markup markup_sq ) drop(dom*) compress nogaps,using table4.rtf

//table5
use ASIF,clear
xtivreg2 lnrd markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10  (lnTFP_domshare=L2.lnTFP_domshare), fe 
est store a1
ivreg2h lnrd markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum L.lnprofit  (lnTFP_domshare=),fe
est store a2 
esttab a1 a2  , replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP_domshare markup markup_sq subsidy_dum) drop(dom*) compress nogaps,using table5.rtf 
use ASIF,clear
ivreg2h lnrd markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 (lnTFP_domshare=l1.lnTFP_domshare),fe 
est store a3
esttab a3, replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP_domshare ) compress nogaps,using table5.rtf, append 
use ASIF,clear
xtivreg2 lnrd markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt  dom10 (lnTFP=L2.lnTFP), fe 
est store a4
ivreg2h lnrd markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum L.lnprofit  (lnTFP=),fe
est store a5 
esttab a4 a5  , replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP markup markup_sq subsidy_dum) drop(dom*) compress nogaps,using table5.rtf, append 
use ASIF,clear
ivreg2h lnrd markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10  (lnTFP=L2.lnTFP),fe 
est store a6
esttab a6, replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP ) compress nogaps,using table5.rtf, append 

//table6
use ASIF,clear
drop if lnrd==.
xtset id year
winsor2 lnrd  ,cuts(1 99) replace
xtreg lnnew lnTFP subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a1
xtreg lnnew lnTFP markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a2
xtreg lnnew lnTFP_domshare subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a3
xtreg lnnew lnTFP_domshare markup markup_sq subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a4
xtreg lnrd lnTFP_acf subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a5
xtreg lnrd lnTFP_acf markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a6
xtreg lnrd lnTFP_acf_domshare subsidy_dum age age2 lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a7
xtreg lnrd lnTFP_acf_domshare markup markup_sq subsidy_dum age age2  lnsize ex_dum finance_dum lndebt dom10 dom11 , fe r nonest
est sto a8
esttab a1 a2 a3 a4 a5 a6 a7 a8, replace scalar(N r2) sfmt(%20.0f %6.3f) b(%6.3f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01) order(lnTFP_acf_domshare lnTFP_acf markup markup_sq subsidy_dum) drop(dom*) compress nogaps,using table6.rtf



