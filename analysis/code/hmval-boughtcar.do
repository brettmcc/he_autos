* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "D:\he_autos\build\output\mrgdPsid.dta"

local allcontrols = "i.headrace i.headmarital i.headedu famsize mtg2 hmval faminc have_stock"
local hmvalvar = "hmvalchg2yrsback hmvalincr2yrsback hmvalincr2yrsback_gt2pct"
local hmvalvarlag = " hmvalchg2yrsback_lag1 hmvalincr2yrsback_lag1 hmvalincr2yrsback_gt2pct_lag1"
local vehvar = "vehboughtinlast2yrs newvehboughtinlast2yrs newvehboughtinlast2yrs_dummy"

*Run regressions using all the different specifications for (1) car purchases and (2) home value changes
!del D:\he_autos\analysis\output\hmval-boughtcar.csv
foreach hvar in `hmvalvar' {
	if "`hvar'"=="hmvalchg2yrsback" local hvarnum = 1 
	else if "`hvar'"=="hmvalincr2yrsback" local hvarnum = 2
	else if "`hvar'"=="hmvalincr2yrsback_gt2pct" local hvarnum = 3
	foreach vvar in `vehvar' {
		if "`vvar'"=="vehboughtinlast2yrs" local vehvarnum = 1 
		if "`vvar'"=="newvehboughtinlast2yrs" local vehvarnum = 2 
		if "`vvar'"=="newvehboughtinlast2yrs_dummy" local vehvarnum = 3
		display "`vehvarnum'"
		forval y = 2001(2)2011 {
			quietly reg `vvar' `hvar' if year==`y' [aweight=WGT] 
			estimates store reg_`vehvarnum'_`hvarnum'_`y'
		}
	}
	esttab reg_*_`hvarnum'_*  using "D:\he_autos\analysis\output\hmval-boughtcar.csv", ///
		star(* .1 ** .05 *** .01) csv append title(`vvar') drop(_cons) nonumbers ///
		mtitles("2001" "2003" "2005" "2007" "2009" "2011" "2001" "2003" ///
			"2005" "2007" "2009" "2011" "2001" "2003" "2005" "2007" "2009" "2011") title(unlagged and no controls)
}

*same as above but now using lagged home value change variables 
foreach hvar in `hmvalvarlag' {
	if "`hvar'"=="hmvalchg2yrsback" local hvarnum = 1 
	else if "`hvar'"=="hmvalincr2yrsback" local hvarnum = 2
	else if "`hvar'"=="hmvalincr2yrsback_gt2pct" local hvarnum = 3
	foreach vvar in `vehvar' {
		if "`vvar'"=="vehboughtinlast2yrs" local vehvarnum = 1 
		if "`vvar'"=="newvehboughtinlast2yrs" local vehvarnum = 2 
		if "`vvar'"=="newvehboughtinlast2yrs_dummy" local vehvarnum = 3
		display "`vehvarnum'"
		forval y = 2003(2)2011 {
			quietly reg `vvar' `hvar' if year==`y' [aweight=WGT] 
			estimates store reg_`vehvarnum'_`hvarnum'_`y'
		}
	}
	esttab reg_*_`hvarnum'_*  using "D:\he_autos\analysis\output\hmval-boughtcar.csv", ///
		star(* .1 ** .05 *** .01) csv append title(`vvar') drop(_cons) nonumbers ///
		mtitles("2001" "2003" "2005" "2007" "2009" "2011" "2001" "2003" ///
			"2005" "2007" "2009" "2011" "2001" "2003" "2005" "2007" "2009" "2011") title(Lagged variables and no controls)
}


local allcontrols = "i.headrace i.headmarital i.headedu famsize mtg2 hmval faminc have_stock"
local hmvalvar = "hmvalchg2yrsback hmvalincr2yrsback hmvalincr2yrsback_gt2pct"
local hmvalvarlag = " hmvalchg2yrsback_lag1 hmvalincr2yrsback_lag1 hmvalincr2yrsback_gt2pct_lag1"
local vehvar = "vehboughtinlast2yrs newvehboughtinlast2yrs newvehboughtinlast2yrs_dummy"

