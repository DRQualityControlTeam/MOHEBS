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

import delimited "Main\Student\MOHEBS-MOHEBS_Baseline_Student_Survey_Field-1766119309244.csv", case(preserve)

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
drop if INT_DATE < td(2dec2025)

*drop test dataset
drop if tabletUserName == "Bill"

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

*id
ren _id interview_ID
lab var interview_ID"Interview Unique ID"

*Supervisor
label define sup 1 "Moustapha Diamé" 2 "Alkhayri Diawara" 3 "Ismaila Lo" 4 "Mouhamed Habib So" 5 "Amath Niang" 6 "Mouhamet Diop"

destring SUP_NAME,replace
lab var SUP_NAME"Supervisor Name"
lab values SUP_NAME sup

replace SUP_NAME = 1 if !missing(ENUM_NAME_1)
replace SUP_NAME = 2 if !missing(ENUM_NAME_2)
replace SUP_NAME = 3 if !missing(ENUM_NAME_3)
replace SUP_NAME = 4 if !missing(ENUM_NAME_4)
replace SUP_NAME = 5 if !missing(ENUM_NAME_5)
replace SUP_NAME = 6 if !missing(ENUM_NAME_6)

*Enumerator
label define enum 1  "Abdou Aziz Diallo"  2  "Seydou Diallo" 3 "Jeanne Bernadette Ndour" 4  "Victorine Therese Sarr" 5 "Marie Noel Sène" 6  "Ibrahima Ndiaye" 7 "Ndiambale Sarr" 8 "Elhadji Malick Diouf"  9  "Aissatou Diam" 10 "Mamadou Basse" 11  "Aissatou Dieng" 12 "Diegou Diouf" 13 "Bineta Gningue" 14 "Abdou Khadre Diaby" 15 "Nogaye Dieng" 16  "Ousmane Mbengue" 17 "Thiara Diene" 18 "Sackou Mbaye" 19 "Ndeye Fatou Diop" 20 "Boubacar Soumano" 21 "Souleymane Sène" 22 "Baye Mor Mbaye" 23  "Rabia Sy" 24 "Sette Niang" 25 "Abdou Aziz Diagne" 26 "Ngoné Mbodj" 27 "Mariama Diakhaté" 28 "Astou Kane" 29 "Salla Diara" 30 "Marieme Fall" 31 "Baba Adama Ndiaye" 32 "Souhaibou Diop" 33 "Robert Armand Thiaré"  34 "Oumar Thioye" 35 "Adama Ba" 36 "Ramatoulaye Dramé"    

replace ENUM_NAME_4 = "22" if inlist(interview_ID, "687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","38bdc126-72b7-4df0-8444-c471ca2a87e4")

replace ENUM_NAME_4 = "20" if inlist(interview_ID, "cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","64f00d50-e875-4e77-92c1-f4d53ba1a922")

replace ENUM_NAME_4 = "19" if inlist(interview_ID, "34240a67-95fe-48e6-9dc3-481a5eb995f8","d0273b2f-d376-49d6-b1dc-82fc45816d0d","fc083b06-21a2-4665-8228-d741d3d22d15","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

replace ENUM_NAME_3 = "18" if interview_ID == "ae1ce825-0716-42b8-8df0-f4c03de0b574"

replace ENUM_NAME_4 = "24" if inlist(interview_ID,"18e148e8-0d56-481d-addc-401cd8a79600","6f2c99cb-779a-47ef-ba75-450073085f94","4aad058f-af72-471c-95cb-20e762b2f6d8")

replace ENUM_NAME_4 = "21" if inlist(interview_ID, "2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f","f472aa19-e4ee-4e09-b6ab-8bd600de957d","7a7ca376-9da9-4ba4-a445-802999b1d569")

replace ENUM_NAME_3 = "14" if interview_ID == "e1d5d06e-04d1-488f-9f20-0be1971b0b14"

replace ENUM_NAME_1 = "2" if interview_ID == "af0783a4-3262-428e-9f9e-0c2146ff5078"

replace ENUM_NAME_3 = "16" if interview_ID == "27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519"


replace ENUM_NAME = "" if inlist(interview_ID,"687b58cd-3781-4864-8956-3254c912f3dc","18e148e8-0d56-481d-addc-401cd8a79600","2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f","af0783a4-3262-428e-9f9e-0c2146ff5078","27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519","e1d5d06e-04d1-488f-9f20-0be1971b0b14","f472aa19-e4ee-4e09-b6ab-8bd600de957d","7a7ca376-9da9-4ba4-a445-802999b1d569")

replace ENUM_NAME = "" if inlist(interview_ID,"7a7ca376-9da9-4ba4-a445-802999b1d569","6f2c99cb-779a-47ef-ba75-450073085f94","4aad058f-af72-471c-95cb-20e762b2f6d8","ae1ce825-0716-42b8-8df0-f4c03de0b574", "34240a67-95fe-48e6-9dc3-481a5eb995f8","d0273b2f-d376-49d6-b1dc-82fc45816d0d","fc083b06-21a2-4665-8228-d741d3d22d15","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

replace ENUM_NAME = "" if inlist(interview_ID,"cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","64f00d50-e875-4e77-92c1-f4d53ba1a922","687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","38bdc126-72b7-4df0-8444-c471ca2a87e4")

foreach x in ENUM_NAME ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3 ENUM_NAME_4 ENUM_NAME_5 ENUM_NAME_6{
	replace `x' = "" if `x' == "."
}

replace ENUM_NAME = ENUM_NAME_1 + ENUM_NAME_2 + ENUM_NAME_3 + ENUM_NAME_4 + ENUM_NAME_5 + ENUM_NAME_6

destring ENUM_NAME,replace
drop ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3 ENUM_NAME_4 ENUM_NAME_5 ENUM_NAME_6

lab var ENUM_NAME"Enumerator Name"
lab values ENUM_NAME enum

replace SUP_NAME = 6 if interview_ID =="d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace ENUM_NAME = 36 if interview_ID =="d2c71a15-324b-4908-880c-cd2a37b9ae46"

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

*interview_type
lab define int_type 1"Observing" 2"Speaking"
destring interviewer_type,replace
lab var interviewer_type"Are you the census taker observing or speaking?"
lab values interviewer_type int_type

*Location
do "Location.do"

drop SampleIA	SampleIEF	SampleArrondissement	SampleCommune	SampleEchantillon	SampleEcole	SampleGroupe SampleLangue 

*Official language
lab var official_language"What is the Senegalese language in this school?"
recode official_language (3=4)(2=3)(1=2)

lab values official_language lan

*teaching_language
lab var teaching_language"What is the language teachers actually use to actually teach in the school?"
lab values teaching_language lan

*enumerator_langugae
gen enumerator_langugae =""
order enumerator_langugae,before(enumerator_langugae_1)
lab var enumerator_langugae"What languages are you most comfortable speaking and reading in? (Select all that apply)"
lab var enumerator_langugae_1 "French"
lab var enumerator_langugae_2 "Wolof"
lab var enumerator_langugae_3 "Serere"
lab var enumerator_langugae_4 "Pulaar"

lab define yes_no 1 "Yes" 0 "No"

destring enumerator_langugae_1	enumerator_langugae_2	enumerator_langugae_3	enumerator_langugae_4,replace

lab values enumerator_langugae_1 enumerator_langugae_2	enumerator_langugae_3 enumerator_langugae_4 yes_no

order enumerator_langugae enumerator_langugae_1 enumerator_langugae_2	enumerator_langugae_3 enumerator_langugae_4, after(teaching_language)

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

destring B2,replace
lab values B2 gend

*B3
lab var B3"B3. How old are you?"

*B4
lab var B4"B4. What grade are you in now ?"
lab define b4 1"CI" 2"CP" 3"CE1"
destring B4,replace
lab values B4 b4

*B5
lab var B5"B5. Did you attend a learning program (preschool/ Ecole maternelle ou préscolaire) before grade 1?"
lab define b5 1"Yes" 0"No" 98"Don't know/no answer"

destring B5,replace
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
destring B6_1	B6_2 B6_3 B6_4 B6_96,replace
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
destring B7_1	B7_2 B7_3 B7_4 B7_96,replace
lab values B7_1	B7_2 B7_3 B7_4 B7_96 yes_no

*B8
lab var B8"B8. How many days of school did you miss in the last week?"
label define b8 1 "0 days, I attended school every day." 2 "1 day" 3 "2 days" 4 "3 days" 5 "4 days" 6 "5 days, I missed every day of school last week." 98 "Didn't Know/No Response"

destring B8,replace
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
destring B10,replace
lab values B10 b10

*B12
lab var B12"B12. During this school year, are you taking any extra tutoring outside of the school day?"
destring B12,replace
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
	destring `x',replace
	lab values `x' yes_no
}

*semantic_test_language1
foreach x in semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language4{
	lab var `x'"Which language are you testing in?"
}

lab define sema_lan 1"French" 2"Wolof" 3"Serer" 4"Pulaar" 96"Other 1" 996"Other 2" 9996"Other 3"
destring semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language3 semantic_recording_3 semantic_language_timer3_1 semantic_language_timer3duration semantic_language_timer3time_rem semantic_language_timer3gridAuto semantic_language_timer3number_o semantic_language_timer3items_pe interviewer_semantic_3 word_count_language_1 word_count_language_2 word_count_language_3 word_count_language_4 semantic_test_language4,replace

lab values semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language4 sema_lan

foreach x in semantic_language_timer1gridAuto semantic_language_timer2gridAuto semantic_language_timer3gridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values semantic_language_timer1gridAuto semantic_language_timer2gridAuto semantic_language_timer3gridAuto true_false


order semantic_test_language2 interviewer_semantic_2 semantic_recording_2 semantic_language_timer2duration semantic_language_timer2time_rem semantic_language_timer2gridAuto  word_count_language_2,after(word_count_language_1)

order semantic_test_language3 interviewer_semantic_3 semantic_recording_3 semantic_language_timer3duration semantic_language_timer3time_rem semantic_language_timer3gridAuto word_count_language_3,after(word_count_language_2)

*update 4
order semantic_test_language4 interviewer_semantic_4	semantic_recording_4 semantic_language_timer4duration semantic_language_timer4time_rem	semantic_language_timer4gridAuto semantic_language_timer4items_pe word_count_language_4,after(word_count_language_3)

drop semantic_language_timer4_1 semantic_language_timer4item_at_	semantic_language_timer4time_int semantic_language_timer4number_o v2173 semantic_language_timer4items_pe semantic_language_timer4autoStop semantic_language_timer3number_o  semantic_language_timer4item_at_ semantic_language_timer2number_o semantic_language_timer2items_pe semantic_language_timer3items_pe semantic_language_timer1number_o semantic_language_timer1items_pe semantic_language_timer1_1 semantic_language_timer2_1 semantic_language_timer3_1 semantic_language_timer4_1 semantic_language_timer3time_int

*************************************************************************
**Phonological section
*************************************************************************
ren v1071 phonological_awareness_srnum_att
ren v176 phonological_awareness_wfnum_att
ren v1430 phonological_awareness_frnum_att
ren v1809 phonological_awareness_prnum_att
ren(interviewer_phonological_stop_fr interviewer_phonological_stop_wf interviewer_phonological_stop_sr interviewer_phonological_stop_pr) (phonological_stop_fr phonological_stop_wf phonological_stop_sr phonological_stop_pr)

destring phonological_stop_sr phonological_awareness_srautoSto phonological_awareness_srnum_att phonological_awareness_srnumber_ phonological_awareness_sr_* phonological_awareness_wf_* phonological_awareness_wfnum_att phonological_awareness_wfnumber_ phonological_stop_wf phonological_awareness_wfautoSto phonological_awareness_fr_*  phonological_awareness_frnum_att phonological_awareness_frnumber_ phonological_awareness_frautoSto  phonological_stop_fr phonological_awareness_prnum_att phonological_awareness_prautoSto phonological_awareness_prnumber_ phonological_stop_pr phonological_awareness_pr_*,replace

*interviewer_phonological_stop_sr
lab values phonological_stop_fr phonological_stop_wf phonological_stop_sr phonological_stop_pr yes_no

order phonological_awareness_fr_* phonological_awareness_frnumber_ phonological_awareness_frnum_att phonological_awareness_frgridAut phonological_awareness_frautoSto phonological_stop_fr  phonological_awareness_wf_* phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_sr_* phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_*  phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr,after(word_count_language_4)

lab define cor_inc 1"Correct" 0"Incorrect"

lab values phonological_awareness_fr_1 - phonological_awareness_fr_10 phonological_awareness_wf_1 - phonological_awareness_wf_10 phonological_awareness_sr_1 - phonological_awareness_sr_10 phonological_awareness_pr_1 - phonological_awareness_pr_10 cor_inc

foreach x in phonological_awareness_frgridAut phonological_awareness_wfgridAut phonological_awareness_srgridAut phonological_awareness_prgridAut{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab define true_false 1"True" 0"False"
lab values phonological_awareness_frgridAut phonological_awareness_wfgridAut phonological_awareness_srgridAut phonological_awareness_prgridAut true_false

*Update correction
*fr
foreach x in phonological_awareness_fr_6 phonological_awareness_fr_7	phonological_awareness_fr_8	phonological_awareness_fr_9 phonological_awareness_fr_10 {
	replace `x'= . if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0
}

replace phonological_awareness_frnumber_ = 0 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

replace phonological_awareness_frnum_att = 5 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

replace phonological_awareness_frgridAut = 1 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

foreach x in phonological_awareness_fr_2 phonological_awareness_fr_3	phonological_awareness_fr_4	phonological_awareness_fr_5 {
	replace `x'= 0 if interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"
}

replace phonological_awareness_frgridAut = 0 if phonological_awareness_frnum_att == 0

replace phonological_stop_fr = 1 if phonological_awareness_frgridAut == 1
replace phonological_stop_fr = 0 if phonological_awareness_frgridAut == 0

*wf
foreach x in phonological_awareness_wf_6 phonological_awareness_wf_7	phonological_awareness_wf_8	phonological_awareness_wf_9 phonological_awareness_wf_10 {
	replace `x'= . if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0
}

replace phonological_awareness_wfnumber_ = 0 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

replace phonological_awareness_wfnum_att = 5 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

replace phonological_awareness_wfgridAut = 1 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

foreach x in phonological_awareness_wf_2 phonological_awareness_wf_3	phonological_awareness_wf_4	phonological_awareness_wf_5 {
	replace `x'= 0 if interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"
}

replace phonological_awareness_wfgridAut = 0 if phonological_awareness_wfnum_att == 0

replace phonological_stop_wf = 1 if phonological_awareness_wfgridAut == 1
replace phonological_stop_wf = 0 if phonological_awareness_wfgridAut == 0

*sr
foreach x in phonological_awareness_sr_6 phonological_awareness_sr_7	phonological_awareness_sr_8	phonological_awareness_sr_9 phonological_awareness_sr_10 {
	replace `x'= . if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0
}

replace phonological_awareness_srnumber_ = 0 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

replace phonological_awareness_srnum_att = 5 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

replace phonological_awareness_srgridAut = 1 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

foreach x in phonological_awareness_sr_2 phonological_awareness_sr_3	phonological_awareness_sr_4	phonological_awareness_sr_5 {
	replace `x'= 0 if interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"
}

replace phonological_awareness_srgridAut = 0 if phonological_awareness_srnum_att == 0

replace phonological_stop_sr = 1 if phonological_awareness_srgridAut == 1
replace phonological_stop_sr = 0 if phonological_awareness_srgridAut == 0

*pr
foreach x in phonological_awareness_pr_6 phonological_awareness_pr_7	phonological_awareness_pr_8	phonological_awareness_pr_9 phonological_awareness_pr_10 {
	replace `x'= . if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0
}

replace phonological_awareness_prnumber_ = 0 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

replace phonological_awareness_prnum_att = 5 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

replace phonological_awareness_prgridAut = 1 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

foreach x in phonological_awareness_pr_2 phonological_awareness_pr_3	phonological_awareness_pr_4	phonological_awareness_pr_5 {
	replace `x'= 0 if interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"
}

replace phonological_awareness_prgridAut = 0 if phonological_awareness_prnum_att == 0

replace phonological_stop_pr = 1 if phonological_awareness_prgridAut == 1
replace phonological_stop_pr = 0 if phonological_awareness_prgridAut == 0


*************************************************************************
**Oral Vocabulary section
*************************************************************************
ren (v1077 v1080 v1083 v1086 v1089 v1092 v1095 v1098 v1101 v1104 v1107	v1110 v1113 v1116 v1119 v1122 v1125 v1442 v1445 v1448 v1451 v1454 v1457 v1460 v1463 v1466 v1469 v1472 v1475 v1478 v1481 v1484 v222 v227 v232 v237 v242 v247 v252 v257 v262 v267 v272 v277 v282 v287 v292 v297 v302 v1815 v1818 v1821 v1824 v1827 v1830 v1833 v1836 v1839 v1842 v1845 v1848 v1851 v1854 v1857 v1860 v1863) (sr_oral_vocabulary_example_1  sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15  fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15)

ren (v1436 v1439)(fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2)


destring sr_oral_vocabulary_example_1 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15 fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2, replace

order fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 sr_oral_vocabulary_example_1 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15,after(phonological_stop_pr)

*************************************************************************
**Letter Knowledge section
*************************************************************************
ren (v403 interviewer_letter_knowledge_rea interviewer_letter_knowledge_sto v448 v1513 v1560 v1561 v1558 v1154 v1201 v1202 v1199 v1892 v1939 v1940 v1937) (letter_knowledge_wfnum_att letter_knowledge_reason_wf letter_knowledge_stop_wf letter_knowledge_wf_Bnum_att letter_knowledge_frnum_att letter_knowledge_reason_fr letter_knowledge_stop_fr letter_knowledge_fr_Bnum_att letter_knowledge_srnum_att letter_knowledge_reason_sr letter_knowledge_stop_sr letter_knowledge_sr_Bnum_att letter_knowledge_prnum_att letter_knowledge_reason_pr letter_knowledge_stop_pr letter_knowledge_pr_Bnum_att)

*fr
order  letter_knowledge_recording_fr letter_knowledge_fr_*  letter_knowledge_frduration letter_knowledge_frtime_remainin letter_knowledge_frgridAutoStopp letter_knowledge_frautoStop letter_knowledge_fritem_at_time letter_knowledge_frtime_intermed letter_knowledge_frnumber_of_ite letter_knowledge_frnum_att letter_knowledge_fritems_per_min letter_knowledge_reason_fr letter_knowledge_stop_fr,after(pr_ov_picture_matching_q15)

order letter_knowledge_fr_B_* letter_knowledge_fr_B*,after(letter_knowledge_stop_fr)

drop letter_knowledge_frautoStop letter_knowledge_fritem_at_time letter_knowledge_frtime_intermed letter_knowledge_fr_BautoStop	letter_knowledge_fr_Bitem_at_tim letter_knowledge_fr_Btime_interm
		


*wf
order letter_knowledge_recording_wf  letter_knowledge_wf_*  letter_knowledge_wfduration letter_knowledge_wftime_remainin letter_knowledge_wfgridAutoStopp letter_knowledge_wfautoStop letter_knowledge_wfitem_at_time letter_knowledge_wftime_intermed letter_knowledge_wfnumber_of_ite letter_knowledge_wfnum_att letter_knowledge_wfitems_per_min letter_knowledge_reason_wf letter_knowledge_stop_wf,after(letter_knowledge_fr_Bitems_per_m)

order letter_knowledge_wf_B_* letter_knowledge_wf_B*,after(letter_knowledge_stop_wf)

drop letter_knowledge_wfautoStop	letter_knowledge_wfitem_at_time	letter_knowledge_wftime_intermed letter_knowledge_wf_BautoStop	letter_knowledge_wf_Bitem_at_tim letter_knowledge_wf_Btime_interm

*sr
order letter_knowledge_recording_sr letter_knowledge_sr_* letter_knowledge_srduration letter_knowledge_srtime_remainin letter_knowledge_srgridAutoStopp letter_knowledge_srautoStop letter_knowledge_sritem_at_time letter_knowledge_srtime_intermed letter_knowledge_srnumber_of_ite letter_knowledge_srnum_att letter_knowledge_sritems_per_min letter_knowledge_reason_sr  letter_knowledge_stop_sr,after(letter_knowledge_wf_Bitems_per_m)

order letter_knowledge_sr_B_*  letter_knowledge_sr_B*,after(letter_knowledge_stop_sr)

drop letter_knowledge_srautoStop	letter_knowledge_sritem_at_time	letter_knowledge_srtime_intermed letter_knowledge_sr_BautoStop	letter_knowledge_sr_Bitem_at_tim letter_knowledge_sr_Btime_interm

*pr
order letter_knowledge_recording_pr  letter_knowledge_pr_*  letter_knowledge_prduration letter_knowledge_prtime_remainin letter_knowledge_prgridAutoStopp letter_knowledge_prautoStop letter_knowledge_pritem_at_time letter_knowledge_prtime_intermed letter_knowledge_prnumber_of_ite letter_knowledge_prnum_att letter_knowledge_pritems_per_min letter_knowledge_pr_B_*  letter_knowledge_pr_B* letter_knowledge_reason_pr letter_knowledge_stop_pr, after(letter_knowledge_sr_Bitems_per_m)

order letter_knowledge_pr_B_*  letter_knowledge_pr_B*,after(letter_knowledge_stop_pr)

drop letter_knowledge_prautoStop letter_knowledge_pritem_at_time letter_knowledge_prtime_intermed letter_knowledge_pr_BautoStop	letter_knowledge_pr_Bitem_at_tim letter_knowledge_pr_Btime_interm

destring letter_knowledge_fr_* letter_knowledge_fr_B_* letter_knowledge_frduration	letter_knowledge_frtime_remainin letter_knowledge_wf_* letter_knowledge_wf_B_* letter_knowledge_wfduration letter_knowledge_wftime_remainin letter_knowledge_sr_* letter_knowledge_sr_B_* letter_knowledge_srduration letter_knowledge_srtime_remainin letter_knowledge_pr_* letter_knowledge_pr_B_* letter_knowledge_prduration letter_knowledge_prtime_remainin letter_knowledge_frnumber_of_ite	letter_knowledge_frnum_att	letter_knowledge_fritems_per_min	letter_knowledge_reason_fr	letter_knowledge_stop_fr letter_knowledge_wfnumber_of_ite	letter_knowledge_wfnum_att	letter_knowledge_wfitems_per_min	letter_knowledge_reason_wf	letter_knowledge_stop_wf letter_knowledge_srnumber_of_ite	letter_knowledge_srnum_att	letter_knowledge_sritems_per_min	letter_knowledge_reason_sr	letter_knowledge_stop_sr letter_knowledge_prnumber_of_ite	letter_knowledge_prnum_att	letter_knowledge_pritems_per_min	letter_knowledge_reason_pr	letter_knowledge_stop_pr,replace

lab values letter_knowledge_fr_1 - letter_knowledge_fr_20 letter_knowledge_fr_B_1 - letter_knowledge_fr_B_36 letter_knowledge_wf_1 - letter_knowledge_wf_20 letter_knowledge_wf_B_1 - letter_knowledge_wf_B_36 letter_knowledge_sr_1 - letter_knowledge_sr_20 letter_knowledge_sr_B_1 - letter_knowledge_sr_B_36 letter_knowledge_pr_1 - letter_knowledge_pr_20 letter_knowledge_pr_B_1 - letter_knowledge_pr_B_36 cor_inc

lab values letter_knowledge_stop_fr letter_knowledge_stop_wf letter_knowledge_stop_sr letter_knowledge_stop_pr letter_knowledge_reason_fr letter_knowledge_reason_wf letter_knowledge_reason_sr letter_knowledge_reason_pr yes_no

foreach x in letter_knowledge_fr_BgridAutoSto letter_knowledge_wf_BgridAutoSto letter_knowledge_sr_BgridAutoSto letter_knowledge_pr_BgridAutoSto letter_knowledge_frgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_srgridAutoStopp letter_knowledge_prgridAutoStopp{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values letter_knowledge_fr_BgridAutoSto letter_knowledge_wf_BgridAutoSto letter_knowledge_sr_BgridAutoSto letter_knowledge_pr_BgridAutoSto letter_knowledge_frgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_srgridAutoStopp letter_knowledge_prgridAutoStopp true_false

*update correction
*fr
foreach x in letter_knowledge_fr_9	letter_knowledge_fr_10	letter_knowledge_fr_11	letter_knowledge_fr_12	letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x'= . if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0
}

replace letter_knowledge_frnumber_of_ite = 0 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_fritems_per_min = 0 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_frnum_att = 8 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_frgridAutoStopp = 1 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_stop_fr = 1 if letter_knowledge_frgridAutoStopp == 1
replace letter_knowledge_stop_fr = 0 if letter_knowledge_frgridAutoStopp == 0

foreach x in letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")
}

egen letter_knowledge_frnum_of_ite1 = rowtotal(letter_knowledge_fr_1 - letter_knowledge_fr_20)
replace letter_knowledge_frnumber_of_ite = letter_knowledge_frnum_of_ite1 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")

replace letter_knowledge_fritems_per_min = letter_knowledge_frnumber_of_ite if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")

foreach x in letter_knowledge_fr_Bduration	letter_knowledge_fr_Btime_remain	letter_knowledge_fr_BgridAutoSto	letter_knowledge_fr_Bnumber_of_i	letter_knowledge_fr_Bnum_att	letter_knowledge_fr_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7") | letter_knowledge_frnumber_of_ite < 13
}

replace letter_knowledge_fr_Btime_remain = letter_knowledge_fr_Btime_remain - 62 if letter_knowledge_fr_Bnumber_of_i == 0 & letter_knowledge_fr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_fr_B_1-letter_knowledge_fr_B_36)
replace letter_knowledge_fr_Bnumber_of_i = corrr1 if letter_knowledge_fr_Bnum_att == 0 & letter_knowledge_fr_Bnumber_of_i == 0 

replace letter_knowledge_fr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_fr_Bduration-letter_knowledge_fr_Btime_remain))) if letter_knowledge_fr_Bnum_att == 0 & letter_knowledge_fr_Bnumber_of_i == 0 | !missing(letter_knowledge_fr_Btime_remain)


egen att1 = rownonmiss(letter_knowledge_fr_B_1-letter_knowledge_fr_B_36)
replace letter_knowledge_fr_Bnum_att = att1 if letter_knowledge_fr_Bnum_att == 0

drop letter_knowledge_frnum_of_ite1 att1 corrr1

*wf
foreach x in letter_knowledge_wf_9	letter_knowledge_wf_10	letter_knowledge_wf_11	letter_knowledge_wf_12	letter_knowledge_wf_13	letter_knowledge_wf_14	letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19	letter_knowledge_wf_20{
	replace `x'= . if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0
}

replace letter_knowledge_wfnumber_of_ite = 0 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfitems_per_min = 0 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfnum_att = 8 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfgridAutoStopp = 1 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_stop_wf = 1 if letter_knowledge_wfgridAutoStopp == 1
replace letter_knowledge_stop_wf = 0 if letter_knowledge_wfgridAutoStopp == 0

foreach x in letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17{
	replace `x' = 0 if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d")
}

egen letter_knowledge_wfnum_of_ite1 = rowtotal(letter_knowledge_wf_1 - letter_knowledge_wf_20)
replace letter_knowledge_wfnumber_of_ite = letter_knowledge_wfnum_of_ite1 if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d","67b71d7b-c519-402a-8ecb-9bff07849803", "3ec4200b-e4fc-4b5d-8508-165b7dda4b7d","dd2019e6-d5da-4e39-a73e-086054939141")

replace letter_knowledge_wfitems_per_min = letter_knowledge_wfnumber_of_ite if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d","67b71d7b-c519-402a-8ecb-9bff07849803","3ec4200b-e4fc-4b5d-8508-165b7dda4b7d","dd2019e6-d5da-4e39-a73e-086054939141")

foreach x in letter_knowledge_wf_Bduration	letter_knowledge_wf_Btime_remain	letter_knowledge_wf_BgridAutoSto	letter_knowledge_wf_Bnumber_of_i	letter_knowledge_wf_Bnum_att	letter_knowledge_wf_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d") | letter_knowledge_wfnumber_of_ite < 13
}

replace letter_knowledge_wf_Btime_remain = letter_knowledge_wf_Btime_remain - 62 if letter_knowledge_wf_Bnumber_of_i == 0 & letter_knowledge_wf_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_wf_B_1-letter_knowledge_wf_B_36)
replace letter_knowledge_wf_Bnumber_of_i = corrr1 if letter_knowledge_wf_Bnum_att == 0 & letter_knowledge_wf_Bnumber_of_i == 0 

replace letter_knowledge_wf_Bitems_per_m = round(60*(corrr1/(letter_knowledge_wf_Bduration-letter_knowledge_wf_Btime_remain))) if letter_knowledge_wf_Bnum_att == 0 & letter_knowledge_wf_Bnumber_of_i == 0 | !missing(letter_knowledge_wf_Btime_remain)

egen att1 = rownonmiss(letter_knowledge_wf_B_1-letter_knowledge_wf_B_36)
replace letter_knowledge_wf_Bnum_att = att1 if letter_knowledge_wf_Bnum_att == 0

drop letter_knowledge_wfnum_of_ite1 att1 corrr1


*sr
foreach x in letter_knowledge_sr_9	letter_knowledge_sr_10	letter_knowledge_sr_11	letter_knowledge_sr_12	letter_knowledge_sr_13	letter_knowledge_sr_14	letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x'= . if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0
}

replace letter_knowledge_srnumber_of_ite = 0 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_sritems_per_min = 0 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_srnum_att = 8 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_srgridAutoStopp = 1 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_stop_sr = 1 if letter_knowledge_srgridAutoStopp == 1
replace letter_knowledge_stop_sr = 0 if letter_knowledge_srgridAutoStopp == 0

foreach x in letter_knowledge_sr_7	letter_knowledge_sr_8 letter_knowledge_sr_11	letter_knowledge_sr_12	letter_knowledge_sr_13	letter_knowledge_sr_14 letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17{
	replace `x' = 0 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")
}

egen letter_knowledge_srnum_of_ite1 = rowtotal(letter_knowledge_sr_1 - letter_knowledge_sr_20)
replace letter_knowledge_srnumber_of_ite = letter_knowledge_srnum_of_ite1 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")

replace letter_knowledge_sritems_per_min = letter_knowledge_srnumber_of_ite if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")

foreach x in letter_knowledge_sr_Bduration	letter_knowledge_sr_Btime_remain	letter_knowledge_sr_BgridAutoSto	letter_knowledge_sr_Bnumber_of_i	letter_knowledge_sr_Bnum_att	letter_knowledge_sr_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc") |    letter_knowledge_srnumber_of_ite < 13
}

