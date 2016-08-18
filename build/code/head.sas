***********************************************************************************************************************
***********************************************************************************************************************
***********************************************PSID HEAD INFORMATION***************************************************
***********************************************************************************************************************
***********************************************************************************************************************
*********************************************************************************************************************** 
**********************************************************************************************************************;


***Include Head AGE, RACE, MARITAL STATUS, EDUCATION, FAMILY SIZE, Whether Self-Employed and Occupation;

***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************
******Headedu 1968 - 1990
0 0 - 5 grades and has difficulty reading 
1 0 - 5 grades, no difficulty reading 
2 6 - 8 grades 
3 9 - 11 grades 
4 12 grades (completed high school) 
5 12 grades plus non-academic training 
6 College, no degree 
7 College, bachelors degree (A.B., B.S., etc.) 
8 College, advanced or professional degrees (M.A., Ph.D., LLB, BD, M.S., etc.) 
9 N.A., D.K.
1991 - 2005, years completed,
Education questions were not asked again since 1985 for old heads.
******HeadMarital 
1 Married 
2 Single 
3 Widowed 
4 Divorced 
5 Separated; 

******Headrace
1 White 
2 Black 
3 American Indian, Aleut, Eskimo 
4 Asian, Pacific Islander 
5 Mentions Latino origin or descent 
6 Mentions color other than black or white 
7 Other 
9 NA DK;

******Work Status
1 Working now 
2 Only temporarily laid off, sick leave or maternity leave 
3 Looking for work, unemployed 
4 Retired 
5 Permanently disabled temporarily disabled 
6 Keeping house 
7 Student 
8 Other;  

******Selfemploy
1 Someone else only 
2 Both someone else and self 
3 Self-employed only 
9 NA DK 
0 Inap.: not working for money now;

******Industry and Occupation
Occupation code in family data had 1 digit in 1968 - 1975 and 2 digits in 1976 - 1980 
Inducstry code in family data had 2 digits in 1971 - 1980 
We use the retrospective 3-digit industry and occupation code provide by PSID.
1981 - 1993 1999 - 2001 3 digits   1994 - 1997 income data 3 digits
1968 - 2001 (1970 census)
2003 and 2005 (2000 census) we do not have a good way to map it to the 1 digit.
We try our best to map the industry code between 1970 and 2000 census
Occupation
0                   Not in labor force at all, retired (includes students and housewives who did no work last year and 
                    are not working). Permanently disabled or not in labor force and did no work last year. 
1         1   - 195 Professional, Technical, and Kindred Workers 
2         201 - 245 Managers and Administrators, except Farm 
3         260 - 285 Sales Workers 
4         301 - 395 Clerical and Kindred Workers 
5         401 - 600 Craftsman and Kindred Workers 
6         601 - 695 Operatives, except Transport 
7         701 - 715 Transport Equipment Operatives 
8         740 - 785 Laborers, except Farm 
9         801 - 802 Farmers and Farm Managers 
10        821 - 824 Farm Laborers and Farm Foremen 
11        901 - 965 Service Workers, except Private Household 
12        980 - 984 Private Household Workers 
Industry
0                   Inap. unemployed, retired, permanently disabled, housewife, student, other (V9005=3-8) 
1         17 - 28   Agriculture, Forestry, and Fisheries 
2         47 - 57   Mining 
3         67 - 77   Construction 
4         107 - 398 Manufacturing 
5         407 - 479 Transportation, Communications, and Other Public Utilities 
6         507 - 698 Wholesale and Retail Trade 
7         707 - 718 Finance, Insurance, and Real Estate 
8         727 - 759 Business and Repair Services 
9         769 - 798 Personal Services 
10        807 - 809 Entertainment and Recreation Services 
11        828 - 897 Professional and Related Services 
12        907 - 937 Public Administration; 

***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************;
*this macro produces the if-then-else statements to make the employment status variable consistent over time. 
 It should be used for 1976 to 1986;
%macro empStatus(var,year);
	if &var in (1,2) then headstatus&year=1;
	else if &var=3 then headstatus&year=2;
	else if &var in (4,5) then headstatus&year=3;
	else if &var=6 then headstatus&year=4;
	else if &var=7 then headstatus&year=5;
	else if &var=8 then headstatus&year=6;
	*else %put no dice;
%mend;
/*%macro headocc(year);
	if &year>=1976 and &year<=1980 then do;
		if headocc3digit&year in (10:19) then headocc&year = 1;
		else if headocc3digit&year in (20:29) then headocc&year = 2;
		else if headocc3digit&year in (30:39) then headocc&year = 3;
		else if headocc3digit&year in (40:49) then headocc&year = 4;
		else if headocc3digit&year in (50:51) then headocc&year = 5;
		else if headocc3digit&year in (52,55,99) then headocc&year = 9;
		else if headocc3digit&year in (60:69) then headocc&year = 6;
		else if headocc3digit&year in (70:79) then headocc&year = 7;
		else if headocc3digit&year = 80 then headocc&year = 8;
		else if headocc3digit&year =  .   then headocc&year = .;
		else if headocc3digit&year =  0 then headocc&year = 0;
	end;
	*later years combine self employed and non-self-employed managers into one category;
	if &year<=1980 & headocc3digit&year = 3 then headocc&year =2;
	*later years also mix up farmers, farm laborers, and service workers;
	if &year<=1980 & headocc3digit&year = 8 then headocc&year = 7;
	else if year>=1981 then do;
		if headocc3digit&year =  .   then do; headocc&year = .; end;        
	   else if headocc3digit&year =  999 then do; headocc&year = 9; end;        
	   else if headocc3digit&year =  0   then do; headocc&year = 0; end;
	   * 	Professional, Technical, and Kindred Workers;
	   else if headocc3digit&year le 195 then do; headocc&year = 1; end;
	   *Managers and Administrators, except Farm;
	   else if headocc3digit&year le 245 and headocc3digit&year ge 195 then do; headocc&year = 2; end;
	   * 	Sales, Clerical and Kindred Workers;
	   else if headocc3digit&year le 395 and headocc3digit&year ge 245 then do; headocc&year = 4; end;
	   *Craftsman and Kindred Workers;
	   else if headocc3digit&year le 600 and headocc3digit&year ge 401 then do; headocc&year = 5; end;
		*Operatives;
	   else if headocc3digit&year le 715 and headocc3digit&year ge 601 then do; headocc&year = 6; end;
	   * 	Laborers, and service workers, farm laborers;
	   else if headocc3digit&year le 984 and headocc3digit&year ge 716 then do; headocc&year = 7; end;
	end;
%mend;*/
%macro loopOcc;
	%do y=1968 %to 1997;
		%headocc(&y);
	%end;
	%headocc(1999);
	%headocc(2001);
