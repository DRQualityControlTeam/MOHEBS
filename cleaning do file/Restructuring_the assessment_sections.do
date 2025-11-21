*Survey_language logic
lab define false_true 1 "True" 0 "False"
 

foreach r in letter_knowledge_srgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_prgridAutoStopp  reading_familiar_words_prgridAut reading_familiar_words_srgridAut reading_familiar_words_wfgridAut oral_reading_fluency_prgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_wfgridAutoS{
    tostring `r',replace
    replace `r' = "1" if `r' == "TRUE"
	replace `r' = "0" if `r' == "FALSE"
}

destring letter_knowledge_srgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_prgridAutoStopp reading_familiar_words_prgridAut reading_familiar_words_srgridAut reading_familiar_words_wfgridAut oral_reading_fluency_prgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_wfgridAutoS,replace

lab values letter_knowledge_srgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_prgridAutoStopp reading_familiar_words_prgridAut reading_familiar_words_srgridAut reading_familiar_words_wfgridAut oral_reading_fluency_prgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_wfgridAutoS false_true

*Restructuring the data into long then wide to shorten the variables 

*Letter Knowledge
ren letter_knowledge_srduration letter_knowledge_sr_101
ren letter_knowledge_srtime_remainin letter_knowledge_sr_102
ren letter_knowledge_srgridAutoStopp letter_knowledge_sr_103
ren letter_knowledge_srautoStop letter_knowledge_sr_104
ren letter_knowledge_srnum_corr letter_knowledge_sr_105
ren letter_knowledge_srnum_att letter_knowledge_sr_106
ren letter_knowledge_sritems_per_min letter_knowledge_sr_107

ren letter_knowledge_wfduration letter_knowledge_wf_101
ren letter_knowledge_wftime_remainin letter_knowledge_wf_102
ren letter_knowledge_wfgridAutoStopp letter_knowledge_wf_103
ren letter_knowledge_wfautoStop letter_knowledge_wf_104
ren letter_knowledge_wfnum_corr letter_knowledge_wf_105
ren letter_knowledge_wfnum_att letter_knowledge_wf_106
ren letter_knowledge_wfitems_per_min letter_knowledge_wf_107

ren letter_knowledge_prduration letter_knowledge_pr_101
ren letter_knowledge_prtime_remainin letter_knowledge_pr_102
ren letter_knowledge_prgridAutoStopp letter_knowledge_pr_103
ren letter_knowledge_prautoStop letter_knowledge_pr_104
ren letter_knowledge_prnum_corr letter_knowledge_pr_105
ren letter_knowledge_prnum_att letter_knowledge_pr_106
ren letter_knowledge_pritems_per_min letter_knowledge_pr_107

* Step 1: Reshape to long format for all variable groups
reshape long letter_knowledge_wf_ letter_knowledge_sr_ letter_knowledge_pr_, i(interview_ID survey_language) j(index)


* Step 2: Combine the variables into a single column
gen v1 = cond(!missing(letter_knowledge_wf_), letter_knowledge_wf_,cond(!missing(letter_knowledge_sr_), letter_knowledge_sr_, letter_knowledge_pr_))

* Step 3: Drop the intermediate variables and rename
drop letter_knowledge_wf_ letter_knowledge_sr_ letter_knowledge_pr_
rename index letter_knowledge_index

* Step 4: Reshape back to wide format
reshape wide v1, i(interview_ID survey_language) j(letter_knowledge_index)

* Step 5: Rename columns for clarity
rename v1* letter_knowledge_*

*rename from 101 - 107
ren letter_knowledge_101 letter_knowledge_duration
ren letter_knowledge_102 letter_knowledge_time_remaining
ren letter_knowledge_103 letter_knowledge_gridAutoStopp
ren letter_knowledge_104 letter_knowledge_autoStop
ren letter_knowledge_105 letter_knowledge_correct
ren letter_knowledge_106 letter_knowledge_attempt
ren letter_knowledge_107 letter_knowledge_items_per_min