*Run regressions using all the different specifications for (1) car purchases and (2) home value changes with control variables
!del D:\he_autos\analysis\output\hmval-boughtcar-controls.csv
foreach hvar in `hmvalvar' {
	if "`hvar'"=="hmvalchg2yrsback" local hvarnum = 1 
	else if "`hvar'"=="hmvalincr2yrsback" local hvarnum = 2
	else if "`hvar'"=="hmvalincr2yrsback_gt2pct" local hvarnum = 3
	display "`hvarnum'"
	foreach vvar in `vehvar' {
		if "`vvar'"=="vehboughtinlast2yrs" local vehvarnum = 1 
		if "`vvar'"=="newvehboughtinlast2yrs" local vehvarnum = 2 
		if "`vvar'"=="newvehboughtinlast2yrs_dummy" local vehvarnum = 3
		display "`vehvarnum'"
		forval y = 2001(2)2011 {
			quietly reg `vvar' `hvar' `allcontrols' if year==`y' [aweight=WGT] 
			estimates store reg_`vehvarnum'_`hvarnum'_`y'
		}
	}
	esttab reg_*_`hvarnum'_*  using "D:\he_autos\analysis\output\hmval-boughtcar-controls.csv", ///
		star(* .1 ** .05 *** .01) csv append title(`vvar') keep(`hvar') nonumbers ///
		mtitles("2001" "2003" "2005" "2007" "2009" "2011" "2001" "2003" ///
			"2005" "2007" "2009" "2011" "2001" "2003" "2005" "2007" "2009" "2011") title(unlagged with controls)
}

*same as above but now using lagged home value change variables and with controls
foreach hvar in `hmvalvarlag' {
	if "`hvar'"=="hmvalchg2yrsback" local hvarnum = 1 
	else if "`hvar'"=="hmvalincr2yrsback" local hvarnum = 2
	else if "`hvar'"=="hmvalincr2yrsback_gt2pct" local hvarnum = 3
	display "`hvarnum'"
	foreach vvar in `vehvar' {
		if "`vvar'"=="vehboughtinlast2yrs" local vehvarnum = 1 
		if "`vvar'"=="newvehboughtinlast2yrs" local vehvarnum = 2 
		if "`vvar'"=="newvehboughtinlast2yrs_dummy" local vehvarnum = 3
		display "`vehvarnum'"
		forval y = 2003(2)2011 {
			quietly reg `vvar' `hvar' `allcontrols' if year==`y' [aweight=WGT] 
			estimates store reg_`vehvarnum'_`hvarnum'_`y'
		}
	}
	esttab reg_*_`hvarnum'_*  using "D:\he_autos\analysis\output\hmval-boughtcar-controls.csv", ///
		star(* .1 ** .05 *** .01) csv append title(`vvar') keep(`hvar') nonumbers ///
		mtitles("2001" "2003" "2005" "2007" "2009" "2011" "2001" "2003" ///
			"2005" "2007" "2009" "2011" "2001" "2003" "2005" "2007" "2009" "2011") title(Lagged variables with controls)
}



/*
local allcontrols = "i.year i.headrace i. headmarital i.headedu famsize mtg2 hmval faminc have_stock"

reg vehboughtinlast2yrs hmvalchg2yrsback `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalchg2yrsback_lag1 `allcontrols' if pid==pid[_n-1] [aweight=WGT] 
reg vehboughtinlast2yrs hmvalincr2yrsback_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]

reg newvehboughtinlast2yrs hmvalchg2yrsback `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs hmvalincr2yrsback `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs hmvalincr2yrsback_gt2pct `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs hmvalchg2yrsback_lag1 `allcontrols' if pid==pid[_n-1] [aweight=WGT] 
reg newvehboughtinlast2yrs hmvalincr2yrsback_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]
reg newvehboughtinlast2yrs hmvalincr2yrsback_gt2pct_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]

local allcontrols = "i.year i.headrace i. headmarital i.headedu famsize mtg2 hmval faminc have_stock"

reg newvehboughtinlast2yrs_dummy hmvalchg2yrsback `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs_dummy hmvalincr2yrsback `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs_dummy hmvalincr2yrsback_gt2pct `allcontrols' [aweight=WGT]
reg newvehboughtinlast2yrs_dummy hmvalchg2yrsback_lag1 `allcontrols' if pid==pid[_n-1] [aweight=WGT] 
reg newvehboughtinlast2yrs_dummy hmvalincr2yrsback_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]
reg newvehboughtinlast2yrs_dummy hmvalincr2yrsback_gt2pct_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]
