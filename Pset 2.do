**QUESTION 1
tab ssex if stark==1 & cltypek==1
tab ssex if stark==1 & cltypek==2
tab ssex if stark==1 & cltypek==3

**For white/asian add up frequency of white + asian
tab srace if stark==1 & cltypek==1
tab srace if stark==1 & cltypek==2
tab srace if stark==1 & cltypek==3

**Generate dummy variables
gen smallclass= (cltypek==1)
gen regularandaide= (cltypek==3)
gen whiteorasian= (srace==1 | srace==3)
gen girl= (ssex==2)
gen freelunch= (sesk==1)
gen whiteteacher= (trace1==1)
gen black= (srace==2)

areg whiteorasian smallclass regularandaide, absorb(schidk)
testparm smallclass regularandaide
**p-value of .66
areg freelunch smallclass regularandaide, absorb(schidk)
testparm smallclass regularandaide
**p-value of .46
areg girl smallclass regularandaide, absorb(schidk)
testparm smallclass regularandaide

**Generate percentile
xtile mathscore = tmathssk, n(100)
xtile readingscore = treadssk, n(100)

egen avgscorepercentile = rmean(mathscore - readingscore)

_________________________
**QUESTION 2:
**Replace missing values
replace cltypek=. if cltypek==9
replace srace=. if srace==9
replace ssex=. if ssex==9
replace sesk=. if sesk==9
replace tracek=. if tracek==9
replace hdegk=. if hdegk==9
replace totexpk=. if totexpk==99
replace schidkn=. if schidkn==999
replace tmathssk=. if tmathssk==999
replace treadssk=. if treadssk==999

reg avgscorepercentile smallclass regularandaide, cluster(schidk)
reg avgscorepercentile smallclass regularandaide i.schidk, cluster(schidk)
reg avgscorepercentile smallclass regularandaide whiteorasian girl freelunch i.schidk, cluster(schidk)
reg avgscorepercentile smallclass regularandaide whiteorasian girl freelunch whiteteacher totexpk i.schidk, cluster(schidk)

gen teacherofownrace=0
replace teacherofownrace=1 if srace==1 & tracek==1
replace teacherofownrace=1 if srace==2 & tracek==2

**QUESTION 4:
drop if srace==3 | srace==4 | srace==5 | srace==6
drop if tracek==3 | tracek==4 | tracek==5 | tracek==6
drop if stark==2
drop if tmathssk==.
drop if treadssk==.

reg teacherofownrace smallclass black girl freelunch i.schidk if stark==1, cluster(schidk)
reg teacherofownrace smallclass black girl freelunch i.schidk, cluster(schidk)

Linear regression                               Number of obs     =      6,295
                                                F(3, 78)          =          .
                                                Prob > F          =          .
                                                R-squared         =     0.4981
                                                Root MSE          =     .30349

                               (Std. Err. adjusted for 79 clusters in schidkn)
------------------------------------------------------------------------------
             |               Robust
teacherofo~e |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
  smallclass |  -.0045508   .0370871    -0.12   0.903    -.0783856     .069284
       black |  -.5756009   .1352133    -4.26   0.000    -.8447899   -.3064119
        girl |  -.0013368   .0094745    -0.14   0.888    -.0201991    .0175255
   freelunch |  -.0002994   .0102846    -0.03   0.977    -.0207745    .0201757
