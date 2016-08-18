* Brett McCully, August 2016
* Analyze PSID dataset created from SAS, looking at relationship between home 
* value changes and whether a household bought a car. 

set more off
clear all

use "W:\psid_data\mrgdpsid.dta", clear
reshape long vehboughtinlast2yrs hmvalchglast2yrs headrace, i(pid) j(year)
keep vehboughtinlast2yrs hmvalchglast2yrs pid year headrace

reg vehboughtinlast2yrs hmvalchglast2yrs i.year if vehboughtinlast2yrs!=. & hmvalchglast2yrs!=. & year!=2013
reg vehboughtinlast2yrs hmvalchglast2yrs i.year i.headrace if vehboughtinlast2yrs!=. & hmvalchglast2yrs!=. & year!=2013
