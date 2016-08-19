* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "W:\BM-HE-Autos\build\output\mrgdPsid.dta"

reg vehboughtinlast2yrs hmvalchg2yrsback i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalchg2yrsback i.year i.headrace [aweight=WGT]
reg vehboughtinlast2yrs hmvalchg2yrsback i.year i.headrace i. headmarital i.headedu famsize [aweight=WGT]

reg vehboughtinlast2yrs hmvalincr2yrsback i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback i.year i.headrace [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback i.year i.headrace i. headmarital i.headedu famsize [aweight=WGT]

reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct i.year [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct i.year i.headrace [aweight=WGT]
reg vehboughtinlast2yrs hmvalincr2yrsback_gt2pct i.year i.headrace i. headmarital i.headedu famsize [aweight=WGT]

