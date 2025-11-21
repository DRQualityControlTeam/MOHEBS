******************************************* MOHEBS SURVEY*************************************************************
*************************************************************************
********************************************************************************
// 00-init
cls
clear all
run "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Codes\MOHEBS\init\00-init.do"

*folder directories.
// ${gsdData} -- data
//${gsdCode} -- codes
//${gsdQChecks} -- QC
***************************************************************************
****STUDENT Survey
***************************************************************************

**Setting the working directory
cls
clear all
cd "${gsdData}\Raw"

***import dataset

import delimited "Pilot\Student\MOHEBS-MOHEBS_Baseline_Student_Survey-1763747498174.csv", case(preserve)

*****************************************************************************************************************
****Formating date
*****************************************************************************************************************

**date
tostring INT_DATE, replace
gen INT_DATE1 = date(INT_DATE, "MDY")
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(_id)
lab var INT_DATE"Interview date"

*filter out older dates
drop if INT_DATE < td(21nov2025)
drop if tabletUserName == "Deborah"

*****************************************************************************************************************
**dropping irrelevant variables
*****************************************************************************************************************
cd "${gsdCode}\MOHEBS\cleaning do file"

do "dropping_irrelevant_vars.do"

*Replacing UNDEFINED && SKIPPED
ds, has(type string)
foreach var in `r(varlist)'{
	replace `var' = "" if `var' == "SKIPPED"
	replace `var' = "." if `var' == "UNDEFINED"
	replace `var' = "." if `var' == "orphaned"
}

*Enumerator
label define enum 1  "Ousmane Mbengue" 2  "Rabia Sy" 3  "Aissatou Dieng" 4  "Diegou Diouf" 5  "Victorine Therese Sarr" 6  "Aissatou Diam" 7  "Abdou Aziz Diallo" 8  "Ibrahima Ndiaye" 9  "Seydou Diallo" 10 "Baye Mor Mbaye" 11 "Bineta Gningue" 12 "Boubacar Soumano" 13 "Ndeye Fatou Diop" 14 "Sackou Mbaye" 15 "Sette Niang" 16 "Souleymane Sène" 17 "Thiara Diene" 18 "Robert Armand Thiaré" 19 "Baba Adama Ndiaye" 20 "Mouhamet Diop" 21 "Oumar Thioye" 22 "Ramatoulaye Dramé" 23 "Elhadji Malick Diouf" 24 "Jeanne Bernadette Ndour" 25 "Mamadou Basse" 26 "Marie Noel Sène" 27 "Ndiambale Sarr" 28 "Abdou Khadre Diaby" 29 "Nogaye Dieng" 30 "Abdou Aziz Diagne" 31 "Adama Ba" 32 "Astou Kane" 33 "Mariama Diakhaté" 34 "Marieme Fall" 35 "Ngoné Mbodj" 36 "Salla Diara" 37 "Souhaibou Diop"

lab var ENUM_NAME"Enumerator Name"
lab values ENUM_NAME enum

**Survey Language
lab var survey_language"Enumerator: Record the language of instruction being used to administer the survey"
lab define sur_lan 1"French" 2 "Wolof" 3 "Serer" 4 "Pulaar"
destring survey_language, replace
lab values survey_language sur_lan

*Time.
gen double INT_STARTTIME1 = clock(INT_STARTTIME, "hm")
gen double INT_ENDTIME1 = clock(INT_ENDTIME, "hm")
format INT_STARTTIME1 INT_ENDTIME1 %tcHH:MM

gen double time_diff = INT_ENDTIME1 - INT_STARTTIME1
gen double Duration_mins = time_diff/(1000*60)

drop INT_STARTTIME INT_ENDTIME time_diff
ren INT_ENDTIME1 INT_ENDTIME
ren INT_STARTTIME1 INT_STARTTIME

lab var INT_STARTTIME"Interview Start time"
lab var INT_ENDTIME"Interview End time"
lab var Duration_mins"Interview Duration (Minutes)"

order INT_STARTTIME INT_ENDTIME Duration_mins,after(INT_DATE)

*assessment_type
lab var assessment_type"Is this an individual or pair assessment?"
lab define asse_ty 1"Individual assessment" 2 "Assessment in pair"
lab values assessment_type asse_ty

*Location
do "Location.do"

*Official language
lab var official_language"What is the Senegalese language in this school?"
recode official_language (3=4)(2=3)(1=2)

lab values official_language lan

*teaching_language
lab var teaching_language"What is the language teachers actually use to actually teach in the school?"
lab values teaching_language lan

*student_langugae_1
gen student_langugae =""
order student_langugae,before(student_langugae_1)
lab var student_langugae"What languages are you most comfortable speaking and reading in? (Select all that apply)"
lab var student_langugae_1 "French"
lab var student_langugae_2 "Wolof"
lab var student_langugae_3 "Serere"
lab var student_langugae_4 "Pulaar"
lab define yes_no 1 "Yes" 0 "No"

destring student_langugae_1	student_langugae_2	student_langugae_3	student_langugae_4,replace

lab values student_langugae_1	student_langugae_2	student_langugae_3	student_langugae_4 yes_no

order  student_langugae_1	student_langugae_2	student_langugae_3	student_langugae_4, after(teaching_language)

*consent
lab var Consent "Are you ready to start?"
replace Consent = "1" if Consent == "yes"
replace Consent = "0" if Consent == "no"

destring Consent,replace
lab values Consent yes_no

*B1a and B1b
lab var B1a"First name"
lab var B1b"Last name"
gen Student_Name = B1a + " " + B1b
order Student_Name,after(B1b)
lab var Student_Name"Student's Full names"

*B2
lab var B2"B2. What is your gender?:"
lab define gend 1"Boy" 2"Girl" 96"Other"
lab values B2 gend

*B3
lab var B3"B3. How old are you?"

*B4
lab var B4"B4. What grade are you in now ?"
lab define b4 1"CI" 2"CP" 3"CE1"
lab values B4 b4

*B5
lab var B5"B5. Did you attend a learning program (preschool/ Ecole maternelle ou préscolaire) before grade 1?"
lab define b5 1"Yes" 0"No" 98"Don't know/no answer"
lab values B5 b5

*B6
gen B6=""
order B6, before(B6_1)
lab var B6 "B6.	What language(s) do you speak at home? Tell me all the languages you speak at home."
lab var B6_1 "French"
lab var B6_2 "Wolof"
lab var B6_3 "Serere"
lab var B6_4 "Pulaar"
lab var B6_96 "Otherspecify"
lab var B6_S "Please specify Other"
lab values B6_1	B6_2 B6_3 B6_4 B6_96 yes_no

*B7
gen B7=""
order B7, before(B7_1)
lab var B7 "B7.	What language do you use when you play with your friends at school? Tell me about all the languages  you use when playing with your friends at school."
lab var B7_1 "French"
lab var B7_2 "Wolof"
lab var B7_3 "Serere"
lab var B7_4 "Pulaar"
lab var B7_96 "Otherspecify"
lab var B7_S "Please specify Other"
lab values B7_1	B7_2 B7_3 B7_4 B7_96 yes_no

*B8
lab var B8"B8. How many days of school did you miss in the last week?"
label define b8 1 "0 days, I attended school every day." 2 "1 day" 3 "2 days" 4 "3 days" 5 "4 days" 6 "5 days, I missed every day of school last week." 98 "Didn't Know/No Response"