%mend;

data headinfor1999;
set in.fam99;
id1999                        =                  ER13002            ;                        
headage1999                   =                  ER13010            ;      
headgender1999                =                  ER13011            ;      
headmarital1999               =                  ER16423            ;      
headrace1999                  =                  ER15928            ; 
headedu1999					  =					 ER16516 			; 
headstatus1999                =                  ER13205            ;
selfemploy1999                =                  ER13210            ;               
famsize1999                   =                  ER13009            ;               
headocc3digit1999             =                  ER13215            ;        
headind3digit1999             =                  ER13216            ;
WGT1999						  =					 ER16518 			;	 
keep id1999 headage1999 headgender1999 WGT1999 headmarital1999 headrace1999 headedu1999 headstatus1999 selfemploy1999 famsize1999 headocc3digit1999 headind3digit1999; 

data headinfor2001;
set in.fam01;
id2001                        =                  ER17002            ;                        
headage2001                   =                  ER17013            ;      
headgender2001                =                  ER17014            ;      
headmarital2001               =                  ER20369            ;      
headrace2001                  =                  ER19989            ;
headedu2001					  =					 ER20457 			; 
headstatus2001                =                  ER17216            ;
selfemploy2001                =                  ER17221            ;               
famsize2001                   =                  ER17012            ;               
headocc3digit2001             =                  ER17226            ;        
headind3digit2001             =                  ER17227            ;        
WGT2001                       =                  ER20394            ;
keep id2001 headage2001 headgender2001 WGT2001 headmarital2001 headrace2001 headedu2001 headstatus2001 selfemploy2001 famsize2001 headocc3digit2001 headind3digit2001; 


data headinfor2003;
set in.fam03;
id2003                        =                  ER21002            ;                        
headage2003                   =                  ER21017            ;      
headgender2003                =                  ER21018            ;      
headedu2003                   =                  ER24148            ;
headmarital2003               =                  ER24150            ;      
headrace2003                  =                  ER23426            ;       
headstatus2003                =                  ER21123            ;
selfemploy2003                =                  ER21147            ;               
famsize2003                   =                  ER21016            ;               
headocc3digit2003             =                  ER21145            ;        
headind3digit2003             =                  ER21146            ;        
WGT2003                       =                  ER24179            ;
keep id2003 headage2003 headgender2003 WGT2003 headmarital2003 headedu2003 headrace2003 headstatus2003 selfemploy2003 famsize2003 headocc3digit2003 headind3digit2003; 

data headinfor2005;
set in.fam05;
id2005                        =                  ER25002            ;                        
headage2005                   =                  ER25017            ;      
headgender2005                =                  ER25018            ;      
headedu2005                   =                  ER28047            ;
headmarital2005               =                  ER28049            ;      
headrace2005                  =                  ER27393            ;       
headstatus2005                =                  ER25104            ;
selfemploy2005                =                  ER25129            ;               
famsize2005                   =                  ER25016            ;               
headocc3digit2005             =                  ER25127            ;        
headind3digit2005             =                  ER25128            ;        
WGT2005                       =                  ER28078            ;
keep id2005 headage2005 headgender2005 WGT2005 headmarital2005 headedu2005 headrace2005 headstatus2005 selfemploy2005 famsize2005 headocc3digit2005 headind3digit2005; run;

data headinfor2007;
set in.fam07;
id2007                        =                  ER36002            ;                        
headage2007                   =                  ER36017            ;      
headgender2007                =                  ER36018            ;      
headedu2007                   =                  ER41037            ;
headmarital2007               =                  ER41039            ;      
headrace2007                  =                  ER40565            ;       
headstatus2007                =                  ER36109            ;
selfemploy2007                =                  ER36134            ;               
famsize2007                   =                  ER36016            ;               
headocc3digit2007             =                  ER36132            ;        
headind3digit2007             =                  ER36133            ;        
WGT2007                       =                  ER41069            ;
keep id2007 headage2007 headgender2007 WGT2007 headmarital2007 headedu2007 headrace2007 headstatus2007 selfemploy2007 famsize2007 headocc3digit2007 headind3digit2007; run;
 
data headinfor2009;
set in.fam09;
id2009                        =                  ER42002            ;                        
headage2009                   =                  ER42017            ;      
headgender2009                =                  ER42018            ;      
headedu2009                   =                  ER46981            ;
headmarital2009               =                  ER46983            ;      
headrace2009                  =                  ER46543            ;       
headstatus2009                =                  ER42140            ;
selfemploy2009                =                  ER42169            ;               
famsize2009                   =                  ER42016            ;               
headocc3digit2009             =                  ER42167            ;        
headind3digit2009             =                  ER42168            ;        
WGT2009                       =                  ER47012            ;
keep id2009 headage2009 headgender2009 WGT2009 headmarital2009 headedu2009 headrace2009 headstatus2009 selfemploy2009 famsize2009 headocc3digit2009 headind3digit2009; run;

data headinfor2011;
set in.fam11;
id2011                        =                  ER47302			;
headage2011					  =					 ER47317			;
headgender2011                =                  ER47318            ;      
headedu2011                   =                  ER52405            ;
headmarital2011               =                  ER52407            ;      
headrace2011                  =                  ER51904            ;       
headstatus2011                =                  ER47448            ;
selfemploy2011                =                  ER47482            ;               
famsize2011                   =                  ER47316            ;               
headocc3digit2011             =                  ER47479            ;        
headind3digit2011             =                  ER47480            ;        
WGT2011                       =                  ER52436            ;
keep id2011 headage2011 headgender2011 WGT2011 headmarital2011 headedu2011 headrace2011 headstatus2011 selfemploy2011 famsize2011 headocc3digit2011 headind3digit2011; run;


