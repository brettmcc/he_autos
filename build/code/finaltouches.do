* Brett McCully, August 2016
* Finish prepping PSID dataset for analysis

log using "E:\he_autos\build\temp\finaltouches.log", replace

set more off
clear all

use "E:\he_autos\build\temp\mrgdpsid.dta", clear
forval y = 2001(2)2013 {
	local y2back = `y' - 2
	gen hmvalchg2yrsback`y' = hmval`y' - hmval`y2back' if soldHome`y'!=. & soldHome`y'!=1
	gen hmvalincr2yrsback`y' = (hmvalchg2yrsback`y'>0) if hmvalchg2yrsback`y'!=.
	gen hmvalincr2yrsback_gt2pct`y' = (((hmval`y' - hmval`y2back')/hmval`y2back'-1)>.02) if ((hmval`y' - hmval`y2back')/hmval`y2back'-1)!=.
}

local vars = "hmowner secMtg hmval vehboughtinlast2yrs headrace hmvalchg2yrsback headmarital WGT headedu famsize hmvalincr2yrsback hmvalincr2yrsback_gt2pct faminc have_stock newvehboughtinlast2yrs"
reshape long `vars', i(pid) j(year)
keep pid year `vars'
gen hmvalchg2yrsback_lag1 = hmvalchg2yrsback[_n-1]
gen hmvalincr2yrsback_lag1 = hmvalincr2yrsback[_n-1]
gen hmvalincr2yrsback_gt2pct_lag1 = hmvalincr2yrsback_gt2pct[_n-1]

/*Individuals cannot change race or get less educated*/
count if headrace!=headrace[_n-1] & headrace!=. & headrace[_n-1]!=. & pid==pid[_n-1]
count if headrace!=headrace[_n+1] & headrace!=. & headrace[_n+1]!=. & pid==pid[_n+1]
count if headedu<headedu[_n-1] & headedu!=. & headedu[_n-1]!=. & pid==pid[_n-1]
count if headedu>headedu[_n+1] & headedu!=. & headedu[_n+1]!=. & pid==pid[_n+1]

*drop from 2013 since it has an anomalously lower rate of bought car in last 2 years
drop if year==2013

*make second mortgage variable a dummy for whether or not individual has one, assuming dont know or 
*refused responses indicate the respondent doesnt have one;
gen mtg2 = (secMtg==1) if hmowner==1
gen newvehboughtinlast2yrs_dummy = (newvehboughtinlast2yrs >0 & newvehboughtinlast2yrs != . )
drop secMtg


label define race 1 "White" 2 "Black" 3 "Other"
label define marital 1 "Married" 2 "Single" 3 "Widowed" 4 "Divorced" 5 "Separated"
label define edu 1 "high school dropout" 2 "high school grad" 3 "Some college" 4 "college grad or more"
label define hmown 1 "Homeowner" 5 "Rents" 8 "Neither owns/rents"
label values headrace race
label values headmarital marital
label values headedu edu
label values hmowner hmown

save "E:\he_autos\build\output\mrgdPsid.dta", replace

log close