lab values B8 b8

*B9
gen B9 = ""
lab var B9"B9. Why did you miss school? (Only ask if the student has missed days. Do not read the answer choices."
order B9,after(B8)

lab var B9_1"B9_1. I was sick."
lab var B9_2"B9_2. It was raining/The weather was bad."
lab var B9_3"B9_3. The teacher was not coming."
lab var B9_4"B9_4. I didn't want to go to school."
lab var B9_5"B9_5. I couldn't afford the course materials or pay my tuition."
lab var B9_6"B9_6.  I should have helped my mom or someone else with the housework."
lab var B9_7"B9_7. We need to help our parents find gainful employment or the earning potential of their parents."
lab var B9_8"B9_8. Transportation issues/or lack of transportation facilities"
lab var B9_9"B9_9.  Take care of your siblings."
lab var B9_10"B9_10.  No one helps me to go to school."
lab var B9_96"B9_96. Other, specify"
lab var B9_S"Please specify other"

destring B9_1	B9_2	B9_3	B9_4	B9_5	B9_6	B9_7	B9_8	B9_9	B9_10	B9_96,replace
lab values B9_1	B9_2	B9_3	B9_4	B9_5	B9_6	B9_7	B9_8	B9_9	B9_10	B9_96 yes_no

*B10
lab var B10"B10. Have you eaten today?"
lab define b10 1"Yes" 0"No" 99 "No response"
lab values B10 b10

*B12
lab var B12"B12. During this school year, are you taking any extra tutoring outside of the school day?"
lab values B12 b10


*************************************************************************
**Semantic section
*************************************************************************
gen languages_spoken = ""
order languages_spoken, before(languages_spoken_1)
lab var languages_spoken "Enumerator: Select all the languages mentioned by the student in B6 and B7"
lab var languages_spoken_1 "French"
lab var languages_spoken_2 "Wolof"
lab var languages_spoken_3 "Serere"
lab var languages_spoken_4 "Pulaar"
lab var languages_spoken_96 "Otherspecify - 1" 
lab var languages_spoken_996 "Otherspecify - 2" 
lab var languages_spoken_9996 "Otherspecify - 3" 
lab var languages_spoken_S1 "Please specify Other - 1"
lab var languages_spoken_S2 "Please specify Other - 2"
lab var languages_spoken_S3 "Please specify Other - 3"
foreach x in languages_spoken_1 languages_spoken_2 languages_spoken_3	languages_spoken_4 languages_spoken_96 languages_spoken_996	languages_spoken_9996{
	lab values `x' yes_no
}

*semantic_test_language1
foreach x in semantic_test_language1 semantic_test_language2{
	lab var `x'"Which language are you testing in?"
}

lab define sema_lan 1"French" 2"Wolof" 3"Serer" 4"Pulaar" 96"Other 1" 996"Other 2" 9996"Other 3"
destring semantic_test_language1 semantic_test_language2,replace
lab values semantic_test_language1 semantic_test_language2 sema_lan

ren (v105 v121) (semantic_lan_timer1items_att semantic_lan_timer2items_att)


*************************************************************************
**Phonological section
*************************************************************************
ren v152 phonological_awareness_srnum_att
ren v933 phonological_awareness_wfnum_att
ren v1419 phonological_awareness_frnum_att
ren v2034 phonological_awareness_prnum_att

destring interviewer_phonological_stop_sr phonological_awareness_srautoSto phonological_awareness_srnum_att phonological_awareness_srnumber_ phonological_awareness_sr_* phonological_awareness_wf_* phonological_awareness_wfnum_att phonological_awareness_wfnumber_ interviewer_phonological_stop_wf phonological_awareness_wfautoSto phonological_awareness_fr_*  phonological_awareness_frnum_att phonological_awareness_frnumber_ phonological_awareness_frautoSto  interviewer_phonological_stop_fr phonological_awareness_prnum_att phonological_awareness_prautoSto phonological_awareness_prnumber_ interviewer_phonological_stop_pr,replace

*interviewer_phonological_stop_sr
lab values interviewer_phonological_stop_sr interviewer_phonological_stop_pr interviewer_phonological_stop_fr interviewer_phonological_stop_wf yes_no

order phonological_awareness_fr_* phonological_awareness_frnumber_ phonological_awareness_frnum_att phonological_awareness_frgridAut phonological_awareness_frautoSto interviewer_phonological_stop_fr  phonological_awareness_wf_* phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto interviewer_phonological_stop_wf phonological_awareness_sr_* phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto interviewer_phonological_stop_sr,before(v230)

*************************************************************************
**Oral Vocabulary section
*************************************************************************
ren (v230 v235 v240 v245 v250 v255 v260 v265 v270 v275 v280	v285 v290 v295 v300 v305 v310 v1425 v1428 v1431 v1434 v1437 v1440 v1443 v1446 v1449 v1452 v1455 v1458 v1461 v1464 v1467 v1470 v1473 v939 v942 v945 v948 v951 v954 v957 v960 v963 v966 v969 v972 v975 v978 v981 v984 v987 v2040	v2043	v2046	v2049	v2052	v2055	v2058	v2061	v2064	v2067	v2070	v2073	v2076	v2079	v2082	v2085	v2088) (sr_oral_vocabulary_example_1  sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 fr_oral_vocabulary_example_1  fr_oral_vocabulary_example_2 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15)

destring sr_oral_vocabulary_example_1 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 fr_oral_vocabulary_example_1  fr_oral_vocabulary_example_2 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15, replace

order fr_oral_vocabulary_example_1  fr_oral_vocabulary_example_2 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 sr_oral_vocabulary_example_1 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15,after(interviewer_phonological_stop_sr)


*************************************************************************
**Letter Knowledge section
*************************************************************************















**************************************
**Variable Renaming
****************************************

***Renaming of variables
ren letter_knowledge_prnumber_of_ite letter_knowledge_prnum_corr
ren letter_knowledge_wfnumber_of_ite letter_knowledge_wfnum_corr
ren letter_knowledge_srnumber_of_ite letter_knowledge_srnum_corr
ren v987 letter_knowledge_srnum_att
ren v314 letter_knowledge_prnum_att
ren v767 letter_knowledge_wfnum_att

ren reading_familiar_words_wfnumber_ reading_familiar_words_wfnum_cor
ren reading_familiar_words_srnumber_ reading_familiar_words_srnum_cor
ren reading_familiar_words_prnumber_ reading_familiar_words_prnum_cor
ren v373 reading_familiar_words_prnum_att
ren v826 reading_familiar_words_wfnum_att
ren v1046 reading_familiar_words_srnum_att

ren oral_reading_fluency_prnumber_of oral_reading_fluency_prnum_corr
ren oral_reading_fluency_srnumber_of oral_reading_fluency_srnum_corr
ren oral_reading_fluency_wfnumber_of oral_reading_fluency_wfnum_corr
ren v421 oral_reading_fluency_prnum_att
ren v878 oral_reading_fluency_wfnum_att
ren v1098 oral_reading_fluency_srnum_att

ren v535 digital_discrimination_1num_att
ren v544 digital_discrimination_2num_att
ren v553 digital_discrimination_3num_att

