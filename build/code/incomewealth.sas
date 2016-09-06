* Brett McCully, August 2016;
* Rename and organize income and wealth-related variables;
proc printto log='W:\he_autos-master\build\temp\incomewealth.log' new;
run;

options mprint spool;

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
		%put &i.;
		%let yr = %scan(&yrs,&i);
		%let twodigyr = %substr(&yr,3);
		/*match year to ID variable and chained CPI value with base year 1999*/
		%if &yr. = 1999 %then %do; %let idvar = ER13002; %let cpi = 100; %end;
		%if &yr. = 2001 %then %do; %let idvar = ER17002; %let cpi = 104.3; %end;
		%if &yr. = 2003 %then %do; %let idvar = ER21002; %let cpi = 107.8; %end;
		%if &yr. = 2005 %then %do; %let idvar = ER25002; %let cpi = 113.7; %end;
		%if &yr. = 2007 %then %do; %let idvar = ER36002; %let cpi = 119.957; %end;
		%if &yr. = 2009 %then %do; %let idvar = ER42002; %let cpi = 123.850; %end;
		%if &yr. = 2011 %then %do; %let idvar = ER47302; %let cpi = 129.453; %end;
		*unsure of 2013 number;
		%if &yr. = 2013 %then %do; %let idvar = ER53002; %let cpi = 130; %end;

		data incomewealth&yr.;
			set in.fam&twodigyr.(keep=&idvar. %scan(&faminc.,&i.) %scan(&have_stock.,&i.));
			id&yr. = &idvar.;
			faminc&yr. = %scan(&faminc.,&i.)*&cpi./100;
			stock&yr. = %scan(&have_stock.,&i.);
			have_stock&yr. = (stock&yr.=1);

			keep id&yr. faminc&yr. have_stock&yr.;
		run;
	%end;
%mend;

%rename(1999 2001 2003 2005 2007 2009 2011 2013);

data tmphe.incomewealth;
	merge incomewealth:;
run;

proc printto;
run;
