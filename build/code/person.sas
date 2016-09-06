
data temphe.person;
set in.inperson;
id1968       =      ER30001;
id1969       =      ER30020;
id1970       =      ER30043;
id1971       =      ER30067;
id1972       =      ER30091;
id1973       =      ER30117;
id1974       =      ER30138;
id1975       =      ER30160;
id1976       =      ER30188;
id1977       =      ER30217;
id1978       =      ER30246;
id1979       =      ER30283;
id1980       =      ER30313;
id1981       =      ER30343;
id1982       =      ER30373;
id1983       =      ER30399;
id1984       =      ER30429;
id1985       =      ER30463;
id1986       =      ER30498;
id1987       =      ER30535;
id1988       =      ER30570;
id1989       =      ER30606;
id1990       =      ER30642;
id1991       =      ER30689;
id1992       =      ER30733;
id1993       =      ER30806;
id1994       =      ER33101;
id1995       =      ER33201;
id1996       =      ER33301;
id1997       =      ER33401;
id1999       =      ER33501;
id2001       =      ER33601;
id2003       =      ER33701;
id2005       =      ER33801;
id2007       =      ER33901;
id2009       =      ER34001;
id2011		 =		ER34101;
id2013		 =		ER34201;
seqno1969      =      ER30021;
seqno1970      =      ER30044;
seqno1971      =      ER30068;
seqno1972      =      ER30092;
seqno1973      =      ER30118;
seqno1974      =      ER30139;
seqno1975      =      ER30161;
seqno1976      =      ER30189;
seqno1977      =      ER30218;
seqno1978      =      ER30247;
seqno1979      =      ER30284;
seqno1980      =      ER30314;
seqno1981      =      ER30344;
seqno1982      =      ER30374;
seqno1983      =      ER30400;
seqno1984      =      ER30430;
seqno1985      =      ER30464;
seqno1986      =      ER30499;
seqno1987      =      ER30536;
seqno1988      =      ER30571;
seqno1989      =      ER30607;
seqno1990      =      ER30643;
seqno1991      =      ER30690;
seqno1992      =      ER30734;
seqno1993      =      ER30807;
seqno1994      =      ER33102;
seqno1995      =      ER33202;
seqno1996      =      ER33302;
seqno1997      =      ER33402;
seqno1999      =      ER33502;
seqno2001      =      ER33602;
seqno2003      =      ER33702;
seqno2005      =      ER33802;
seqno2007      =      ER33902;
seqno2009      =      ER34002;
seqno2011	   =	  ER34102;
seqno2013	   =	  ER34202;
rel1968      =      ER30003;
rel1969      =      ER30022;
rel1970      =      ER30045;
rel1971      =      ER30069;
rel1972      =      ER30093;
rel1973      =      ER30119;
rel1974      =      ER30140;
rel1975      =      ER30162;
rel1976      =      ER30190;
rel1977      =      ER30219;
rel1978      =      ER30248;
rel1979      =      ER30285;
rel1980      =      ER30315;
rel1981      =      ER30345;
rel1982      =      ER30375;
rel1983      =      ER30401;
rel1984      =      ER30431;
rel1985      =      ER30465;
rel1986      =      ER30500;
rel1987      =      ER30537;
rel1988      =      ER30572;
rel1989      =      ER30608;
rel1990      =      ER30644;
rel1991      =      ER30691;
rel1992      =      ER30735;
rel1993      =      ER30808;
rel1994      =      ER33103;
rel1995      =      ER33203;
rel1996      =      ER33303;
rel1997      =      ER33403;
rel1999      =      ER33503;
rel2001      =      ER33603;
rel2003      =      ER33703;
rel2005      =      ER33803;
rel2007      =      ER33903;
rel2009      =      ER34003;
rel2011		 =		ER34103;
rel2013		 =		ER34203;

pid = ER30001 * 1000 + ER30002;

keep id1968 - id1997 id1999 id2001 id2003 id2005 id2007 id2009 id2011 id2013
     seqno1969 - seqno1997 seqno1999 seqno2001 seqno2003 seqno2005 seqno2007 seqno2009 seqno2011 seqno2013
	 rel1968 - rel1997 rel1999 rel2001 rel2003 rel2005 rel2007 rel2009 rel2011 rel2013 pid;
run;