ren v590 substraction_grid_1num_att
ren v599 substraction_grid_2num_att
ren v608 substraction_grid_3num_att

*****************************************************************************************************************
**Value labelling
*****************************************************************************************************************






*Status
lab define stat 1"Student present" 2"Student absent"
lab values status stat





*lang
ren selected_studentLangue_2_label student_lang
replace student_lang =  "2" if student_lang == "wolof"
replace student_lang =  "3" if student_lang == "serere"
replace student_lang =  "4" if student_lang == "pulaar"

destring student_lang,replace
lab values student_lang sur_lan

*Letter Knowledge
lab define cor_inc 1"Correct" 0"Incorrect"
destring letter_knowledge_*, replace
lab values letter_knowledge_sr_* letter_knowledge_wf_* letter_knowledge_pr_* cor_inc

*Reading familiar word
destring reading_familiar_words_*, replace
lab values reading_familiar_words_pr_* reading_familiar_words_wf_* reading_familiar_words_sr_* cor_inc

*Oral reading fluency
destring oral_reading_fluency_*,replace
lab values oral_reading_fluency_wf_* oral_reading_fluency_pr_* oral_reading_fluency_sr_* cor_inc

*Reading comprehension
lab define read_comp 1 "Correct" 2 "Incorrect" 3 "No answer"
destring reading_comprehension_q*,replace
lab values reading_comprehension_q* read_comp

*picture_matching
destring picture_matching_*, replace

forval i = 1/11 {
    gen double corr_pic`i' = 0
}

replace corr_pic1 = 1 if picture_matching_q1selection == 3
replace corr_pic2 = 1 if picture_matching_q2selection == 3
replace corr_pic3 = 1 if picture_matching_q3selection == 4
replace corr_pic4 = 1 if picture_matching_q4selection == 1
replace corr_pic5 = 1 if picture_matching_q5selection == 1 
replace corr_pic6 = 1 if picture_matching_q6selection == 1
replace corr_pic7 = 1 if picture_matching_q7selection == 3 
replace corr_pic8 = 1 if picture_matching_q8selection == 3
replace corr_pic9 = 1 if picture_matching_q9selection == 2
replace corr_pic10 = 1 if picture_matching_q10selection == 2
replace corr_pic11 = 1 if picture_matching_q11selection == 4 //check which is the correct answer.


order corr_pic*, after(picture_matching_q11selection)

gen double picture_matching_score = 0
forval i = 1/11 {
    replace picture_matching_score = picture_matching_score + corr_pic`i'
}

order picture_matching_score, after(corr_pic11)
drop corr_pic*

lab var picture_matching_score" Scores of correct answer in Image matching Section"

****STudent Numerical
*dropping irrelevant variables
drop number_grid_3number_of_items_att counting_grid_1number_of_items_a counting_grid_2number_of_items_a counting_grid_1number_of_items_a number_grid_3number_of_items_att number_grid_2number_of_items_att number_grid_1number_of_items_att digital_discrimination_1num_att digital_discrimination_3num_att addition_grid_1number_of_items_a addition_grid_3number_of_items_a substraction_grid_2num_att substraction_grid_3num_att addition_grid_2number_of_items_a substraction_grid_1num_att addition_grid_2number_of_items_a

*Numeric grid
destring number_grid_*,replace
lab values number_grid_1_* number_grid_2_* number_grid_3_* cor_inc

ren number_grid_1number_of_items_cor number_grid_1num_corr
ren number_grid_2number_of_items_cor number_grid_2num_corr
ren number_grid_3number_of_items_cor number_grid_3num_corr

*Counting
destring counting_grid_*,replace
lab values counting_grid_1_* counting_grid_2_* counting_grid_3_* counting_grid_4_* counting_grid_5_* counting_grid_6_* cor_inc

ren counting_grid_1number_of_items_c counting_grid_1num_corr
ren counting_grid_2number_of_items_c counting_grid_2num_corr
ren counting_grid_3number_of_items_c counting_grid_3num_corr
ren counting_grid_4number_of_items_c counting_grid_4num_corr
ren counting_grid_5number_of_items_c counting_grid_5num_corr
ren counting_grid_6number_of_items_c counting_grid_6num_corr

*Discrimination
destring digital_discrimination_*,replace
lab values digital_discrimination_3_* digital_discrimination_2_* digital_discrimination_1_* cor_inc

ren digital_discrimination_1number_o digital_discrimination_1num_corr
ren digital_discrimination_2number_o digital_discrimination_2num_corr
ren digital_discrimination_3number_o digital_discrimination_3num_corr

*Addition Grid
destring addition_grid_*,replace
lab values addition_grid_3_* addition_grid_2_* addition_grid_1_* cor_inc

ren addition_grid_1number_of_items_c addition_grid_1num_corr
ren addition_grid_2number_of_items_c addition_grid_2num_corr
ren addition_grid_3number_of_items_c addition_grid_3num_corr

destring correct_addition_grid_1 correct_addition_grid_2,replace
lab values correct_addition_grid_1 correct_addition_grid_2 dig

*Subtraction Grid
destring substraction_grid_*,replace
lab values substraction_grid_1_* substraction_grid_2_* substraction_grid_3_* cor_inc

ren substraction_grid_1number_of_ite substraction_grid_1num_corr
ren substraction_grid_2number_of_ite substraction_grid_2num_corr
ren substraction_grid_3number_of_ite substraction_grid_3num_corr

destring correct_substraction_grid_1 correct_substraction_grid_2,replace
lab values correct_substraction_grid_1 correct_substraction_grid_2 dig

*Addition strategy Grid
lab define yesno 1"yes" 2"No"

gen addition_strategy = .
lab var addition_strategy"Note the strategy the child used to solve the question (more than one option can be chosen)"
order addition_strategy,before(addition_strategy_1)

foreach x in  addition_strategy_1 addition_strategy_2 addition_strategy_3 substraction_strategy_1 substraction_strategy_2 substraction_strategy_3{
    replace `x' = "2" if `x' == "0"
}

destring addition_strategy_*,replace
lab values addition_strategy_* yesno

**Substraction strategy Grid
gen substraction_strategy = .
lab var substraction_strategy"Note the strategy the child used to solve the question (more than one option can be chosen)"
order substraction_strategy,before(substraction_strategy_1)

destring substraction_strategy_*,replace
lab values substraction_strategy_* yesno


*B9
lab define B9 1 "Yes" 2 "No" 3 "Don't know/No answer"

gen B10 =.
order B10, before(B10a)
destring B9 B10a B10b B10c B10d B10e B10f B10g B10h B10j B11 B12, replace
lab values B9 B10a B10b B10c B10d B10e B10f B10g B10h B10j B11 B12 B9

*GPS
destring gpslatitude gpslongitude gpsaccuracy, replace

*id
ren _id interview_ID
lab var interview_ID"Interview Unique ID"

*Restructuring
do "Restructuring_the assessment_sections.do"

*Letter_knowledge
lab values letter_knowledge_1 - letter_knowledge_100 cor_inc

*reading familiar
lab values reading_familiar_words_1 - reading_familiar_words_50 cor_inc

*Oral Fluency.
lab values oral_reading_fluency_1 - oral_reading_fluency_43 cor_inc

