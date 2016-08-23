* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "W:\BM-HE-Autos\build\output\mrgdPsid.dta"

local allcontrols = "i.year i.headrace i. headmarital i.headedu famsize mtg2 hmval"

reg vehboughtinlast2yrs hmvalchg2yrsback `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct `allcontrols' [aweight=WGT]
reg vehboughtinlast2yrs hmvalchg2yrsback_lag1 `allcontrols' if pid==pid[_n-1] [aweight=WGT] 
reg vehboughtinlast2yrs hmvalincr2yrsback_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct_lag1 `allcontrols' [aweight=WGT] if pid==pid[_n-1]


reg vehboughtinlast2yrs hmvalchg2yrsback i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalchg2yrsback i.year i.headrace [aweight=WGT]


reg vehboughtinlast2yrs hmvalincr2yrsback i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback i.year i.headrace [aweight=WGT]

reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct i.year i.headrace [aweight=WGT]
