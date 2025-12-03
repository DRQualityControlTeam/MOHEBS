* Encoding: UTF-8.
**************************************************************************************************************************************************************************************
*MOHEBS PROJECT*********************************************************************************************************************************************
*********************************************************************************************************************************************
***STUDENT SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Data\Raw\Main\Student\MOHEBS Baseline Processed Dataset 03-12 v01.dta".

************************************************************************************************************************************************************************************.

variable level INT_DATE ENUM_NAME (Nominal).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=ENUM_NAME INT_DATE DISPLAY=LABEL
  /TABLE ENUM_NAME [COUNT F40.0] BY INT_DATE
  /CATEGORIES VARIABLES=ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE="MOHEBS Student Survey - Team achievements".

* Daily Achievement Output for Student Survey by Schools, Intervention group, Region, Grade,Gender.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=IEF Commune Ecole Groupe B2 DISPLAY=LABEL
  /TABLE IEF > Commune > Ecole [COUNT F40.0] BY Groupe > B2
  /CATEGORIES VARIABLES=IEF Commune Ecole Groupe ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=B2 ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE ="MOHEBS Student Survey - Location achievements- Main".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Progress\Main\Field\MOHEBS Daily Updates v01.xlsx'
     OPERATION=CREATEFILE sheet="Student Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.