*correct_number
lab define cr_grd 1"0 to 3 correct answers" 2"4 or more correct answers"

destring correct_number_grid_1 correct_number_grid_2, replace
lab values correct_number_grid_1 correct_number_grid_2 cr_grd

lab define cr_dd 1"0 - 1 correct answer" 2"2 or more correct answers"
destring correct_dd_grid_1 correct_dd_grid_2 correct_addition_grid_1 correct_addition_grid_2 correct_substraction_grid_1 correct_substraction_grid_2,replace
lab values correct_dd_grid_1 correct_dd_grid_2 correct_addition_grid_1 correct_addition_grid_2 correct_substraction_grid_1 correct_substraction_grid_2 cr_dd

*B13 and B14
destring B13 B14, replace

lab define yesnomay 1"Yes" 2"No" 3"Don't know"
lab values B13 B14 yesnomay

*Ordering
***Order the dataset according the questionnaire
order interview_ID interview_date start_time tabletUserName SUP_NAME  ENUM_NAME IEF Commune Ecole Niveau Eleve_nom n_classes n_classes_2 CLASSE_NUM Sexe status survey_language consent  letter_knowledge* reading_familiar_words_* reading_familiar_* oral_reading_fluency_*  oral_reading_* reading_comprehension_* picture_matching_* number_grid_1* correct_number_grid_1 number_grid_2* correct_number_grid_2 number_grid_3* counting_grid* digital_discrimination_1* correct_dd_grid_1 digital_discrimination_2* correct_dd_grid_2 digital_discrimination_3* addition_grid_1* correct_addition_grid_1 addition_grid_2* correct_addition_grid_2 addition_grid_3* addition_strategy addition_strategy_* substraction_grid_1* correct_substraction_grid_1 substraction_grid_2* correct_substraction_grid_2 substraction_grid_3* substraction_strategy substraction_strategy_* Gender Age Grade B* end_time end_time ENUM_COMMENTS gps*
*****************************************************************************************************************
**Variable labelling
*
do "Labelling_file.do"

*****************************************************************************************************************
**QC Checks
*************************************************************************
*Dropping unconsented
drop if consent == 2


*Tranlations
// do "Translations.do"

*QC Corrections

do "Picture_matching.do"

*QC corr 2
*22-10
replace ENUM_NAME = 28 if inlist(interview_ID,"6e2d79d0-5f89-42ba-835e-fa3574fafc69","4d9116ea-5d59-4c98-9a3a-f8b9b7f45400")

foreach x in letter_knowledge_1	letter_knowledge_2 letter_knowledge_3 letter_knowledge_4 letter_knowledge_5 letter_knowledge_6	letter_knowledge_7	letter_knowledge_8	letter_knowledge_9	letter_knowledge_10 letter_knowledge_correct letter_knowledge_items_per_min{
	replace `x' = 0 if inlist(interview_ID,"9eb12d4b-6750-4261-9120-787b0708074d","0d93561a-7ba0-4a48-9d79-debd89af0f91")
}

replace letter_knowledge_time_remaining = 23 if inlist(interview_ID,"9eb12d4b-6750-4261-9120-787b0708074d","0d93561a-7ba0-4a48-9d79-debd89af0f91")

replace letter_knowledge_gridAutoStopp = 1 if inlist(interview_ID,"9eb12d4b-6750-4261-9120-787b0708074d","0d93561a-7ba0-4a48-9d79-debd89af0f91")

replace letter_knowledge_attempt =10 if inlist(interview_ID,"9eb12d4b-6750-4261-9120-787b0708074d","0d93561a-7ba0-4a48-9d79-debd89af0f91")

foreach x in reading_familiar_words_1	reading_familiar_words_2	reading_familiar_words_3	reading_familiar_words_4	reading_familiar_words_5 reading_familiar_correct reading_familiar_items_per_min{
	replace `x' = 0 if inlist(interview_ID,"832a7192-f5d5-4297-9c65-4a6fd5af12f9","79e73117-b815-46dd-a0ad-fa9c4acd0215")
}

replace reading_familiar_remaining = 41 if inlist(interview_ID,"832a7192-f5d5-4297-9c65-4a6fd5af12f9","79e73117-b815-46dd-a0ad-fa9c4acd0215")

replace reading_familiar_gridAutoStopp = 1 if inlist(interview_ID,"832a7192-f5d5-4297-9c65-4a6fd5af12f9","79e73117-b815-46dd-a0ad-fa9c4acd0215")

replace reading_familiar_attempt = 5 if inlist(interview_ID,"832a7192-f5d5-4297-9c65-4a6fd5af12f9","79e73117-b815-46dd-a0ad-fa9c4acd0215")

foreach x in B5_4 B6_4{
	replace `x' = 1 if interview_ID == "78c2a6e2-6ab2-48e7-a6af-8309811bad2b"
}

replace correct_number_grid_2 = 1 if inlist(interview_ID, "2b1f7938-79e6-409f-9fd2-70eebc2e75c3","0a71238e-3afa-49d7-bbe5-c1a29957ff5a")

foreach x in number_grid_3_1	number_grid_3_2	number_grid_3_3	number_grid_3_4	number_grid_3_5	number_grid_3_6	number_grid_3_7	number_grid_3_8	number_grid_3num_corr{
	replace `x' = . if inlist(interview_ID, "2b1f7938-79e6-409f-9fd2-70eebc2e75c3","0a71238e-3afa-49d7-bbe5-c1a29957ff5a")
}

*23-10
replace ENUM_NAME = 20 if inlist(interview_ID, "8106279d-7cd7-4662-9312-6dddf04d9879","90e08d70-7438-4237-a6fa-c1ddec1a06c6")

replace ENUM_NAME = 28 if inlist(interview_ID, "84fe63b7-b4a8-459c-8599-3c7230a777d9","63e5acd7-1cdd-4180-813d-139203ec76a8","8cd9b019-69ca-4ff8-b5f6-795db07f5e46")