*label variables
lab var  letter_knowledge_1"1. a"
lab var  letter_knowledge_2"2. t"
lab var  letter_knowledge_3"3. b"
lab var  letter_knowledge_4"4. r"
lab var  letter_knowledge_5"5. i"
lab var  letter_knowledge_6"6. L"
lab var  letter_knowledge_7"7. m"
lab var  letter_knowledge_8"8. p"
lab var  letter_knowledge_9"9. d"
lab var  letter_knowledge_10"10. O"
lab var  letter_knowledge_11"11. ng"
lab var  letter_knowledge_12"12. c"
lab var  letter_knowledge_13"13. j"
lab var  letter_knowledge_14"14. K"
lab var  letter_knowledge_15"15. f"
lab var  letter_knowledge_16"16. ó"
lab var  letter_knowledge_17"17. n"
lab var  letter_knowledge_18"18. h"
lab var  letter_knowledge_19"19. E"
lab var  letter_knowledge_20"20. ée"
lab var  letter_knowledge_21"21. y"
lab var  letter_knowledge_22"22. D"
lab var  letter_knowledge_23"23. à"
lab var  letter_knowledge_24"24. İ"
lab var  letter_knowledge_25"25. e"
lab var  letter_knowledge_26"26. o"
lab var  letter_knowledge_27"27. A"
lab var  letter_knowledge_28"28. ë"
lab var  letter_knowledge_29"29. u"
lab var  letter_knowledge_30"30. aa"
lab var  letter_knowledge_31"31. é"
lab var  letter_knowledge_32"32. i"
lab var  letter_knowledge_33"33. M"
lab var  letter_knowledge_34"34. g"
lab var  letter_knowledge_35"35. a"
lab var  letter_knowledge_36"36. ii"
lab var  letter_knowledge_37"37. B"
lab var  letter_knowledge_38"38. r"
lab var  letter_knowledge_39"39. mb"
lab var  letter_knowledge_40"40. N"
lab var  letter_knowledge_41"41. A"
lab var  letter_knowledge_42"42. u"
lab var  letter_knowledge_43"43. d"
lab var  letter_knowledge_44"44. y"
lab var  letter_knowledge_45"45. k"
lab var  letter_knowledge_46"46. P"
lab var  letter_knowledge_47"47. m"
lab var  letter_knowledge_48"48. İ"
lab var  letter_knowledge_49"49. uu"
lab var  letter_knowledge_50"50. ã"
lab var  letter_knowledge_51"51. n"
lab var  letter_knowledge_52"52. óo"
lab var  letter_knowledge_53"53. b"
lab var  letter_knowledge_54"54. Aa"
lab var  letter_knowledge_55"55. e"
lab var  letter_knowledge_56"56. w"
lab var  letter_knowledge_57"57. c"
lab var  letter_knowledge_58"58. ëe"
lab var  letter_knowledge_59"59. S"
lab var  letter_knowledge_60"60. U"
lab var  letter_knowledge_61"61. R"
lab var  letter_knowledge_62"62. nd"
lab var  letter_knowledge_63"63. a"
lab var  letter_knowledge_64"64. ee"
lab var  letter_knowledge_65"65. T"
lab var  letter_knowledge_66"66. ñ"
lab var  letter_knowledge_67"67. l"
lab var  letter_knowledge_68"68. Y"
lab var  letter_knowledge_69"69. G"
lab var  letter_knowledge_70"70. d"
lab var  letter_knowledge_71"71. ŋ"
lab var  letter_knowledge_72"72. k"
lab var  letter_knowledge_73"73. s"
lab var  letter_knowledge_74"74. N"
lab var  letter_knowledge_75"75. q"
lab var  letter_knowledge_76"76. i"
lab var  letter_knowledge_77"77. b"
lab var  letter_knowledge_78"78. x"
lab var  letter_knowledge_79"79. a"
lab var  letter_knowledge_80"80. C"
lab var  letter_knowledge_81"81. U"
lab var  letter_knowledge_82"82. i"
lab var  letter_knowledge_83"83. J"
lab var  letter_knowledge_84"84. t"
lab var  letter_knowledge_85"85. H"
lab var  letter_knowledge_86"86. nj"
lab var  letter_knowledge_87"87. l"
lab var  letter_knowledge_88"88. oo"
lab var  letter_knowledge_89"89. u"
lab var  letter_knowledge_90"90. n"
lab var  letter_knowledge_91"91. o"
lab var  letter_knowledge_92"92. W"
lab var  letter_knowledge_93"93. F"
lab var  letter_knowledge_94"94. t"
lab var  letter_knowledge_95"95. a"
lab var  letter_knowledge_96"96. Ŋ"
lab var  letter_knowledge_97"97. k"
lab var  letter_knowledge_98"98. Q"
lab var  letter_knowledge_99"99. X"
lab var  letter_knowledge_100"100. A"