replace letter_knowledge_sr_Btime_remain = letter_knowledge_sr_Btime_remain - 62 if letter_knowledge_sr_Bnumber_of_i == 0 & letter_knowledge_sr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_sr_B_1-letter_knowledge_sr_B_36)
replace letter_knowledge_sr_Bnumber_of_i = corrr1 if letter_knowledge_sr_Bnum_att == 0 & letter_knowledge_sr_Bnumber_of_i == 0 

replace letter_knowledge_sr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_sr_Bduration-letter_knowledge_sr_Btime_remain))) if letter_knowledge_sr_Bnum_att == 0 & letter_knowledge_sr_Bnumber_of_i == 0 | !missing(letter_knowledge_sr_Btime_remain)


egen att1 = rownonmiss(letter_knowledge_sr_B_1-letter_knowledge_sr_B_36)
replace letter_knowledge_sr_Bnum_att = att1 if letter_knowledge_sr_Bnum_att == 0

drop letter_knowledge_srnum_of_ite1 att1 corrr1


*pr
foreach x in letter_knowledge_pr_9	letter_knowledge_pr_10	letter_knowledge_pr_11	letter_knowledge_pr_12	letter_knowledge_pr_13	letter_knowledge_pr_14	letter_knowledge_pr_15	letter_knowledge_pr_16	letter_knowledge_pr_17	letter_knowledge_pr_18	letter_knowledge_pr_19	letter_knowledge_pr_20{
	replace `x'= . if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0
}

replace letter_knowledge_prnumber_of_ite = 0 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_pritems_per_min = 0 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_prnum_att = 8 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_prgridAutoStopp = 1 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_stop_pr = 1 if letter_knowledge_prgridAutoStopp == 1
replace letter_knowledge_stop_pr = 0 if letter_knowledge_prgridAutoStopp == 0

replace letter_knowledge_pr_Btime_remain = letter_knowledge_pr_Btime_remain - 62 if letter_knowledge_pr_Bnumber_of_i == 0 & letter_knowledge_pr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_pr_B_1-letter_knowledge_pr_B_36)
replace letter_knowledge_pr_Bnumber_of_i = corrr1 if letter_knowledge_pr_Bnum_att == 0 & letter_knowledge_pr_Bnumber_of_i == 0 

replace letter_knowledge_pr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_pr_Bduration-letter_knowledge_pr_Btime_remain))) if letter_knowledge_pr_Bnum_att == 0 & letter_knowledge_pr_Bnumber_of_i == 0 | !missing(letter_knowledge_pr_Btime_remain)

egen att1 = rownonmiss(letter_knowledge_pr_B_1-letter_knowledge_pr_B_36)
replace letter_knowledge_pr_Bnum_att = att1 if letter_knowledge_pr_Bnum_att == 0

drop att1 corrr1

*************************************************************************
**Dceoding- Reading Familiar words section
*************************************************************************
ren (v487 v511 v1230 v1254 v1589 v1613 v1968 v1992 interviewer_read_familiar_stop_f interviewer_read_familiar_stop_w interviewer_read_familiar_stop_s interviewer_read_familiar_stop_p) (reading_familiar_words_wfnum_att reading_famila_word_wf_Bnum_att reading_familiar_words_srnum_att reading_famila_word_sr_Bnum_att reading_familiar_words_frnum_att  reading_famila_word_fr_Bnum_att reading_familiar_words_prnum_att reading_famila_word_pr_Bnum_att read_familiar_stop_fr read_familiar_stop_wf read_familiar_stop_sr read_familiar_stop_pr)


*fr
order read_familiar_words_fr_* read_familiar_words_frduration read_familiar_words_frtime_remai read_familiar_words_frgridAutoSt read_familiar_words_frautoStop read_familiar_words_fritem_at_ti read_familiar_words_frtime_inter read_familiar_words_frnumber_of_ reading_familiar_words_frnum_att read_familiar_words_fritems_per_ read_familiar_stop_fr, after(letter_knowledge_pr_Bitems_per_m)

order read_familiar_words_fr_B_*  read_familiar_words_fr_Bduration read_familiar_words_fr_Btime_rem read_familiar_words_fr_BgridAuto read_familiar_words_fr_BautoStop read_familiar_words_fr_Bitem_at_ read_familiar_words_fr_Btime_int read_familiar_words_fr_Bnumber_o reading_famila_word_fr_Bnum_att  read_familiar_words_fr_Bitems_pe,after(read_familiar_stop_fr)

drop read_familiar_words_fr_BautoStop read_familiar_words_fr_Bitem_at_ read_familiar_words_fr_Btime_int read_familiar_words_frautoStop read_familiar_words_fritem_at_ti	read_familiar_words_frtime_inter

*wf
order  read_familiar_words_wf_* read_familiar_words_wfduration read_familiar_words_wftime_remai read_familiar_words_wfgridAutoSt read_familiar_words_wfautoStop read_familiar_words_wfitem_at_ti read_familiar_words_wftime_inter read_familiar_words_wfnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfitems_per_ read_familiar_stop_wf, after(read_familiar_words_fr_Bitems_pe) 

order read_familiar_words_wf_B_*  read_familiar_words_wf_Bduration read_familiar_words_wf_Btime_rem read_familiar_words_wf_BgridAuto read_familiar_words_wf_BautoStop read_familiar_words_wf_Bitem_at_ read_familiar_words_wf_Btime_int read_familiar_words_wf_Bnumber_o reading_famila_word_wf_Bnum_att read_familiar_words_wf_Bitems_pe ,after(read_familiar_stop_wf)

drop read_familiar_words_wf_BautoStop read_familiar_words_wf_Bitem_at_ read_familiar_words_wf_Btime_int read_familiar_words_wfautoStop read_familiar_words_wfitem_at_ti	read_familiar_words_wftime_inter

*sr
order  read_familiar_words_sr_* read_familiar_words_srduration read_familiar_words_srtime_remai read_familiar_words_srgridAutoSt read_familiar_words_srautoStop read_familiar_words_sritem_at_ti read_familiar_words_srtime_inter read_familiar_words_srnumber_of_ reading_familiar_words_srnum_att read_familiar_words_sritems_per_ read_familiar_stop_sr, after(read_familiar_words_wf_Bitems_pe) 
 
order read_familiar_words_sr_B_*  read_familiar_words_sr_Bduration read_familiar_words_sr_Btime_rem read_familiar_words_sr_BgridAuto read_familiar_words_sr_BautoStop read_familiar_words_sr_Bitem_at_ read_familiar_words_sr_Btime_int read_familiar_words_sr_Bnumber_o reading_famila_word_sr_Bnum_att read_familiar_words_sr_Bitems_pe,after(read_familiar_stop_sr)

drop read_familiar_words_sr_BautoStop read_familiar_words_sr_Bitem_at_ read_familiar_words_sr_Btime_int read_familiar_words_srautoStop read_familiar_words_sritem_at_ti	read_familiar_words_srtime_inter

*pr
order  read_familiar_words_pr_* read_familiar_words_prduration read_familiar_words_prtime_remai read_familiar_words_prgridAutoSt read_familiar_words_prautoStop read_familiar_words_pritem_at_ti read_familiar_words_prtime_inter read_familiar_words_prnumber_of_ reading_familiar_words_prnum_att read_familiar_words_pritems_per_ read_familiar_stop_pr, after(read_familiar_words_sr_Bitems_pe) 

order read_familiar_words_pr_B_*  read_familiar_words_pr_Bduration read_familiar_words_pr_Btime_rem read_familiar_words_pr_BgridAuto read_familiar_words_pr_Bnumber_o reading_famila_word_pr_Bnum_att read_familiar_words_pr_Bitems_pe,after(read_familiar_stop_pr)

drop read_familiar_words_pr_BautoStop read_familiar_words_pr_Bitem_at_ read_familiar_words_pr_Btime_int read_familiar_words_prautoStop read_familiar_words_pritem_at_ti	read_familiar_words_prtime_inter

destring read_familiar_words_wf_* read_familiar_words_fr_* read_familiar_words_sr_* read_familiar_words_pr_* read_familiar_words_frduration	read_familiar_words_frtime_remai read_familiar_words_frnumber_of_ reading_familiar_words_frnum_att read_familiar_words_fritems_per_ read_familiar_stop_fr read_familiar_words_wfduration read_familiar_words_wftime_remai read_familiar_words_wfnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfitems_per_ read_familiar_stop_wf reading_famila_word_wf_Bnum_att read_familiar_words_srduration	read_familiar_words_srtime_remai read_familiar_words_srnumber_of_ reading_familiar_words_srnum_att read_familiar_words_sritems_per_ read_familiar_stop_sr read_familiar_words_prduration	read_familiar_words_prtime_remai read_familiar_words_prnumber_of_ reading_familiar_words_prnum_att read_familiar_words_pritems_per_	read_familiar_stop_pr reading_famila_word_fr_Bnum_att,replace

lab values read_familiar_words_fr_1 - read_familiar_words_fr_20 read_familiar_words_fr_B_1 - read_familiar_words_fr_B_20 read_familiar_words_wf_1 - read_familiar_words_wf_20 read_familiar_words_wf_B_1 - read_familiar_words_wf_B_15 read_familiar_words_sr_1 - read_familiar_words_sr_20 read_familiar_words_sr_B_1 - read_familiar_words_sr_B_15 read_familiar_words_pr_1 - read_familiar_words_pr_20 read_familiar_words_pr_B_1 - read_familiar_words_pr_B_15 cor_inc

foreach x in read_familiar_words_frgridAutoSt read_familiar_words_wfgridAutoSt read_familiar_words_srgridAutoSt read_familiar_words_prgridAutoSt read_familiar_words_fr_BgridAuto read_familiar_words_wf_BgridAuto read_familiar_words_sr_BgridAuto read_familiar_words_pr_BgridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values read_familiar_words_frgridAutoSt read_familiar_words_wfgridAutoSt read_familiar_words_srgridAutoSt read_familiar_words_prgridAutoSt read_familiar_words_fr_BgridAuto	read_familiar_words_wf_BgridAuto read_familiar_words_sr_BgridAuto read_familiar_words_pr_BgridAuto true_false

lab values read_familiar_stop_fr read_familiar_stop_wf read_familiar_stop_sr read_familiar_stop_pr yes_no

*Update
*fr
foreach x in read_familiar_words_fr_9	read_familiar_words_fr_10	read_familiar_words_fr_11	read_familiar_words_fr_12	read_familiar_words_fr_13	read_familiar_words_fr_14	read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x'= . if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"
}

replace read_familiar_words_frnumber_of_ = 0 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_words_fritems_per_ = 0 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace reading_familiar_words_frnum_att = 8 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 |interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_words_frgridAutoSt = 1 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_stop_fr = 1 if read_familiar_words_frgridAutoSt == 1
replace read_familiar_stop_fr = 0 if read_familiar_words_frgridAutoSt == 0

replace read_familiar_words_fr_Btime_rem = read_familiar_words_fr_Bduration - 62 if read_familiar_words_fr_Bnumber_o == 0 & reading_famila_word_fr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_fr_B_1 -read_familiar_words_fr_B_20)
replace read_familiar_words_fr_Bnumber_o = corrr1 if reading_famila_word_fr_Bnum_att == 0 & read_familiar_words_fr_Bnumber_o == 0 

replace read_familiar_words_fr_Bitems_pe = round(60*(corrr1/(read_familiar_words_fr_Bduration-read_familiar_words_fr_Btime_rem))) if reading_famila_word_fr_Bnum_att == 0 & read_familiar_words_fr_Bnumber_o == 0 | !missing(read_familiar_words_fr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_fr_B_1 -  read_familiar_words_fr_B_20)
replace reading_famila_word_fr_Bnum_att = att1 if reading_famila_word_fr_Bnum_att == 0

drop att1 corrr1

*wf
foreach x in read_familiar_words_wf_9	read_familiar_words_wf_10	read_familiar_words_wf_11	read_familiar_words_wf_12	read_familiar_words_wf_13	read_familiar_words_wf_14	read_familiar_words_wf_15	read_familiar_words_wf_16	read_familiar_words_wf_17	read_familiar_words_wf_18	read_familiar_words_wf_19	read_familiar_words_wf_20{
	replace `x'= . if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0
}

replace read_familiar_words_wfnumber_of_ = 0 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace read_familiar_words_wfitems_per_ = 0 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace reading_familiar_words_wfnum_att = 8 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace read_familiar_words_wfgridAutoSt = 1 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0 

replace read_familiar_stop_wf = 1 if read_familiar_words_wfgridAutoSt == 1
replace read_familiar_stop_wf = 0 if read_familiar_words_wfgridAutoSt == 0

replace read_familiar_words_wf_Btime_rem = read_familiar_words_wf_Bduration - 62 if read_familiar_words_wf_Bnumber_o == 0 & reading_famila_word_wf_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_wf_B_1 -read_familiar_words_wf_B_15)
replace read_familiar_words_wf_Bnumber_o = corrr1 if reading_famila_word_wf_Bnum_att == 0 & read_familiar_words_wf_Bnumber_o == 0 

replace read_familiar_words_wf_Bitems_pe = round(60*(corrr1/(read_familiar_words_wf_Bduration-read_familiar_words_wf_Btime_rem))) if reading_famila_word_wf_Bnum_att == 0 & read_familiar_words_wf_Bnumber_o == 0 | !missing(read_familiar_words_wf_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_wf_B_1-read_familiar_words_wf_B_15)
replace reading_famila_word_wf_Bnum_att = att1 if reading_famila_word_wf_Bnum_att == 0

drop att1 corrr1


*sr
foreach x in read_familiar_words_sr_9	read_familiar_words_sr_10	read_familiar_words_sr_11	read_familiar_words_sr_12	read_familiar_words_sr_13	read_familiar_words_sr_14	read_familiar_words_sr_15	read_familiar_words_sr_16	read_familiar_words_sr_17	read_familiar_words_sr_18	read_familiar_words_sr_19	read_familiar_words_sr_20{
	replace `x'= . if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0
}

replace read_familiar_words_srnumber_of_ = 0 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace read_familiar_words_sritems_per_ = 0 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace reading_familiar_words_srnum_att = 8 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace read_familiar_words_srgridAutoSt = 1 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0 

replace read_familiar_stop_sr = 1 if read_familiar_words_srgridAutoSt == 1
replace read_familiar_stop_sr = 0 if read_familiar_words_srgridAutoSt == 0

destring reading_famila_word_sr_Bnum_att,replace

replace read_familiar_words_sr_Btime_rem = read_familiar_words_sr_Bduration - 62 if read_familiar_words_sr_Bnumber_o == 0 & reading_famila_word_sr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_sr_B_1 -read_familiar_words_sr_B_15)
replace read_familiar_words_sr_Bnumber_o = corrr1 if reading_famila_word_sr_Bnum_att == 0 & read_familiar_words_sr_Bnumber_o == 0 

replace read_familiar_words_sr_Bitems_pe = round(60*(corrr1/(read_familiar_words_sr_Bduration-read_familiar_words_sr_Btime_rem))) if reading_famila_word_sr_Bnum_att == 0 & read_familiar_words_sr_Bnumber_o == 0 | !missing(read_familiar_words_sr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_sr_B_1-read_familiar_words_sr_B_15)
replace reading_famila_word_sr_Bnum_att = att1 if reading_famila_word_sr_Bnum_att == 0  

replace read_familiar_words_sr_Bitems_pe = 15 if interview_ID == "0603e745-4755-4735-ab8b-81a7133999a8"

drop att1 corrr1


*pr
foreach x in read_familiar_words_pr_9	read_familiar_words_pr_10	read_familiar_words_pr_11	read_familiar_words_pr_12	read_familiar_words_pr_13	read_familiar_words_pr_14	read_familiar_words_pr_15	read_familiar_words_pr_16	read_familiar_words_pr_17	read_familiar_words_pr_18	read_familiar_words_pr_19	read_familiar_words_pr_20{
	replace `x'= . if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0
}

