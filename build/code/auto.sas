* auto.sas;
* August 2016, Brett McCully;
proc printto log='W:\he_autos-master\build\temp\auto.log' new;
run;

options mprint;

libname in "W:\rawpsid";
libname tmphe "W:\he_autos-master\build\temp";

/**VARIABLE LISTS**/
%let idvars99to13 = ER13002 ER17002 ER21002 ER25002 ER36002 ER42002 ER47302 ER53002;

*1 - vehicle purchased since last survey
 3 - leased since last survey (only 2003-2013)
 5 - all others
 inexplicable change in frequencies in 2013;
%let veh1boughtinlast2yrs = ER13114 ER17125 ER21764 ER25722 ER36740 ER42743 ER48061 ER53757;
%let veh2boughtinlast2yrs = ER13144 ER17155 ER21793 ER25750 ER36768 ER42766 ER48086 ER53781;
%let veh3boughtinlast2yrs = ER13174 ER17185 ER21822 ER25778 ER36796 ER42789 ER48111 ER53805;
*recode 999998 and 999999 to missing since they are DK and NA, respectively;
%let veh1price =  	ER13115 ER17126 ER21765 ER25723 ER36741 ER42744 ER48062 ER53758;
%let veh2price = ER13145 ER17156 ER21794 ER25751 ER36769 ER42767 ER48087 ER53782;
%let veh3price = ER13175 ER17186 ER21823 ER25779 ER36797 ER42790 ER48112 ER53806;
*how acquired vehicle
1 - bought
2 - leased 
3 - received as gift
7 - other
8 - DK
9 - NA or refused;
%let howacqveh1 = ER13107 ER17118 ER21757 ER25716 ER36734 ER42738 ER48056 ER53753;
%let howacqveh2 = ER13137 ER17148 ER21786 ER25744 ER36762 ER42761 ER48081 ER53777;
%let howacqveh3 = ER13167 ER17178 ER21815 ER25772 ER36790 ER42784 ER48106 ER53801;
*new or used (1999 thru 2011)
1 - new
2 - used
8 - DK
9 - NA or refused;
%let neworusedveh1 = ER13108 ER17119 ER21758 ER25717 ER36735 ER42739 ER48057;
%let neworusedveh2 = ER13138 ER17149 ER21787 ER25745 ER36763 ER42762 ER48082;
%let neworusedveh3 = ER13168 ER17179 ER21816 ER25773 ER36791 ER42785 ER48107;
*car financing
1 - yes, financed all or part of auto purchase
5 - no
8 - DK
9 - NA or refused;
%let financeveh1 = ER13119 ER17130 ER21769 ER25727 ER36745 ER42746 ER48064 ER53760;
%let financeveh2 = ER13149 ER17160 ER21798 ER25755 ER36773 ER42769 ER48089 ER53784;
%let financeveh3 = ER13179 ER17190 ER21827 ER25783 ER36801 ER42792 ER48114 ER53808;


/**MACRO**/
%macro rename(yrs);
	%let max = %sysfunc(countw(&yrs));
	%do i=1 %to &max;
		%let yr = %scan(&yrs,&i);
		%let twodigyr = %substr(&yr,3);
		/*match year to ID variable*/
		%if &yr = 1999 %then %let idvar = ER13002;
		%else %if &yr. = 2001 %then %let idvar = ER17002;
		%else %if &yr. = 2003 %then %let idvar = ER21002;
		%else %if &yr. = 2005 %then %let idvar = ER25002;
		%else %if &yr. = 2007 %then %let idvar = ER36002;
		%else %if &yr. = 2009 %then %let idvar = ER42002;
		%else %if &yr. = 2011 %then %let idvar = ER47302;
		%else %if &yr. = 2013 %then %let idvar = ER53002;

		data auto&yr.;
			set in.fam&twodigyr.;
			id&yr. = &idvar.;
			veh1boughtinlast2yrs&yr. = %scan(&veh1boughtinlast2yrs.,&i.);
			veh2boughtinlast2yrs&yr. = %scan(&veh2boughtinlast2yrs.,&i.);
			veh3boughtinlast2yrs&yr. = %scan(&veh3boughtinlast2yrs.,&i.);
			vehboughtinlast2yrs&yr. = (veh1boughtinlast2yrs&yr.=1 OR veh1boughtinlast2yrs&yr.=1 OR veh1boughtinlast2yrs&yr.=1);
			veh1price&yr. = %scan(&veh1price.,&i.);
			veh2price&yr. = %scan(&veh2price.,&i.);
			veh3price&yr. = %scan(&veh3price.,&i.);
			if veh1price&yr. in (999998,999999) then veh1price&yr.=.;
			if veh2price&yr. in (999998,999999) then veh2price&yr.=.;
			if veh3price&yr. in (999998,999999) then veh3price&yr.=.;
			howacqveh1&yr. = %scan(&howacqveh1.,&i.);
			howacqveh2&yr. = %scan(&howacqveh2.,&i.);
			howacqveh3&yr. = %scan(&howacqveh3.,&i.);
			%if &yr.^=2013 %then %do;
			neworusedveh1&yr. = %scan(&neworusedveh1.,&i.);
			neworusedveh2&yr. = %scan(&neworusedveh2.,&i.);
			neworusedveh3&yr. = %scan(&neworusedveh3.,&i.);
			*counts number of new vehicles purchased in the last 2 years;
			newvehboughtinlast2yrs&yr. = (veh1boughtinlast2yrs&yr.=1 AND neworusedveh1&yr.=1) + (veh2boughtinlast2yrs&yr.=1 AND neworusedveh2&yr.=1) + (veh3boughtinlast2yrs&yr.=1 AND neworusedveh3&yr.=1);
			%end;
			financeveh1&yr. = %scan(&financeveh1.,&i.);
			financeveh2&yr. = %scan(&financeveh2.,&i.);
			financeveh3&yr. = %scan(&financeveh3.,&i.);
			keep id&yr. vehboughtinlast2yrs&yr. veh1boughtinlast2yrs&yr. veh2boughtinlast2yrs&yr. veh3boughtinlast2yrs&yr.
				 veh1price&yr. veh2price&yr. veh3price&yr. howacqveh1&yr. howacqveh2&yr. howacqveh3&yr.
				 %if &yr.^=2013 %then %do; neworusedveh1&yr. neworusedveh2&yr. neworusedveh3&yr. 
										newvehboughtinlast2yrs&yr. %end;
				 financeveh1&yr. financeveh2&yr. financeveh3&yr.;
		run;
	%end;
%mend;

%rename(1999 2001 2003 2005 2007 2009 2011 2013);

data tmphe.auto;
	merge auto:;
run;
	
proc printto;
run;