lab var letter_knowledge_duration"letter_knowledge.duration"
lab var letter_knowledge_time_remaining"letter_knowledge.time_remaining"
lab var letter_knowledge_gridAutoStopp"letter_knowledge.gridAutoStopped"
lab var letter_knowledge_autoStop"letter_knowledge.autoStop"
lab var letter_knowledge_correct"letter_knowledge.number_of_items_correct"
lab var letter_knowledge_attempt"letter_knowledge.number_of_items_attempted"
lab var letter_knowledge_items_per_min"letter_knowledge.items_per_minute"

lab values letter_knowledge_gridAutoStopp false_true

*Reading Familiar 
ren reading_familiar_words_wfduratio reading_familiar_words_wf_51
ren reading_familiar_words_wftime_re reading_familiar_words_wf_52
ren reading_familiar_words_wfgridAut reading_familiar_words_wf_53
ren reading_familiar_words_wfautoSto reading_familiar_words_wf_54
ren reading_familiar_words_wfnum_cor reading_familiar_words_wf_55
ren reading_familiar_words_wfnum_att reading_familiar_words_wf_56
ren reading_familiar_words_wfitems_p reading_familiar_words_wf_57

ren reading_familiar_words_prduratio reading_familiar_words_pr_51
ren reading_familiar_words_prtime_re reading_familiar_words_pr_52
ren reading_familiar_words_prgridAut reading_familiar_words_pr_53
ren reading_familiar_words_prautoSto reading_familiar_words_pr_54
ren reading_familiar_words_prnum_cor reading_familiar_words_pr_55
ren reading_familiar_words_prnum_att reading_familiar_words_pr_56
ren reading_familiar_words_pritems_p reading_familiar_words_pr_57

ren reading_familiar_words_srduratio reading_familiar_words_sr_51
ren reading_familiar_words_srtime_re reading_familiar_words_sr_52
ren reading_familiar_words_srgridAut reading_familiar_words_sr_53
ren reading_familiar_words_srautoSto reading_familiar_words_sr_54
ren reading_familiar_words_srnum_cor reading_familiar_words_sr_55
ren reading_familiar_words_srnum_att reading_familiar_words_sr_56
ren reading_familiar_words_sritems_p reading_familiar_words_sr_57

* Step 1: Reshape to long format for all variable groups
reshape long reading_familiar_words_wf_ reading_familiar_words_sr_ reading_familiar_words_pr_, i(interview_ID survey_language) j(index)


* Step 2: Combine the variables into a single column
gen v1 = cond(!missing(reading_familiar_words_wf_), reading_familiar_words_wf_,cond(!missing(reading_familiar_words_sr_), reading_familiar_words_sr_, reading_familiar_words_pr_))

* Step 3: Drop the intermediate variables and rename
drop reading_familiar_words_wf_ reading_familiar_words_sr_ reading_familiar_words_pr_
rename index reading_familiar_words_index

* Step 4: Reshape back to wide format
reshape wide v1, i(interview_ID survey_language) j(reading_familiar_words_index)

* Step 5: Rename columns for clarity
rename v1* reading_familiar_words_*