foreach x in letter_knowledge_1	letter_knowledge_2 letter_knowledge_3 letter_knowledge_4 letter_knowledge_5 letter_knowledge_6	letter_knowledge_7	letter_knowledge_8	letter_knowledge_9	letter_knowledge_10 letter_knowledge_correct letter_knowledge_items_per_min{
	replace `x' = 0 if inlist(interview_ID,"0d93561a-7ba0-4a48-9d79-debd89af0f91","6a8d5f9f-229d-416c-8ad6-4991488df314","0eba41c1-1d39-4207-b26f-bcf5c0dd23f7","6cf2cb12-9ac9-4712-8f2a-a8e496d8aff0","3e910c07-c52b-45fe-90a6-fdd53dfed6e7","2bef1f4a-d99d-4432-b523-78b5e223401b")
}

replace letter_knowledge_time_remaining = 17 if inlist(interview_ID,"0d93561a-7ba0-4a48-9d79-debd89af0f91","6a8d5f9f-229d-416c-8ad6-4991488df314","0eba41c1-1d39-4207-b26f-bcf5c0dd23f7","6cf2cb12-9ac9-4712-8f2a-a8e496d8aff0","3e910c07-c52b-45fe-90a6-fdd53dfed6e7","2bef1f4a-d99d-4432-b523-78b5e223401b")

replace letter_knowledge_gridAutoStopp = 1 if inlist(interview_ID,"0d93561a-7ba0-4a48-9d79-debd89af0f91","6a8d5f9f-229d-416c-8ad6-4991488df314","0eba41c1-1d39-4207-b26f-bcf5c0dd23f7","6cf2cb12-9ac9-4712-8f2a-a8e496d8aff0","3e910c07-c52b-45fe-90a6-fdd53dfed6e7","2bef1f4a-d99d-4432-b523-78b5e223401b")

replace letter_knowledge_attempt =10 if inlist(interview_ID,"0d93561a-7ba0-4a48-9d79-debd89af0f91","6a8d5f9f-229d-416c-8ad6-4991488df314","0eba41c1-1d39-4207-b26f-bcf5c0dd23f7","6cf2cb12-9ac9-4712-8f2a-a8e496d8aff0","3e910c07-c52b-45fe-90a6-fdd53dfed6e7","2bef1f4a-d99d-4432-b523-78b5e223401b")

foreach x in reading_familiar_words_1	reading_familiar_words_2	reading_familiar_words_3	reading_familiar_words_4	reading_familiar_words_5 reading_familiar_correct reading_familiar_items_per_min{
	replace `x' = 0 if inlist(interview_ID,"6a8d5f9f-229d-416c-8ad6-4991488df314","df702af3-82c3-423f-8be9-8736cd6ddb7e","e8cddb56-a5be-421b-a5e5-f89df3a0a851","16bc274d-8a2d-4983-b76f-8bf831127eaa","138f465a-5867-4112-8b3e-9f38b7259ee3","a0e9eba2-da58-488e-b4d1-039aec3da45c","f88dcb9f-5c7f-4b0c-a39e-0f023afdcf26","48e77ca3-e02b-47aa-a57a-e8857b2f1bb8")
}

replace reading_familiar_remaining = 39 if inlist(interview_ID,"6a8d5f9f-229d-416c-8ad6-4991488df314","df702af3-82c3-423f-8be9-8736cd6ddb7e","e8cddb56-a5be-421b-a5e5-f89df3a0a851","16bc274d-8a2d-4983-b76f-8bf831127eaa","138f465a-5867-4112-8b3e-9f38b7259ee3","a0e9eba2-da58-488e-b4d1-039aec3da45c","f88dcb9f-5c7f-4b0c-a39e-0f023afdcf26","48e77ca3-e02b-47aa-a57a-e8857b2f1bb8")

replace reading_familiar_gridAutoStopp = 1 if inlist(interview_ID,"6a8d5f9f-229d-416c-8ad6-4991488df314","df702af3-82c3-423f-8be9-8736cd6ddb7e","e8cddb56-a5be-421b-a5e5-f89df3a0a851","16bc274d-8a2d-4983-b76f-8bf831127eaa","138f465a-5867-4112-8b3e-9f38b7259ee3","a0e9eba2-da58-488e-b4d1-039aec3da45c","f88dcb9f-5c7f-4b0c-a39e-0f023afdcf26","48e77ca3-e02b-47aa-a57a-e8857b2f1bb8")

replace reading_familiar_attempt = 5 if inlist(interview_ID,"6a8d5f9f-229d-416c-8ad6-4991488df314","df702af3-82c3-423f-8be9-8736cd6ddb7e","e8cddb56-a5be-421b-a5e5-f89df3a0a851","16bc274d-8a2d-4983-b76f-8bf831127eaa","138f465a-5867-4112-8b3e-9f38b7259ee3","a0e9eba2-da58-488e-b4d1-039aec3da45c","f88dcb9f-5c7f-4b0c-a39e-0f023afdcf26","48e77ca3-e02b-47aa-a57a-e8857b2f1bb8")

drop if interview_ID == "63b99c8c-81ef-41f8-96bd-50d184c8e18f"

replace correct_dd_grid_2 = 1 if inlist(interview_ID, "623df2d5-f5ee-4406-a044-0fea6affdcdb","7b9556cb-3df2-4cd8-b58e-6295e80fc924")

foreach x in digital_discrimination_3_1	digital_discrimination_3_2	digital_discrimination_3_3	digital_discrimination_3_4	digital_discrimination_3num_corr{
	replace `x'=. if inlist(interview_ID, "623df2d5-f5ee-4406-a044-0fea6affdcdb","7b9556cb-3df2-4cd8-b58e-6295e80fc924")
}

replace correct_substraction_grid_1 = 1 if interview_ID == "e8cddb56-a5be-421b-a5e5-f89df3a0a851"

foreach x in substraction_grid_2_1	substraction_grid_2_2	substraction_grid_2_3	substraction_grid_2_4	substraction_grid_2num_corr	correct_substraction_grid_2	substraction_grid_3_1	substraction_grid_3_2	substraction_grid_3_3	substraction_grid_3_4	substraction_grid_3num_corr	substraction_strategy{
	replace `x' = 0 if interview_ID == "e8cddb56-a5be-421b-a5e5-f89df3a0a851"
}

replace correct_substraction_grid_2 = 2 if interview_ID == "894894a7-024e-4b75-b9b9-4cc519ad6673"

foreach x in substraction_grid_3_1	substraction_grid_3_2	substraction_grid_3_3	substraction_grid_3_4	substraction_grid_3num_corr	substraction_strategy{
	replace `x' = 0 if interview_ID == "894894a7-024e-4b75-b9b9-4cc519ad6673"
}

*14-11
replace ENUM_NAME = 28 if inlist(interview_ID,"74c5d45a-aa50-44ba-976a-a683132e49e3","98c697fc-5240-47d9-96a8-eef8e765374b","b517a783-e01e-4b17-9b99-9e8fba66c6fd","9aae20cd-8539-42a8-af08-918ddcd68835","1e2dd812-2b7b-43a5-952d-8d9b5cf81e23")

foreach x in oral_reading_duration	oral_reading_remaining	oral_reading_gridAutoStopp	oral_reading_correct	oral_reading_attempt{
	replace `x' = .  if inlist(interview_ID, "e311fa66-07a9-4785-bbfe-4ac355bbcf09","3a8f67a0-f932-4c06-9adf-1ffe80ec41ac","e7010601-952d-43b2-a77f-a7c9848c0990","8995a555-c2a4-41a7-9b7e-65e92b4af0e0","9d2b43f8-afad-41cc-87e9-a8d784072862")
}

*14-11
drop if inlist(interview_ID,"5c406e16-cca1-46e3-921f-0f5481b46788","a8aa1d57-dffd-4724-851b-ab66bb529b93")

replace correct_number_grid_2 = 2 if interview_ID == "7b9556cb-3df2-4cd8-b58e-6295e80fc924"

replace number_grid_3_1	= 1 if interview_ID == "7b9556cb-3df2-4cd8-b58e-6295e80fc924"