data headinfor2013;
set in.fam13;
id2013						  =     			 ER53002			;
headage2013					  =					 ER53017			;
headgender2013                =                  ER53018            ;      
headedu2013                   =                  ER58223            ;
headmarital2013               =                  ER58225            ;      
headrace2013                  =                  ER57659            ;       
headstatus2013                =                  ER53148            ;
selfemploy2013                =                  ER53182            ;               
famsize2013                   =                  ER53016            ;               
headocc3digit2013             =                  ER53179            ;        
headind3digit2013             =                  ER53180            ;        
WGT2013                       =                  ER58257            ;
keep id2013 headage2013 headgender2013 WGT2013 headmarital2013 headedu2013 headrace2013 headstatus2013 selfemploy2013 famsize2013 headocc3digit2013 headind3digit2013; run;


data out.head;
merge headinfor1999 headinfor2001 headinfor2003 headinfor2005 headinfor2007 headinfor2009 headinfor2011 headinfor2013;
if    headage1999       > 120 then headage1999      =.   ;
if    headage2001       > 120 then headage2001      =.   ;
if    headage2003       > 120 then headage2003      =.   ;
if    headage2005       > 120 then headage2005      =.   ;
if    headage2007       > 120 then headage2007      =.   ;
if    headage2009       > 120 then headage2009      =.   ;
if    headage2011       > 120 then headage2011      =.   ;
if    headage2013       > 120 then headage2013      =.   ;
                                                    
if    headrace1999      > 7   then headrace1999     =.   ;
if    headrace2001      > 7   then headrace2001     =.   ;
if    headrace2003      > 7   then headrace2003     =.   ;
if    headrace2005      > 7   then headrace2005     =.   ;
if    headrace2007      > 7   then headrace2007     =.   ;
if    headrace2009      > 7   then headrace2009     =.   ;
if    headrace2011      > 7   then headrace2011     =.   ;
if    headrace2013      > 7   then headrace2013     =.   ;

if    headmarital1999   > 7   then headmarital1999  =.   ; 
if    headmarital2001   > 7   then headmarital2001  =.   ; 
if    headmarital2003   > 7   then headmarital2003  =.   ; 
if    headmarital2005   > 7   then headmarital2005  =.   ; 
if    headmarital2007   > 7   then headmarital2007  =.   ; 
if    headmarital2009   > 7   then headmarital2009  =.   ; 
if    headmarital2011   > 7   then headmarital2011  =.   ; 
if    headmarital2013   > 7   then headmarital2013  =.   ; 

if    selfemploy1999    > 7   then selfemploy1999   =.   ; 
if    selfemploy2001    > 7   then selfemploy2001   =.   ; 
if    selfemploy2003    > 7   then selfemploy2003   =.   ; 
if    selfemploy2005    > 7   then selfemploy2005   =.   ; 
if    selfemploy2007    > 7   then selfemploy2007   =.   ; 
if    selfemploy2009    > 7   then selfemploy2009   =.   ; 
if    selfemploy2011    > 7   then selfemploy2011   =.   ; 
if    selfemploy2013    > 7   then selfemploy2013   =.   ; 

if    headstatus1999    > 10  then headstatus1999 = .;
if    headstatus2001    > 10  then headstatus2001 = .;
if    headstatus2003    > 10  then headstatus2003 = .;
if    headstatus2005    > 10  then headstatus2005 = .;
if    headstatus2007    > 10  then headstatus2007 = .;
if    headstatus2009    > 10  then headstatus2009 = .;
if    headstatus2011    > 10  then headstatus2011 = .;
if    headstatus2013    > 10  then headstatus2013 = .;
                                  
if    headedu1999       = 99  then    headedu1999   =   .;                                 
if    headedu2001       = 99  then    headedu2001   =   .;                                 
if    headedu2003       = 99  then    headedu2003   =   .;                                 
if    headedu2005       = 99  then    headedu2005   =   .;                                 
if    headedu2007       = 99  then    headedu2007   =   .;                                 
if    headedu2009       = 99  then    headedu2009   =   .;                                 
if    headedu2011       = 99  then    headedu2011   =   .;                                 
if    headedu2013       = 99  then    headedu2013   =   .;                                 
      
if    headedu1999       < 12  and  headedu1999 ne . then school1999   = 1;
if    headedu2001       < 12  and  headedu2001 ne . then school2001   = 1;
if    headedu2003       < 12  and  headedu2003 ne . then school2003   = 1;
if    headedu2005       < 12  and  headedu2005 ne . then school2005   = 1;
if    headedu2007       < 12  and  headedu2007 ne . then school2007   = 1;
if    headedu2009       < 12  and  headedu2009 ne . then school2009   = 1;
if    headedu2011       < 12  and  headedu2009 ne . then school2011   = 1;
if    headedu2013       < 12  and  headedu2009 ne . then school2013   = 1;
      
if    headedu1999       = 12 then school1999   = 2;                                 
if    headedu2001       = 12 then school2001   = 2;                                 
if    headedu2003       = 12 then school2003   = 2;                                 
if    headedu2005       = 12 then school2005   = 2;                                 
if    headedu2007       = 12 then school2007   = 2;                                 
if    headedu2009       = 12 then school2009   = 2;                                 
if    headedu2011       = 12 then school2011   = 2;                                 
if    headedu2013       = 12 then school2013   = 2;                                 
                                                                                 
if    headedu1999       > 12 and headedu1999  < 16  then school1999   = 3;          
if    headedu2001       > 12 and headedu2001  < 16  then school2001   = 3;          
if    headedu2003       > 12 and headedu2003  < 16  then school2003   = 3;          
if    headedu2005       > 12 and headedu2005  < 16  then school2005   = 3;          
if    headedu2007       > 12 and headedu2007  < 16  then school2007   = 3;          
if    headedu2009       > 12 and headedu2009  < 16  then school2009   = 3;          
if    headedu2011       > 12 and headedu2011  < 16  then school2011   = 3;          
if    headedu2013       > 12 and headedu2013  < 16  then school2013   = 3;          
                                                                                                 
if    headedu1999       >= 16  and headedu1999<90 then school1999   = 4  ;                              
if    headedu2001       >= 16  and headedu2001<90 then school2001   = 4  ;                              
if    headedu2003       >= 16  and headedu2003<90 then school2003   = 4  ;                              
if    headedu2005       >= 16  and headedu2005<90 then school2005   = 4  ;                              
if    headedu2007       >= 16  and headedu2007<90 then school2007   = 4  ;                              
if    headedu2009       >= 16  and headedu2009<90 then school2009   = 4  ;                              
if    headedu2011       >= 16  and headedu2011<90 then school2011   = 4  ;                              
if    headedu2013       >= 16  and headedu2013<90 then school2013   = 4  ;                              