*labelling
lab var reading_familiar_words_1"1. daba"
lab var reading_familiar_words_2"2. mata"
lab var reading_familiar_words_3"3. tofo"
lab var reading_familiar_words_4"4. tal"
lab var reading_familiar_words_5"5. mala"
lab var reading_familiar_words_6"6. bati"
lab var reading_familiar_words_7"7. fit"
lab var reading_familiar_words_8"8. tal"
lab var reading_familiar_words_9"9. laax"
lab var reading_familiar_words_10"10. ami"
lab var reading_familiar_words_11"11. mooy"
lab var reading_familiar_words_12"12. dallu"
lab var reading_familiar_words_13"13. nañu"
lab var reading_familiar_words_14"14. ngi"
lab var reading_familiar_words_15"15. génn"
lab var reading_familiar_words_16"16. yu"
lab var reading_familiar_words_17"17. bari"
lab var reading_familiar_words_18"18. ci"
lab var reading_familiar_words_19"19. garab"
lab var reading_familiar_words_20"20. madam"
lab var reading_familiar_words_21"21. ekool"
lab var reading_familiar_words_22"22. yi"
lab var reading_familiar_words_23"23. elew"
lab var reading_familiar_words_24"24. bee"
lab var reading_familiar_words_25"25. ëttu"
lab var reading_familiar_words_26"26. biro"
lab var reading_familiar_words_27"27. Faal"
lab var reading_familiar_words_28"28. ñoom"
lab var reading_familiar_words_29"29. tey"
lab var reading_familiar_words_30"30. yee"
lab var reading_familiar_words_31"31. elew"
lab var reading_familiar_words_32"32. di"
lab var reading_familiar_words_33"33. xumb"
lab var reading_familiar_words_34"34. doole"
lab var reading_familiar_words_35"35. yaa"
lab var reading_familiar_words_36"36. nga"
lab var reading_familiar_words_37"37. jaay"
lab var reading_familiar_words_38"38. ñu"
lab var reading_familiar_words_39"39. toog"
lab var reading_familiar_words_40"40. diw"
lab var reading_familiar_words_41"41. fa"
lab var reading_familiar_words_42"42. riir"
lab var reading_familiar_words_43"43. yaw"
lab var reading_familiar_words_44"44. too"
lab var reading_familiar_words_45"45. liw"
lab var reading_familiar_words_46"46. seen"
lab var reading_familiar_words_47"47. wetu"
lab var reading_familiar_words_48"48. bi"
lab var reading_familiar_words_49"49. yi"
lab var reading_familiar_words_50"50. buuxante"

*rename from 51 - 57
ren reading_familiar_words_51 reading_familiar_duration
ren reading_familiar_words_52 reading_familiar_remaining
ren reading_familiar_words_53 reading_familiar_gridAutoStopp
ren reading_familiar_words_54 reading_familiar_autoStop
ren reading_familiar_words_55 reading_familiar_correct
ren reading_familiar_words_56 reading_familiar_attempt
ren reading_familiar_words_57 reading_familiar_items_per_min

lab var reading_familiar_duration"reading_familiar_words.duration"
lab var reading_familiar_remaining"reading_familiar_words.time_remaining"
lab var reading_familiar_gridAutoStopp"reading_familiar_words.gridAutoStopped"
lab var reading_familiar_autoStop"reading_familiar_words.autoStop"
lab var reading_familiar_correct"reading_familiar_words.number_of_items_correct"
lab var reading_familiar_attempt"reading_familiar_words.number_of_items_attempted"
lab var reading_familiar_items_per_min"reading_familiar_words.items_per_minute"

lab values reading_familiar_gridAutoStopp false_true

*Oral Fluency.

***Ensure the correct calculation is not biased. since Pulaar are 39 items.
ren oral_reading_fluency_prduration oral_reading_fluency_pr_44
ren oral_reading_fluency_prtime_rema oral_reading_fluency_pr_45
ren oral_reading_fluency_prgridAutoS oral_reading_fluency_pr_46
ren oral_reading_fluency_prnum_corr oral_reading_fluency_pr_47
ren oral_reading_fluency_prnum_att oral_reading_fluency_pr_48
ren oral_reading_fluency_pritems_per oral_reading_fluency_pr_49

ren oral_reading_fluency_srduration oral_reading_fluency_sr_44
ren oral_reading_fluency_srtime_rema oral_reading_fluency_sr_45
ren oral_reading_fluency_srgridAutoS oral_reading_fluency_sr_46
ren oral_reading_fluency_srnum_corr oral_reading_fluency_sr_47
ren oral_reading_fluency_srnum_att oral_reading_fluency_sr_48
ren oral_reading_fluency_sritems_per oral_reading_fluency_sr_49

ren oral_reading_fluency_wfduration oral_reading_fluency_wf_44
ren oral_reading_fluency_wftime_rema oral_reading_fluency_wf_45
ren oral_reading_fluency_wfgridAutoS oral_reading_fluency_wf_46
ren oral_reading_fluency_wfnum_corr oral_reading_fluency_wf_47
ren oral_reading_fluency_wfnum_att oral_reading_fluency_wf_48
ren oral_reading_fluency_wfitems_per oral_reading_fluency_wf_49