foreach x in number_grid_3_2 number_grid_3_3 number_grid_3_4	number_grid_3_5	number_grid_3_6	number_grid_3_7	number_grid_3_8{
	replace `x' = 0 if interview_ID == "7b9556cb-3df2-4cd8-b58e-6295e80fc924"
}

replace digital_discrimination_1_3 = 0 if interview_ID == "7a763838-4133-408b-9876-a74737f0c4e0"
replace digital_discrimination_1_2 = 0 if interview_ID == "7a763838-4133-408b-9876-a74737f0c4e0"
replace digital_discrimination_1num_corr = 1 if interview_ID == "7a763838-4133-408b-9876-a74737f0c4e0"

replace number_grid_2_5 = 0 if interview_ID == "d5dd8269-63db-48a4-aacf-696ca3e24a97"
replace number_grid_2num_corr = 3 if interview_ID == "d5dd8269-63db-48a4-aacf-696ca3e24a97"

replace Eleve_nom = "Adji Dibor Diallo" if interview_ID == "9b510cc9-6c3c-4696-a86a-a2a38deb498b"

foreach x in letter_knowledge_1 letter_knowledge_10 letter_knowledge_correct letter_knowledge_items_per_min{
	replace `x' = 0 if interview_ID == "dc63d32a-13fa-4ada-9d52-714fa1d0672b"
}

replace letter_knowledge_time_remaining = 27 if interview_ID == "dc63d32a-13fa-4ada-9d52-714fa1d0672b"
replace letter_knowledge_gridAutoStopp = 1 if interview_ID == "dc63d32a-13fa-4ada-9d52-714fa1d0672b"
replace letter_knowledge_attempt = 10 if interview_ID == "dc63d32a-13fa-4ada-9d52-714fa1d0672b"

replace ENUM_NAME = 28 if inlist(interview_ID,"85ca2f6c-aef6-4a12-9a6b-fd2038544220","51d316e4-c34c-4675-8d37-7201244c3795","5adb2a0b-bca1-4824-a2b0-c0642d3cecdb")

foreach x in reading_familiar_words_5 reading_familiar_words_3 reading_familiar_correct reading_familiar_items_per_min{
	replace `x' = 0 if interview_ID == "445ecefc-f003-4dee-a1b1-a9ae3d642f9b"
}
replace reading_familiar_gridAutoStopp = 1 if interview_ID == "445ecefc-f003-4dee-a1b1-a9ae3d642f9b"
replace reading_familiar_remaining = 35 if interview_ID == "445ecefc-f003-4dee-a1b1-a9ae3d642f9b"
replace reading_familiar_attempt = 5 if interview_ID == "445ecefc-f003-4dee-a1b1-a9ae3d642f9b"

replace oral_reading_items_per_min = 27 if interview_ID == "7751daf6-ed68-43b0-8fab-8a0880326897"
replace oral_reading_remaining = 0 if interview_ID == "7751daf6-ed68-43b0-8fab-8a0880326897"

replace number_grid_2_4 = 0 if interview_ID == "afab19c1-feb9-4723-a650-a75bd7b6595d"
replace number_grid_2num_corr = 3 if interview_ID == "afab19c1-feb9-4723-a650-a75bd7b6595d"

replace correct_dd_grid_2 = 1 if interview_ID == "de4ebbfc-b956-46fc-b0be-5fc7d837ab2d"

foreach x in number_grid_2_1	number_grid_2_2	number_grid_2_3 number_grid_2_6	number_grid_2_7 number_grid_2_8{
	replace `x' = 1 if interview_ID == "56530f7c-42b2-4013-a211-a43a12ed5b73"
}

foreach x in number_grid_2_2	number_grid_2_3 number_grid_2_6 number_grid_2_8 number_grid_2_1{
	replace `x' = 1 if interview_ID == "56530f7c-42b2-4013-a211-a43a12ed5b73"
}

foreach x in reading_familiar_correct reading_familiar_items_per_min addition_grid_2_2	addition_grid_2_3{
	replace `x' = 0 if interview_ID == "659898a8-50d3-4654-aada-c82195e38fdf"
}

replace addition_grid_2num_corr = 1 if interview_ID == "ea6650f6-ee9d-4e81-bd00-e1295cc92784"

replace addition_grid_2_3 = 1 if interview_ID == "fe468165-658a-4e01-8dd9-31a87043f7c6"
replace addition_grid_2num_corr = 2 if interview_ID == "fe468165-658a-4e01-8dd9-31a87043f7c6"

replace number_grid_1_8 = 0 if interview_ID == "1612876c-3f39-4f2f-b57d-1eddf9bbc92d"

replace number_grid_1num_corr = 3 if interview_ID == "1612876c-3f39-4f2f-b57d-1eddf9bbc92d"

replace number_grid_2num_corr = 6 if interview_ID == "56530f7c-42b2-4013-a211-a43a12ed5b73"

replace ENUM_NAME = 26 if interview_ID == "c2d9bb27-6c1b-4d38-9190-52f1e3596200"

replace Eleve_nom = "Aithia Guisse" if interview_ID == "a290f555-1ce1-41a2-8b12-cd987ab40dfc"

replace Grade = 2 if interview_ID == "3a664179-3acb-4380-8296-2c76626720c8"

replace reading_familiar_remaining = reading_familiar_remaining + 10  if reading_familiar_gridAutoStopp == 1

replace letter_knowledge_time_remaining = letter_knowledge_time_remaining + 10  if letter_knowledge_gridAutoStopp == 1

replace Eleve_nom = "Aliou Diouf" if interview_ID == "b5c5b14d-1974-4eb4-9d82-693b809b995b"

drop if interview_ID == "72e852f9-8a12-4cd4-8476-e522320b01fb"

replace number_grid_3num_corr  = 1 if interview_ID == "7b9556cb-3df2-4cd8-b58e-6295e80fc924"

foreach x in digital_discrimination_3_1	digital_discrimination_3_2	digital_discrimination_3_3	digital_discrimination_3_4	digital_discrimination_3num_corr{
	replace `x' = . if correct_dd_grid_2 == 1
}

foreach x in addition_grid_2_1	addition_grid_2_2	addition_grid_2_3	addition_grid_2_4	addition_grid_2num_corr{
	replace `x' = . if correct_addition_grid_1 == 1
}

foreach x in substraction_grid_2_1	substraction_grid_2_2	substraction_grid_2_3	substraction_grid_2_4	substraction_grid_2num_corr{
	replace `x' = . if correct_substraction_grid_1 == 1
}				

foreach x in correct_substraction_grid_2 substraction_grid_3_1	substraction_grid_3_2	substraction_grid_3_3	substraction_grid_3_4	substraction_grid_3num_corr substraction_strategy{
	replace `x' = . if  correct_substraction_grid_1 == 1
}	

**Check the correct lang SocÃ©.

replace B5_s1 =trim(B5_s1)
replace B5_s1 = "Bambara" if B5_s1 == "bambara"

replace B6_s1 =trim(B6_s1)
replace B6_s1 = "Bambara" if B6_s1 == "bambara"

drop n_classes
ren n_classes_2 n_classes

lab define ages 999 "unknown"
lab values Age ages

save "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT\Endline\Data\Raw\Main\UND NDAW WUNE Endline Processed Dataset 14-11 v01.dta",replace

// drop B5_s2 B5_s3 B6_s2 B6_s3 ENUM_COMMENTS
// order student_lang, after(survey_language)
// order end_time,after(B14)
// drop gpslatitude	gpslongitude	gpsaccuracy
//
// save "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\UND NDAW PROJECT\Endline\Data\Clean\UND NDAW WUNE Endline Clean Dataset 14-11 v01.dta",replace

***************************************************************************************QC checks-Flaggings
***************************************************************************************
* QC files
cd "${gsdQChecks}"