replace read_familiar_words_prnumber_of_ = 0 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace read_familiar_words_pritems_per_ = 0 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace reading_familiar_words_prnum_att = 8 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace read_familiar_words_prgridAutoSt = 1 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0 

replace read_familiar_stop_pr = 1 if read_familiar_words_prgridAutoSt == 1
replace read_familiar_stop_pr = 0 if read_familiar_words_prgridAutoSt == 0

destring reading_famila_word_pr_Bnum_att,replace

replace read_familiar_words_pr_Btime_rem = read_familiar_words_pr_Bduration - 62 if read_familiar_words_pr_Bnumber_o == 0 & reading_famila_word_pr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_pr_B_1 -read_familiar_words_pr_B_15)
replace read_familiar_words_pr_Bnumber_o = corrr1 if reading_famila_word_pr_Bnum_att == 0 & read_familiar_words_pr_Bnumber_o == 0 

replace read_familiar_words_pr_Bitems_pe = round(60*(corrr1/(read_familiar_words_pr_Bduration-read_familiar_words_pr_Btime_rem))) if reading_famila_word_pr_Bnum_att == 0 & read_familiar_words_pr_Bnumber_o == 0 | !missing(read_familiar_words_pr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_pr_B_1-read_familiar_words_pr_B_15)
replace reading_famila_word_pr_Bnum_att = att1 if reading_famila_word_pr_Bnum_att == 0

drop att1 corrr1

*************************************************************************
**Dceoding- Reading Invented words section
*************************************************************************
********************

ren (v549 interviewer_read_invented_stop_w v588 v1284 interviewer_read_invented_stop_s v1323 v1643 interviewer_read_invented_stop_f v1682 v2022 interviewer_read_invented_stop_p v2061) (read_invented_words_wfnum_att read_invented_stop_wf read_invented_word_wf_Bnum_att read_invented_words_srnum_att read_invented_stop_sr read_invented_word_sr_Bnum_att read_invented_words_frnum_att read_invented_stop_fr  read_invented_word_fr_Bnum_att read_invented_words_prnum_att read_invented_stop_pr read_invented_word_pr_Bnum_att)

*fr
order read_invented_words_fr_*  read_invented_words_frduration read_invented_words_frtime_remai read_invented_words_frgridAutoSt read_invented_words_frautoStop read_invented_words_fritem_at_ti read_invented_words_frtime_inter read_invented_words_frnumber_of_ read_invented_words_frnum_att read_invented_words_fritems_per_ read_invented_stop_fr, after(read_familiar_words_pr_Bitems_pe)

order read_invented_words_fr_B_*  read_invented_words_fr_Bduration read_invented_words_fr_Btime_rem read_invented_words_fr_BgridAuto read_invented_words_fr_BautoStop read_invented_words_fr_Bitem_at_ read_invented_words_fr_Btime_int read_invented_words_fr_Bnumber_o read_invented_word_fr_Bnum_att read_invented_words_fr_Bitems_pe,after(read_invented_stop_fr)

drop read_invented_words_frautoStop read_invented_words_fritem_at_ti read_invented_words_frtime_inter read_invented_words_fr_BautoStop read_invented_words_fr_Bitem_at_ read_invented_words_fr_Btime_int

destring read_invented_words_fr_* read_invented_words_frduration read_invented_words_frtime_remai read_invented_words_frnumber_of_ read_invented_words_fritems_per_ read_invented_words_frnum_att read_invented_stop_fr read_invented_word_fr_Bnum_att,replace

*wf
order read_invented_words_wf_*  read_invented_words_wfduration read_invented_words_wftime_remai read_invented_words_wfgridAutoSt read_invented_words_wfautoStop read_invented_words_wfitem_at_ti read_invented_words_wftime_inter read_invented_words_wfnumber_of_ read_invented_words_wfnum_att read_invented_words_wfitems_per_ read_invented_stop_wf, after(read_invented_words_fr_Bitems_pe)

order read_invented_words_wf_B_*  read_invented_words_wf_Bduration read_invented_words_wf_Btime_rem read_invented_words_wf_BgridAuto read_invented_words_wf_BautoStop read_invented_words_wf_Bitem_at_ read_invented_words_wf_Btime_int read_invented_words_wf_Bnumber_o read_invented_word_wf_Bnum_att read_invented_words_wf_Bitems_pe,after(read_invented_stop_wf)

drop read_invented_words_wfautoStop read_invented_words_wfitem_at_ti read_invented_words_wftime_inter read_invented_words_wf_BautoStop read_invented_words_wf_Bitem_at_ read_invented_words_wf_Btime_int

destring read_invented_words_wf_* read_invented_words_wfduration read_invented_words_wftime_remai read_invented_words_wfnumber_of_ read_invented_words_wfitems_per_ read_invented_words_wfnum_att read_invented_stop_wf read_invented_word_wf_Bnum_att,replace

*sr
order read_invented_words_sr_*  read_invented_words_srduration read_invented_words_srtime_remai read_invented_words_srgridAutoSt read_invented_words_srautoStop read_invented_words_sritem_at_ti read_invented_words_srtime_inter read_invented_words_srnumber_of_ read_invented_words_srnum_att read_invented_words_sritems_per_ read_invented_stop_sr, after(read_invented_words_wf_Bitems_pe)

order read_invented_words_sr_B_*  read_invented_words_sr_Bduration read_invented_words_sr_Btime_rem read_invented_words_sr_BgridAuto read_invented_words_sr_BautoStop read_invented_words_sr_Bitem_at_ read_invented_words_sr_Btime_int read_invented_words_sr_Bnumber_o read_invented_word_sr_Bnum_att read_invented_words_sr_Bitems_pe,after(read_invented_stop_sr)

drop read_invented_words_srautoStop read_invented_words_sritem_at_ti read_invented_words_srtime_inter read_invented_words_sr_BautoStop read_invented_words_sr_Bitem_at_ read_invented_words_sr_Btime_int

destring read_invented_words_sr_* read_invented_words_srduration read_invented_words_srtime_remai read_invented_words_srnumber_of_ read_invented_words_sritems_per_ read_invented_words_srnum_att read_invented_stop_sr,replace

*pr
order read_invented_words_pr_*  read_invented_words_prduration read_invented_words_prtime_remai read_invented_words_prgridAutoSt read_invented_words_prautoStop read_invented_words_pritem_at_ti read_invented_words_prtime_inter read_invented_words_prnumber_of_ read_invented_words_prnum_att read_invented_words_pritems_per_ read_invented_stop_pr, after(read_invented_words_sr_Bitems_pe)

order read_invented_words_pr_B_*  read_invented_words_pr_Bduration read_invented_words_pr_Btime_rem read_invented_words_pr_BgridAuto read_invented_words_pr_BautoStop read_invented_words_pr_Bitem_at_ read_invented_words_pr_Btime_int read_invented_words_pr_Bnumber_o read_invented_word_pr_Bnum_att read_invented_words_pr_Bitems_pe,after(read_invented_words_pritems_per_)

drop read_invented_words_prautoStop read_invented_words_pritem_at_ti read_invented_words_prtime_inter read_invented_words_pr_BautoStop read_invented_words_pr_Bitem_at_ read_invented_words_pr_Btime_int

destring read_invented_words_pr_* read_invented_words_prduration read_invented_words_prtime_remai read_invented_words_prnumber_of_ read_invented_words_pritems_per_ read_invented_words_prnum_att read_invented_stop_pr read_invented_word_pr_Bnum_att,replace

lab values read_invented_words_fr_1 - read_invented_words_fr_20 read_invented_words_fr_B_1 - read_invented_words_fr_B_30 read_invented_words_wf_1 - read_invented_words_wf_20 read_invented_words_wf_B_1 - read_invented_words_wf_B_30 read_invented_words_sr_1 - read_invented_words_sr_20 read_invented_words_sr_B_1 - read_invented_words_sr_B_30 read_invented_words_pr_1 - read_invented_words_pr_20 read_invented_words_pr_B_1 - read_invented_words_pr_B_30  cor_inc

foreach x in read_invented_words_frgridAutoSt read_invented_words_wfgridAutoSt read_invented_words_srgridAutoSt read_invented_words_prgridAutoSt read_invented_words_fr_BgridAuto read_invented_words_wf_BgridAuto read_invented_words_pr_BgridAuto read_invented_words_sr_BgridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values read_invented_words_frgridAutoSt read_invented_words_wfgridAutoSt read_invented_words_srgridAutoSt read_invented_words_prgridAutoSt read_invented_words_fr_BgridAuto read_invented_words_wf_BgridAuto read_invented_words_sr_BgridAuto read_invented_words_pr_BgridAuto true_false

lab values read_invented_stop_fr read_invented_stop_wf read_invented_stop_sr read_invented_stop_pr yes_no

*Update

*fr
foreach x in read_invented_words_fr_9	read_invented_words_fr_10	read_invented_words_fr_11	read_invented_words_fr_12	read_invented_words_fr_13	read_invented_words_fr_14	read_invented_words_fr_15	read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18	read_invented_words_fr_19	read_invented_words_fr_20{
	replace `x'= . if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0
}

replace read_invented_words_frnumber_of_ = 0 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_fritems_per_ = 0 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_frnum_att = 8 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_frgridAutoSt = 1 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_stop_fr = 1 if read_invented_words_frgridAutoSt == 1
replace read_invented_stop_fr = 0 if read_invented_words_frgridAutoSt == 0

destring read_invented_word_fr_Bnum_att,replace

replace read_invented_words_fr_Btime_rem = read_invented_words_fr_Bduration - 63 if read_invented_words_fr_Bnumber_o == 0 & read_invented_word_fr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_fr_B_1 -read_invented_words_fr_B_30)
replace read_invented_words_fr_Bnumber_o = corrr1 if read_invented_word_fr_Bnum_att == 0 & read_invented_words_fr_Bnumber_o == 0 

replace read_invented_words_fr_Bitems_pe = round(60*(corrr1/(read_invented_words_fr_Bduration-read_invented_words_fr_Btime_rem))) if read_invented_word_fr_Bnum_att == 0 & read_invented_words_fr_Bnumber_o == 0 | !missing(read_invented_words_fr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_fr_B_1 -read_invented_words_fr_B_30)
replace read_invented_word_fr_Bnum_att = att1 if read_invented_word_fr_Bnum_att == 0

drop att1 corrr1

*wf
foreach x in read_invented_words_wf_9	read_invented_words_wf_10	read_invented_words_wf_11	read_invented_words_wf_12	read_invented_words_wf_13	read_invented_words_wf_14	read_invented_words_wf_15	read_invented_words_wf_16	read_invented_words_wf_17	read_invented_words_wf_18	read_invented_words_wf_19	read_invented_words_wf_20{
	replace `x'= . if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0
}

replace read_invented_words_wfnumber_of_ = 0 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfitems_per_ = 0 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfnum_att = 8 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfgridAutoSt = 1 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_stop_wf = 1 if read_invented_words_wfgridAutoSt == 1
replace read_invented_stop_wf = 0 if read_invented_words_wfgridAutoSt == 0

destring read_invented_word_wf_Bnum_att,replace

replace read_invented_words_wf_Btime_rem = read_invented_words_wf_Bduration - 63 if read_invented_words_wf_Bnumber_o == 0 & read_invented_word_wf_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_wf_B_1 -read_invented_words_wf_B_30)
replace read_invented_words_wf_Bnumber_o = corrr1 if read_invented_word_wf_Bnum_att == 0 & read_invented_words_wf_Bnumber_o == 0

replace read_invented_words_wf_Bitems_pe = round(60*(corrr1/(read_invented_words_wf_Bduration-read_invented_words_wf_Btime_rem))) if read_invented_word_wf_Bnum_att == 0 & read_invented_words_wf_Bnumber_o == 0 | !missing(read_invented_words_wf_Btime_rem)

egen att1 = rownonmiss(read_invented_words_wf_B_1 -read_invented_words_wf_B_30)
replace read_invented_word_wf_Bnum_att = att1 if read_invented_word_wf_Bnum_att == 0

drop att1 corrr1

egen corrr1 = rowtotal(read_invented_words_wf_1 -read_invented_words_wf_20)
replace read_invented_words_wfnumber_of_ = corrr1 if inlist(interview_ID ,"c8ff5326-e9dd-4955-94ef-52e0164bd216","73c00981-7704-45c1-a0b1-c68f526a6c20")

replace read_invented_words_wfitems_per_ = round(60*(corrr1/(read_invented_words_wfduration-read_invented_words_wftime_remai))) if inlist(interview_ID ,"c8ff5326-e9dd-4955-94ef-52e0164bd216","73c00981-7704-45c1-a0b1-c68f526a6c20") 
drop corrr1

*sr
foreach x in read_invented_words_sr_9	read_invented_words_sr_10	read_invented_words_sr_11	read_invented_words_sr_12	read_invented_words_sr_13	read_invented_words_sr_14	read_invented_words_sr_15	read_invented_words_sr_16	read_invented_words_sr_17	read_invented_words_sr_18	read_invented_words_sr_19	read_invented_words_sr_20{
	replace `x'= . if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0
}

replace read_invented_words_srnumber_of_ = 0 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_sritems_per_ = 0 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_srnum_att = 8 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_srgridAutoSt = 1 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_stop_sr = 1 if read_invented_words_srgridAutoSt == 1
replace read_invented_stop_sr = 0 if read_invented_words_srgridAutoSt == 0

destring read_invented_word_sr_Bnum_att,replace

replace read_invented_words_sr_Btime_rem = read_invented_words_sr_Bduration - 63 if read_invented_words_sr_Bnumber_o == 0 & read_invented_word_sr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_sr_B_1 -read_invented_words_sr_B_30)
replace read_invented_words_sr_Bnumber_o = corrr1 if read_invented_word_sr_Bnum_att == 0 & read_invented_words_sr_Bnumber_o == 0 

replace read_invented_words_sr_Bitems_pe = round(60*(corrr1/(read_invented_words_sr_Bduration-read_invented_words_sr_Btime_rem))) if read_invented_word_sr_Bnum_att == 0 & read_invented_words_sr_Bnumber_o == 0 | !missing(read_invented_words_sr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_sr_B_1 -read_invented_words_sr_B_30)
replace read_invented_word_sr_Bnum_att = att1 if read_invented_word_sr_Bnum_att == 0

drop att1 corrr1

*pr
foreach x in read_invented_words_pr_9	read_invented_words_pr_10	read_invented_words_pr_11	read_invented_words_pr_12	read_invented_words_pr_13	read_invented_words_pr_14	read_invented_words_pr_15	read_invented_words_pr_16	read_invented_words_pr_17	read_invented_words_pr_18	read_invented_words_pr_19	read_invented_words_pr_20{
	replace `x'= . if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0
}

replace read_invented_words_prnumber_of_ = 0 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_pritems_per_ = 0 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_prnum_att = 8 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_prgridAutoSt = 1 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_stop_pr = 1 if read_invented_words_prgridAutoSt == 1
replace read_invented_stop_pr = 0 if read_invented_words_prgridAutoSt == 0

destring read_invented_word_pr_Bnum_att,replace

replace read_invented_words_pr_Btime_rem = read_invented_words_pr_Bduration - 63 if read_invented_words_pr_Bnumber_o == 0 & read_invented_word_pr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_pr_B_1 -read_invented_words_pr_B_30)
replace read_invented_words_pr_Bnumber_o = corrr1 if read_invented_word_pr_Bnum_att == 0 & read_invented_words_pr_Bnumber_o == 0 

replace read_invented_words_pr_Bitems_pe = round(60*(corrr1/(read_invented_words_pr_Bduration-read_invented_words_pr_Btime_rem))) if read_invented_word_pr_Bnum_att == 0 & read_invented_words_pr_Bnumber_o == 0 | !missing(read_invented_words_pr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_pr_B_1 -read_invented_words_pr_B_30)
replace read_invented_word_pr_Bnum_att = att1 if read_invented_word_pr_Bnum_att == 0

drop att1 corrr1

 
*************************************************************************
**Oral Reading Fluency section
*************************************************************************
ren (v651 v1376 v1735 v2119 interviewer_orf_stop_wf interviewer_orf_stop_fr interviewer_orf_stop_pr interviewer_orf_stop_sr) (oral_reading_fluency_wfnum_att oral_reading_fluency_srnum_att oral_reading_fluency_frnum_att oral_reading_fluency_prnum_att oral_reading_fluency_stop_wf oral_reading_fluency_stop_fr oral_reading_fluency_stop_pr oral_reading_fluency_stop_sr)

 
order oral_reading_fluency_fr_* oral_reading_fluency_frduration oral_reading_fluency_frtime_rema oral_reading_fluency_frgridAutoS oral_reading_fluency_frautoStop oral_reading_fluency_fritem_at_t oral_reading_fluency_frtime_inte oral_reading_fluency_frnumber_of oral_reading_fluency_frnum_att oral_reading_fluency_fritems_per oral_reading_fluency_stop_fr oral_reading_fluency_wf_* oral_reading_fluency_wfduration oral_reading_fluency_wftime_rema oral_reading_fluency_wfgridAutoS oral_reading_fluency_wfautoStop oral_reading_fluency_wfitem_at_t oral_reading_fluency_wftime_inte oral_reading_fluency_wfnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfitems_per oral_reading_fluency_stop_wf oral_reading_fluency_sr_* oral_reading_fluency_srduration oral_reading_fluency_srtime_rema oral_reading_fluency_srgridAutoS oral_reading_fluency_srautoStop oral_reading_fluency_sritem_at_t oral_reading_fluency_srtime_inte oral_reading_fluency_srnumber_of oral_reading_fluency_srnum_att oral_reading_fluency_sritems_per oral_reading_fluency_stop_sr oral_reading_fluency_pr_* oral_reading_fluency_prduration oral_reading_fluency_prtime_rema oral_reading_fluency_prgridAutoS oral_reading_fluency_prautoStop oral_reading_fluency_pritem_at_t oral_reading_fluency_prtime_inte oral_reading_fluency_prnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_pritems_per oral_reading_fluency_stop_pr,after(read_invented_stop_pr)

drop oral_reading_fluency_fritem_at_t oral_reading_fluency_frtime_inte oral_reading_fluency_wfitem_at_t oral_reading_fluency_wftime_inte  oral_reading_fluency_sritem_at_t oral_reading_fluency_srtime_inte oral_reading_fluency_pritem_at_t oral_reading_fluency_prtime_inte


destring oral_reading_fluency_fr_* oral_reading_fluency_frduration oral_reading_fluency_frtime_rema oral_reading_fluency_frautoStop oral_reading_fluency_frnumber_of oral_reading_fluency_frnum_att oral_reading_fluency_fritems_per oral_reading_fluency_stop_fr oral_reading_fluency_wf_* oral_reading_fluency_wfduration oral_reading_fluency_wftime_rema oral_reading_fluency_wfautoStop oral_reading_fluency_wfnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfitems_per oral_reading_fluency_stop_wf oral_reading_fluency_sr_* oral_reading_fluency_srduration oral_reading_fluency_srtime_rema oral_reading_fluency_srautoStop oral_reading_fluency_srnumber_of oral_reading_fluency_srnum_att oral_reading_fluency_sritems_per oral_reading_fluency_stop_sr oral_reading_fluency_pr_* oral_reading_fluency_prduration oral_reading_fluency_prtime_rema oral_reading_fluency_prautoStop oral_reading_fluency_prnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_pritems_per oral_reading_fluency_stop_pr,replace

lab values oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43 oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43  oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43  oral_reading_fluency_pr_1 - oral_reading_fluency_pr_43 cor_inc

foreach x in oral_reading_fluency_frgridAutoS oral_reading_fluency_wfgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_prgridAutoS{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values oral_reading_fluency_frgridAutoS oral_reading_fluency_wfgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_prgridAutoS true_false

*updated
*fr
foreach x in  oral_reading_fluency_fr_9 oral_reading_fluency_fr_10 oral_reading_fluency_fr_11 oral_reading_fluency_fr_12 oral_reading_fluency_fr_13 oral_reading_fluency_fr_14 oral_reading_fluency_fr_15 oral_reading_fluency_fr_16 oral_reading_fluency_fr_17 oral_reading_fluency_fr_18 oral_reading_fluency_fr_19 oral_reading_fluency_fr_20 oral_reading_fluency_fr_21 oral_reading_fluency_fr_22 oral_reading_fluency_fr_23 oral_reading_fluency_fr_24 oral_reading_fluency_fr_25 oral_reading_fluency_fr_26 oral_reading_fluency_fr_27 oral_reading_fluency_fr_28 oral_reading_fluency_fr_29 oral_reading_fluency_fr_30 oral_reading_fluency_fr_31 oral_reading_fluency_fr_32 oral_reading_fluency_fr_33 oral_reading_fluency_fr_34 oral_reading_fluency_fr_35 oral_reading_fluency_fr_36 oral_reading_fluency_fr_37 oral_reading_fluency_fr_38 oral_reading_fluency_fr_39 oral_reading_fluency_fr_40 oral_reading_fluency_fr_41 oral_reading_fluency_fr_42 oral_reading_fluency_fr_43{
	replace `x'= . if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0
}

replace oral_reading_fluency_frnumber_of = 0 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_fritems_per = 0 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_frnum_att = 8 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_frgridAutoS = 1 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_stop_fr = 1 if oral_reading_fluency_frgridAutoS == 1
replace oral_reading_fluency_stop_fr = 0 if oral_reading_fluency_frgridAutoS == 0

foreach x in oral_reading_fluency_fr_6	oral_reading_fluency_fr_7	oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_6 == . & !missing(oral_reading_fluency_fr_5)
}
		
foreach x in oral_reading_fluency_fr_7	oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_7 == . & !missing(oral_reading_fluency_fr_6)
}

foreach x in oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_8 == . & !missing(oral_reading_fluency_fr_7)
}


foreach x in oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_9 == . & !missing(oral_reading_fluency_fr_8)
}

egen corrr = rowtotal(oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43)

replace oral_reading_fluency_frnumber_of = corrr if !missing(oral_reading_fluency_frnumber_of)
replace oral_reading_fluency_fritems_per = corrr if !missing(oral_reading_fluency_fritems_per)

replace oral_reading_fluency_frtime_rema = 0 if oral_reading_fluency_frtime_rema<0

egen att = rownonmiss(oral_reading_fluency_fr_1-oral_reading_fluency_fr_43)

replace oral_reading_fluency_frnum_att = att if !missing(oral_reading_fluency_frnum_att)

drop att corrr

*wf
foreach x in  oral_reading_fluency_wf_9 oral_reading_fluency_wf_10 oral_reading_fluency_wf_11 oral_reading_fluency_wf_12 oral_reading_fluency_wf_13 oral_reading_fluency_wf_14 oral_reading_fluency_wf_15 oral_reading_fluency_wf_16 oral_reading_fluency_wf_17 oral_reading_fluency_wf_18 oral_reading_fluency_wf_19 oral_reading_fluency_wf_20 oral_reading_fluency_wf_21 oral_reading_fluency_wf_22 oral_reading_fluency_wf_23 oral_reading_fluency_wf_24 oral_reading_fluency_wf_25 oral_reading_fluency_wf_26 oral_reading_fluency_wf_27 oral_reading_fluency_wf_28 oral_reading_fluency_wf_29 oral_reading_fluency_wf_30 oral_reading_fluency_wf_31 oral_reading_fluency_wf_32 oral_reading_fluency_wf_33 oral_reading_fluency_wf_34 oral_reading_fluency_wf_35 oral_reading_fluency_wf_36 oral_reading_fluency_wf_37 oral_reading_fluency_wf_38 oral_reading_fluency_wf_39 oral_reading_fluency_wf_40 oral_reading_fluency_wf_41 oral_reading_fluency_wf_42 oral_reading_fluency_wf_43{
	replace `x'= . if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0
}

replace oral_reading_fluency_wfnumber_of = 0 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfitems_per = 0 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfnum_att = 8 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfgridAutoS = 1 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_stop_wf = 1 if oral_reading_fluency_wfgridAutoS == 1
replace oral_reading_fluency_stop_wf = 0 if oral_reading_fluency_wfgridAutoS == 0

foreach x in oral_reading_fluency_wf_6	oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_6 == . & !missing(oral_reading_fluency_wf_5)
}
		
