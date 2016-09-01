* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "W:\BM-HE-Autos\build\output\mrgdPsid.dta"

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
