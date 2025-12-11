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

import delimited "Main\Student\MOHEBS-MOHEBS_Baseline_Student_Survey_Field-1765344078720.csv", case(preserve)

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
replace letter_knowledge_wfnumber_of_ite = letter_knowledge_wfnum_of_ite1 if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d")

replace letter_knowledge_wfitems_per_min = letter_knowledge_wfnumber_of_ite if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d")

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

*saving data
cd "${gsdData}\Raw"
save "Main\Student\MOHEBS Student Baseline Processed Dataset 10-12 v01.dta",replace


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
replace Policy_2b_4 = 60 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9", "uuid:4a06c160-0357-40e9-bbed-2e9b6386c823","uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:4a06c160-0357-40e9-bbed-2e9b6386c823")

replace Policy_2b_2 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6", "uuid:1088507b-fb7b-404f-9015-0d717f279931","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_1 = 120 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")
replace Policy_3b_1 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")
replace Policy_3b_1 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:af5363f0-58c7-4414-b79c-fc98944a650e")


replace Policy_3b_2 = 60 if inlist(KEY,"uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")
replace Policy_3b_2 = 180 if inlist(KEY,"uuid:1088507b-fb7b-404f-9015-0d717f279931")
replace Policy_3b_2 = 240 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")
replace Policy_3b_2 = 300 if inlist(KEY,"uuid:3143c533-280b-4b21-9ffc-75f848b08269")

replace Policy_3b_3 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")
replace Policy_3b_4 = 180 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9")

foreach x in  Policy_3b_1 Policy_3b_2	Policy_3b_4{
	replace `x' = `x' * 60 if inlist(KEY,"uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6","uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:1088507b-fb7b-404f-9015-0d717f279931","uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")
} 

replace Policy_4b_1 = Policy_4b_1*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")

replace Policy_4b_2 = Policy_4b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:0d35b9d9-f50f-4a27-b640-784fb9f87360")

replace Policy_4b_3 = Policy_4b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")

foreach x in Policy_4b_1 Policy_4b_2 Policy_4b_3{
	replace `x' = `x' * 60 if inlist(KEY,"uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:def5b794-0023-4a0e-b709-7ac768d28d19")
} 

replace Policy_5b_1 = Policy_5b_1*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a")

replace Policy_5b_2 = Policy_5b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b")

replace Policy_5b_3 = Policy_5b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")

replace Policy_5b_4 = Policy_5b_4*60 if inlist(KEY, "uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:7e5596b4-082b-4935-b293-72556ebd2347")

foreach x in Policy_5b_1 Policy_5b_2 Policy_5b_4{
	replace `x' = `x' * 60 if inlist(KEY,"uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347")
}

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



// drop START_TIME_str END_TIME_str grppp1 lan1 Calc1 Calc2 Calc3 Calc4 Calc5 Calc6 Calc7 Calc8 Calc9 Calc10 Calc11 Calc12 lang_calc1 Policy_calc Firstname	Lastname	RES_NAME

*save dataset
cd "${gsdData}\Raw"
save "Main\Teachers\MOHEBS Teachers Baseline Processed Dataset 10-12 v01.dta",replace

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