foreach x in oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_7 == . & !missing(oral_reading_fluency_wf_6)
}

foreach x in oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_8 == . & !missing(oral_reading_fluency_wf_7)
}


foreach x in oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_9 == . & !missing(oral_reading_fluency_wf_8)
}

egen corrr = rowtotal(oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43)

replace oral_reading_fluency_wfnumber_of = corrr if !missing(oral_reading_fluency_wfnumber_of)
replace oral_reading_fluency_wfitems_per = corrr if !missing(oral_reading_fluency_wfitems_per)

replace oral_reading_fluency_wftime_rema = 0 if oral_reading_fluency_wftime_rema<0

egen att = rownonmiss(oral_reading_fluency_wf_1-oral_reading_fluency_wf_43)

replace oral_reading_fluency_wfnum_att = att if !missing(oral_reading_fluency_wfnum_att)

drop att corrr

*sr
foreach x in  oral_reading_fluency_sr_9 oral_reading_fluency_sr_10 oral_reading_fluency_sr_11 oral_reading_fluency_sr_12 oral_reading_fluency_sr_13 oral_reading_fluency_sr_14 oral_reading_fluency_sr_15 oral_reading_fluency_sr_16 oral_reading_fluency_sr_17 oral_reading_fluency_sr_18 oral_reading_fluency_sr_19 oral_reading_fluency_sr_20 oral_reading_fluency_sr_21 oral_reading_fluency_sr_22 oral_reading_fluency_sr_23 oral_reading_fluency_sr_24 oral_reading_fluency_sr_25 oral_reading_fluency_sr_26 oral_reading_fluency_sr_27 oral_reading_fluency_sr_28 oral_reading_fluency_sr_29 oral_reading_fluency_sr_30 oral_reading_fluency_sr_31 oral_reading_fluency_sr_32 oral_reading_fluency_sr_33 oral_reading_fluency_sr_34 oral_reading_fluency_sr_35 oral_reading_fluency_sr_36 oral_reading_fluency_sr_37 oral_reading_fluency_sr_38 oral_reading_fluency_sr_39 oral_reading_fluency_sr_40 oral_reading_fluency_sr_41 oral_reading_fluency_sr_42 oral_reading_fluency_sr_43{
	replace `x'= . if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0
}

replace oral_reading_fluency_srnumber_of = 0 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_sritems_per = 0 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_srnum_att = 8 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_srgridAutoS = 1 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_stop_sr = 1 if oral_reading_fluency_srgridAutoS == 1
replace oral_reading_fluency_stop_sr = 0 if oral_reading_fluency_srgridAutoS == 0

foreach x in oral_reading_fluency_sr_6	oral_reading_fluency_sr_7	oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_6 == . & !missing(oral_reading_fluency_sr_5)
}
		
foreach x in oral_reading_fluency_sr_7	oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_7 == . & !missing(oral_reading_fluency_sr_6)
}

foreach x in oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_8 == . & !missing(oral_reading_fluency_sr_7)
}


foreach x in oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_9 == . & !missing(oral_reading_fluency_sr_8)
}

egen corrr = rowtotal(oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43)

replace oral_reading_fluency_srnumber_of = corrr if !missing(oral_reading_fluency_srnumber_of)
replace oral_reading_fluency_sritems_per = corrr if !missing(oral_reading_fluency_sritems_per)

replace oral_reading_fluency_srtime_rema = 0 if oral_reading_fluency_srtime_rema<0

egen att = rownonmiss(oral_reading_fluency_sr_1-oral_reading_fluency_sr_43)

replace oral_reading_fluency_srnum_att = att if !missing(oral_reading_fluency_srnum_att)

drop att corrr

*pr
foreach x in  oral_reading_fluency_pr_9 oral_reading_fluency_pr_10 oral_reading_fluency_pr_11 oral_reading_fluency_pr_12 oral_reading_fluency_pr_13 oral_reading_fluency_pr_14 oral_reading_fluency_pr_15 oral_reading_fluency_pr_16 oral_reading_fluency_pr_17 oral_reading_fluency_pr_18 oral_reading_fluency_pr_19 oral_reading_fluency_pr_20 oral_reading_fluency_pr_21 oral_reading_fluency_pr_22 oral_reading_fluency_pr_23 oral_reading_fluency_pr_24 oral_reading_fluency_pr_25 oral_reading_fluency_pr_26 oral_reading_fluency_pr_27 oral_reading_fluency_pr_28 oral_reading_fluency_pr_29 oral_reading_fluency_pr_30 oral_reading_fluency_pr_31 oral_reading_fluency_pr_32 oral_reading_fluency_pr_33 oral_reading_fluency_pr_34 oral_reading_fluency_pr_35 oral_reading_fluency_pr_36 oral_reading_fluency_pr_37 oral_reading_fluency_pr_38 oral_reading_fluency_pr_39 oral_reading_fluency_pr_40 oral_reading_fluency_pr_41 oral_reading_fluency_pr_42 oral_reading_fluency_pr_43{
	replace `x'= . if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0
}

replace oral_reading_fluency_prnumber_of = 0 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_pritems_per = 0 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_prnum_att = 8 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_prgridAutoS = 1 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_stop_pr = 1 if oral_reading_fluency_prgridAutoS == 1
replace oral_reading_fluency_stop_pr = 0 if oral_reading_fluency_prgridAutoS == 0

foreach x in oral_reading_fluency_pr_6	oral_reading_fluency_pr_7	oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_6 == . & !missing(oral_reading_fluency_pr_5)
}
		
foreach x in oral_reading_fluency_pr_7	oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_7 == . & !missing(oral_reading_fluency_pr_6)
}

foreach x in oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_8 == . & !missing(oral_reading_fluency_pr_7)
}


foreach x in oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_9 == . & !missing(oral_reading_fluency_pr_8)
}

egen corrr = rowtotal(oral_reading_fluency_pr_1 - oral_reading_fluency_pr_43)

replace oral_reading_fluency_prnumber_of = corrr if !missing(oral_reading_fluency_prnumber_of)
replace oral_reading_fluency_pritems_per = corrr if !missing(oral_reading_fluency_pritems_per)

replace oral_reading_fluency_prtime_rema = 0 if oral_reading_fluency_prtime_rema<0

egen att = rownonmiss(oral_reading_fluency_pr_1-oral_reading_fluency_pr_43)

replace oral_reading_fluency_prnum_att = att if !missing(oral_reading_fluency_prnum_att)

drop att corrr
*************************************************************************
**Reading Comprehension section
*************************************************************************
order reading_comprehension_fr_q1 reading_comprehension_fr_q2 reading_comprehension_fr_q3 reading_comprehension_fr_q4 reading_comprehension_fr_q5 reading_comprehension_fr_q6  reading_comprehension_wf_q1 reading_comprehension_wf_q2 reading_comprehension_wf_q3 reading_comprehension_wf_q4 reading_comprehension_wf_q5 reading_comprehension_wf_q6 reading_comprehension_sr_q1 reading_comprehension_sr_q2 reading_comprehension_sr_q3 reading_comprehension_sr_q4 reading_comprehension_sr_q5 reading_comprehension_sr_q6  reading_comprehension_pr_q1 reading_comprehension_pr_q2 reading_comprehension_pr_q3 reading_comprehension_pr_q4 reading_comprehension_pr_q5 reading_comprehension_pr_q6,after(oral_reading_fluency_stop_pr)

destring reading_comprehension_fr_q1 reading_comprehension_fr_q2 reading_comprehension_fr_q3 reading_comprehension_fr_q4 reading_comprehension_fr_q5 reading_comprehension_fr_q6  reading_comprehension_wf_q1 reading_comprehension_wf_q2 reading_comprehension_wf_q3 reading_comprehension_wf_q4 reading_comprehension_wf_q5 reading_comprehension_wf_q6 reading_comprehension_sr_q1 reading_comprehension_sr_q2 reading_comprehension_sr_q3 reading_comprehension_sr_q4 reading_comprehension_sr_q5 reading_comprehension_sr_q6  reading_comprehension_pr_q1 reading_comprehension_pr_q2 reading_comprehension_pr_q3 reading_comprehension_pr_q4 reading_comprehension_pr_q5 reading_comprehension_pr_q6,replace


lab define read_comp 1 "Correct" 2 "Incorrect" 99 "No response"
destring reading_comprehension_*,replace
lab values reading_comprehension_* read_comp

*************************************************************************
**Reading Comprehension Picture matching section
*************************************************************************

ren (v698  v703 v708 v713 v718 v723 v728 v733 v738 v743 v748 v1387 v1390 v1393 v1396 v1399 v1402 v1405 v1408 v1411 v1414 v1417 v1746 v1749 v1752 v1755 v1758 v1761 v1764 v1774 v1777 v1780 v1783 v2130 v2133 v2136 v2139 v2142 v2145 v2148 v2151 v2154 v2157 v2160 interviewer_rc_pm_stop_wf interviewer_rc_pm_stop_pr interviewer_rc_pm_stop_fr interviewer_rc_pm_stop_sr) (rc_picture_matching_example_wf rc_picture_matching_wf_q1 rc_picture_matching_wf_q2 rc_picture_matching_wf_q3 rc_picture_matching_wf_q4 rc_picture_matching_wf_q5 rc_picture_matching_wf_q6 rc_picture_matching_wf_q7 rc_picture_matching_wf_q8 rc_picture_matching_wf_q9 rc_picture_matching_wf_q10  rc_picture_matching_example_sr rc_picture_matching_sr_q1 rc_picture_matching_sr_q2 rc_picture_matching_sr_q3 rc_picture_matching_sr_q4 rc_picture_matching_sr_q5 rc_picture_matching_sr_q6 rc_picture_matching_sr_q7 rc_picture_matching_sr_q8 rc_picture_matching_sr_q9 rc_picture_matching_sr_q10 rc_picture_matching_example_fr rc_picture_matching_fr_q1 rc_picture_matching_fr_q2 rc_picture_matching_fr_q3 rc_picture_matching_fr_q4 rc_picture_matching_fr_q5 rc_picture_matching_fr_q6 rc_picture_matching_fr_q7 rc_picture_matching_fr_q8 rc_picture_matching_fr_q9 rc_picture_matching_fr_q10 rc_picture_matching_example_pr rc_picture_matching_pr_q1 rc_picture_matching_pr_q2 rc_picture_matching_pr_q3 rc_picture_matching_pr_q4 rc_picture_matching_pr_q5 rc_picture_matching_pr_q6 rc_picture_matching_pr_q7 rc_picture_matching_pr_q8 rc_picture_matching_pr_q9 rc_picture_matching_pr_q10 rc_pm_stop_wf rc_pm_stop_pr rc_pm_stop_fr rc_pm_stop_sr)

order rc_picture_matching_example_fr rc_picture_matching_fr_q* rc_pm_stop_fr rc_picture_matching_example_wf rc_picture_matching_wf_q* rc_pm_stop_wf rc_picture_matching_example_sr rc_picture_matching_sr_q* rc_pm_stop_sr rc_picture_matching_example_pr rc_picture_matching_pr_q* rc_pm_stop_pr,after(reading_comprehension_pr_q6)

destring rc_picture_matching_example_fr rc_picture_matching_fr_q* rc_pm_stop_fr rc_picture_matching_example_wf rc_picture_matching_wf_q* rc_pm_stop_wf rc_picture_matching_example_sr rc_picture_matching_sr_q* rc_pm_stop_sr rc_picture_matching_example_pr rc_picture_matching_pr_q* rc_pm_stop_pr,replace

* correct picture
* 1. Define the value label (only once)
label define childruns 3 "The child runs", replace
label define childplays 4 "The child plays", replace
label define sleeps 3 "He sleeps", replace
label define catdog 1 "Cat and dog", replace
label define plogh 1 "The farmer ploughs", replace
label define duck 2 "The duck swims", replace
label define mouse 2 "The mouse is in front of the box", replace
label define ppmus 1 "People make music", replace
label define egg 3 "A hen is sitting on her eggs", replace
label define tree 2 "In my village there are many hills. I like to play on the hill with a single tree. It is the best for climbing.", replace
label define skip 2 "A group of friends get together to play in the evenings after school. There are always more than two children playing. They sometimes sing songs, but they don't have any instruments. They also don't have a ball, so they mainly play hopscotch, skipping rope, or tag", replace

* 2. Apply the label to each variable
foreach x in rc_picture_matching_example_fr rc_picture_matching_example_wf rc_picture_matching_example_sr rc_picture_matching_example_pr {
    label values `x' childruns
}

foreach x in rc_picture_matching_fr_q1 rc_picture_matching_wf_q1 rc_picture_matching_sr_q1 rc_picture_matching_pr_q1 {
    label values `x' childplays
}

foreach x in rc_picture_matching_fr_q2 rc_picture_matching_wf_q2 rc_picture_matching_sr_q2 rc_picture_matching_pr_q2 {
    label values `x' sleeps
}

foreach x in rc_picture_matching_fr_q3 rc_picture_matching_wf_q3 rc_picture_matching_sr_q3 rc_picture_matching_pr_q3 {
    label values `x' catdog
}

foreach x in rc_picture_matching_fr_q4 rc_picture_matching_wf_q4 rc_picture_matching_sr_q4 rc_picture_matching_pr_q4 {
    label values `x' plogh
}

foreach x in rc_picture_matching_fr_q5 rc_picture_matching_wf_q5 rc_picture_matching_sr_q5 rc_picture_matching_pr_q5 {
    label values `x' duck
}

foreach x in rc_picture_matching_fr_q6 rc_picture_matching_wf_q6 rc_picture_matching_sr_q6 rc_picture_matching_pr_q6 {
    label values `x' mouse
}

foreach x in rc_picture_matching_fr_q7 rc_picture_matching_wf_q7 rc_picture_matching_sr_q7 rc_picture_matching_pr_q7 {
    label values `x' ppmus
}

foreach x in rc_picture_matching_fr_q8 rc_picture_matching_wf_q8 rc_picture_matching_sr_q8 rc_picture_matching_pr_q8 {
    label values `x' egg
}

foreach x in rc_picture_matching_fr_q9 rc_picture_matching_wf_q9 rc_picture_matching_sr_q9 rc_picture_matching_pr_q9 {
    label values `x' tree
}