originalheadedu1999 = headedu1999; 
originalheadedu2001 = headedu2001; 
originalheadedu2003 = headedu2003; 
originalheadedu2005 = headedu2005; 
originalheadedu2007 = headedu2007; 
originalheadedu2009 = headedu2009; 
originalheadedu2011 = headedu2011; 
originalheadedu2013 = headedu2013; 

headedu1999   =   school1999; 
headedu2001   =   school2001; 
headedu2003   =   school2003; 
headedu2005   =   school2005; 
headedu2007   =   school2007; 
headedu2009   =   school2009; 
headedu2011   =   school2011; 
headedu2013   =   school2013; 

*%loopOcc;
%macro occind(year);
        if headocc3digit&year =  .   then do; headocc&year = .; end;        
   else if headocc3digit&year =  999 then do; headocc&year = .; end;        
   else if headocc3digit&year =  0   then do; headocc&year = 0; end;
   else if headocc3digit&year le 195 then do; headocc&year = 1; end;
   else if headocc3digit&year le 245 then do; headocc&year = 2; end;
   else if headocc3digit&year le 285 then do; headocc&year = 3; end;
   else if headocc3digit&year le 395 then do; headocc&year = 4; end;
   else if headocc3digit&year le 600 then do; headocc&year = 5; end;
   else if headocc3digit&year le 695 then do; headocc&year = 6; end;
   else if headocc3digit&year le 715 then do; headocc&year = 7; end;
   else if headocc3digit&year le 785 then do; headocc&year = 8; end;
   else if headocc3digit&year le 802 then do; headocc&year = 9; end;
   else if headocc3digit&year le 824 then do; headocc&year = 10; end;
   else if headocc3digit&year le 965 then do; headocc&year = 11; end;
   else if headocc3digit&year le 984 then do; headocc&year = 12; end;

        if headind3digit&year =  .   then do; headind&year = .; end;        
   else if headind3digit&year =  999 then do; headind&year = .; end;        
   else if headind3digit&year =  0   then do; headind&year = 0; end;
   else if headind3digit&year le 28  then do; headind&year = 1; end;
   else if headind3digit&year le 57  then do; headind&year = 2; end;
   else if headind3digit&year le 77  then do; headind&year = 3; end;
   else if headind3digit&year le 398 then do; headind&year = 4; end;
   else if headind3digit&year le 479 then do; headind&year = 5; end;
   else if headind3digit&year le 698 then do; headind&year = 6; end;
   else if headind3digit&year le 718 then do; headind&year = 7; end;
   else if headind3digit&year le 759 then do; headind&year = 8; end;
   else if headind3digit&year le 798 then do; headind&year = 9; end;
   else if headind3digit&year le 809 then do; headind&year = 10; end;
   else if headind3digit&year le 897 then do; headind&year = 11; end;
   else if headind3digit&year le 937 then do; headind&year = 12; end;
%mend;

%occind(1999) %occind(2001) 

if headind3digit2003  =  .                                  then headind2003 = .; 
if headind3digit2003  =  999                                then headind2003 = .; 
if headind3digit2003  =  0                                  then headind2003 = 0; 
if headind3digit2003  > 0     and headind3digit2003 le 29   then headind2003 = 1; 
if headind3digit2003  ge 37   and headind3digit2003 le 49   then headind2003 = 2; 
if headind3digit2003  =  77                                 then headind2003 = 3; 
if headind3digit2003  ge 107  and headind3digit2003 le 399  then headind2003 = 4; 
if (headind3digit2003 ge 57   and headind3digit2003 le 69)                        
or (headind3digit2003 ge 647  and headind3digit2003 le 679) then headind2003 = 5; 
if headind3digit2003  ge 407  and headind3digit2003 le 579  then headind2003 = 6; 
if headind3digit2003  ge 687  and headind3digit2003 le 719  then headind2003 = 7; 
if headind3digit2003  ge 757  and headind3digit2003 le 779  then headind2003 = 8; 
if headind3digit2003  ge 866  and headind3digit2003 le 869  then headind2003 = 9; 
if headind3digit2003  ge 856  and headind3digit2003 le 859  then headind2003 = 10;
if (headind3digit2003 ge 727  and headind3digit2003 le 749)                       
or (headind3digit2003 ge 786  and headind3digit2003 le 847)                       
or (headind3digit2003 ge 877  and headind3digit2003 le 929) then headind2003 = 11;
if headind3digit2003  ge 937  and headind3digit2003 le 987  then headind2003 = 12;

if headind3digit2005  =  .                                  then headind2005 = .; 
if headind3digit2005  =  999                                then headind2005 = .; 
if headind3digit2005  =  0                                  then headind2005 = 0; 
if headind3digit2005  > 0     and headind3digit2005 le 29   then headind2005 = 1; 
if headind3digit2005  ge 37   and headind3digit2005 le 49   then headind2005 = 2; 
if headind3digit2005  =  77                                 then headind2005 = 3; 
if headind3digit2005  ge 107  and headind3digit2005 le 399  then headind2005 = 4; 
if (headind3digit2005 ge 57   and headind3digit2005 le 69)                        
or (headind3digit2005 ge 647  and headind3digit2005 le 679) then headind2005 = 5; 
if headind3digit2005  ge 407  and headind3digit2005 le 579  then headind2005 = 6; 
if headind3digit2005  ge 687  and headind3digit2005 le 719  then headind2005 = 7; 
if headind3digit2005  ge 757  and headind3digit2005 le 779  then headind2005 = 8; 
if headind3digit2005  ge 866  and headind3digit2005 le 869  then headind2005 = 9; 
if headind3digit2005  ge 856  and headind3digit2005 le 859  then headind2005 = 10;
if (headind3digit2005 ge 727  and headind3digit2005 le 749)                       
or (headind3digit2005 ge 786  and headind3digit2005 le 847)                       
or (headind3digit2005 ge 877  and headind3digit2005 le 929) then headind2005 = 11;
if headind3digit2005  ge 937  and headind3digit2005 le 987  then headind2005 = 12;

