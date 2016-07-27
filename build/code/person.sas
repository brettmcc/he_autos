
data psiddata.person;
set psiddata.fam99 psiddata.fam01 psiddata.fam03 psiddata.fam05 
	psiddata.fam07 psiddata.fam09 psiddata.fam11 psiddata.fam13;
id1999       =      ER33501;
id2001       =      ER33601;
id2003       =      ER33701;
id2005       =      ER33801;
id2007       =      ER33901;
id2009       =      ER34001;
id2011		 =		ER34101;
id2013		 =		ER34201;
seqno1999      =      ER33502;
seqno2001      =      ER33602;
seqno2003      =      ER33702;
seqno2005      =      ER33802;
seqno2007      =      ER33902;
seqno2009      =      ER34002;
seqno2011	   =	  ER34102;
seqno2013	   =	  ER34202;
rel1999      =      ER33503;
rel2001      =      ER33603;
rel2003      =      ER33703;
rel2005      =      ER33803;
rel2007      =      ER33903;
rel2009      =      ER34003;
rel2011		 =		ER34103;
rel2013		 =		ER34203;

pid = ER30001 * 1000 + ER30002;

keep id1999 id2001 id2003 id2005 id2007 id2009
     seqno1999 seqno2001 seqno2003 seqno2005 seqno2007 seqno2009
	 rel1999 rel2001 rel2003 rel2005 rel2007 rel2009 pid;
run;