**
* Create the date folders
****************************************************************************************************

// --- Step 1: Get today's date ---
local td = date(c(current_date), "DMY")

local d = day(`td')
local m = month(`td')
local foldername : display %02.0f `d' "-" %02.0f `m'
global dates : display %02.0f `d' "-" %02.0f `m'
display "`foldername'"

local folder "${dates}"
capture rmdir /s /q "`folder'"
capture mkdir "`folder'"

* QC files
cd "${dates}"

* var_kept
global var_kept "interview_ID interview_date SUP_NAME ENUM_NAME IEF Commune Ecole Niveau Eleve_nom n_classes CLASSE_NUM Sexe status Gender Age Grade survey_language"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(duration_mins,30,60)
cap export excel $var_kept start_time end_time duration_mins issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort interview_date ENUM_NAME (start_time): gen gap_mins = (start_time - end_time[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept start_time end_time gap_mins issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**GPS Accuracy
preserve
replace issue_comment ="The GPS Accuracy captured is low"
keep if gpsaccuracy> 20
cap export excel $var_kept gps* issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(gpsaccuracy_issues,replace)firstrow(variables)
restore

**Duplicates GPS
duplicates tag gpslatitude gpslongitude, gen (gps_dup)

preserve
replace issue_comment ="The GPS captured are duplicated, kindly clarify"
keep if gps_dup> 0
cap export excel $var_kept gps* issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(gps_duplicates_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag Ecole Eleve_nom Sexe,gen(int_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if int_dup>0
cap export excel $var_kept int_dup issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(Interv_dupl_main_issues,replace)firstrow(variables)
restore

*Ensuring Replacement info == to the main

**Gender not matching
preserve
replace issue_comment ="The Gender of the student not matching the one sampled, kindly clarify"
keep if Sexe != Gender & status == 1
cap export excel $var_kept issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(GenderNotMatch_issues,replace)firstrow(variables)
restore

**Grade not matching
preserve
replace issue_comment ="The Grade of the student not matching the one sampled, kindly clarify"
keep if Niveau != Grade & status == 1
cap export excel $var_kept issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(GradeNotMatch_issues,replace)firstrow(variables)
restore


*Letter_knowledge 
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_time_remaining >30 & letter_knowledge_gridAutoStopp == 0)| letter_knowledge_gridAutoStopp == 1 | letter_knowledge_attempt < 10
cap export excel $var_kept letter_knowledge* issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(Letter_knowledge_time,replace)firstrow(variables)
restore

* reading familiar 
preserve
replace issue_comment ="Timer in the reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (reading_familiar_remaining >30 & reading_familiar_gridAutoStopp == 0)| reading_familiar_gridAutoStopp == 1 | reading_familiar_attempt < 5
cap export excel $var_kept reading_familiar* issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(reading_familiar_time,replace)firstrow(variables)
restore

* Oral fluency 
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_remaining >30 & oral_reading_gridAutoStopp == 0)| oral_reading_gridAutoStopp == 1
cap export excel $var_kept oral_reading_* issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(oral_fluency_time,replace)firstrow(variables)
restore

**Languages spoken and used home by kid is different from the interview survey language
lab define b6 1 "French" 2 "Wolof" 3 "Serere" 4 "Pulaar" 95 "Otherspecify - 1" 96 "Otherspecify - 2" 97 "Otherspecify - 3"

replace B6_1 = 1 if B6_1 == 1
replace B6_2 = 2 if B6_2 == 1
replace B6_3 = 3 if B6_3 == 1
replace B6_4 = 4 if B6_4 == 1
replace B6_5 = 95 if B6_5 == 1
replace B6_6 = 96 if B6_6 == 1
replace B6_7 = 97 if B6_7 == 1

replace B5_1 = 1 if B5_1 == 1
replace B5_2 = 2 if B5_2 == 1
replace B5_3 = 3 if B5_3 == 1
replace B5_4 = 4 if B5_4 == 1
replace B5_5 = 95 if B5_5 == 1
replace B5_6 = 96 if B5_6 == 1
replace B5_7 = 97 if B5_7 == 1

foreach x in B6_1 B6_2 B6_3 B6_4 B6_5 B6_6 B6_7 B5_1 B5_2 B5_3 B5_4 B5_5 B5_6 B5_7{
    replace `x' = .  if `x' == 0
}
lab values B6_1 B6_2 B6_3 B6_4 B6_5 B6_6 B6_7 B5_1 B5_2 B5_3 B5_4 B5_5 B5_6 B5_7 b6

gen exists1 = 0
gen exists2 = 0
gen exists3 = 0
gen exists4 = 0
gen exists5 = 0
gen exists6 = 0
gen exists7 = 0
gen exists8 = 0

replace exists1 = 1 if B5_1 == survey_language
replace exists2 = 1 if B5_2 == survey_language
replace exists3 = 1 if B5_3 == survey_language
replace exists4 = 1 if B5_4 == survey_language
replace exists5 = 1 if B6_1 == survey_language
replace exists6 = 1 if B6_2 == survey_language
replace exists7 = 1 if B6_3 == survey_language
replace exists8 = 1 if B6_4 == survey_language

gen tot_exist = exists1+exists2+exists3+exists4+exists5+exists6+exists7+exists8

preserve
replace issue_comment = "The language selected for the interview is not among the chosen languages in B5 and B6, kindly clarify"
keep if tot_exist == 0
cap export excel $var_kept B5_* B6_* tot_exist issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(language_consitency_issues,replace)firstrow(variables)
restore

*Surv language
preserve
replace issue_comment = "The language selected for the interview is not language done during the baseline, kindly clarify"
keep if student_lang != survey_language
cap export excel $var_kept survey_language student_lang issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(language_consitency_2_issues,replace)firstrow(variables)
restore

*Number of correct words do not align with the correct number grid question
*number_grid_1
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_number_grid_1 == 1 & number_grid_1num_corr>3) | (correct_number_grid_1 == 2 & number_grid_1num_corr<4)
cap export excel $var_kept  number_grid_1* correct_number_grid_1 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(number_grid_1_issues,replace)firstrow(variables)
restore

*number_grid_2
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_number_grid_2 == 1 & number_grid_2num_corr>3) | (correct_number_grid_2 == 2 & number_grid_2num_corr<4)
cap export excel $var_kept  number_grid_2* correct_number_grid_2 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(number_grid_2_issues,replace)firstrow(variables)
restore

*digital_discrimination_1
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_dd_grid_1 == 1 & digital_discrimination_1num_corr>1) | (correct_dd_grid_1 == 2 & digital_discrimination_1num_corr<2)
cap export excel $var_kept  digital_discrimination_1* correct_dd_grid_1 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(digital_discrimination_1_issues,replace)firstrow(variables)
restore

*digital_discrimination_2
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_dd_grid_2 == 1 & digital_discrimination_2num_corr>1) | (correct_dd_grid_2 == 2 & digital_discrimination_2num_corr<2)
cap export excel $var_kept  digital_discrimination_2* correct_dd_grid_2 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(digital_discrimination_2_issues,replace)firstrow(variables)
restore

