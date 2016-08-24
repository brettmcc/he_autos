* Brett McCully, August 2016;
* Rename and organize income and wealth-related variables;

options mprint on;

%let faminc = ER16462 ER20456 ER24099 ER28037 ER41027 ER46935 ER52343 ER58152;
*have stock
1 - yes
5 - no
8 - DK
9 - NA;	
%let have_stock = ER15006 ER19202 ER22567 ER26548 ER37566 ER43557 ER48882 ER54633;

/**MACRO**/
%macro rename(yrs);
	%let max = %sysfunc(countw(&yrs));
	%do i=1 %to &max;
		%let yr = %scan(&yrs,&i);
		%let twodigyr = %substr(&yr,3);
		/*match year to ID variable*/
		%if &yr. = 1999 %then %let idvar = ER13002;
		%else %if &yr. = 2001 %then %let idvar = ER17002;
		%else %if &yr. = 2003 %then %let idvar = ER21002;
		%else %if &yr. = 2005 %then %let idvar = ER25002;
		%else %if &yr. = 2007 %then %let idvar = ER36002;
		%else %if &yr. = 2009 %then %let idvar = ER42002;
		%else %if &yr. = 2011 %then %let idvar = ER47302;
		%else %if &yr. = 2013 %then %let idvar = ER53002;

		data incomewealth&yr.;
			set in.fam&twodigyr.;
			id&yr. = &idvar.;
			faminc&yr. = %scan(&faminc.,&yrs.);
			stock&yr. = %scan(&have_stock.,&yrs.);
			have_stock&yr. = (stock&yr.=1);

			keep id&yr. faminc&yr. have_stock&yr.;
		run;
	%end;
%mend;

%rename(1999 2001 2003 2005 2007 2009 2011 2013);

data out.incomewealth;
	merge incomewealth:;
run;
