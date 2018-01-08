**TWINS STUDY: 
gen exp = age - educ - 6
**-6 adjusts for first 6 years of life not in school
gen exp2 = (exp)^2
gen lnhourlywage = ln(hourlywage)
reg lnhourlywage educ exp exp2
**Run Regression below for fixed effects twin invariant characteristics
reg lnhourlywage educ exp exp2 i.id

**CARD STUDY:
gen lnwage = log(wage)
gen exper2 = exper^2
* to recreate Table 2 Column 2 page 34
reg lnwage educ exper exper2 black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 

**Table 3 A column 1
**Only proximity to a 4 year college determined
reg educ nearc4 black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 exper exper2
gen lnwage = ln(wage)
ivreg lnwage (educ=nearc4) black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 exper exper2

**CHILE Data Set
reg mathscore motherschooling indigenous
reg mathscore indigenous
gen mult = motherschooling*indigenous
reg mathscore motherschooling indigenous mult
**Get Graph mathscore & interaction term
twoway (lfit mathscore motherschooling if indigenous==0) (lfit mathscore motherschooling if indigenous==1)