foreach x in rc_picture_matching_fr_q10 rc_picture_matching_wf_q10 rc_picture_matching_sr_q10 rc_picture_matching_pr_q10 {
    label values `x' skip
}

lab values rc_pm_stop_fr rc_pm_stop_wf rc_pm_stop_pr rc_pm_stop_sr yes_no

replace rc_pm_stop_fr = 1 if rc_picture_matching_fr_q6 == . & !missing(rc_picture_matching_fr_q5)
replace rc_pm_stop_fr = 0 if !missing(rc_picture_matching_fr_q6)

replace rc_pm_stop_wf = 1 if rc_picture_matching_wf_q6 == . & !missing(rc_picture_matching_wf_q5)
replace rc_pm_stop_wf = 0 if !missing(rc_picture_matching_wf_q6)

replace rc_pm_stop_sr = 1 if rc_picture_matching_sr_q6 == . & !missing(rc_picture_matching_sr_q5)
replace rc_pm_stop_sr = 0 if !missing(rc_picture_matching_sr_q6)

replace rc_pm_stop_pr = 1 if rc_picture_matching_pr_q6 == . & !missing(rc_picture_matching_pr_q5)
replace rc_pm_stop_pr = 0 if !missing(rc_picture_matching_pr_q6)

*************************************************************************
**Math form section
*************************************************************************
*math_language_record
destring math_language_record,replace
lab values math_language_record lan

*shapes
destring shapes_number_1 number_shapes_correct_1 shapes_number_2  number_shapes_correct_2 shapes_number_3 number_shapes_correct_3,replace

order identifying_shapes_response_lang shapes_number_1 number_shapes_correct_1 shapes_number_2  number_shapes_correct_2 shapes_number_3 number_shapes_correct_3,after(math_language_record)

*identifying_shapes_response_lang
destring identifying_shapes_response_lang,replace

lab values identifying_shapes_response_lang lan

*position_tracking
order position_tracking_response_langu,before(position_tracking_1)
destring position_tracking_1 - position_tracking_6 position_tracking_response_langu,replace

lab values position_tracking_response_langu lan
recode position_tracking_1 - position_tracking_6 (2=0)

lab values position_tracking_1 - position_tracking_6 cor_inc

* identifying_numbers 
order identifying_numbers_response_lan,after(position_tracking_6)

foreach x in identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3gridAu{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

destring identifying_numbers_response_lan - v839 identifying_numbers_correct_1 - v854 identifying_numbers_correct_2 identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3_1 - v865 identifying_numbers_grid_3autoSt,replace

lab values identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3gridAu true_false
lab values identifying_numbers_response_lan lan
lab values identifying_numbers_grid_1_1 - identifying_numbers_grid_1_8  identifying_numbers_grid_2_1 - identifying_numbers_grid_2_8 identifying_numbers_grid_3_1 - identifying_numbers_grid_3_4 cor_inc

drop identifying_numbers_grid_1autoSt identifying_numbers_grid_2autoSt v839 v854 v865 identifying_numbers_grid_3autoSt

order  identifying_numbers_grid_3_1 -  identifying_numbers_grid_3gridAu,after(identifying_numbers_correct_2)

ren identifying_numbers_grid_3number identify_numbers_grid_3num_corr
ren identifying_numbers_grid_2number identify_numbers_grid_2num_corr
ren identifying_numbers_grid_1number identify_numbers_grid_1num_corr

drop identifying_numbers_correct_1 identifying_numbers_correct_2 identifying_numbers_grid_3gridAu identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu

*counting
order counting_language,before(counting_1)

destring counting_language counting_1 - counting_6,replace
lab values counting_language lan

recode counting_1 - counting_6 (2=0)
lab values counting_1 - counting_6 cor_inc

*digital_discrimination
order digital_discrimination_language,before(digital_discrimination_grid_1_1)
destring digital_discrimination_*,replace

lab values digital_discrimination_grid_1_1 - digital_discrimination_grid_1_4 digital_discrimination_grid_2_1 - digital_discrimination_grid_2_4 digital_discrimination_grid_3_1 - digital_discrimination_grid_3_2 cor_inc
lab values digital_discrimination_language lan

foreach x in digital_discrimination_grid_3gri digital_discrimination_grid_2gri digital_discrimination_grid_1gri{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values digital_discrimination_grid_3gri digital_discrimination_grid_2gri digital_discrimination_grid_1gri true_false
ren digital_discrimination_grid_1num digital_discrimination_1num_corr
ren digital_discrimination_grid_2num digital_discrimination_2num_corr
ren digital_discrimination_grid_3num digital_discrimination_3num_corr

drop v903 v914 v923 digital_discrimination_grid_1aut digital_discrimination_grid_2aut digital_discrimination_grid_3aut digital_discrimination_grid_1gri	digital_discrimination_correct_1 digital_discrimination_grid_2gri	digital_discrimination_correct_2 digital_discrimination_grid_3gri

*Missing
order missing_response_language,before(missing_number_grid_1_1)
destring missing_number_grid_* missing_response_language missing_number_correct_grid_1,replace
lab values missing_number_grid_1_1 - missing_number_grid_1_4 missing_number_grid_2_1 - missing_number_grid_2_4 cor_inc
lab values missing_response_language lan

drop v938 v949 missing_number_grid_1autoStop missing_number_grid_2autoStop


foreach x in missing_number_grid_1gridAutoSto missing_number_grid_2gridAutoSto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}
lab values missing_number_grid_1gridAutoSto missing_number_grid_2gridAutoSto true_false

ren missing_number_grid_1number_of_i missing_number_1num_corr
ren missing_number_grid_2number_of_i missing_number_2num_corr

drop missing_number_grid_1gridAutoSto missing_number_correct_grid_1 missing_number_grid_2gridAutoSto

*Decimal
drop decimal_system_grid_1autoStop decimal_system_grid_2autoStop decimal_system_grid_3autoStop v964 v975 v984

ren decimal_system_grid_3number_of_i decimal_system_3num_corr
ren decimal_system_grid_2number_of_i decimal_system_2num_corr
ren decimal_system_grid_1number_of_i decimal_system_1num_corr

destring decimal_correct_* decimal_system_* decimal_response_language,replace

order decimal_response_language,before(decimal_system_grid_1_1)
lab values decimal_response_language lan

foreach x in decimal_system_grid_2gridAutoSto  decimal_system_grid_1gridAutoSto decimal_system_grid_3gridAutoSto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}
lab values decimal_system_grid_2gridAutoSto  decimal_system_grid_1gridAutoSto decimal_system_grid_3gridAutoSto true_false

lab values decimal_system_grid_1_1 - decimal_system_grid_1_4 decimal_system_grid_2_1 - decimal_system_grid_2_4 decimal_system_grid_3_1 decimal_system_grid_3_2 cor_inc

drop decimal_system_grid_1gridAutoSto	decimal_correct_1 decimal_system_grid_2gridAutoSto	decimal_correct_2 decimal_system_grid_3gridAutoSto

*Addion and subtraction
order addition_subtraction_response_la,before(addition_subtraction_1)

destring addition_subtraction_response_la addition_subtraction*,replace

lab define add_sub 1"Correct" 2"Partially correct" 3"Incorrect"

lab values addition_subtraction_response_la lan
lab values addition_subtraction_1 - addition_subtraction_5 add_sub

*Addition  and Subtraction strategy Grid
gen addition_subtraction_strategy = .
lab var addition_subtraction_strategy"Note the strategy the student used to solve the addition and subtraction questions"
order addition_subtraction_strategy,before(addition_subtraction_strategy_1)

lab values addition_subtraction_strategy_1 - addition_subtraction_strategy_99 yes_no

*word_addition_subtraction
order word_addition_subtraction_respon,before(word_addition_subtraction_1)

destring word_addition_subtraction_respon word_addition_subtraction_*,replace

lab values word_addition_subtraction_respon lan
lab values word_addition_subtraction_1 - word_addition_subtraction_5 add_sub

*word add sub strategy
ren (word_addition_subtraction_strate v1035 v1036 v1037) (word_add_sub_strategy_1 word_add_sub_strategy_2 word_add_sub_strategy_3 word_add_sub_strategy_99 )

destring word_add_sub_strategy_*,replace
lab values word_add_sub_strategy_1 - word_add_sub_strategy_99 yes_no

*translator
ren translator translators
destring translators,replace
lab values translators yes_no
lab var translators"Was the translator used?"
order translators INT_ENDTIME,after(word_add_sub_strategy_99)

destring reading_famila_word_sr_Bnum_att read_invented_word_sr_Bnum_att reading_famila_word_pr_Bnum_att GPSlatitude GPSlongitude GPSaccuracy,replace

// ds, has(type string)
// destring `r(varlist)', replace

*****************************************************************************************************************
**Value labelling
*****************************************************************************************************************

do "Labelling_file.do"

*****************************************************************************************************************
**QC Checks
*************************************************************************
drop if Consent == 0

replace Student_Name = trim(strproper(Student_Name))
replace B6_S = trim(strproper(B6_S))

lab define int_sem 1"Very confident" 2 "Somewhat confident" 3"Not confident"

destring interviewer_semantic_1 interviewer_semantic_2 interviewer_semantic_3 interviewer_semantic_4 semantic_language_timer1time_rem semantic_language_timer2time_rem semantic_language_timer3time_rem semantic_language_timer4time_rem,replace

lab values interviewer_semantic_1 interviewer_semantic_2 interviewer_semantic_3 interviewer_semantic_4 int_sem

*correction
foreach x in semantic_language_timer1time_rem semantic_language_timer2time_rem semantic_language_timer3time_rem semantic_language_timer4time_rem{
	replace `x' = 0  if !missing(`x') & (`x' > 0 | `x' < 0)
}

replace INT_DATE=  td(08dec2025) if interview_ID == "7c7ce476-52ae-46d1-b214-b24d120eac32"

*Corrections.
*Client Query 1.
replace survey_language = 1 if B4 == 3 & survey_language != 1
replace survey_language = official_language if B4 == 1 & survey_language == 1

*Query 2.
replace teaching_language =1 if interview_ID =="d03e46ec-dd62-4a81-b2c3-7594ec03ff79"
replace teaching_language =3 if interview_ID =="6deb405f-a52e-4547-8927-1d9789a58eba"
replace teaching_language =1 if interview_ID =="6bfd7f9f-8346-4772-b4e4-85b95389bea6"
replace teaching_language =1 if interview_ID =="0a0bac0b-7fee-4684-bd91-88a4b9034726"
replace teaching_language =3 if interview_ID =="f33fd61f-2d41-4ebc-a7e5-d48c2bc8643d"
replace teaching_language =3 if interview_ID =="e9acb732-0e86-4c23-a4ab-b1fd28bb32b4"
replace teaching_language =3 if interview_ID =="acfd0e15-e404-4719-a042-b32fb68e29b1"
replace teaching_language =3 if interview_ID =="47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5"
replace teaching_language =3 if interview_ID =="3506df89-9581-4a5b-ac89-fb274d49d350"
replace teaching_language =3 if interview_ID =="d6b9c0c5-667b-4f6b-9f41-301b44cdada0"
replace teaching_language =3 if interview_ID =="eb556751-a143-44ca-a4fa-bc9a93833f69"
replace teaching_language =3 if interview_ID =="ceb56aff-c84a-48f1-8fb5-28aa6a4a7408"
replace teaching_language =3 if interview_ID =="b4318f26-486e-4833-bc9b-e6e03a6387f6"
replace teaching_language =3 if interview_ID =="45451da8-6aea-4ccd-a668-fcf6fcca1084"
replace teaching_language =3 if interview_ID =="9e4ed0cc-3d30-4f77-814d-a4c56e292587"
replace teaching_language =3 if interview_ID =="e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4"
replace teaching_language =3 if interview_ID =="91fd21c5-3d48-456a-b33e-9ccc1199647b"
replace teaching_language =3 if interview_ID =="a45cd6b0-302a-47c6-8ac0-24f9949d65b4"
replace teaching_language =3 if interview_ID =="987c1aba-d5ae-4fc1-b977-11d61c1accc2"
replace teaching_language =3 if interview_ID =="d171cc2c-40d1-462e-8531-23811ab76b1d"
replace teaching_language =3 if interview_ID =="827ab6a2-6ab0-44b8-8926-42b61b393e58"
replace teaching_language =3 if interview_ID =="ae264f26-2482-435a-ab2b-7f496a34d19c"
replace teaching_language =3 if interview_ID =="fac45cb0-0101-475c-a7a8-432678d7643d"
replace teaching_language =3 if interview_ID =="dbe08ef8-79d1-4966-b423-c8df4ea4acbf"
replace teaching_language =3 if interview_ID =="e23bc4d0-8eaf-4b1f-910a-98c0b0386594"
replace teaching_language =3 if interview_ID =="c7aeb8c7-81c8-4f3f-8584-421e61eb4dc3"
replace teaching_language =3 if interview_ID =="3a64ac6c-1dd1-490e-a6f5-d6509f56bcad"
replace teaching_language =3 if interview_ID =="021c7c83-722d-4818-a494-ab5274360532"
replace teaching_language =3 if interview_ID =="ed131b98-c787-4c82-882c-1d2796ab369a"
replace teaching_language =3 if interview_ID =="a69faeaf-9aa1-4e50-a309-13c75bcb7da1"
replace teaching_language =3 if interview_ID =="58e215ac-afef-42d9-8cb7-7e6bdefb9d62"
replace teaching_language =3 if interview_ID =="3dba3444-f931-4192-a026-0592fed5c4db"
replace teaching_language =3 if interview_ID =="28d6e665-18e3-496c-84bd-57f5ae998d08"
replace teaching_language =1 if interview_ID =="f9a21cb3-0622-4552-a3ca-975394b9ca03"
replace teaching_language =1 if interview_ID =="57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace teaching_language =1 if interview_ID =="ffa369ac-4283-4a90-98fc-8846a6c6fb4e"
replace teaching_language =3 if interview_ID =="1c99fea7-31d3-4fbe-9949-e030e0c2fe22"
replace teaching_language =3 if interview_ID =="ac518c97-0e79-4799-89cb-51f1acc52413"
replace teaching_language =3 if interview_ID =="f9c51d62-9d83-492a-90d2-a376ba12b8a6"
replace teaching_language =1 if interview_ID =="48422b8d-42ad-4294-95f3-7bb2d2701d36"
replace teaching_language =3 if interview_ID =="b27b2164-9414-41ed-ad4c-6ad383f86e44"
replace teaching_language =1 if interview_ID =="24e563f4-7d09-4d17-8169-d8814d697ffb"
replace teaching_language =1 if interview_ID =="d988403c-a0a2-44eb-86f0-2de65ce7db54"
replace teaching_language =1 if interview_ID =="e331d060-57d1-41a4-8848-e2f62d57ae65"
replace teaching_language =1 if interview_ID =="56bb62c2-a467-4786-8eef-bfe55ba3ba9b"
replace teaching_language =3 if interview_ID =="196aa4be-9aac-4248-b02e-de881f76db71"
replace teaching_language =3 if interview_ID =="371e0e95-b6f3-4517-9852-942506c8e086"
replace teaching_language =3 if interview_ID =="952690be-cd52-4bc5-ad46-62bf83c09b3a"
replace teaching_language =1 if interview_ID =="54045343-38e8-4bc7-aa0c-b56350f62bfc"
replace teaching_language =3 if interview_ID =="20d2bb4a-d1ab-46e9-bf57-70c07c123719"
replace teaching_language =3 if interview_ID =="6860cd27-31b9-4c21-a54c-0d0fd8f8209d"
replace teaching_language =1 if interview_ID =="3c155564-2174-4b0f-8542-ce0c061257eb"
replace teaching_language =1 if interview_ID =="189318b4-6126-40eb-bbcd-da310507f175"
replace teaching_language =3 if interview_ID =="fa7c730e-4e47-4e56-9adf-331a3dbce907"
replace teaching_language =3 if interview_ID =="b4918c03-457a-44b9-a048-aa68b8846e21"
replace teaching_language =3 if interview_ID =="c2bfffc5-9f55-416f-a8b4-01fe9b77ba4c"
replace teaching_language =3 if interview_ID =="c13e00e0-9036-46a4-be98-80d9df50bdd1"
replace teaching_language =1 if interview_ID =="764eaee0-b5be-4432-874b-69b1261cc181"
replace teaching_language =1 if interview_ID =="0603e745-4755-4735-ab8b-81a7133999a8"
replace teaching_language =1 if interview_ID =="2166db2f-c8b8-4a12-898e-8296e1b10890"
replace teaching_language =1 if interview_ID =="c905025e-4182-40be-831f-b476507dfa77"
replace teaching_language =1 if interview_ID =="9bbde13b-062c-4f07-8cc5-7561b17a480d"
replace teaching_language =3 if interview_ID =="85bc6364-0680-4751-86cd-ee3fda033816"
replace teaching_language =1 if interview_ID =="840d9ee5-ca5a-43f6-a855-9257880755da"
replace teaching_language =1 if interview_ID =="a86a2cd3-f0b6-4a89-91e5-25c1db9a269d"
replace teaching_language =3 if interview_ID =="90e20319-9fc1-4c08-a9b9-3f851839aded"
replace teaching_language =1 if interview_ID =="be0cd69b-653b-4da4-bfc5-a1d41d6d12e2"
replace teaching_language =3 if interview_ID =="24b7ec03-358c-4ac7-af7f-32137d492cb2"
replace teaching_language =3 if interview_ID =="03da1bc6-09f3-40b8-bef9-2cbc0d0cca5d"
replace teaching_language =3 if interview_ID =="17011753-34e8-4c53-853a-d2cb0f2f83f3"
replace teaching_language =3 if interview_ID =="1d852e1b-7029-450f-937e-09975a21638b"
replace teaching_language =3 if interview_ID =="16a2a2e2-7692-4df3-a6e0-0b4183b70642"
replace teaching_language =3 if interview_ID =="9fedd8b1-26d4-4f91-bbc0-dfa887f6c186"
replace teaching_language =3 if interview_ID =="3f55022b-b396-4388-8f39-d8f36054d20a"
replace teaching_language =3 if interview_ID =="04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace teaching_language =1 if interview_ID =="f925fc1d-0d39-41ac-95d4-93679ff6d84c"
replace teaching_language =3 if interview_ID =="903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace teaching_language =3 if interview_ID =="5bcc1c7d-0f28-4158-a2df-6ebfff0e3701"
replace teaching_language =3 if interview_ID =="7316171a-365c-4f27-bc5c-a2d19739d52a"
replace teaching_language =3 if interview_ID =="146af2fd-2f60-4d50-aae1-5449c556cd7b"
replace teaching_language =1 if interview_ID =="cf6b59a7-6ed5-4f0a-83e1-3b6554e76190"
replace teaching_language =3 if interview_ID =="828a231d-8d3b-4515-82f2-4db8720c1887"
replace teaching_language =3 if interview_ID =="4dc7b3e5-f8c8-4a66-9acb-4185ede2c16b"
replace teaching_language =3 if interview_ID =="4963cf77-9f2b-40ed-a8b4-1bb0b7561e25"
replace teaching_language =3 if interview_ID =="b48552c3-08bd-4b63-8e07-8a9b534653fe"
replace teaching_language =3 if interview_ID =="7f0e472f-7946-44f4-8b11-535c2c87545e"
replace teaching_language =3 if interview_ID =="c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace teaching_language =3 if interview_ID =="87d312cc-e8e9-484f-b63a-50f0a4daec07"
replace teaching_language =3 if interview_ID =="5c2a2905-8d24-420d-8a50-8031ecf83e0e"
replace teaching_language =3 if interview_ID =="297ad4cd-9734-4d17-9424-ed3fa3594af6"
replace teaching_language =3 if interview_ID =="d9c218e5-e0e6-493c-a1d1-0fabfbfc039b"
replace teaching_language =1 if interview_ID =="f472aa19-e4ee-4e09-b6ab-8bd600de957d"
replace teaching_language =1 if interview_ID =="7a7ca376-9da9-4ba4-a445-802999b1d569"
replace teaching_language =1 if interview_ID =="2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f"
replace teaching_language =2 if interview_ID =="664c5d1c-1210-4aaf-b804-5b42b7057989"
replace teaching_language =1 if interview_ID =="e6112283-c0b2-4c38-8292-1ffa830d7dc8"
replace teaching_language =1 if interview_ID =="6f2c99cb-779a-47ef-ba75-450073085f94"
replace teaching_language =1 if interview_ID =="2d4589ca-0227-430d-ab9d-3f48b9852abb"
replace teaching_language =1 if interview_ID =="33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9"
replace teaching_language =2 if interview_ID =="775fdf37-148c-42cf-9e6e-789e29b752e0"
replace teaching_language =1 if interview_ID =="49d3258b-2f7f-4a5b-b7da-a94119a1741d"
replace teaching_language =1 if interview_ID =="fc083b06-21a2-4665-8228-d741d3d22d15"
replace teaching_language =1 if interview_ID =="df33a347-224b-4d44-b56a-ff31036cff13"
replace teaching_language =2 if interview_ID =="74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace teaching_language =2 if interview_ID =="9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace teaching_language =1 if interview_ID =="d0273b2f-d376-49d6-b1dc-82fc45816d0d"
replace teaching_language =1 if interview_ID =="ce096236-6d51-45ee-9bf3-c71e9644f103"
replace teaching_language =1 if interview_ID =="5f855822-db47-4379-8082-f4b892591670"
replace teaching_language =2 if interview_ID =="80f5c997-81f6-4501-b289-0acbe647690f"
replace teaching_language =1 if interview_ID =="bba9da36-baf3-489d-8964-49514a08ae95"
replace teaching_language =2 if interview_ID =="2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace teaching_language =1 if interview_ID =="4eae42ee-944c-48e1-a67e-650538cc8941"
replace teaching_language =1 if interview_ID =="34240a67-95fe-48e6-9dc3-481a5eb995f8"
replace teaching_language =2 if interview_ID =="687b58cd-3781-4864-8956-3254c912f3dc"
replace teaching_language =1 if interview_ID =="70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace teaching_language =2 if interview_ID =="3ab06563-d43a-4539-8a4a-2fe171d9f713"
replace teaching_language =2 if interview_ID =="f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace teaching_language =1 if interview_ID =="b508dc8b-253b-42b1-b88f-435fdbe52869"
replace teaching_language =2 if interview_ID =="38bdc126-72b7-4df0-8444-c471ca2a87e4"
replace teaching_language =1 if interview_ID =="18e148e8-0d56-481d-addc-401cd8a79600"
replace teaching_language =2 if interview_ID =="96c50de6-a383-4198-a9df-d2dc2e6c678c"
replace teaching_language =2 if interview_ID =="bb896380-88b3-426b-b1cb-c992b1145c15"
replace teaching_language =2 if interview_ID =="016920bf-44b8-4d91-a780-c6a0e957484d"
replace teaching_language =1 if interview_ID =="958c05fe-fa40-4655-b83a-c9653c7ddfd4"
replace teaching_language =2 if interview_ID =="64f00d50-e875-4e77-92c1-f4d53ba1a922"
replace teaching_language =2 if interview_ID =="2eeabd68-3ed4-49f5-a54d-375966e9f7e8"
replace teaching_language =1 if interview_ID =="4aad058f-af72-471c-95cb-20e762b2f6d8"
replace teaching_language =2 if interview_ID =="cdacae65-f165-42ee-8668-d30927fa89b4"
replace teaching_language =2 if interview_ID =="a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4"
replace teaching_language =1 if interview_ID =="c9c31e8d-6685-43f6-abdb-acb22510e956"
replace teaching_language =2 if interview_ID =="27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519"
replace teaching_language =1 if interview_ID =="cc4ccbd3-15ab-4f89-b523-6aaba6d526e9"
replace teaching_language =1 if interview_ID =="2d855cfe-06f0-4c0f-88b6-4e2f1b6e9659"
replace teaching_language =1 if interview_ID =="d4172b31-e410-4ae7-9e35-df10df8671e3"
replace teaching_language =1 if interview_ID =="695d3744-bced-4b2d-a3c7-f9dab6c0dd92"
replace teaching_language =1 if interview_ID =="4592a6d6-e884-4dcf-9010-cf8ac8140ede"
replace teaching_language =1 if interview_ID =="db5e40e9-5901-4841-bb67-5ae1a3c6a7eb"
replace teaching_language =1 if interview_ID =="ae1ce825-0716-42b8-8df0-f4c03de0b574"
replace teaching_language =1 if interview_ID =="16de6940-63b3-46ea-bbe8-bbcb02e7f9fe"
replace teaching_language =1 if interview_ID =="eab63d34-d938-449e-ab1d-55de9b38c544"
replace teaching_language =2 if interview_ID =="ecd24a66-fb95-406e-a056-30c082ccc370"
replace teaching_language =1 if interview_ID =="fd081796-3a85-40a8-9ac2-0ab56af3c176"
replace teaching_language =2 if interview_ID =="1ccccc68-0735-4dab-b908-a0d3a80a4c9a"
replace teaching_language =2 if interview_ID =="8290158c-8202-4707-a821-c6ca4e5f4cf7"
replace teaching_language =2 if interview_ID =="e1d5d06e-04d1-488f-9f20-0be1971b0b14"
replace teaching_language =2 if interview_ID =="5875efa2-2b0b-4353-b809-e69b1c767cc7"
replace teaching_language =2 if interview_ID =="b2810855-8afa-47f4-b6fa-9c5ebb61fba4"
replace teaching_language =2 if interview_ID =="ef097054-041a-4ff4-985f-27d9e373255e"
replace teaching_language =2 if interview_ID =="a59b6d10-2cb8-4c01-8442-e59478955834"
replace teaching_language =1 if interview_ID =="05cc7dad-1032-4141-b32f-b29e2b442c53"
replace teaching_language =1 if interview_ID =="4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace teaching_language =2 if interview_ID =="de6386c0-0baf-49b3-bffb-3cac46465ed0"
replace teaching_language =1 if interview_ID =="3676f691-4038-4d35-850f-081bb916d90e"
replace teaching_language =2 if interview_ID =="04af0d11-cd0a-438a-84b3-b07badf6126d"
replace teaching_language =2 if interview_ID =="2f95b04e-68ef-4dec-bba4-0aa80fe4c337"
replace teaching_language =1 if interview_ID =="4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace teaching_language =2 if interview_ID =="849563d3-9773-4a1d-89d8-b7b3a16beb89"
replace teaching_language =1 if interview_ID =="dfbcf07f-5330-48e9-992f-5234859a41a6"
replace teaching_language =2 if interview_ID =="ae218944-f91c-4924-b5ea-1b31a3b0f013"
replace teaching_language =1 if interview_ID =="4644aea1-f044-4cb4-b79a-638800249e8e"
replace teaching_language =1 if interview_ID =="fb9c234b-de3a-40b1-877d-e0774134e95a"
replace teaching_language =2 if interview_ID =="54450ef7-08f0-4f9a-a288-f09d7a6c382d"
replace teaching_language =1 if interview_ID =="896bdf68-1cc1-4b29-bba7-c19e80e50af4"
replace teaching_language =1 if interview_ID =="e5ffddbc-31f4-41e2-a5ad-a63bf0a2f196"
replace teaching_language =1 if interview_ID =="987e3c29-0aa1-4a9c-8aac-916cbc79c550"
replace teaching_language =2 if interview_ID =="278c20ad-72e0-474f-98a2-eb146c877e82"
replace teaching_language =1 if interview_ID =="7e029362-f6a3-411d-8b23-17cd283b7bd8"
replace teaching_language =2 if interview_ID =="b14a5f5e-8b6c-45ed-9ccd-fa1aef85d4dc"
replace teaching_language =1 if interview_ID =="371c0317-3508-4318-b597-f78fe787d8c2"
replace teaching_language =1 if interview_ID =="8036d97d-de52-4a90-be25-312c7151c8b4"
replace teaching_language =1 if interview_ID =="8d3c5fd7-5873-4bf9-81a7-17cc5e4bf39e"
replace teaching_language =1 if interview_ID =="2d0edb86-ec51-4056-a030-9e611ed03ac5"
replace teaching_language =1 if interview_ID =="e9c0ac27-52af-4d1a-8db0-8144b2c5b136"
replace teaching_language =1 if interview_ID =="a0932450-5d6a-4c41-a840-7e8d3073dbe1"
replace teaching_language =2 if interview_ID =="d894d25a-03bc-4663-9dea-fbdf62608d63"
replace teaching_language =1 if interview_ID =="94a31cc7-278a-4dc1-a99f-69fedfbfb4ff"
replace teaching_language =1 if interview_ID =="906a3c39-e317-44ac-a320-b9e0e7bf872c"
replace teaching_language =2 if interview_ID =="36c27614-ece9-4128-8f7e-4e1d7c5a0fa2"
replace teaching_language =2 if interview_ID =="bd2b73ce-9bf3-476d-b89c-47f166f60259"
replace teaching_language =2 if interview_ID =="3cd2c24c-6a2c-470f-90c2-a025d028238d"
replace teaching_language =1 if interview_ID =="4ccb1827-b89e-4397-9de0-746a9203fa5f"
replace teaching_language =2 if interview_ID =="3e41e2ff-9e52-4d18-b6e8-6faf47694c1f"
replace teaching_language =1 if interview_ID =="721f4c0a-19e0-44a6-a988-9dcb1099479e"
replace teaching_language =2 if interview_ID =="dc021baf-6958-4b75-ab39-a6963e4177c4"
replace teaching_language =2 if interview_ID =="f6bdb475-82a5-47e7-aa3a-728b13a2906b"
replace teaching_language =2 if interview_ID =="cfee0ae8-ab33-49d0-8a64-e9828e7b273e"
replace teaching_language =1 if interview_ID =="b186bac0-cc7f-409d-853f-6e45b086c73d"
replace teaching_language =1 if interview_ID =="8c21f71d-6af5-489c-b9c0-71360d00efce"
replace teaching_language =2 if interview_ID =="2cd65397-d824-480c-97ed-cf25d86de3e3"
replace teaching_language =1 if interview_ID =="e323eca7-90a5-408f-881d-f97277b5a5d7"
replace teaching_language =2 if interview_ID =="2205b7de-57f0-4715-85cc-73673f868678"
replace teaching_language =2 if interview_ID =="b0a34862-9126-4fbe-a263-1b445ef70ef3"
replace teaching_language =2 if interview_ID =="8f2109f7-7b96-4b23-8383-7fa94872f586"
replace teaching_language =1 if interview_ID =="4c2c557a-2499-4a4e-99d6-41547e8c1a5d"
replace teaching_language =2 if interview_ID =="6f4445ff-dc73-4064-9174-0044d2973395"
replace teaching_language =1 if interview_ID =="480d348e-70f2-4c4e-8a30-cb6f8cd3ffb8"
replace teaching_language =1 if interview_ID =="1d4c9450-8d69-4f4b-8795-11257f6bfeab"
replace teaching_language =1 if interview_ID =="b10da94e-4ef1-4886-9ee2-be6be009489b"
replace teaching_language =1 if interview_ID =="3c9bd3bb-5071-44b4-a65d-50f28f9608a4"
replace teaching_language =1 if interview_ID =="f6f55a81-b07b-4ddc-8c70-0a9d77a7f56d"
replace teaching_language =1 if interview_ID =="0f1e6edb-fbdd-49a6-98b4-8a29a96c6fce"
replace teaching_language =1 if interview_ID =="ddf9180a-94dd-4109-a1d3-e26552185847"
replace teaching_language =1 if interview_ID =="6129d954-3047-43e7-97a6-b58e5870603b"
replace teaching_language =1 if interview_ID =="e2a5aa95-3efe-4176-8de2-a917e416f892"
replace teaching_language =1 if interview_ID =="eff2f8f1-8eca-4e81-937a-6cb060ad35fe"
replace teaching_language =2 if interview_ID =="56645761-47d9-4afd-abac-085730b553b4"
replace teaching_language =1 if interview_ID =="ec1cca0d-209a-422a-add1-556ab98ff141"
replace teaching_language =2 if interview_ID =="5d269cb5-2db4-4006-881f-d0c5cf95d158"
replace teaching_language =2 if interview_ID =="fc355bf6-b25a-4cf0-9e92-a866fd8c9cda"
replace teaching_language =1 if interview_ID =="a88f1ef6-f60a-43a9-931f-4739f52c69d7"
replace teaching_language =1 if interview_ID =="52db65f5-3c9f-4d76-bade-daa69c6693f7"
replace teaching_language =1 if interview_ID =="d7c38247-d416-4855-b261-5050a11bac45"
replace teaching_language =2 if interview_ID =="32083ff4-497b-470c-83d3-ef7e448879be"
replace teaching_language =2 if interview_ID =="d747478e-c559-4fa5-a205-dd55d2e84615"
replace teaching_language =2 if interview_ID =="7644de24-742d-4cbe-bbc6-0e4916ed7133"
replace teaching_language =2 if interview_ID =="ba3d30d5-2d1b-4345-88dc-4687ca935d06"
replace teaching_language =1 if interview_ID =="342492e9-a75c-415e-9303-e4fff2ef6019"
replace teaching_language =2 if interview_ID =="423b834f-e93d-4f99-a392-d2cedd3a09ec"
replace teaching_language =1 if interview_ID =="cc2c09e4-d50e-4db2-b70a-1343534512c4"
replace teaching_language =1 if interview_ID =="5a8c8e58-9d6a-4a8b-8802-079294482ae1"
replace teaching_language =1 if interview_ID =="763ea2cb-2ba2-4707-b96a-0209f4d0ca55"
replace teaching_language =2 if interview_ID =="585e2373-1621-41c8-a53c-c84166907d78"
replace teaching_language =2 if interview_ID =="3eb87b48-e1b1-4004-aced-ffa569170df3"
replace teaching_language =2 if interview_ID =="a5cbd55d-9a46-4dc9-8d9f-bf71d9e2e05b"
replace teaching_language =2 if interview_ID =="cbc373d5-d289-4b98-b8b8-8d13ce9e469e"
replace teaching_language =1 if interview_ID =="50e669b7-5e85-4250-b834-d2bd5ef2f6a2"
replace teaching_language =2 if interview_ID =="86700737-288a-4b8e-b7fd-0db7c2f3ddce"
replace teaching_language =1 if interview_ID =="7301d1e7-6c89-4219-9050-27e16a5bb8fb"
replace teaching_language =2 if interview_ID =="9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace teaching_language =2 if interview_ID =="9ece55b5-5dd4-4a2b-9d27-3eb4087925e5"
replace teaching_language =1 if interview_ID =="41dc0aa6-9bbe-4fa0-aae9-a563b1c49456"
replace teaching_language =2 if interview_ID =="744dcc9a-7871-446d-9161-ac97cbd808df"
replace teaching_language =2 if interview_ID =="57af00e3-d5db-4f4d-8741-d5a691d27744"
replace teaching_language =1 if interview_ID =="82eea277-0346-4c40-b235-30f785cc6a8c"
replace teaching_language =2 if interview_ID =="f956d6aa-5c0c-4739-9e00-dc2e3a315c71"
replace teaching_language =2 if interview_ID =="e66b02e8-0253-423a-970c-c354079d37fb"
replace teaching_language =1 if interview_ID =="76da393a-4246-4d2d-87eb-f5c0fa97db92"
replace teaching_language =2 if interview_ID =="1eeedaaf-eecb-45b0-a69d-ea362dd1c425"
replace teaching_language =2 if interview_ID =="dd445b1c-916f-4b7c-9059-24f0a45655a8"
replace teaching_language =2 if interview_ID =="a3799748-5d88-4de6-a038-c5923894507d"
replace teaching_language =2 if interview_ID =="500d304c-1438-41e4-96b5-9c38c84f7e39"
replace teaching_language =2 if interview_ID =="02cddc5e-7724-4cec-8019-f15ca2aaf6da"
replace teaching_language =2 if interview_ID =="4dd8a3b9-5493-40ac-8625-55221a642082"
replace teaching_language =2 if interview_ID =="6e2f6dad-354e-4bf6-8452-21008ad88ca7"
replace teaching_language =2 if interview_ID =="2611f2db-a04a-47da-b261-259ccd28e338"
replace teaching_language =2 if interview_ID =="ccde7f7d-4080-427c-8805-3c9dea4bf1cc"
replace teaching_language =2 if interview_ID =="75ded4fd-27e2-440e-90d2-977194e4e0f9"
replace teaching_language =2 if interview_ID =="1e82a138-c1bd-40da-b7f5-bc1c37566c7f"
replace teaching_language =2 if interview_ID =="7451cbf4-4128-4e20-aa6a-fd1d09750f3a"
replace teaching_language =1 if interview_ID =="2ddf89db-e7bb-4cc4-a5bf-3284a3536072"
replace teaching_language =1 if interview_ID =="2ea90b08-8d95-441e-a8a4-8bd812e0aa57"
replace teaching_language =2 if interview_ID =="5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace teaching_language =2 if interview_ID =="eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace teaching_language =2 if interview_ID =="0efe8e10-f0fa-4fa8-b28e-da8c9192a60f"
replace teaching_language =1 if interview_ID =="1f111b6a-387e-4e61-81c9-622d207742f7"
replace teaching_language =2 if interview_ID =="ca332f93-3166-4d0a-90ef-44d651ebf19a"
replace teaching_language =2 if interview_ID =="3a3d32d6-3da6-4f5d-a72b-c57591490ea2"
replace teaching_language =2 if interview_ID =="6eb72794-efc0-48af-92e2-a90b403de61f"
replace teaching_language =2 if interview_ID =="bbdfb929-3c53-480a-a728-4633f329f833"
replace teaching_language =2 if interview_ID =="8cf7dab5-e361-4e11-a07b-53b4ddb07d3b"
replace teaching_language =2 if interview_ID =="dab6f85d-1dcf-420d-a750-47681dea2b8e"
replace teaching_language =2 if interview_ID =="967f49aa-c855-4fcb-b32c-a46e896964a8"
replace teaching_language =2 if interview_ID =="d2bd98e7-64bd-499e-bbcf-95f2ef86650b"
replace teaching_language =2 if interview_ID =="5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace teaching_language =2 if interview_ID =="7d5e030b-01da-4e7c-b0d7-237e2a63754f"
replace teaching_language =2 if interview_ID =="6ebca319-337b-40fc-a0e7-170ea5dc629f"
replace teaching_language =2 if interview_ID =="5d3db37f-b6ac-43ec-9130-af7edc8149cd"
replace teaching_language =2 if interview_ID =="d67f831d-b280-4f07-b17f-d350388e3e01"
replace teaching_language =2 if interview_ID =="f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace teaching_language =2 if interview_ID =="e654d973-eae8-4dfa-849b-4b7b226911bc"
replace teaching_language =2 if interview_ID =="dbd1c883-0268-4394-a86c-9ba0d1e56d09"
replace teaching_language =2 if interview_ID =="bc95181a-9571-4c52-afdc-a3eac063cfcb"
replace teaching_language =2 if interview_ID =="97d71f6c-98da-4cd9-bc86-dce05b13fb44"
replace teaching_language =2 if interview_ID =="f7f16800-2a85-442b-9f83-69ffbc18021c"
replace teaching_language =2 if interview_ID =="c36a9870-8acb-41cb-b989-78b7f52753a9"
replace teaching_language =1 if interview_ID =="7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace teaching_language =1 if interview_ID =="8ad12e26-7380-4936-8b9d-7771e5b65fec"
replace teaching_language =2 if interview_ID =="fac43095-6f57-476e-bc3f-6364aab4708e"
replace teaching_language =2 if interview_ID =="2abb8dd0-08b8-41a7-9637-3e8e64ae7276"
replace teaching_language =2 if interview_ID =="74ac1b56-86c2-4946-86a3-1b850eeeed35"
replace teaching_language =2 if interview_ID =="992de92e-d253-43df-9fce-5d6937cc4b1a"
replace teaching_language =1 if interview_ID =="32c49089-74ee-45b7-9679-59f048b79e51"
replace teaching_language =2 if interview_ID =="c860a452-4dca-422b-927b-af6f89153562"
replace teaching_language =2 if interview_ID =="2c2d763c-77a2-46a8-8bcd-a46e75709bca"
replace teaching_language =2 if interview_ID =="aa71dbcc-9fd7-4b18-8b0e-480a4869766d"
replace teaching_language =2 if interview_ID =="73fff59c-a151-4d4d-b903-fb2d1485a31d"
replace teaching_language =2 if interview_ID =="b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace teaching_language =2 if interview_ID =="00aa1fe9-0240-4be0-b851-223e592e7bf5"
replace teaching_language =2 if interview_ID =="5dd52609-089b-4200-9ce6-ec1b0e3100bb"
replace teaching_language =2 if interview_ID =="de3c2ea7-219c-420e-922b-c6c8d9cc6aa0"
replace teaching_language =2 if interview_ID =="ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace teaching_language =2 if interview_ID =="acedeb6c-4873-4230-8a07-2e059b91d746"
replace teaching_language =2 if interview_ID =="08b9b550-4288-456e-8452-10720aed8fa4"

*Query 4.
*phonological_awareness

foreach x in phonological_awareness_fr_1 phonological_awareness_fr_2 phonological_awareness_fr_3 phonological_awareness_fr_4 phonological_awareness_fr_5 phonological_awareness_fr_6 phonological_awareness_fr_7 phonological_awareness_fr_8 phonological_awareness_fr_9 phonological_awareness_fr_10 phonological_awareness_frnumber_ phonological_awareness_frnum_att phonological_awareness_frgridAut phonological_awareness_frautoSto phonological_stop_fr{
	replace `x' = . if B4 == 1
}

foreach x in  phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 2 & survey_language == 2 & official_language == 2
}

