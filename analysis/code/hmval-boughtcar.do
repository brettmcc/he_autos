* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "W:\psid_data\mrgdpsid.dta", clear
local vars = "vehboughtinlast2yrs hmvalchglast2yrs headrace hmvalincrlast2yrs hmvalincrlast2yrs_gt2pct headmarital WGT headedu famsize"
reshape long `vars', i(pid) j(year)
keep pid year `vars'
*drop from 2013 since it has an anomonously lower rate of bought car in last 2 years
drop if year==2013

/*
reg vehboughtinlast2yrs hmvalchglast2yrs i.year [iweight=WGT]
reg vehboughtinlast2yrs hmvalchglast2yrs i.year i.headrace [iweight=WGT]

reg vehboughtinlast2yrs hmvalincrlast2yrs i.year [iweight=WGT]
reg vehboughtinlast2yrs hmvalincrlast2yrs i.year i.headrace [iweight=WGT]
*/

reg vehboughtinlast2yrs hmvalincrlast2yrs_gt2pct i.year [iweight=WGT]
reg vehboughtinlast2yrs hmvalincrlast2yrs_gt2pct i.year i.headrace [iweight=WGT]
reg vehboughtinlast2yrs hmvalincrlast2yrs_gt2pct i.year i.headrace i. headmarital i.headedu famsize [iweight=WGT]