if headind3digit2007  =  .                                  then headind2007 = .; 
if headind3digit2007  =  999                                then headind2007 = .; 
if headind3digit2007  =  0                                  then headind2007 = 0; 
if headind3digit2007  > 0     and headind3digit2007 le 29   then headind2007 = 1; 
if headind3digit2007  ge 37   and headind3digit2007 le 49   then headind2007 = 2; 
if headind3digit2007  =  77                                 then headind2007 = 3; 
if headind3digit2007  ge 107  and headind3digit2007 le 399  then headind2007 = 4; 
if (headind3digit2007 ge 57   and headind3digit2007 le 69)                        
or (headind3digit2007 ge 647  and headind3digit2007 le 679) then headind2007 = 5; 
if headind3digit2007  ge 407  and headind3digit2007 le 579  then headind2007 = 6; 
if headind3digit2007  ge 687  and headind3digit2007 le 719  then headind2007 = 7; 
if headind3digit2007  ge 757  and headind3digit2007 le 779  then headind2007 = 8; 
if headind3digit2007  ge 866  and headind3digit2007 le 869  then headind2007 = 9; 
if headind3digit2007  ge 856  and headind3digit2007 le 859  then headind2007 = 10;
if (headind3digit2007 ge 727  and headind3digit2007 le 749)                       
or (headind3digit2007 ge 786  and headind3digit2007 le 847)                       
or (headind3digit2007 ge 877  and headind3digit2007 le 929) then headind2007 = 11;
if headind3digit2007  ge 937  and headind3digit2007 le 987  then headind2007 = 12;

if headind3digit2009  =  .                                  then headind2009 = .; 
if headind3digit2009  =  999                                then headind2009 = .; 
if headind3digit2009  =  0                                  then headind2009 = 0; 
if headind3digit2009  > 0     and headind3digit2009 le 29   then headind2009 = 1; 
if headind3digit2009  ge 37   and headind3digit2009 le 49   then headind2009 = 2; 
if headind3digit2009  =  77                                 then headind2009 = 3; 
if headind3digit2009  ge 107  and headind3digit2009 le 399  then headind2009 = 4; 
if (headind3digit2009 ge 57   and headind3digit2009 le 69)                        
or (headind3digit2009 ge 647  and headind3digit2009 le 679) then headind2009 = 5; 
if headind3digit2009  ge 407  and headind3digit2009 le 579  then headind2009 = 6; 
if headind3digit2009  ge 687  and headind3digit2009 le 719  then headind2009 = 7; 
if headind3digit2009  ge 757  and headind3digit2009 le 779  then headind2009 = 8; 
if headind3digit2009  ge 866  and headind3digit2009 le 869  then headind2009 = 9; 
if headind3digit2009  ge 856  and headind3digit2009 le 859  then headind2009 = 10;
if (headind3digit2009 ge 727  and headind3digit2009 le 749)                       
or (headind3digit2009 ge 786  and headind3digit2009 le 847)                       
or (headind3digit2009 ge 877  and headind3digit2009 le 929) then headind2009 = 11;
if headind3digit2009  ge 937  and headind3digit2009 le 987  then headind2009 = 12;

if headind3digit2011  =  .                                  then headind2011 = .; 
if headind3digit2011  =  999                                then headind2011 = .; 
if headind3digit2011  =  0                                  then headind2011 = 0; 
if headind3digit2011  > 0     and headind3digit2011 le 29   then headind2011 = 1; 
if headind3digit2011  ge 37   and headind3digit2011 le 49   then headind2011 = 2; 
if headind3digit2011  =  77                                 then headind2011 = 3; 
if headind3digit2011  ge 107  and headind3digit2011 le 399  then headind2011 = 4; 
if (headind3digit2011 ge 57   and headind3digit2011 le 69)                        
or (headind3digit2011 ge 647  and headind3digit2011 le 679) then headind2011 = 5; 
if headind3digit2011  ge 407  and headind3digit2011 le 579  then headind2011 = 6; 
if headind3digit2011  ge 687  and headind3digit2011 le 719  then headind2011 = 7; 
if headind3digit2011  ge 757  and headind3digit2011 le 779  then headind2011 = 8; 
if headind3digit2011  ge 866  and headind3digit2011 le 869  then headind2011 = 9; 
if headind3digit2011  ge 856  and headind3digit2011 le 859  then headind2011 = 10;
if (headind3digit2011 ge 727  and headind3digit2011 le 749)                       
or (headind3digit2011 ge 786  and headind3digit2011 le 847)                       
or (headind3digit2011 ge 877  and headind3digit2011 le 929) then headind2011 = 11;
if headind3digit2011  ge 937  and headind3digit2011 le 987  then headind2011 = 12;

if headind3digit2013  =  .                                  then headind2013 = .; 
if headind3digit2013  =  999                                then headind2013 = .; 
if headind3digit2013  =  0                                  then headind2013 = 0; 
if headind3digit2013  > 0     and headind3digit2013 le 29   then headind2013 = 1; 
if headind3digit2013  ge 37   and headind3digit2013 le 49   then headind2013 = 2; 
if headind3digit2013  =  77                                 then headind2013 = 3; 
if headind3digit2013  ge 107  and headind3digit2013 le 399  then headind2013 = 4; 
if (headind3digit2013 ge 57   and headind3digit2013 le 69)                        
or (headind3digit2013 ge 647  and headind3digit2013 le 679) then headind2013 = 5; 
if headind3digit2013  ge 407  and headind3digit2013 le 579  then headind2013 = 6; 
if headind3digit2013  ge 687  and headind3digit2013 le 719  then headind2013 = 7; 
if headind3digit2013  ge 757  and headind3digit2013 le 779  then headind2013 = 8; 
if headind3digit2013  ge 866  and headind3digit2013 le 869  then headind2013 = 9; 
if headind3digit2013  ge 856  and headind3digit2013 le 859  then headind2013 = 10;
if (headind3digit2013 ge 727  and headind3digit2013 le 749)                       
or (headind3digit2013 ge 786  and headind3digit2013 le 847)                       
or (headind3digit2013 ge 877  and headind3digit2013 le 929) then headind2013 = 11;
if headind3digit2013  ge 937  and headind3digit2013 le 987  then headind2013 = 12;

