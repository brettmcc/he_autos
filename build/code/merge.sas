* merge.sas;
* Brett McCully, August 2016;

/*Merge together person, head, housing, and auto, keeping only the head-observation.*/

%macro merger;
	%do y=1999 %to 2013 %by 2;
		data temp&y.;
			merge person(where=(rel&y.=10 & seqno&y.=1) housing
