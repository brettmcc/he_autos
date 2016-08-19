* merge.sas;
* Brett McCully, August 2016;

/*Merge together person, head, housing, and auto, keeping only the head-observation.*/

%macro merger;
	%do y=1999 %to 2013 %by 2;
		proc sort data=out.person; by id&y.; run;
		proc sort data=out.housing; by id&y.; run;
		proc sort data=out.auto; by id&y.; run;
		proc sort data=out.head; by id&y.; run;
		data temp&y.(drop=rel&y. seqno&y.);
			merge 	out.person(keep=pid id&y. rel&y. seqno&y. where=(rel&y.=10 & seqno&y.=1))
					out.housing(keep=id&y. hmval&y. mortgage&y. secMtg&y. hmowner&y. soldHome&y.)
					out.auto(keep=id&y. vehboughtinlast2yrs&y. veh1boughtinlast2yrs&y. veh2boughtinlast2yrs&y. veh3boughtinlast2yrs&y.
							veh1price&y. veh2price&y. veh3price&y. howacqveh1&y. howacqveh2&y. howacqveh3&y.
				 			%if &y.^=2013 %then %do; neworusedveh1&y. neworusedveh2&y. neworusedveh3&y. %end;
				 			financeveh1&y. financeveh2&y. financeveh3&y.)
					out.head(keep=id&y. headmarital&y.  headedu&y.  headrace&y.  headstatus&y.  selfemploy&y.  famsize&y.  headocc&y.  headind&y. wgt&y.);
			by id&y.;
			if headrace&y. in (3, 4, 5, 6, 7) then headrace&y. = 3; 
			if headrace&y. = 0 then headrace&y. = .;
			format headrace&y. race.;
		run;
		proc sort data=temp&y.;
			by pid;
		run;
	%end;
%mend;

proc format;
	value race 1 = 'White'
				2 = 'Black'
				3 = 'Other';
run;

%merger;

data temp.mrgdPsid(drop=id: where=(pid^=.));
	merge temp:;
	by pid;
run;