foreach x in   phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 2 & survey_language == 3 & official_language == 3
}

foreach x in   phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf  phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr{
	replace `x' = . if B4 == 2 & survey_language == 4 & official_language == 4
}

foreach x in  phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 3 & survey_language == 1
}

//////////////////////////////////////////////////

******OTHER ASSESSMENT SECTIONS TO BE SORTED.
//////////////////////////////////////////////////

*Query 5
*fr
egen corr_lett_fr = rowtotal(letter_knowledge_fr_1 - letter_knowledge_fr_20)

replace letter_knowledge_frnumber_of_ite = corr_lett_fr
drop corr_lett_fr

*wf
egen corr_lett_wf = rowtotal(letter_knowledge_wf_1 - letter_knowledge_wf_20)

replace letter_knowledge_wfnumber_of_ite = corr_lett_wf

drop corr_lett_wf

*sr
egen corr_lett_sr = rowtotal(letter_knowledge_sr_1 - letter_knowledge_sr_20)

replace letter_knowledge_srnumber_of_ite = corr_lett_sr

drop corr_lett_sr

*pr
egen corr_lett_pr = rowtotal(letter_knowledge_pr_1 - letter_knowledge_pr_20)

replace letter_knowledge_prnumber_of_ite = corr_lett_pr

drop corr_lett_pr

///////////////////////////////////////////////
*Do for other assessment sections too.
///////////////////////////////////////////////

*Query 6/7.
//
// drop if inlist(interview_ID, "f481619c-ce36-4071-9723-cdef053c2a1b","47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5","3dba3444-f931-4192-a026-0592fed5c4db","9ae1afd4-343c-4676-aaa1-794fcf1401f0","ce096236-6d51-45ee-9bf3-c71e9644f103","d9c218e5-e0e6-493c-a1d1-0fabfbfc039b","5c2a2905-8d24-420d-8a50-8031ecf83e0e","f925fc1d-0d39-41ac-95d4-93679ff6d84c","cf6b59a7-6ed5-4f0a-83e1-3b6554e76190","5e1ab6e9-06c6-439c-b861-8fc5bef186e1","e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4","7e41401a-2629-47d3-989b-331096ec30d2","5f727244-96b2-401e-8b19-5a3b5bb464ce","ae1ce825-0716-42b8-8df0-f4c03de0b574","05cc7dad-1032-4141-b32f-b29e2b442c53","b508dc8b-253b-42b1-b88f-435fdbe52869","fd078077-4f3f-4e65-82ce-7f10b8982c97")

*GPS issue
drop if inlist(interview_ID, "2c2d763c-77a2-46a8-8bcd-a46e75709bca", "00aa1fe9-0240-4be0-b851-223e592e7bf5","5dd52609-089b-4200-9ce6-ec1b0e3100bb")

*Corrections on school grade data
*Student-CE1
replace Ecole = 60 if inlist(interview_ID,"34240a67-95fe-48e6-9dc3-481a5eb995f8")
drop if inlist(interview_ID,"db5e40e9-5901-4841-bb67-5ae1a3c6a7eb","f155b559-9343-422f-b48a-534e15410db8")

*CP
drop if inlist(interview_ID,"50ea1893-d501-4ac3-9caf-39c180bc5790","ec024bd8-7641-4d5f-b311-045fc7b45c4c")

replace Ecole = 60 if inlist(interview_ID,"6f2c99cb-779a-47ef-ba75-450073085f94","d0273b2f-d376-49d6-b1dc-82fc45816d0d","4aad058f-af72-471c-95cb-20e762b2f6d8","fc083b06-21a2-4665-8228-d741d3d22d15","18e148e8-0d56-481d-addc-401cd8a79600","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

*CE1
replace Ecole = 17 if inlist(interview_ID,"f6d5a07d-0d19-4411-a497-155614f3e724")
replace Ecole = 60 if inlist(interview_ID,"cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","323e8c24-dd56-4749-a507-d0699efc9619","687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","64f00d50-e875-4e77-92c1-f4d53ba1a922","2eeabd68-3ed4-49f5-a54d-375966e9f7e8","38bdc126-72b7-4df0-8444-c471ca2a87e4")

*semantic 6-12 corr
replace semantic_language_timer1time_rem = 0 if inlist(interview_ID,"c661d318-bc92-4a49-bdaa-82467b79d913","1e0571ed-db76-4822-8c23-8af79ce41085")

replace semantic_language_timer2time_rem = 0 if interview_ID == "47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5"

*09-12 Corrections
egen corr_red_fr = rowtotal(read_familiar_words_wf_1 - read_familiar_words_wf_20)

replace read_familiar_words_wfnumber_of_ = corr_red_fr

drop corr_red_fr

*Dropping incomplete interviews.
drop if inlist(interview_ID,"eb556751-a143-44ca-a4fa-bc9a93833f69","9e4ed0cc-3d30-4f77-814d-a4c56e292587","3dba3444-f931-4192-a026-0592fed5c4db","bbdfb929-3c53-480a-a728-4633f329f833","d9c218e5-e0e6-493c-a1d1-0fabfbfc039b","47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5","ce096236-6d51-45ee-9bf3-c71e9644f103","5f855822-db47-4379-8082-f4b892591670")

drop if inlist(interview_ID,"de3c2ea7-219c-420e-922b-c6c8d9cc6aa0","fd078077-4f3f-4e65-82ce-7f10b8982c97","05cc7dad-1032-4141-b32f-b29e2b442c53")

drop if inlist(interview_ID,"7869334c-cd3d-4388-8419-a216dd14caef","f2a4e283-d553-4d14-ad0e-a58a1bcb8424","8ff22001-8c87-4dd9-98d4-eeaa9a822b54","9ed45e5b-3930-43cb-b03c-b810974c8c56","43ac1534-7f8e-425d-88f8-cc93e82f173b","78ba35a8-bcb9-405a-9f4e-266a98275e54","419c2b74-de5a-4aad-a54b-280d098d1ce5","840ba10d-cf58-4833-b331-89cd74cc9772")

drop if inlist(interview_ID,"2d9cb548-7200-48a5-9566-e17039a1bff8","06c17ef7-1608-458f-8473-2f736870f4b5","86cd1e56-aa42-499b-b877-74f71485d830","c95c2b98-bd5b-4dcf-9238-210b23130ed2","38e8446d-f142-427a-b3cf-027bb64cd917","f07daf03-9221-4709-9d1c-e99ebe5119bd","cef32e30-7229-4564-8eb9-541425055a67","22495d80-cb3c-435f-b21f-d801f89a6629")

drop if inlist(interview_ID,"840ef329-dacb-462e-9009-f55d1296f1b4","126795ed-3114-45b3-8d85-d753a0d7108f","827947db-1c1a-4ad7-9979-6ae5296b56d9","7dc317cb-d5b9-46bd-b8e2-7195df5fbb6d","8ba63e44-856f-4478-8d36-c8ae3d911b19","d3816a4b-33c6-4b32-80d2-d89b53157feb","9dcd5ddd-7c4f-49c4-a82e-49cdc3a63daa","b55c5039-e885-42f7-b59c-3352d7a7ba4a")

drop if inlist(interview_ID,"46d53249-ec7e-4b7a-87d5-ed5f0f5c8ca9","6beb9aa4-212a-4448-833c-0ae62c737a71","a732939c-eee6-45d4-bfa5-a226f9ff321c","349f62ac-f24d-47ae-92c8-3b893d44d528","19641916-5d8a-44dc-84f7-14687a0f1dc5","5d84205a-b25f-4b07-ba84-ad4967439d32","7416e101-ba15-4426-b0ce-f749708f7653","d0df4be5-d867-4bf2-8354-3273d271108b")

drop if inlist(interview_ID,"2353cf8a-8572-440f-bf88-7fe4b897108b","0ac45d66-8ac1-43e3-892d-526c644742fa")

drop if inlist(interview_ID,"159f4fce-be16-48c4-9bfb-23d143ee91db")

drop if inlist(interview_ID,"a7ff331e-4908-4621-8ef0-88a94e169773","f5df61f6-7e29-4a91-af8f-cfe4d479a6a5","40d3557b-f93e-497f-b805-dea78f5f3e59")



*saving data
cd "${gsdData}\Raw"
save "Main\Student\MOHEBS Student Baseline Processed Dataset 19-12 v01.dta",replace

// Semantic - No auto stop
// Phonological - Auto stop after first 5 wrongs
// Oral vocabulary - No auto stop
// Letter knowledge - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Decoding Familiar - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Decoding Invented - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Oral reading fluency - Auto stop after first 8
// Reading comprehension - No auto stop
// Reading comprehension picture matching - First 5 wrongs * (This was not applied to the script)

// MATHS SECTION
// Identifying shapes - If a student identifies correctly at least one triangle in grid 1 or grid 2, they will see grid 3; other wise they will not see grid 3
// Distance/ position tracking - No skip
// Identifying numbers
//
// If the student gives fewer than 4 correct answers between lines 1 and 2, move on to the next activity. If the student moves to lines 3 and 4 but gives fewer than 4 correct answers between those lines, move on to the next activity.
// Counting - No skip
// Digital discrimination
//
// If the student gives fewer than 2 correct answers between lines 1 and 2, move on to the next activity.
//
// If the student moves to lines 3 and 4, but gives less than 2 correct points between these lines, move on to the next activity.
// Missing number
//
// If child gives fewer than 2 correct responses between Rows 1 and 2, assign a 0 and move to the next activity. 
//
// If the child progresses to Rows 3 and 4, but gives fewer than 2 correct between those rows, assign a 1 and move to the next activity
// Decimal system
//
// If the student gives fewer than 2 correct answers between lines 1 and 2, move on to the next activity.
//
// If the student moves to lines 3 and 4, but gives less than 2 correct points between these lines, move on to the next activity.
// Addition and subtraction
//
// If the student cannot solve any of the first two problems, move on to the next activity.
//
// If the student answers at least one correctly, continue with the rest of the examples.
// Addition and subtraction word problem
//
// If the student fails to solve either of the first two problems, move on to the next activity.
//
// If the student answers at least one of the first two correctly, continue with the remaining problems.
// 
********************************QC checks-Flaggings
***************************************************************************************
* QC files
cd "${gsdQChecks}"

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
global var_kept "interview_ID INT_DATE INT_STARTTIME INT_ENDTIME survey_language ENUM_NAME assessment_type interviewer_type IA IEF Arrondissement Commune Echantillon Ecole Groupe Language official_language teaching_language Student_Name B2 B3 B4"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(Duration_mins,45,90)
cap export excel $var_kept Duration_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (INT_STARTTIME): gen gap_mins = (INT_STARTTIME - INT_ENDTIME[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept INT_STARTTIME INT_ENDTIME gap_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**GPS Accuracy
preserve
replace issue_comment ="The GPS Accuracy captured is low"
keep if GPSaccuracy> 20
cap export excel $var_kept GPS* issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(GPSaccuracy_issues,replace)firstrow(variables)
restore

**Duplicates GPS
duplicates tag GPSlatitude GPSlongitude, gen (gps_dup)

preserve
replace issue_comment ="The GPS captured are duplicated, kindly clarify"
keep if gps_dup> 0
cap export excel $var_kept GPS* issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(gps_duplicates_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag Ecole Student_Name B2 B3 B4,gen(int_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if int_dup>0
cap export excel $var_kept int_dup issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Interv_dupl_main_issues,replace)firstrow(variables)
restore

////////

*Official language against Survey_language
*Grade 1 C1.
preserve
replace issue_comment ="The survey language is different from the official language yet it is grade 1 student, Kindly clarify"
keep if survey_language == 1 & B4 == 1
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Language_mismatch_gr1,replace)firstrow(variables)
restore 

*Grade 1 C3.
preserve
replace issue_comment ="The survey language is not French yet the student is grade 3, Kindly clarify"
keep if survey_language != 1 & B4 == 3
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Language_mismatch_gr3,replace)firstrow(variables)
restore 

*Teaching language against school.
bysort Ecole teaching_language: gen tag = _n == 1
bysort Ecole: egen teaching_language_uniq = total(tag)

sort Ecole teaching_language

preserve
replace issue_comment ="The school teaching language seems inconsitent, kindly clarify"
keep if teaching_language_uniq > 1
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Teach_School,replace)firstrow(variables)
restore 

/////////

*Semantic section
*Semantic 1
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 1 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer1time_rem != 0 & word_count_language_1 <= 10 & semantic_language_timer1gridAuto == 0)| (semantic_language_timer1time_rem != 0 & semantic_language_timer1gridAuto == 1 & word_count_language_1 <= 10)
cap export excel $var_kept semantic_language_timer1duration	semantic_language_timer1time_rem semantic_language_timer1gridAuto word_count_language_1	interviewer_semantic_1 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_1,replace)firstrow(variables)
restore 

*Semantic 2
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 2 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer2time_rem != 0 & word_count_language_2 <= 10 & semantic_language_timer2gridAuto == 0)| (semantic_language_timer2time_rem != 0 & semantic_language_timer2gridAuto == 1 & word_count_language_2 <= 10)
cap export excel $var_kept semantic_language_timer2duration	semantic_language_timer2time_rem semantic_language_timer2gridAuto word_count_language_2	interviewer_semantic_2 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_2,replace)firstrow(variables)
restore 

*Semantic 3
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 3 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer3time_rem != 0 & word_count_language_3 <= 10 & semantic_language_timer3gridAuto == 0)| (semantic_language_timer3time_rem != 0 & semantic_language_timer3gridAuto == 1 & word_count_language_3 <= 10)
cap export excel $var_kept semantic_language_timer3duration	semantic_language_timer3time_rem semantic_language_timer3gridAuto word_count_language_3	interviewer_semantic_3 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_3,replace)firstrow(variables)
restore 

*Letter_knowledge 
*listen to recordings
*fr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_frduration - letter_knowledge_frtime_remainin < 60 & letter_knowledge_frgridAutoStopp == 0) | letter_knowledge_frgridAutoStopp == 1 | letter_knowledge_frnum_att < 8
cap export excel $var_kept letter_knowledge_recording_fr -  letter_knowledge_reason_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_wfduration - letter_knowledge_wftime_remainin < 60 & letter_knowledge_wfgridAutoStopp == 0) | letter_knowledge_wfgridAutoStopp == 1 | letter_knowledge_wfnum_att < 8
cap export excel $var_kept letter_knowledge_recording_wf -  letter_knowledge_reason_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_srduration - letter_knowledge_srtime_remainin  < 60 & letter_knowledge_srgridAutoStopp == 0)| letter_knowledge_srgridAutoStopp == 1 | letter_knowledge_srnum_att < 8
cap export excel $var_kept letter_knowledge_recording_sr -  letter_knowledge_reason_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_prduration - letter_knowledge_prtime_remainin  < 60 & letter_knowledge_prgridAutoStopp == 0)| letter_knowledge_prgridAutoStopp == 1 | letter_knowledge_prnum_att < 8
cap export excel $var_kept letter_knowledge_recording_pr -  letter_knowledge_reason_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_fr != letter_knowledge_frgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_fr -  letter_knowledge_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_wf != letter_knowledge_wfgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_wf -  letter_knowledge_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_wf_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_sr != letter_knowledge_srgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_sr -  letter_knowledge_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_sr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_pr != letter_knowledge_prgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_pr -  letter_knowledge_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_pr_stop,replace)firstrow(variables)
restore

*letter part B
*fr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_fr_Bduration - letter_knowledge_fr_Btime_remain < 60 & letter_knowledge_fr_BgridAutoSto == 0)| letter_knowledge_fr_BgridAutoSto == 1 | letter_knowledge_fr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_fr_B_1 -  letter_knowledge_fr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_wf_Bduration - letter_knowledge_wf_Btime_remain < 60 & letter_knowledge_wf_BgridAutoSto == 0) | letter_knowledge_wf_BgridAutoSto == 1 | letter_knowledge_wf_Bnum_att < 8
cap export excel $var_kept letter_knowledge_wf_B_1 -  letter_knowledge_wf_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_sr_Bduration - letter_knowledge_sr_Btime_remain < 60 & letter_knowledge_sr_BgridAutoSto == 0)| letter_knowledge_sr_BgridAutoSto == 1 | letter_knowledge_sr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_sr_B_1 -  letter_knowledge_sr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_pr_Bduration - letter_knowledge_pr_Btime_remain < 60 & letter_knowledge_pr_BgridAutoSto == 0)| letter_knowledge_pr_BgridAutoSto == 1 | letter_knowledge_pr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_pr_B_1 -  letter_knowledge_pr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_pr_time,replace)firstrow(variables)
restore

* reading familiar 
*Listen to the recordings
*fr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_frduration - read_familiar_words_frtime_remai < 60 & read_familiar_words_frgridAutoSt == 0) | read_familiar_words_frgridAutoSt == 1 | reading_familiar_words_frnum_att < 8
cap export excel $var_kept read_familiar_words_fr_1 - read_familiar_words_fritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_wfduration - read_familiar_words_wftime_remai < 60 & read_familiar_words_wfgridAutoSt == 0) | read_familiar_words_wfgridAutoSt == 1 | reading_familiar_words_wfnum_att < 8
cap export excel $var_kept read_familiar_words_wf_1 - read_familiar_words_wfitems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_srduration - read_familiar_words_srtime_remai < 60 & read_familiar_words_srgridAutoSt == 0)| read_familiar_words_srgridAutoSt == 1 | reading_familiar_words_srnum_att < 8
cap export excel $var_kept read_familiar_words_sr_1 - read_familiar_words_sritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_prduration - read_familiar_words_prtime_remai < 60 & read_familiar_words_prgridAutoSt == 0)| read_familiar_words_prgridAutoSt == 1 | reading_familiar_words_prnum_att < 8
cap export excel $var_kept read_familiar_words_pr_1 - read_familiar_words_pritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_fr != read_familiar_words_frgridAutoSt)
cap export excel $var_kept read_familiar_words_fr_1 - read_familiar_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_wf != read_familiar_words_wfgridAutoSt)
cap export excel $var_kept read_familiar_words_wf_1 - read_familiar_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_sr != read_familiar_words_srgridAutoSt)
cap export excel $var_kept read_familiar_words_sr_1 - read_familiar_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_pr != read_familiar_words_prgridAutoSt)
cap export excel $var_kept read_familiar_words_pr_1 - read_familiar_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*Familiar part B
*fr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_fr_Bduration - read_familiar_words_fr_Btime_rem < 60 & read_familiar_words_fr_BgridAuto == 0)| read_familiar_words_fr_BgridAuto == 1 | reading_famila_word_fr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_fr_B_1 - read_familiar_words_fr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_wf_Bduration - read_familiar_words_wf_Btime_rem < 60 & read_familiar_words_wf_BgridAuto == 0) | read_familiar_words_fr_BgridAuto == 1 | reading_famila_word_fr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_wf_B_1 - read_familiar_words_wf_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_sr_Bduration - read_familiar_words_sr_Btime_rem < 60 & read_familiar_words_sr_BgridAuto == 0) | read_familiar_words_sr_BgridAuto == 1 | reading_famila_word_sr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_sr_B_1 - read_familiar_words_sr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_pr_Bduration - read_familiar_words_pr_Btime_rem < 60 & read_familiar_words_pr_Btime_rem == 0)| read_familiar_words_pr_BgridAuto == 1 | reading_famila_word_pr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_pr_B_1 - read_familiar_words_pr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_pr_time,replace)firstrow(variables)
restore

* reading Invented
*Listen to recordings 
*fr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_frduration - read_invented_words_frtime_remai < 60 & read_invented_words_frgridAutoSt == 0)| read_invented_words_frgridAutoSt == 1 | read_invented_words_frnum_att < 8
cap export excel $var_kept read_invented_words_fr_1 - read_invented_words_fritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_wfduration - read_invented_words_wftime_remai < 60 & read_invented_words_wfgridAutoSt == 0) | read_invented_words_wfgridAutoSt == 1 | read_invented_words_wfnum_att < 8
cap export excel $var_kept read_invented_words_wf_1 - read_invented_words_wfitems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_srduration - read_invented_words_srtime_remai < 60 & read_invented_words_srgridAutoSt == 0)| read_invented_words_srgridAutoSt == 1 | read_invented_words_srnum_att < 8
cap export excel $var_kept read_invented_words_sr_1 - read_invented_words_sritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_prduration - read_invented_words_prtime_remai < 60 & read_invented_words_prgridAutoSt == 0)| read_invented_words_prgridAutoSt == 1 | read_invented_words_prnum_att < 8
cap export excel $var_kept read_invented_words_pr_1 - read_invented_words_pritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_fr != read_invented_words_frgridAutoSt)
cap export excel $var_kept read_invented_words_fr_1 - read_invented_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_wf != read_invented_words_wfgridAutoSt)
cap export excel $var_kept read_invented_words_wf_1 - read_invented_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_wf_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_sr != read_invented_words_srgridAutoSt)
cap export excel $var_kept read_invented_words_sr_1 - read_invented_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_sr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_pr != read_invented_words_prgridAutoSt)
cap export excel $var_kept read_invented_words_pr_1 - read_invented_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_pr_stop,replace)firstrow(variables)
restore

*Invented part B
*fr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_fr_Bduration - read_invented_words_fr_Btime_rem < 60 & read_invented_words_fr_BgridAuto == 0)| read_invented_words_fr_BgridAuto == 1 | read_invented_word_fr_Bnum_att < 8
cap export excel $var_kept read_invented_words_fr_B_1 - read_invented_words_fr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_wf_Bduration - read_invented_words_wf_Btime_rem < 60 & read_invented_words_wf_BgridAuto == 0) | read_invented_words_wf_BgridAuto == 1 | read_invented_word_wf_Bnum_att < 8
cap export excel $var_kept read_invented_words_wf_B_1 - read_invented_words_wf_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_sr_Bduration - read_invented_words_sr_Btime_rem < 60 & read_invented_words_sr_BgridAuto == 0)| read_invented_words_sr_BgridAuto == 1 | read_invented_word_sr_Bnum_att < 8
cap export excel $var_kept read_invented_words_sr_B_1 - read_invented_words_sr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_pr_Bduration - read_invented_words_pr_Btime_rem < 60 & read_invented_words_pr_BgridAuto == 0) | read_invented_words_pr_BgridAuto == 1 | read_invented_word_pr_Bnum_att < 8
cap export excel $var_kept read_invented_words_pr_B_1 - read_invented_words_pr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_pr_time,replace)firstrow(variables)
restore

// * Oral fluency 
*fr
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_frtime_rema >30 & oral_reading_fluency_frnum_att < 20)
cap export excel $var_kept oral_reading_fluency_fr_1 - oral_reading_fluency_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_wftime_rema >30 & oral_reading_fluency_wfnum_att < 20)
cap export excel $var_kept oral_reading_fluency_wf_1 - oral_reading_fluency_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_wf_time,replace)firstrow(variables)
restore

// *sr
// preserve
// replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
// keep if (oral_reading_fluency_srtime_rema >30 & oral_reading_fluency_srnum_att < 20)
// cap export excel $var_kept oral_reading_fluency_sr_1 - oral_reading_fluency_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_sr_time,replace)firstrow(variables)
// restore

*pr
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_prtime_rema >30 & oral_reading_fluency_prnum_att < 20)
cap export excel $var_kept oral_reading_fluency_pr_1 - oral_reading_fluency_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_pr_time,replace)firstrow(variables)
restore


**Languages spoken and used home by kid is different from the interview survey language

****Baseline data Quick descriptive analysis of the scores fareness.
*Letter_knowledge part a
summ letter_knowledge_frnum_att letter_knowledge_frnumber_of_ite letter_knowledge_wfnum_att letter_knowledge_wfnumber_of_ite letter_knowledge_srnum_att letter_knowledge_srnumber_of_ite letter_knowledge_prnum_att letter_knowledge_prnumber_of_ite

*Letter_knowledge part b
summ letter_knowledge_fr_Bnum_att letter_knowledge_fr_Bnumber_of_i letter_knowledge_sr_Bnum_att letter_knowledge_sr_Bnumber_of_i letter_knowledge_pr_Bnum_att letter_knowledge_pr_Bnumber_of_i letter_knowledge_wf_Bnum_att letter_knowledge_wf_Bnumber_of_i

*reading familiar part a
summ reading_familiar_words_frnum_att read_familiar_words_frnumber_of_ reading_familiar_words_srnum_att read_familiar_words_srnumber_of_ reading_familiar_words_prnum_att read_familiar_words_prnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfnumber_of_ 

*reading familiar part b
summ reading_famila_word_fr_Bnum_att read_familiar_words_fr_Bnumber_o reading_famila_word_sr_Bnum_att read_familiar_words_sr_Bnumber_o reading_famila_word_pr_Bnum_att read_familiar_words_pr_Bnumber_o reading_famila_word_wf_Bnum_att read_familiar_words_wf_Bnumber_o

*reading invented part a
summ read_invented_words_frnum_att read_invented_words_frnumber_of_ read_invented_words_srnum_att read_invented_words_srnumber_of_ read_invented_words_prnum_att read_invented_words_prnumber_of_ read_invented_words_wfnum_att read_invented_words_wfnumber_of_

*reading invented part b
summ read_invented_word_fr_Bnum_att read_invented_words_fr_Bnumber_o read_invented_word_sr_Bnum_att read_invented_words_sr_Bnumber_o read_invented_word_pr_Bnum_att read_invented_words_pr_Bnumber_o read_invented_word_wf_Bnum_att read_invented_words_wf_Bnumber_o

*phonological_awareness
*view manually
*compute average scores/descriptive
summ phonological_awareness_prnumber_ phonological_awareness_srnumber_ phonological_awareness_wfnumber_ phonological_awareness_frnumber_

*oral reading
summ oral_reading_fluency_frnum_att oral_reading_fluency_frnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_prnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfnumber_of

****END********************************************************************
bvhgv


***************************************************************************
****TEACHERS Survey
***************************************************************************


**Setting the working directory
cls
clear all
cd "${gsdData}\Raw"

***import dataset
import spss using "Main\Teachers\MOHEBS Teachers' Survey_WIDE.sav"

**Converting date to stata format calender
// *sort time and date
replace INT_DATE = dofc(INT_DATE)
format INT_DATE %td

lab var INT_DATE"Interview Date"

*Time.
gen str8 START_TIME_str = string(START_TIME, "%tcHH:MM:SS")
gen str8 END_TIME_str   = string(END_TIME,   "%tcHH:MM:SS")


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


*Location
cd "${gsdCode}\MOHEBS\cleaning do file"
do "Location_Teachers.do"

*Grade
lab var Grade_1"CI (first grade)"
lab var Grade_2"CP (second grade)"
lab var Grade_3"CE1 (third grade)"
lab var Grade_96"Other, specify"

*correction
replace Policy_2b_4 = 60 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9", "uuid:4a06c160-0357-40e9-bbed-2e9b6386c823","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac","uuid:0f2e41b2-e374-41c7-b1ac-0e8eceb227b0")

replace Policy_2b_4 = 300 if KEY == "uuid:5aabf678-237e-4fb0-8c56-71c2eecbf136"

replace Policy_2b_2 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6", "uuid:1088507b-fb7b-404f-9015-0d717f279931","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_1 = 120 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_1 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")

replace Policy_3b_1 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:af5363f0-58c7-4414-b79c-fc98944a650e")

replace Policy_3b_1 = 120 if KEY == "uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1"

replace Policy_3b_2 = 60 if inlist(KEY,"uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")

replace Policy_3b_2 = 180 if inlist(KEY,"uuid:1088507b-fb7b-404f-9015-0d717f279931")

replace Policy_3b_2 = 240 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_2 = 300 if inlist(KEY,"uuid:3143c533-280b-4b21-9ffc-75f848b08269")

replace Policy_3b_3 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")
replace Policy_3b_4 = 180 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9")

replace Policy_3b_4=Policy_3b_4*60 if inlist(KEY,"uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:0f2e41b2-e374-41c7-b1ac-0e8eceb227b0","uuid:5aabf678-237e-4fb0-8c56-71c2eecbf136","uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac")


//////
replace Policy_4b_1 = Policy_4b_1 * 60 if inlist(KEY,"uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")

replace Policy_4b_1 = Policy_4b_1 * 60 if inlist(KEY,"uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e","uuid:12dcd295-5e99-430e-a7b9-6af729fda951","uuid:a9c4b952-e16f-4509-b0d0-bc3c5eee44fe","uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2")

replace Policy_4b_2 = Policy_4b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:0d35b9d9-f50f-4a27-b640-784fb9f87360")

replace Policy_4b_3 = Policy_4b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")

replace Policy_5b_1 = Policy_5b_1*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e")

replace Policy_5b_2 = Policy_5b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b")


replace Policy_5b_3 = Policy_5b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")


replace Policy_5b_4 = Policy_5b_4*60 if inlist(KEY, "uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:12dcd295-5e99-430e-a7b9-6af729fda951","uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e")


order KEY

lab var Firstname"What is your first name"
lab var Lastname"What is your last name"
lab var  female"female. Is the respondent a man or a woman?"
lab var  RH_past_a"RH_past_a. Did you practice Remédiation Harmonisée during the 2024 – 2025 school year?"
lab var  RH_past_b"RH_past_b. Which grade did you practice Remédiation Harmonisée during the 2024 – 2025 school year"
lab var  Age"Age. How old are you?"
lab var  Edu"Edu. What is your highest educational qualification?"
lab var  Grade"Grade. What grade do you currently teach in the 2025 – 2026 school year?"
lab var  Grade_S"Grade. Please specify other"
lab var  RH_hoursa"RH_hoursa. How many hours per week do you teach math in Remédiation Harmonisée to CI students in your classroom?"
lab var  RH_hoursb"RH_hoursb. How many hours per week do you teach reading in Remédiation Harmonisée to CI students in your classroom?"
lab var  RH_hoursc"RH_hoursc. How many hours per week do you teach math in Remédiation Harmonisée to CP students in your classroom?"
lab var  RH_hoursd"RH_hoursd. How many hours per week do you teach reading in Remédiation Harmonisée to CP students in your classroom?"
lab var  MM_hoursa"MM_hoursa. How many hours per week do you teach MOHEBS math/math in national languages to CI students in your classroom?"
lab var  Lang_1a"Lang_1a. What languages do the CP students in this classroom speak as their national language?"
lab var  Lang_1a_1"Wolof"
lab var  Lang_1a_2"Pulaar"
lab var  Lang_1a_3"Serer"
lab var  Lang_1a_96"Other, specify"
lab var  Lang_1a_S"Lang_1a_S. Please specify Other specify?"
lab var  Lang_1b"Lang_1b. What languages do the CI students in this classroom speak as their  national language?"
lab var  Lang_1b_1"French"
lab var  Lang_1b_2"Wolof"
lab var  Lang_1b_3"Pulaar"
lab var  Lang_1b_4"Serer"
lab var  Lang_1b_96"Other, specify"
lab var  Lang_1b_S"Lang_1b_S. Please specify Other specify?"

lab var  Lang_2"Lang_2. What is your own mother tongue? "
lab var  Lang_2_S"Lang_2_S. What is your own mother tongue? Other specify?"
lab var  Lang_3"Lang_3. How comfortable are you speaking the students' national language?"
lab var  Lang_4"Lang_4. How comfortable are you reading in the students' national language?"
lab var  Lang_5"Lang_5. How comfortable are you speaking French?"
lab var  Lang_6"Lang_6. How comfortable are you reading in French?"
lab var  Policy_2a"Policy_2a. In the CI classroom you teach, which language(s) do you use to teach math in class?"
lab var  Policy_2a_1"French"
lab var  Policy_2a_2"Wolof"
lab var  Policy_2a_3"Pulaar"
lab var  Policy_2a_4"Serer"
gen Policy_2b = .
order Policy_2b,before(Policy_2b_1)
lab var  Policy_2b"Policy_2b. In the CI classroom you teach, how much time do you spend teaching math in each language on a daily basis?"
lab var  Policy_2b_1"Policy_2b_1. French"

lab var  Policy_2b_2"Policy_2b_2. Wolof"

lab var  Policy_2b_3"Policy_2b_3. Pulaar"

lab var  Policy_2b_4"Policy_2b_4. Serer"

lab var  Policy_2c"Policy_2c. While teaching math in the CI classroom, at what point do you switch languages?"
lab var  Policy_2c_0"I do not switch languages"
lab var  Policy_2c_1"When a student asks a question in a different language"
lab var  Policy_2c_2"When students appear confused or disengaged "
lab var  Policy_2c_3"When introducing a new concept"
lab var  Policy_2c_4"When giving instructions for activities"
lab var  Policy_2c_5"When addressing individuals during one-on-one support"
lab var  Policy_2c_6"When translating key vocabulary terms"
lab var  Policy_2c_7"I alternate languages with every instruction"
lab var  Policy_2c_8"I spend half of the class speaking one language and then switch to the other"
lab var  Policy_3a"Policy_3a. In the CI classroom you teach, which language(s) do you use to teach reading in class?"
lab var  Policy_3a_1"French"
lab var  Policy_3a_2"Wolof"
lab var  Policy_3a_3"Pulaar"
lab var  Policy_3a_4"Serer"

gen Policy_3b = .
order Policy_3b,before(Policy_3b_1)
lab var  Policy_3b"Policy_3b. In the CI classroom you teach, how much time do you spend teaching reading in each language, on a daily basis?"
lab var  Policy_3b_1"French"
lab var  Policy_3b_2"Wolof"
lab var  Policy_3b_3"Pulaar"
lab var  Policy_3b_4"Serer"

lab var  Policy_3c"Policy_3c. While teaching reading in the CI classroom, at what point do you switch languages?"

lab var  Policy_3c_0"I do not switch languages"
lab var  Policy_3c_1"When a student asks a question in a different language"
lab var  Policy_3c_2"When students appear confused or disengaged "
lab var  Policy_3c_3"When introducing a new concept"
lab var  Policy_3c_4"When giving instructions for activities"
lab var  Policy_3c_5"When addressing individuals during one-on-one support"
lab var  Policy_3c_6"When translating key vocabulary terms"
lab var  Policy_3c_7"I alternate languages with every instruction"
lab var  Policy_3c_8"I spend half of the class speaking one language and then switch to the other"
lab var  Policy_4a"Policy_4a. In the CP classroom you teach, which language(s) do you use to teach math in class?"
lab var  Policy_4a_1"French"
lab var  Policy_4a_2"Wolof"
lab var  Policy_4a_3"Pulaar"
lab var  Policy_4a_4"Serer"

gen Policy_4b = .
order Policy_4b,before(Policy_4b_1)
lab var  Policy_4b"Policy_4b. In the CP classroom you teach, how much time do you spend teaching math in each language, on a daily basis?"

lab var  Policy_4b_1"French"
lab var  Policy_4b_2"Wolof"
lab var  Policy_4b_3"Pulaar"
lab var  Policy_4b_4"Serer"

lab var  Policy_4c"Policy_4c. While teaching math in the CP classroom, at what point do you switch languages?"
lab var  Policy_4c_0"I do not switch languages"
lab var  Policy_4c_1"When a student asks a question in a different language"
lab var  Policy_4c_2"When students appear confused or disengaged "
lab var  Policy_4c_3"When introducing a new concept"
lab var  Policy_4c_4"When giving instructions for activities"
lab var  Policy_4c_5"When addressing individuals during one-on-one support"
lab var  Policy_4c_6"When translating key vocabulary terms"
lab var  Policy_4c_7"I alternate languages with every instruction"
lab var  Policy_4c_8"I spend half of the class speaking one language and then switch to the other"

lab var  Policy_5a"Policy_5a. In the CP classroom you teach, which language(s) do you use to teach reading in class?"
lab var  Policy_5a_1"French"
lab var  Policy_5a_2"Wolof"
lab var  Policy_5a_3"Pulaar"
lab var  Policy_5a_4"Serer"
gen Policy_5b = .
order Policy_5b,before(Policy_5b_1)
lab var  Policy_5b"Policy_5b. In the CP classroom you teach, how much time do you spend teaching reading in each language,on a daily basis?"
lab var  Policy_5b_1"French"
lab var  Policy_5b_2"Wolof"
lab var  Policy_5b_3"Pulaar"
lab var  Policy_5b_4"Serer"

lab var  Policy_5c"Policy_5c. While teaching reading in the CP classroom, at what point do you switch languages?"

lab var  Policy_5c_0"I do not switch languages"
lab var  Policy_5c_1"When a student asks a question in a different language"
lab var  Policy_5c_2"When students appear confused or disengaged "
lab var  Policy_5c_3"When introducing a new concept"
lab var  Policy_5c_4"When giving instructions for activities"
lab var  Policy_5c_5"When addressing individuals during one-on-one support"
lab var  Policy_5c_6"When translating key vocabulary terms"
lab var  Policy_5c_7"I alternate languages with every instruction"
lab var  Policy_5c_8"I spend half of the class speaking one language and then switch to the other"

lab var  Lang_7"Lang_7. Do any of your CI students NOT speak the school language of instruction in this classroom? "
lab var  Lang_7a"Lang_7a. How many students is that?"
lab var  Lang_7b"Lang_7b. Out of how many students in the CI class? "
lab var  Lang_8"Lang_8. Do any of your CP students NOT speak ${Policy_calc} in this classroom? "
lab var  Lang_8a"Lang_8a. How many students is that for ${Policy_calc} ? "
lab var  Lang_8b"Lang_8b. Out of how many students in the CP class?  ${Policy_calc}"
lab var  Lang_9"Lang_9. How do you manage teaching in a multilingual classroom?"
lab var  nl_1a"nl_1a. Did you participate in the CI MOHEBS math training (formation de base) at the start of the school year?"
lab var  nl_1b"nl_1b. Was this training sufficient? "
lab var  nl_1c"nl_1c. How many days did you attend in total?"
lab var  nl_2a"nl_2a. Did you participate in the Remédiation Harmonisée training at the start of the school year?"
lab var  nl_2b"nl_2b. Was this training sufficient? "
lab var  nl_2c"nl_2c. How many days did you attend in total?"
lab var  nl_3a"nl_3a. Did you participate in the training related to teaching reading in the national languages at the start of the school year?"
lab var  nl_3b"nl_3b. Was this training sufficient? "
lab var  nl_3c"nl_3c. How many days did you attend in total?"
lab var  exp_1"exp_1. How many service years do you have as a teacher?"

lab var  Mat_1"Mat_1. Do you have the student math textbooks in national language for the CI classroom you teach?"
lab var  Mat_2"Mat_2. Do you have the teacher's math guide in national language for the CI classroom you teach?"
lab var  Mat_3"Mat_3. Do students in your classroom have their own national language math textbooks?"
lab var  Mat_4"Mat_4. What is the math textbook/student ratio in your CI classroom?"
lab var  Mat_5"Mat_5. Are there national language supplementary math materials available for you to support your lesson in this classroom?"
lab var  Mat_6"Mat_6. Are these national language supplementary math materials accessible to the students you teach?"
lab var  Mat_7"Mat_7. Does the school provide you with the necessary support in your effort to teach students how to do math in their national language?"
lab var  Mat_8"Mat_8. Do you have the student math textbooks in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_9"Mat_9. Do you have the teacher's math guide in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_10"Mat_10. Do students in your Remédiation Harmonisée classroom have their own national language math textbooks?"
lab var  Mat_11"Mat_11. What is the math textbook/student ratio in your Remédiation Harmonisée classroom? "
lab var  Mat_12"Mat_12. Are there national language supplementary math materials available for you to support your lesson in this Remédiation Harmonisée classroom?"
lab var  Mat_13"Mat_13. Are these national language supplementary math materials accessible to the students you teach in this Remédiation Harmonisée classroom?"
lab var  Mat_14"Mat_14. Do you have  student reading textbooks in the national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_15"Mat_15. Do you have the teacher's reading guide in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_16"Mat_16. Do students in your Remédiation Harmonisée classroom have their own national language reading textbooks?"
lab var  Mat_17"Mat_17. What is the reading textbook/student ratio in your Remédiation Harmonisée classroom? "
lab var  Mat_18"Mat_18. Are there national language supplementary reading materials available for you to support your lesson in this Remédiation Harmonisée classroom?"
lab var  Mat_19"Mat_19. Are these national language supplementary reading materials accessible to the students you teach in this Remédiation Harmonisée classroom?"
lab var  E1"Enumerator Question: How confident are you that the teacher understood all your questions in the ${lang_calc1}?"
lab var  Lang_9_1"I only teach in one language"
lab var  Lang_9_2"I repeat every instruction and lecture line-by-line in each language"
lab var  Lang_9_3"I teach in the majority language first and then repeat in the second language"
lab var  Lang_9_4"I lecture in the majority language and give instructions in all languages"

*correction
drop if KEY == "uuid:1c4905eb-47ba-4a42-b1be-3025b87a791d"

*correction school
replace School = 21 if KEY == "uuid:b2fb7271-d881-4991-b183-34112d05e4f5"
replace School = 35 if inlist(KEY,"uuid:4cb3de4f-a249-40a4-9328-4ef0599449e5","uuid:232da800-f169-45ac-9abf-a05c1cd4e259")

*6-12
replace Policy_2c_7 = 0 if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")
replace Policy_2c = "0" if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")

replace Policy_2c_2 = 0 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_2c = "0" if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")

replace Policy_2c_3 = 0 if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")
replace Policy_2c = "0" if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")

replace Policy_4c_2 = 0 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_4c_0 = 1 if inlist(KEY,"uuid:4e5c8c66-8fef-4357-b7ed-c05c0283e5f1","uuid:c127f20c-c009-4c82-8e38-df6a8318b1e7","uuid:0643e63e-745d-4163-8d74-2811197ae644")
replace Policy_4c = "0" if inlist(KEY,"uuid:4e5c8c66-8fef-4357-b7ed-c05c0283e5f1","uuid:c127f20c-c009-4c82-8e38-df6a8318b1e7","uuid:0643e63e-745d-4163-8d74-2811197ae644")

*9-12
replace Policy_4b_1 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_4b_4 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_5b_1 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"
replace Policy_5b_2 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_4c_2 = 0 if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")
replace Policy_4c_0 = 1 if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")
replace Policy_4c = "0" if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")

replace Policy_4c_7 = 0 if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"
replace Policy_4c_0 = 1 if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"
replace Policy_4c = "0" if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"

replace Policy_2c_7 = 0 if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"
replace Policy_2c_0 = 1 if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"
replace Policy_2c = "0" if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"

*10-12
replace Policy_2c_7 = 0 if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"
replace Policy_2c_0 = 1 if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"
replace Policy_2c = "0" if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"

replace Policy_4c_2 = 0 if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"
replace Policy_4c_0 = 1 if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"
replace Policy_4c = "0" if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"

*11-12
replace Policy_3b_4 = 240 if KEY == "uuid:1d248b04-b7b5-44e1-b1eb-cbb985a2602c"

*12-12
replace Policy_4b_1 = 60 if KEY == "uuid:e6415062-657e-47f4-98cc-b67fd5c15ba1"
replace Policy_3b_2 = 120 if KEY == "uuid:868ebc27-e83b-4c04-beee-df1ff11885ce"
replace Policy_2b_2 = 60 if KEY == "uuid:868ebc27-e83b-4c04-beee-df1ff11885ce"

*13-12
replace Policy_4c_3 = 0 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c_0 = 1 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c = "0" if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"

*15-12
replace Policy_2c_5 = 0 if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"
replace Policy_2c_0 = 1 if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"
replace Policy_2c = "0" if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"

replace Policy_4b_1 = 60 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"


replace Policy_4c_3 = 0 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c_0 = 1 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c = "0" if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"

replace Policy_4c_1 = 0 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"
replace Policy_4c_0 = 1 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"
replace Policy_4c = "0" if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"

replace Policy_4c_2 = 0 if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"
replace Policy_4c_0 = 1 if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"
replace Policy_4c = "0" if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"


// drop START_TIME_str END_TIME_str grppp1 lan1 Calc1 Calc2 Calc3 Calc4 Calc5 Calc6 Calc7 Calc8 Calc9 Calc10 Calc11 Calc12 lang_calc1 Policy_calc Firstname	Lastname	RES_NAME


*save dataset
cd "${gsdData}\Raw"
save "Main\Teachers\MOHEBS Teachers Baseline Processed Dataset 19-12 v01.dta",replace

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
gen Duration_mins = round((END_TIME - START_TIME)/(1000*60))

preserve
drop END_TIME START_TIME
ren (START_TIME_str END_TIME_str) (START_TIME END_TIME)

replace issue_comment ="interview duration is *Longer* or *Shorter*, kindly clarify"
keep if !inrange(Duration_mins,25,45)
cap export excel $var_kept Duration_mins issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
drop END_TIME START_TIME
ren (START_TIME_str END_TIME_str) (START_TIME END_TIME)
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept gap_mins issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

*GPS Accuracy
preserve
replace issue_comment = "The GPS Accuracy is way low, kindly clarify"
keep if GPS_Accuracy > 20
cap export excel $var_kept GPS_Accuracy issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(GPS_issues,replace)firstrow(variables)
restore

*Duplicate GPS
duplicates tag GPS_Latitude GPS_Longitude GPS_Altitude,gen(dup1)

preserve
replace issue_comment = "The interview is done on the same point of location, kindly clarify"
keep if dup1 > 0
cap export excel $var_kept GPS_Latitude GPS_Longitude GPS_Altitude issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(GPS_Dups_issues,replace)firstrow(variables)
restore

**Respondent Name
preserve
replace issue_comment = "The Respondent name seems invalid, kindly clarify"
keep if strlen(RES_NAME)<2
cap export excel $var_kept RES_NAME issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(RES_NAME_issues,replace)firstrow(variables)
restore

**Duplicate interviews Respondent Name
duplicates tag Region School,gen (dup)

preserve
replace issue_comment = "The interviews are a duplicates, kindly clarify"
keep if dup > 0
cap export excel $var_kept Region School RES_NAME dup issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Interview_dup_issues,replace)firstrow(variables)
restore

*Age
preserve
replace issue_comment ="Age provided is way high or low, kindly clarify"
keep if !inrange(Age,18,45)
cap export excel $var_kept Age issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Age_issues,replace)firstrow(variables)
restore

*Minutes
*RH_hoursa
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursa,1,40)
cap export excel $var_kept RH_hoursa issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursa_issues,replace)firstrow(variables)
restore

*RH_hoursb
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursb,1,40)
cap export excel $var_kept RH_hoursb issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursb_issues,replace)firstrow(variables)
restore

*RH_hoursc
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursc,1,40)
cap export excel $var_kept RH_hoursc issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursc_issues,replace)firstrow(variables)
restore

*RH_hoursd
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursd,1,40)
cap export excel $var_kept RH_hoursd issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursd_issues,replace)firstrow(variables)
restore

*MM_hoursa
preserve
replace issue_comment ="The hours per week taught MOHEBS math/math in national languages for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(MM_hoursa,1,40)
cap export excel $var_kept MM_hoursa issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(MM_hoursa_issues,replace)firstrow(variables)
restore

*total hours
egen tot_hrs_taught = rowtotal(RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa)

preserve
replace issue_comment ="The hours per week taught by the teacher is way high or low, kindly clarify"
keep if !inrange(tot_hrs_taught,10,40)
cap export excel $var_kept RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa tot_hrs_taught issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(total_hours_issues,replace)firstrow(variables)
restore

*Age_experience issues
preserve
replace issue_comment = "Age versus experience do not match, kindly clarify"
gen age_exp = exp_1
replace age_exp = 1 if exp_1 == 1
replace age_exp = 3 if exp_1 == 2
replace age_exp = 5 if exp_1 == 3
replace age_exp = 10 if exp_1 == 4
replace age_exp = 11 if exp_1 == 5

keep if Age - age_exp < 18
cap export excel $var_kept Age exp_1 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(age_experience_issues,replace)firstrow(variables)
restore

*Language as intergers check
preserve
replace issue_comment = " The language seems to be integers, kindly clarify"
keep if strlen(Lang_2_S)< 2
cap export excel $var_kept Lang_2_S issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Mother_tongue_issues,replace)firstrow(variables)
restore

*French Speaking Consisitency
preserve
replace issue_comment = "Inconsistencies in French language spoken by the teacher, kindly clarify"
keep if Lang_1b_1 == 1 & (Lang_3 != Lang_5)
cap export excel $var_kept Lang_1b* Lang_3 Lang_5 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(French_speak_issues,replace)firstrow(variables)
restore

*French Reading Consisitency
preserve
replace issue_comment = "Inconsistencies in French language read by the teacher, kindly clarify"
keep if Lang_1b_1 == 1 & (Lang_4 != Lang_6)
cap export excel $var_kept Lang_1b* Lang_4 Lang_6 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(French_read_issues,replace)firstrow(variables)
restore


*Time spent teaching maths in languages

*policy_2b_1 // French
preserve
replace issue_comment = "Time spent using French to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_1, 10, 60)
cap export excel $var_kept Policy_2b_1 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(Maths_french_issues,replace)firstrow(variables)
restore

*policy_2b_2 // Wolof
preserve
replace issue_comment = "Time spent using Wolof to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_2,10,60)
cap export excel $var_kept Policy_2b_2 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(Maths_wolof_issues,replace)firstrow(variables)
restore

*policy_2b_3 // Pulaar
preserve
replace issue_comment = "Time spent using Pulaar to teach maths is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_2b_3,10,60)
cap export excel $var_kept Policy_2b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_pulaar_issues, replace)firstrow(variables)
restore

*policy_2b_4 // Serer
preserve
replace issue_comment = "Time spent using Serer to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_4, 10, 60)
cap export excel $var_kept Policy_2b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_serer_issues,replace)firstrow(variables)
restore 


*total time spent teaching maths in all languages
preserve
replace issue_comment = "The time spent teaching maths is more than 1 hour or less than 30 minutes, kindly clarify"
egen total_time_maths = rowtotal(Policy_2b_1 Policy_2b_2 Policy_2b_3 Policy_2b_4)
keep if !inrange(total_time_maths,30,60)
cap export excel $var_kept Policy_2b_1 Policy_2b_2 Policy_2b_3 Policy_2b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(mathematics_total_time_issues,replace)firstrow(variables)
restore

*checking if language count matches response "I do not switch" for maths
preserve
replace issue_comment = "More than 1 language and 'I do not switch languages' response, kindly clarify"
gen lang_count  = wordcount(Policy_2a)
keep if lang_count > 1 & Policy_2c_0 == 1
cap export excel $var_kept Policy_2a* Policy_2c_0 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_lang_switch_mis,replace)firstrow(variables)
restore

*checking if one language matches response "I do not switch languages" for maths
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_2a)
keep if lang_count == 1 & Policy_2c_0 != 1
cap export excel $var_kept Policy_2a* Policy_2c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_1_lang_switch_mis,replace)firstrow(variables)
restore

*Time spent reading in languages
*policy_3b_1 * //French
preserve 
replace issue_comment = "Time using French is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_1,10,60)
cap export excel $var_kept Policy_3b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_fr,replace)firstrow(variables)
restore

*policy_3b_2 //Wolof
preserve
replace issue_comment = "Time using Wolof is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_2,10,60)
cap export excel $var_kept Policy_3b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_wf,replace)firstrow(variables)
restore

*policy_3b_3 //Pulaar
preserve
replace issue_comment = "Time using Pulaar is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_3,10,60)
cap export excel $var_kept Policy_3b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_pulaar,replace)firstrow(variables)
restore

*policy_3b_4 //Serer
preserve
replace issue_comment = "Time using Serer is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_4,10,60)
cap export excel $var_kept Policy_3b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_serer,replace)firstrow(variables)
restore

*total time spent teaching in all languages
preserve 
replace issue_comment = "Time spent in all is more or less than a lesson or double lesson, kindly clarify"
egen total_time = rowtotal(Policy_3b_1 Policy_3b_2 Policy_3b_3 Policy_3b_4)
keep if !inrange(total_time,30,60)
cap export excel $var_kept Policy_3b_1 Policy_3b_2 Policy_3b_3 Policy_3b_4 total_time issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Tot_time_lang_issues,replace)firstrow(variables)
restore

*checking if language count matches response I do not switch for reading
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_3a)
keep if lang_count > 1 & Policy_3c_0 == 1
cap export excel $var_kept Policy_3a* policy_3c* lang_count issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(read_lang_swit_mismatch,replace)firstrow(variables)
restore


*checking if only 1  language count matches response "I do not switch" for reading
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_3a)
keep if lang_count == 1 & Policy_3c_0 != 1
cap export excel $var_kept Policy_3a* policy_3c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(reading_one_lang_swit_mis,replace)firstrow(variables)
restore

*checking if non_school instructions language speakers are equal to the whole classroom
preserve
replace issue_comment = "The non-school instructions language speakers can't be the whole class, kindly clarify"
keep if Lang_7 == 1 & (Lang_7a == Lang_7b)
cap export excel $var_kept Lang_7 Lang_7a Lang_7b issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Non_school_intru_speakers,replace)firstrow(variables)
restore

*Checking no of training Moheb maths
preserve
replace issue_comment = "More than 30 days or 0 days training, kindly clarify"
keep if !inrange(nl_1c, 1, 30) | (nl_1a == 1 & nl_1c != - 999)
cap export excel $var_kept nl_1a nl_1c issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(mohebmath_train_issues,replace)firstrow(variables)
restore

*Checking no of training reading
preserve
replace issue_comment = "More than 30 days or 0 days training, kindly clarify"
keep if !inrange(nl_3c, 1, 30) | (nl_3a == 1 & nl_3c != -999)
cap export excel $var_kept nl_3a nl_3c issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(read_train_days_issues,replace)firstrow(variables)
restore

*Time spent teaching maths in languages for grade 2

*policy_4b_1 // French
preserve
replace issue_comment = "Time spent using French to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_1, 10, 60)
cap export excel $var_kept Policy_4b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_french_issues_grade2,replace)firstrow(variables)
restore

*policy_4b_2 // Wolof
preserve
replace issue_comment = "Time spent using Wolof to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_2,10,60)
cap export excel $var_kept Policy_4b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_wolof_issues_grade2,replace)firstrow(variables)
restore

*policy_4b_3 // Pulaar
preserve
replace issue_comment = "Time spent using Pulaar to teach maths is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_4b_3,10,60)
cap export excel $var_kept Policy_4b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_pulaar_issues_grade2, replace)firstrow(variables)
restore

*policy_4b_4 // Serer
preserve
replace issue_comment = "Time spent using Serer to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_4, 10, 60)
cap export excel $var_kept Policy_4b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_serer_grade2,replace)firstrow(variables)
restore

*total time spent teaching maths in all languages grade 2
preserve
replace issue_comment = "The time spent teaching maths is more than 1 hour or less than 30 minutes, kindly clarify"
egen total_time_maths = rowtotal(Policy_4b_1 Policy_4b_2 Policy_4b_3 Policy_4b_4)
keep if !inrange(total_time_maths,30,60)
cap export excel $var_kept Policy_4b_1 Policy_4b_2 Policy_4b_3 Policy_4b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(maths_tot_time_grade2,replace)firstrow(variables)
restore

*checking if language count matches response "I do not switch" for maths grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_4a)
keep if lang_count > 1 & Policy_4c_0 == 1
cap export excel $var_kept Policy_4a* Policy_4c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_lang_swit_mismat_grade2,replace)firstrow(variables)
restore

*checking if one language matches response "I do not switch languages" for maths grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_4a)
keep if lang_count == 1 & Policy_4c_0 != 1
cap export excel $var_kept Policy_4a* Policy_4c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_1_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*Time spent reading in languages in grade 2
*policy_5b_1 * //French
preserve 
replace issue_comment = "Time using French is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_1,10,60)
cap export excel $var_kept Policy_5b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_french_grade2,replace)firstrow(variables)
restore

*policy_5b_2 //Wolof
preserve
replace issue_comment = "Time using Wolof is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_2,10,60)
cap export excel $var_kept Policy_5b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_wolof_grade2,replace)firstrow(variables)
restore

*policy_5b_3 //Pulaar
preserve
replace issue_comment = "Time using Pulaar is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_3,10,60)
cap export excel $var_kept Policy_5b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_pulaar_grade2,replace)firstrow(variables)
restore

*policy_5b_4 //Serer
preserve
replace issue_comment = "Time using Serer is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_4,10,60)
cap export excel $var_kept Policy_5b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_serer_grade2,replace)firstrow(variables)
restore

*total time spent teaching in all languages for grade 2
preserve 
replace issue_comment = "Time spent in all is more or less than a lesson or double lesson, kindly clarify"
egen total_time = rowtotal(Policy_5b_1 Policy_5b_2 Policy_5b_3 Policy_5b_4)
keep if !inrange(total_time,30,60)
cap export excel $var_kept Policy_5b_1 Policy_5b_2 Policy_5b_3 Policy_5b_4 total_time issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Tot_time_spent_lang_grade2,replace)firstrow(variables)
restore

*checking if language count matches response I do not switch for reading for grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_5a)
keep if lang_count > 1 & Policy_5c_0 == 1
cap export excel $var_kept Policy_5a* Policy_5c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(read_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*checking if only 1  language count matches response "I do not switch" for reading for grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_5a)
keep if lang_count == 1 & Policy_5c_0 != 1
cap export excel $var_kept Policy_5a* Policy_5c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(read_1_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*checking if non_school instructions language speakers are equal to the whole classroom for grade 2
preserve
replace issue_comment = "The non-school instructions language speakers can't be the whole class, kindly clarify"
keep if Lang_8 == 1 & (Lang_8a == Lang_8b)
cap export excel $var_kept Lang_8 Lang_8a Lang_8b issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Non_schl_intru_speak_grade2, replace)firstrow(variables)
restore