if headocc3digit2003 =  .                                  then headocc2003 = .;  
if headocc3digit2003 =  999                                then headocc2003 = .;  
if headocc3digit2003 =  0                                  then headocc2003 = 0;  
if (headocc3digit2003 ge 80  and headocc3digit2003 le 196)                        
or (headocc3digit2003 ge 210 and headocc3digit2003 le 365) then headocc2003 = 1;  
if (headocc3digit2003 ge 1   and headocc3digit2003 le 73)  then headocc2003 = 2;  
if (headocc3digit2003 ge 200 and headocc3digit2003 le 206)                        
or (headocc3digit2003 ge 470 and headocc3digit2003 le 496) then headocc2003 = 3;  
if headocc3digit2003 ge 500  and headocc3digit2003 le 593  then headocc2003 = 4;  
if headocc3digit2003 ge 700  and headocc3digit2003 le 896  then headocc2003 = 5;  
if headocc3digit2003 ge 900  and headocc3digit2003 le 975  then headocc2003 = 7;  
if headocc3digit2003 ge 620  and headocc3digit2003 le 694  then headocc2003 = 8;  
if headocc3digit2003 ge 600  and headocc3digit2003 le 613  then headocc2003 = 10; 
if (headocc3digit2003 ge 370 and headocc3digit2003 le 465)                        
or (headocc3digit2003 ge 980 and headocc3digit2003 le 983) then headocc2003 = 11; 

if headocc3digit2005 =  .                                  then headocc2005 = .;  
if headocc3digit2005 =  999                                then headocc2005 = .;  
if headocc3digit2005 =  0                                  then headocc2005 = 0;  
if (headocc3digit2005 ge 80  and headocc3digit2005 le 196)                        
or (headocc3digit2005 ge 210 and headocc3digit2005 le 365) then headocc2005 = 1;  
if (headocc3digit2005 ge 1   and headocc3digit2005 le 73)  then headocc2005 = 2;  
if (headocc3digit2005 ge 200 and headocc3digit2005 le 206)                        
or (headocc3digit2005 ge 470 and headocc3digit2005 le 496) then headocc2005 = 3;  
if headocc3digit2005 ge 500  and headocc3digit2005 le 593  then headocc2005 = 4;  
if headocc3digit2005 ge 700  and headocc3digit2005 le 896  then headocc2005 = 5;  
if headocc3digit2005 ge 900  and headocc3digit2005 le 975  then headocc2005 = 7;  
if headocc3digit2005 ge 620  and headocc3digit2005 le 694  then headocc2005 = 8;  
if headocc3digit2005 ge 600  and headocc3digit2005 le 613  then headocc2005 = 10; 
if (headocc3digit2005 ge 370 and headocc3digit2005 le 465)                        
or (headocc3digit2005 ge 980 and headocc3digit2005 le 983) then headocc2005 = 11; 

if headocc3digit2007 =  .                                  then headocc2007 = .;  
if headocc3digit2007 =  999                                then headocc2007 = .;  
if headocc3digit2007 =  0                                  then headocc2007 = 0;  
if (headocc3digit2007 ge 80  and headocc3digit2007 le 196)                        
or (headocc3digit2007 ge 210 and headocc3digit2007 le 365) then headocc2007 = 1;  
if (headocc3digit2007 ge 1   and headocc3digit2007 le 73)  then headocc2007 = 2;  
if (headocc3digit2007 ge 200 and headocc3digit2007 le 206)                        
or (headocc3digit2007 ge 470 and headocc3digit2007 le 496) then headocc2007 = 3;  
if headocc3digit2007 ge 500  and headocc3digit2007 le 593  then headocc2007 = 4;  
if headocc3digit2007 ge 700  and headocc3digit2007 le 896  then headocc2007 = 5;  
if headocc3digit2007 ge 900  and headocc3digit2007 le 975  then headocc2007 = 7;  
if headocc3digit2007 ge 620  and headocc3digit2007 le 694  then headocc2007 = 8;  
if headocc3digit2007 ge 600  and headocc3digit2007 le 613  then headocc2007 = 10; 
if (headocc3digit2007 ge 370 and headocc3digit2007 le 465)                        
or (headocc3digit2007 ge 980 and headocc3digit2007 le 983) then headocc2007 = 11; 

if headocc3digit2009 =  .                                  then headocc2009 = .;  
if headocc3digit2009 =  999                                then headocc2009 = .;  
if headocc3digit2009 =  0                                  then headocc2009 = 0;  
if (headocc3digit2009 ge 80  and headocc3digit2009 le 196)                        
or (headocc3digit2009 ge 210 and headocc3digit2009 le 365) then headocc2009 = 1;  
if (headocc3digit2009 ge 1   and headocc3digit2009 le 73)  then headocc2009 = 2;  
if (headocc3digit2009 ge 200 and headocc3digit2009 le 206)                        
or (headocc3digit2009 ge 470 and headocc3digit2009 le 496) then headocc2009 = 3;  
if headocc3digit2009 ge 500  and headocc3digit2009 le 593  then headocc2009 = 4;  
if headocc3digit2009 ge 700  and headocc3digit2009 le 896  then headocc2009 = 5;  
if headocc3digit2009 ge 900  and headocc3digit2009 le 975  then headocc2009 = 7;  
if headocc3digit2009 ge 620  and headocc3digit2009 le 694  then headocc2009 = 8;  
if headocc3digit2009 ge 600  and headocc3digit2009 le 613  then headocc2009 = 10; 
if (headocc3digit2009 ge 370 and headocc3digit2009 le 465)                        
or (headocc3digit2009 ge 980 and headocc3digit2009 le 983) then headocc2009 = 11; 

if headocc3digit2011 =  .                                  then headocc2011 = .;  
if headocc3digit2011 =  999                                then headocc2011 = .;  
if headocc3digit2011 =  0                                  then headocc2011 = 0;  
if (headocc3digit2011 ge 80  and headocc3digit2011 le 196)                        
or (headocc3digit2011 ge 210 and headocc3digit2011 le 365) then headocc2011 = 1;  
if (headocc3digit2011 ge 1   and headocc3digit2011 le 73)  then headocc2011 = 2;  
if (headocc3digit2011 ge 200 and headocc3digit2011 le 206)                        
or (headocc3digit2011 ge 470 and headocc3digit2011 le 496) then headocc2011 = 3;  
if headocc3digit2011 ge 500  and headocc3digit2011 le 593  then headocc2011 = 4;  
if headocc3digit2011 ge 700  and headocc3digit2011 le 896  then headocc2011 = 5;  
if headocc3digit2011 ge 900  and headocc3digit2011 le 975  then headocc2011 = 7;  
if headocc3digit2011 ge 620  and headocc3digit2011 le 694  then headocc2011 = 8;  
if headocc3digit2011 ge 600  and headocc3digit2011 le 613  then headocc2011 = 10; 
if (headocc3digit2011 ge 370 and headocc3digit2011 le 465)                        
or (headocc3digit2011 ge 980 and headocc3digit2011 le 983) then headocc2011 = 11; 