*addition_grid_1
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_addition_grid_1 == 1 & addition_grid_1num_corr>1) | (correct_addition_grid_1 == 2 & addition_grid_1num_corr<2)
cap export excel $var_kept  addition_grid_1* correct_addition_grid_1 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(addition_grid_1_issues,replace)firstrow(variables)
restore

*addition_grid_2
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_addition_grid_2 == 1 & addition_grid_2num_corr>1) | (correct_addition_grid_2 == 2 & addition_grid_2num_corr<2)
cap export excel $var_kept  addition_grid_2* correct_addition_grid_2 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(addition_grid_2_issues,replace)firstrow(variables)
restore

*substraction_grid_1
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_substraction_grid_1 == 1 & substraction_grid_1num_corr>1) | (correct_substraction_grid_1 == 2 & substraction_grid_1num_corr<2)
cap export excel $var_kept  substraction_grid_1* correct_substraction_grid_1 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(substraction_grid_1_issues,replace)firstrow(variables)
restore

*substraction_grid_2
preserve
replace issue_comment = "Number of correct words do not align with the correct number grid question, kindly clarify"
keep if (correct_substraction_grid_2 == 1 & substraction_grid_2num_corr>1) | (correct_substraction_grid_2 == 2 & substraction_grid_2num_corr<2)
cap export excel $var_kept substraction_grid_2* correct_substraction_grid_2 issue_comment using "14-11\UND NDAW WUNE DQA issues 14-11 v01.xlsx", sheet(substraction_grid_2_issues,replace)firstrow(variables)
restore

****Baseline
summ letter_knowledge_attempt letter_knowledge_correct
summ reading_familiar_attempt reading_familiar_correct
summ oral_reading_attempt oral_reading_correct
summ picture_matching_score

****END********************************************************************


***************************************************************************
****TEACHERS Survey
***************************************************************************


**Setting the working directory
cls
clear all
cd "${gsdData}\Raw"

***import dataset
import spss using "Test\Teachers\MOHEBS Teachers' Survey_WIDE.sav"

**Converting date to stata format calender
// *sort time and date
replace INT_DATE = dofc(INT_DATE)
format INT_DATE %td

lab var INT_DATE"Interview Date"

*filter only test data.
drop if INT_DATE < td(16nov2025)

*Time.
gen str8 start_time_str = string(START_TIME, "%tcHH:MM:SS")
gen str8 end_time_str   = string(END_TIME,   "%tcHH:MM:SS")


*dropping irrelevant variables
drop SubmissionDate username starttime endtime deviceid devicephonenum device_info duration caseid Enum_calc instanceID formdef_version

*Dropping unconsented interviews.
drop if Consent == 0

*Respondent Name
replace Firstname = strproper(Firstname)
replace Lastname = strproper(Lastname)

gen RES_NAME = Firstname + " " + Lastname
order RES_NAME, before(female)
lab var RES_NAME"Respondent names"

*lab variables.
lab var Policy_1"Policy_1. What is/are the language(s) of instruction of this school?"


***************************************************************************************QC checks-Flaggings
***************************************************************************************

cd "${gsdQChecks}"

// --- Step 1: Get today's date ---
local td = date(c(current_date), "DMY")

local d = day(`td')
local m = month(`td')
local foldername : display %02.0f `d' "-" %02.0f `m'
global dates : display %02.0f `d' "-" %02.0f `m'
display "`foldername'"

local folder "${dates}"
capture rmdir /s /q "`folder'"
capture mkdir "`folder'"

*QC files
cd "${dates}"

* var_kept

global var_kept "KEY INT_DATE START_TIME END_TIME  SUP_NAME ENUM_NAME Region School RH_school RES_NAME female Age Grade Grade_1 Grade_2 Grade_3 Grade_96 Grade_S"

** generate a Comment based on the issue raised
gen issue_comment = ""


*Duration chcek

*calculate duration in minutes.
gen duration_mins = round((END_TIME - START_TIME)/(1000*60))

preserve
drop END_TIME START_TIME
ren (start_time_str end_time_str) (START_TIME END_TIME)

replace issue_comment ="interview duration is *Longer* or *Shorter*, kindly clarify"
keep if !inrange(duration_mins,25,45)
cap export excel $var_kept duration_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
drop END_TIME START_TIME
ren (start_time_str end_time_str) (START_TIME END_TIME)
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept gap_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

*GPS Accuracy
preserve
replace issue_comment = "The GPS Accuracy is way low, kindly clarify"
keep if GPS_Accuracy > 20
cap export excel $var_kept GPS_Accuracy issue_comment using "MOHEBS DQA ${dates} v01.xlsx",sheet(GPS_issues,replace)firstrow(variables)
restore

*Duplicate GPS
duplicates tag GPS_Latitude GPS_Longitude GPS_Altitude,gen(dup1)

preserve
replace issue_comment = "The interview is done on the same point of location, kindly clarify"
keep if dup1 > 0
cap export excel $var_kept GPS_Latitude GPS_Longitude GPS_Altitude issue_comment using "MOHEBS DQA ${dates} v01.xlsx",sheet(GPS_Dups_issues,replace)firstrow(variables)
restore

**Respondent Name
preserve
replace issue_comment = "The Respondent name seems invalid, kindly clarify"
keep if strlen(RES_NAME)<2
cap export excel $var_kept RES_NAME issue_comment using "MOHEBS DQA ${dates} v01.xlsx",sheet(RES_NAME_issues,replace)firstrow(variables)
restore

**Duplicate interviews Respondent Name
duplicates tag Region School,gen (dup)

preserve
replace issue_comment = "The interviews are a duplicates, kindly clarify"
keep if dup > 0
cap export excel $var_kept Region School RES_NAME dup issue_comment using "MOHEBS DQA ${dates} v01.xlsx",sheet(RES_name_issues,replace)firstrow(variables)
restore

*Age
preserve
replace issue_comment ="Age provided is way high or low, kindly clarify"
keep if !inrange(Age,18,45)
cap export excel $var_kept Age issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(Age_issues,replace)firstrow(variables)
restore

*Minutes
*RH_hoursa
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursa,1,40)
cap export excel $var_kept RH_hoursa issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(RH_hoursa_issues,replace)firstrow(variables)
restore

*RH_hoursb
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursb,1,40)
cap export excel $var_kept RH_hoursb issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(RH_hoursb_issues,replace)firstrow(variables)
restore

*RH_hoursc
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursc,1,40)
cap export excel $var_kept RH_hoursc issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(RH_hoursc_issues,replace)firstrow(variables)
restore

*RH_hoursd
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursd,1,40)
cap export excel $var_kept RH_hoursd issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(RH_hoursd_issues,replace)firstrow(variables)
restore

*MM_hoursa
preserve
replace issue_comment ="The hours per week taught MOHEBS math/math in national languages for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(MM_hoursa,1,40)
cap export excel $var_kept MM_hoursa issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(MM_hoursa_issues,replace)firstrow(variables)
restore

*total hours
egen tot_hrs_taught = rowtotal(RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa)

preserve
replace issue_comment ="The hours per week taught by the teacher is way high or low, kindly clarify"
keep if !inrange(tot_hrs_taught,10,40)
cap export excel $var_kept RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa tot_hrs_taught issue_comment using "MOHEBS DQA ${dates} v01.xlsx", sheet(total_hours_issues,replace)firstrow(variables)
restore









