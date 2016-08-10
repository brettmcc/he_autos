* Housing.sas
* Brett McCully, August 2016;

*clear out any remaining work files;
proc datasets lib=work kill memtype=data nolist;
run;

/**VARIABLES**/
*id, 1968-2013;
%let allidvars = V3 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702 V14802 V16302 V17702 V19002 V20302 V21602 ER2002 ER5002 ER7002 ER10002 ER13002 ER17002 ER21002 ER25002 ER36002 ER42002 ER47302 ER53002;
* homeownership status, 1968 to 2013
1 - owns
5 - rents
8 or 9 - neither or dont know;
%let hmowner = V103 V593 V1264 V1967 V2566 V3108 V3522 V3939 V4450 V5364 V5864 V6479 V7084 V7675 V8364 V8974 V10437 V11618 V13023 V14126 V15140 V16641 V18072 V19372 V20672 V22427 ER2032 ER5031 ER7031 ER10035 ER13040 ER17043 ER21042 ER25028 ER36028 ER42029 ER47329 ER53029;
* home value, 1968 to 2013;
%let hmval = V5 V449 V1122 V1823 V2423 V3021 V3417 V3817 V4318 V5217 V5717 V6319 V6917 V7517 V8217 V8817 V10018 V11125 V12524 V13724 V14824 V16324 V17724 V19024 V20324 V21610 ER2033 ER5032 ER7032 ER10036 ER13041 ER17044 ER21043 ER25029 ER36029 ER42030 ER47330 ER53030;

*If didnt answer above explicitly, then asked follow up of whether home value in various value buckets for 2005 to 2013;
*home value worth 100k+
1 - yes
5 - no
8 or 9 - dont know or refused
0 - already answered home value explicitly;
%let hmval100pl = ER25031 ER36031 ER42032 ER47332 ER53032;
%let hmval200pl = ER25032 ER36032 ER42033 ER47333 ER53033;
%let hmval25pl =  	ER25035 ER36035 ER42036 ER47336 ER53036;
%let hmval400pl = ER25033 ER36033 ER42034 ER47334 ER53034;
%let hmval75pl =  	ER25034 ER36034 ER42035 ER47335 ER53035;
*accuracy code for home value estimate from 1968 to 1993 and 2001 to 2013
from 2001 to 2013 is 1 if value imputed and 0 otherwise;
%let hmvalaccuracycode = V7 V450 V1123 V1824 V2424 V3022 V3418 V3818 V4319 V5218 V5718 V6320 V6918 V7518 V8218 V8818 V10019 V11126 V12525 V13725 V14825 V16325 V17725 V19025 V20325 V21611 ER17045 ER21044 ER25030 ER36030 ER42031 ER47331 ER53031;
*whether have a mortgage, from 1968 to 1972, 1979 to 1981, 1983 to 2013
1 - first mortgage only
2 - two mortgages
5 - no mortgage
9 - NA
0 - does not own property;
%let mortgage = V104 V594 V1265 V1968 V2567 V6480 V7085 V7676 V8975 V10438 V11619 V13024 V14127 V15141 V16642 V18073 V19373 V20673 V22428 ER2036 ER5035 ER7035 ER10039 ER13044 ER17049 ER21048 ER25039 ER36039 ER42040 ER47345 ER53045;

/****ADD HERE***/
*Whether have second mortgage (HELOC + HEL)
1 - yes
5 - no
8 - DK
9 - NA, refused
;
%let secMtg = V595 V1266 V1971 V2570 V6482 V7087 V7678 V8977 V10440 V11621 V13026 V14129 V15142 V16643 V18075 V19375 V20675 V22430 ER2045 ER5044 ER7110 ER10056 ER13053 ER17060 ER21059 ER25050 ER36051 ER42059 ER47366 ER53066;


/**YEARS**/
%let allyears = 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009 2011 2013;
%let aughts =  2001 2003 2005 2007 2009 2011 2013;
%let lastFiveSurveys = 2005 2007 2009 2011 2013;
%let y68to93 = 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993;
%let y68to72 = 1968 1969 1970 1971 1972;
%let y69to72 = 1969 1970 1971 1972;
%let y79to81 = 1979 1980 1981;
%let y83to13 = 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009 2011 2013;


