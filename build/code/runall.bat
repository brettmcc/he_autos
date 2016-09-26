set sasexe=C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe
set sascfg=C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg
set builddir=E:\he_autos\build\

del /Q %builddir%temp\*	

"%sasexe%" -SYSIN "%builddir%code\setlibraries.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\setlibraries.log"
"%sasexe%" -SYSIN "%builddir%code\person.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\person.log"
"%sasexe%" -SYSIN "%builddir%code\auto.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\auto.log"
"%sasexe%" -SYSIN "%builddir%code\head.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\head.log" -PRINT "%builddir%temp\head.lst"
"%sasexe%" -SYSIN "%builddir%code\housing.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\housing.log"
"%sasexe%" -SYSIN "%builddir%code\incomewealth.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\incomewealth.log"
"%sasexe%" -SYSIN "%builddir%code\merge.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\merge.log"

"C:\Program Files\StatTransfer11-64\st.exe" "%builddir%temp\mrgdPsid.sas7bdat" "%builddir%output\mrgdPsid.dta" -y

cd %builddir%temp\
"C:\Program Files (x86)\Stata14\Stata-64.exe" /e do %builddir%code\finaltouches.do


Findstr "WARNING:" %builddir%temp\*.log

Findstr "ERROR:" %builddir%temp\*.log

pause