if headocc3digit2013 =  .                                  then headocc2013 = .;  
if headocc3digit2013 =  999                                then headocc2013 = .;  
if headocc3digit2013 =  0                                  then headocc2013 = 0;  
if (headocc3digit2013 ge 80  and headocc3digit2013 le 196)                        
or (headocc3digit2013 ge 210 and headocc3digit2013 le 365) then headocc2013 = 1;  
if (headocc3digit2013 ge 1   and headocc3digit2013 le 73)  then headocc2013 = 2;  
if (headocc3digit2013 ge 200 and headocc3digit2013 le 206)                        
or (headocc3digit2013 ge 470 and headocc3digit2013 le 496) then headocc2013 = 3;  
if headocc3digit2013 ge 500  and headocc3digit2013 le 593  then headocc2013 = 4;  
if headocc3digit2013 ge 700  and headocc3digit2013 le 896  then headocc2013 = 5;  
if headocc3digit2013 ge 900  and headocc3digit2013 le 975  then headocc2013 = 7;  
if headocc3digit2013 ge 620  and headocc3digit2013 le 694  then headocc2013 = 8;  
if headocc3digit2013 ge 600  and headocc3digit2013 le 613  then headocc2013 = 10; 
if (headocc3digit2013 ge 370 and headocc3digit2013 le 465)                        
or (headocc3digit2013 ge 980 and headocc3digit2013 le 983) then headocc2013 = 11; 

keep
id1999  headage1999  headgender1999   WGT1999  headmarital1999  headedu1999  headrace1999  headstatus1999  selfemploy1999  famsize1999  headocc3digit1999  headind3digit1999  headocc1999  headind1999  originalheadedu1999  
id2001  headage2001  headgender2001   WGT2001  headmarital2001  headedu2001  headrace2001  headstatus2001  selfemploy2001  famsize2001  headocc3digit2001  headind3digit2001  headocc2001  headind2001  originalheadedu2001  
id2003  headage2003  headgender2003   WGT2003  headmarital2003  headedu2003  headrace2003  headstatus2003  selfemploy2003  famsize2003  headocc3digit2003  headind3digit2003  headocc2003  headind2003  originalheadedu2003  
id2005  headage2005  headgender2005   WGT2005  headmarital2005  headedu2005  headrace2005  headstatus2005  selfemploy2005  famsize2005  headocc3digit2005  headind3digit2005  headocc2005  headind2005  originalheadedu2005 
id2007  headage2007  headgender2007   WGT2007  headmarital2007  headedu2007  headrace2007  headstatus2007  selfemploy2007  famsize2007  headocc3digit2007  headind3digit2007  headocc2007  headind2007  originalheadedu2007 
id2009  headage2009  headgender2009   WGT2009  headmarital2009  headedu2009  headrace2009  headstatus2009  selfemploy2009  famsize2009  headocc3digit2009  headind3digit2009  headocc2009  headind2009  originalheadedu2009 
id2011  headage2011  headgender2011   WGT2011  headmarital2011  headedu2011  headrace2011  headstatus2011  selfemploy2011  famsize2011  headocc3digit2011  headind3digit2011  headocc2011  headind2011  originalheadedu2011 
id2013  headage2013  headgender2013   WGT2013  headmarital2013  headedu2013  headrace2013  headstatus2013  selfemploy2013  famsize2013  headocc3digit2013  headind3digit2013  headocc2013  headind2013  originalheadedu2013 ;
run;

proc freq data = out.head;
tables 
headmarital1999  headedu1999  headrace1999  headstatus1999  selfemploy1999  famsize1999  headocc1999  headind1999  
headmarital2001  headedu2001  headrace2001  headstatus2001  selfemploy2001  famsize2001  headocc2001  headind2001  
headmarital2003  headedu2003  headrace2003  headstatus2003  selfemploy2003  famsize2003  headocc2003  headind2003            
headmarital2005  headedu2005  headrace2005  headstatus2005  selfemploy2005  famsize2005  headocc2005  headind2005                          
headmarital2007  headedu2007  headrace2007  headstatus2007  selfemploy2007  famsize2007  headocc2007  headind2007                          
headmarital2009  headedu2009  headrace2009  headstatus2009  selfemploy2009  famsize2009  headocc2009  headind2009                        
headmarital2011  headedu2011  headrace2011  headstatus2011  selfemploy2011  famsize2011  headocc2011  headind2011                          
headmarital2013  headedu2013  headrace2013  headstatus2013  selfemploy2013  famsize2013  headocc2013  headind2013;                           
run;

%macro freq(year);
proc freq data = headinfor&year;
tables headmarital&year headedu&year headrace&year selfemploy&year famsize&year ;
run;
%mend;
%freq(1999); %freq(2001);
%freq(2003); %freq(2005); %freq(2007); %freq(2009); %freq(2011); %freq(2013); 

******************************************************************************************************************
*****Each year there are some invalid observations of education and race of PSID head and wife, valid information*
*****may be located in other waves, we mapped them cross waves to maximize the number of valid observations******;

%macro vrace(year);
data vrace&year;
set out.head;
if id&year ne . and headrace&year ne .; 
w = &year;
headrace = headrace&year;
keep id&year headrace;
proc sort data = vrace&year;
by id&year;

data person;
set out.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data vrace&year;
merge vrace&year(in = in1) person;
by id&year;
keep headrace pid;
if in1;
run;
%mend;
%vrace(1999) %vrace(2001) %vrace(2003) %vrace(2005) %vrace(2007) %vrace(2009) %vrace(2011) %vrace(2013)

data vrace;
set vrace1999 vrace2001 vrace2003 vrace2005 vrace2007 vrace2009 vrace2011 vrace2013;
proc sort data = vrace nodupkey;
by pid;
run;

%macro race(year);
data race&year;
set out.head;
if id&year ne . and headrace&year = .; 
w = &year;
keep id&year w;
proc sort data = race&year;
by id&year;

