* Encoding: UTF-8.
**************************************************************************************************************************************************************************************
*UND NDAW WUNE PROJECT*********************************************************************************************************************************************
*********************************************************************************************************************************************
***STUDENT SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT\Endline\Data\Raw\Main\UND NDAW WUNE Endline Processed Dataset 14-11 v01.dta".

************************************************************************************************************************************************************************************.

variable level interview_date Ecole ENUM_NAME (Nominal).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME interview_date DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME [COUNT F40.0] BY interview_date
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=interview_date ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE="UND Ndaw Wune Survey - Team achievements".

* Daily Achievement Output for Student Survey by Schools, Intervention group, Region, Grade,Gender.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=IEF Commune Ecole Niveau Sexe DISPLAY=LABEL
  /TABLE IEF > Commune > Ecole [COUNT F40.0] BY Niveau > Sexe
  /CATEGORIES VARIABLES=IEF Commune Ecole Niveau Sexe ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE ="UND Ndaw Wune Survey - Location achievements- Main".


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=IEF Eleve_nom status DISPLAY=LABEL
  /TABLE IEF [C] > Eleve_nom [C][COUNT F40.0] BY status [C]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=IEF ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=Eleve_nom ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CATEGORIES VARIABLES=status ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES title = "Status of students interviewed".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT\Endline\Progress\Main\Field\UND NDAW WUNE Daily Updates v01.xlsx'
     OPERATION=CREATEFILE sheet="Student Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.


***********Extracting Open ends & other specify.
sort cases BY  ENUM_COMMENTS(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\ENUM_COMMENTS.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language ENUM_COMMENTS.
sort cases BY  b5_s3(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b5_s3.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b5_s3.
sort cases BY  b5_s2(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b5_s2.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b5_s2.
sort cases BY  b5_s1(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b5_s1.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b5_s1.
sort cases BY  b6_s3(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b6_s3.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b6_s3.
sort cases BY  b6_s2(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b6_s2.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b6_s2.
sort cases BY  b6_s1(D).
SAVE TRANSLATE OUTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT-BASELINE\Open ends\b6_s1.xlsx'
 /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=LABELS
/KEEP = interview_ID interview_date survey_language b6_s1.

TEMPORARY.
SELECT IF (status eq 1).
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Ecole Eleve_nom DISPLAY=LABEL
  /TABLE Ecole > Eleve_nom [COUNT F40.0]
  /CATEGORIES VARIABLES=Ecole Eleve_nom ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95.

TEMPORARY.
SELECT IF (status eq 2).
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Ecole_Replacement Eleve_nom_Replacement DISPLAY=LABEL
  /TABLE Ecole_Replacement > Eleve_nom_Replacement [COUNT F40.0]
  /CATEGORIES VARIABLES=Ecole_Replacement Eleve_nom_Replacement ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95.