* Step 1: Reshape to long format for all variable groups
reshape long oral_reading_fluency_wf_ oral_reading_fluency_sr_ oral_reading_fluency_pr_, i(interview_ID survey_language) j(index)

* Step 2: Combine the variables into a single column
gen v1 = cond(!missing(oral_reading_fluency_wf_), oral_reading_fluency_wf_,cond(!missing(oral_reading_fluency_sr_), oral_reading_fluency_sr_, oral_reading_fluency_pr_))

* Step 3: Drop the intermediate variables and rename
drop oral_reading_fluency_wf_ oral_reading_fluency_sr_ oral_reading_fluency_pr_
rename index oral_reading_fluency_index

* Step 4: Reshape back to wide format
reshape wide v1, i(interview_ID survey_language) j(oral_reading_fluency_index)

* Step 5: Rename columns for clarity
rename v1* oral_reading_fluency_*

*Labelling_file
lab var oral_reading_fluency_1"1. Le"
lab var oral_reading_fluency_2"2. jeu"
lab var oral_reading_fluency_3"3. de"
lab var oral_reading_fluency_4"4. ballon/"
lab var oral_reading_fluency_5"5. C'est"
lab var oral_reading_fluency_6"6. dimanche."
lab var oral_reading_fluency_7"7. Ali"
lab var oral_reading_fluency_8"8. s'amuse"
lab var oral_reading_fluency_9"9. dans"
lab var oral_reading_fluency_10"10. la"
lab var oral_reading_fluency_11"11. cour"
lab var oral_reading_fluency_12"12. de"
lab var oral_reading_fluency_13"13. l'école"
lab var oral_reading_fluency_14"14. avec"
lab var oral_reading_fluency_15"15. son"
lab var oral_reading_fluency_16"16. petit"
lab var oral_reading_fluency_17"17. frère."
lab var oral_reading_fluency_18"18. Son"
lab var oral_reading_fluency_19"19. camarade"
lab var oral_reading_fluency_20"20. Sidi"
lab var oral_reading_fluency_21"21. arrive"
lab var oral_reading_fluency_22"22. avec"
lab var oral_reading_fluency_23"23. un"
lab var oral_reading_fluency_24"24. ballon."
lab var oral_reading_fluency_25"25. Ali,"
lab var oral_reading_fluency_26"26. son"
lab var oral_reading_fluency_27"27. frère"
lab var oral_reading_fluency_28"28. et"
lab var oral_reading_fluency_29"29. Sidi"
lab var oral_reading_fluency_30"30. jouent"
lab var oral_reading_fluency_31"31. au"
lab var oral_reading_fluency_32"32. ballon"
lab var oral_reading_fluency_33"33. toute"
lab var oral_reading_fluency_34"34. la"
lab var oral_reading_fluency_35"35. matinée."
lab var oral_reading_fluency_36"36. Les"
lab var oral_reading_fluency_37"37. amis"
lab var oral_reading_fluency_38"38. ont"
lab var oral_reading_fluency_39"39. bien"
lab var oral_reading_fluency_40"40. joué."
lab var oral_reading_fluency_41"41. Ils"
lab var oral_reading_fluency_42"42. sont"
lab var oral_reading_fluency_43"43. contents."

ren oral_reading_fluency_44 oral_reading_duration
ren oral_reading_fluency_45 oral_reading_remaining
ren oral_reading_fluency_46 oral_reading_gridAutoStopp
ren oral_reading_fluency_47 oral_reading_correct
ren oral_reading_fluency_48 oral_reading_attempt
ren oral_reading_fluency_49 oral_reading_items_per_min

lab var oral_reading_duration"oral_reading_fluency.duration"
lab var oral_reading_remaining"oral_reading_fluency.time_remaining"
lab var oral_reading_gridAutoStopp"oral_reading_fluency.gridAutoStopped"
lab var oral_reading_correct"oral_reading_fluency.number_of_items_correct"
lab var oral_reading_attempt"oral_reading_fluency.number_of_items_attempted"
lab var oral_reading_items_per_min"oral_reading_fluency.items_per_minute"

lab values oral_reading_gridAutoStopp false_true