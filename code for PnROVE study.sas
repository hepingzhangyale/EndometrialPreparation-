proc import datafile = 'C:\Users\wz\Desktop\sasdata\PnROVEoriginaldata.xlsx'
DBMS = excel replace out = wz;
run;
/*test for normality*/
proc univariate data=wz normal;  
class group;
var ageFET BMI interval duration SBP DBP AMH HCGEM oocyte FETEM gestationalage;
histogram/ normal (color=red mu=est sigma=est);
run;  

/*table 1-2*/
proc means data=wz;
class group;
var ageFET BMI SBP DBP HCGEM oocyte FETEM gestationalage;
run;
proc ttest;
class group;
var ageFET BMI SBP DBP HCGEM oocyte FETEM gestationalage;
run;
proc means data=wz median q1 q3 maxdec=2;
class group;
var interval duration AMH;
run;
proc npar1way wilcoxon;
class group;
var interval duration AMH;
run;
proc freq data=wz;
tables group*(agesub BMIsub G P cesarean HPdiagnosis priortransfer priorfail indication PGT fertilization cancellation EMBRYOnumber numberstage notransfer NatuConcet notransferyet)/chisq expected riskdiff RELRISK EXACT NOCOL NOPERCENT;
run;

/*table 3 for pregnancy outcomes*/
proc freq data=wz;
tables group*(healthyLB allpreeclampsia preeclampsia livebirth singlelivebirth twinlivebirth conception clinical ongoing totalloss bioloss clinicalloss earlyloss lateloss)/ chisq expected riskdiff RELRISK EXACT NOCOL NOPERCENT;
run;

/*table 4 for pregnancy complications*/
proc freq data=wz;
tables group*(ectopic GDM HDP hypertension preeclampsia chronichypertension chronicpreeclampsia earlypreeclampsia latepreeclampsia majorpreeclampsia minorpreeclampsia previa abruption accreta PROM stillbirth bleeding preterm CS)/ chisq expected riskdiff RELRISK EXACT NOCOL NOPERCENT;
run;

/*table 3 for birthweight*/
proc means data=wzbaby;
WHERE livenumber =1;
class group;
var birthweight;
run;
proc ttest data=wzbaby;
WHERE livenumber =1;
class group;
var birthweight;
run;
proc means data=wzbaby;
WHERE livenumber =2;
class group;
var birthweight;
run;
proc ttest data=wzbaby;
WHERE livenumber =2;
class group;
var birthweight;
run;

/*table 4 for neonatal complications*/
proc freq data=wzbaby;
tables group*(LGA SGA jaundice infection hospital death defect)/ chisq expected riskdiff RELRISK EXACT NOCOL NOPERCENT;
run;