/**MACRO**/
%macro rename(yrs,vars,basename);
	%let max = %sysfunc(countw(&yrs));
	%do i=1 %to &max;
		%let yr = %scan(&yrs,&i);
		%let twodigyr = %substr(&yr,3);
		%let var = %scan(&vars.,&i.);
		/*match year to ID variable*/
		%if &yr = 1968 %then %let idvar = V3;
		%else %if &yr = 1969 %then %let idvar = V442;
		%else %if &yr = 1970 %then %let idvar = V1102;
		%else %if &yr = 1971 %then %let idvar = V1802;
		%else %if &yr = 1972 %then %let idvar = V2402;
		%else %if &yr = 1973 %then %let idvar = V3002;
		%else %if &yr = 1974 %then %let idvar = V3402;
		%else %if &yr = 1975 %then %let idvar = V3802;
		%else %if &yr = 1976 %then %let idvar = V4302;
		%else %if &yr = 1977 %then %let idvar = V5202;
		%else %if &yr = 1978 %then %let idvar = V5702;
		%else %if &yr = 1979 %then %let idvar = V6302;
		%else %if &yr = 1980 %then %let idvar = V6902;
		%else %if &yr = 1981 %then %let idvar = V7502;
		%else %if &yr = 1982 %then %let idvar = V8202;
		%else %if &yr = 1983 %then %let idvar = V8802;
		%else %if &yr = 1984 %then %let idvar = V10002;
		%else %if &yr = 1985 %then %let idvar = V11102;
		%else %if &yr = 1986 %then %let idvar = V12502;
		%else %if &yr = 1987 %then %let idvar = V13702;
		%else %if &yr = 1988 %then %let idvar = V14802;
		%else %if &yr = 1989 %then %let idvar = V16302;
		%else %if &yr = 1990 %then %let idvar = V17702;
		%else %if &yr = 1991 %then %let idvar = V19002;
		%else %if &yr = 1992 %then %let idvar = V20302;
		%else %if &yr = 1993 %then %let idvar = V21602;
		%else %if &yr = 1994 %then %let idvar = ER2002;
		%else %if &yr = 1995 %then %let idvar = ER5002;
		%else %if &yr = 1996 %then %let idvar = ER7002;
		%else %if &yr = 1997 %then %let idvar = ER10002;
		%else %if &yr = 1999 %then %let idvar = ER13002;
		%else %if &yr = 2001 %then %let idvar = ER17002;
		%else %if &yr = 2003 %then %let idvar = ER21002;
		%else %if &yr = 2005 %then %let idvar = ER25002;
		%else %if &yr = 2007 %then %let idvar = ER36002;
		%else %if &yr = 2009 %then %let idvar = ER42002;
		%else %if &yr = 2011 %then %let idvar = ER47302;
		%else %if &yr = 2013 %then %let idvar = ER53002;

		%put &idvar.;
		data temp;
			set in.fam&twodigyr.;
			id&yr. = &idvar.;
			&basename.&yr. = &var.;
			keep id&yr. &basename.&yr.;
		run;
		proc sort data=temp;
			by id&yr.;
		run;
		proc sort data=out.person;
			by id&yr.;
		run;
		data &basename.&yr.;
			merge temp out.person;
			by id&yr.;
			if &basename.&yr. ^= .;
			keep pid &basename.&yr. id&yr.;
		run;
		proc sort data=&basename.&yr.;
			by pid;
		run;
	%end;

	data &basename.;
		merge &basename.:;
		by pid;
		keep pid &basename.:;
	run;
	proc sort data=&basename.;
		by pid;
	run;
%mend;

%rename(&allyears., &hmowner., hmowner)	%rename(&allyears., &hmval., hmval)
%rename(&lastFiveSurveys., &hmval100pl., hmval100pl)
%rename(&lastFiveSurveys., &hmval200pl., hmval200pl)
%rename(&lastFiveSurveys., &hmval400pl., hmval400pl)
%rename(&lastFiveSurveys., &hmval25pl., hmval25pl)
%rename(&lastFiveSurveys., &hmval75pl., hmval75pl)
%rename(&y68to93. &aughts., &hmvalaccuracycode., hmvalaccuracycode)
%rename(&y68to72. &y79to81. &y83to13., &mortgage., mortgage)
%rename(&y69to72. &y79to81. &y83to13., &secMtg., secMtg)


data out.housing;
	merge hmowner hmval hmval100pl hmval200pl hmval25pl hmval400pl hmval75pl hmvalaccuracycode mortgage secMtg;
	by pid;
run;