data person;
set out.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year = 1969 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data race&year;
merge race&year(in = in1) person;
by id&year;
if in1;
proc sort data = race&year;
by pid;
data race&year;
merge race&year(in = in1) vrace(in = in2);
by pid;
if in1 and in2;
keep id&year headrace;
proc sort data = race&year;
by id&year;
proc print data = race&year;
run;
%mend;
%race(1999) %race(2001) %race(2003) %race(2005) %race(2007) %race(2009) %race(2011) %race(2013)

%macro crace(year);
proc sort data = out.head;
by id&year;
data out.head;
merge out.head race&year;
by id&year;
if headrace ne . then headrace&year = headrace;
run;
data u;
set out.head;
if id&year ne .;
proc freq data = u;
tables headrace&year;
run;
%mend;
%crace(1999) %crace(2001) %crace(2003) %crace(2005) 
%crace(2007) %crace(2009) %crace(2011) %crace(2013)
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
*******************************************************************************************************************;

%macro vedu(year);
data vedu&year;
set out.head;
if id&year ne . and headedu&year ne .; 
w = &year;
headedu = headedu&year;
keep id&year headedu w;
proc sort data = vedu&year;
by id&year;

data person;
set out.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data vedu&year;
merge vedu&year(in = in1) person;
by id&year;
keep headedu pid w;
if in1;
run;
%mend;
%vedu(1999) %vedu(2001) %vedu(2003) %vedu(2005) %vedu(2007) %vedu(2009) %vedu(2011) %vedu(2013) 

data vedu;
set vedu1999 vedu2001 vedu2003 vedu2005 vedu2007 vedu2009 vedu2011 vedu2013;
proc sort data = vedu nodupkey;
by pid headedu;
run;


data eduvary1;
set vedu;
by pid headedu;
if first.pid = 1 and last.pid = 1;
keep pid headedu;

data eduvary3;
set vedu;
by pid headedu;
if first.pid = 0 and last.pid = 0; 
keep pid;

data eduvary3;
merge vedu eduvary3(in = in1);
by pid;
if in1;

data eduvary31 eduvary32 eduvary33;
set eduvary3;
by pid;
if first.pid = 1 then output eduvary31;
else if last.pid = 1 then output eduvary33;
else if first.pid = 0 and last.pid = 0 then output eduvary32;

data eduvary31;
set eduvary31;
headedu1 = headedu; w1 = w;
keep pid headedu1 w1;

data eduvary32;
set eduvary32;
headedu2 = headedu; w2 = w;
keep pid headedu2 w2;
proc sort nodupkey;
by pid;

data eduvary33;
set eduvary33;
headedu3 = headedu; w3 = w;
keep pid headedu3 w3;

data eduvary3;
merge eduvary31 eduvary32 eduvary33;
by pid;

data eduvary2;
merge vedu(in = in1) eduvary1(in = in2) eduvary3(in = in3);
by pid;
if in1 and not in2 and not in3;

data eduvary21 eduvary22;
set eduvary2;
by pid;
if first.pid = 1 then output eduvary21;
else if last.pid = 1 then output eduvary22;

data eduvary21;
set eduvary21;
headedu1 = headedu; w1 = w;
keep pid headedu1 w1;

data eduvary22;
set eduvary22;
headedu2 = headedu; w2 = w;
keep pid headedu2 w2;

data eduvary2;
merge eduvary21 eduvary22;
by pid;
run;

%macro edu(year);
data edu&year;
set out.head;
if id&year ne . and headedu&year = .; 
w = &year;
keep id&year w;
proc sort data = edu&year;
by id&year;

data person;
set out.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data edu&year;
merge edu&year(in = in1) person;
by id&year;
if in1;
proc sort data = edu&year;
by pid;

data edu&year;
merge edu&year(in = in1) eduvary1(in = in2) eduvary2(in = in3) eduvary3(in = in4);
by pid;
if in1 and (in2 or in3 or in4);
if in3 then do; if w < w2 then headedu = headedu1; else headedu = headedu2; end;
if in4 then do; if w < w2 then headedu = headedu1; else if w < w3 then headedu = headedu2; else headedu = headedu3; end;
keep id&year headedu;
proc sort data = edu&year;
by id&year;
run;
%mend;
%edu(1999) %edu(2001) %edu(2003) %edu(2005) %edu(2007) %edu(2009) %edu(2011) %edu(2013)

%macro cedu(year);
proc sort data = out.head;
by id&year;
data out.head;
merge out.head edu&year;
by id&year;
if headedu ne . then headedu&year = headedu;
run;
data u;
set out.head;
if id&year ne .;
proc freq data = u;
tables headedu&year;
run;
%mend;
%cedu(1999) %cedu(2001) %cedu(2003) %cedu(2005) %cedu(2007) %cedu(2009) %cedu(2011) %cedu(2013)


*******************************************************;
proc freq data = out.head;                                                                                                    
tables                                                                                                                             
headmarital1999   headgender1999      headedu1999       headrace1999    headstatus1999    selfemploy1999      famsize1999   headocc1999    headind1999 
headmarital2001   headgender2001      headedu2001       headrace2001    headstatus2001    selfemploy2001      famsize2001   headocc2001    headind2001 
headmarital2003   headgender2003      headedu2003       headrace2003    headstatus2003    selfemploy2003      famsize2003   headocc2003    headind2003                              
headmarital2005   headgender2005      headedu2005       headrace2005    headstatus2005    selfemploy2005      famsize2005   headocc2005    headind2005                             
headmarital2007   headgender2007      headedu2007       headrace2007    headstatus2007    selfemploy2007      famsize2007   headocc2007    headind2007                             
headmarital2009   headgender2009      headedu2009       headrace2009    headstatus2009    selfemploy2009      famsize2009   headocc2009    headind2009                             
headmarital2011   headgender2011      headedu2011       headrace2011    headstatus2011    selfemploy2011      famsize2011   headocc2011    headind2011                             
headmarital2013   headgender2013      headedu2013       headrace2013    headstatus2013    selfemploy2013      famsize2013   headocc2013    headind2013;                             
run;                                                                                                                               

%macro freq(year);
data u;
set out.head;
if id&year ne .;
proc freq data = u;
tables headmarital&year headedu&year headgender&year headrace&year headstatus&year selfemploy&year famsize&year headocc&year headind&year;
run;
%mend;

%freq(1999); %freq(2001); %freq(2003); %freq(2005); %freq(2007); %freq(2009); %freq(2011); %freq(2013);

