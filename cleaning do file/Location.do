*Region
lab define regi 1"Louga" 2"Fatick" 3"Kaffrine"

replace SampleRegion_label = "1" if SampleRegion =="hB9pByVH"
replace SampleRegion_label = "2" if SampleRegion =="6WUIg8r4"
replace SampleRegion_label = "3" if SampleRegion =="1Ossotdc"

destring SampleRegion_label,replace
lab values SampleRegion_label regi
ren SampleRegion_label Region
order Region,after(interviewer_type)

*IEF
lab define ief 1"Fatick" 2"Foundiougne" 3"Birkelane" 4"Kaffrine" 5"Kebemer" 6"Linguere"

replace SampleIEF_label = "1" if SampleIEF =="lEq1aZ3Y"
replace SampleIEF_label = "2" if SampleIEF =="TgYcZTPf"
replace SampleIEF_label = "3" if SampleIEF =="4T5HVGQr"
replace SampleIEF_label = "4" if SampleIEF =="AmBIrBAl"
replace SampleIEF_label = "5" if SampleIEF =="Oz4MAYYn"
replace SampleIEF_label = "6" if SampleIEF =="Rff4uoZN"

destring SampleIEF_label,replace
lab values SampleIEF_label ief
ren SampleIEF_label IEF
order IEF,after(Region)

*Arrondissement
lab define arrond 1 "Art Niakhar" 2 "Ville Fatick" 3 "Ville Diakhao" 4 "Art Ndiob" 5 "Art Djilor" 6 "Ville Soum" 7 "Art Niodior" 8 "Art Toubacouta" 9 "Ville Birkelane" 10 "Art keur Mbouki" 11 "Art Mabo" 12 "Art Gniby" 13 "Ville Kaffrine" 14 "Art Katakel" 15 "Art Ndande" 16 "Ville Kébémer" 17 "Ville Dahra" 18 "Art Barkedji" 19 "Art Yang Yang"

replace SampleArrondissement_label="1" if SampleArrondissement=="1HZIf8n8"
replace SampleArrondissement_label="2" if SampleArrondissement=="pyGDYPvq"
replace SampleArrondissement_label="3" if SampleArrondissement=="DX2AWVAt"
replace SampleArrondissement_label="4" if SampleArrondissement=="Wy7UyKVS"
replace SampleArrondissement_label="5" if SampleArrondissement=="TeneyP3R"
replace SampleArrondissement_label="6" if SampleArrondissement=="ny88DWfd"
replace SampleArrondissement_label="7" if SampleArrondissement=="6PzzDMHI"
replace SampleArrondissement_label="8" if SampleArrondissement=="zkPaplcE"
replace SampleArrondissement_label="9" if SampleArrondissement=="mUTzPAza"
replace SampleArrondissement_label="10" if SampleArrondissement=="2e1GLKxw"
replace SampleArrondissement_label="11" if SampleArrondissement=="KZQ6uqql"
replace SampleArrondissement_label="12" if SampleArrondissement=="mb73EWvy"
replace SampleArrondissement_label="13" if SampleArrondissement=="oLbgZgS1"
replace SampleArrondissement_label="14" if SampleArrondissement=="3cMUr81T"
replace SampleArrondissement_label="15" if SampleArrondissement=="QZkRwLP3"
replace SampleArrondissement_label="16" if SampleArrondissement=="DjijNTRU"
replace SampleArrondissement_label="17" if SampleArrondissement=="WJOjdFjE"
replace SampleArrondissement_label="18" if SampleArrondissement=="dDF5cJug"
replace SampleArrondissement_label="19" if SampleArrondissement=="o1oJvhPP"

destring SampleArrondissement_label,replace
lab values SampleArrondissement_label arrond
ren SampleArrondissement_label Arrondissement
order Arrondissement,after(IEF)

*Commune
lab define comm 1 "Niakhar" 2 "Patar" 3 "Ngayokhene" 4 "Fatick" 5 "Diakhao" 6 "Ndiob" 7 "Thiare Ndialgui" 8 "Mbellacadiao" 9 "Djilor" 10 "Mbam" 11 "Diagane Barka" 12 "Soum" 13 "Dionewar" 14 "Toubacouta" 15 "Birkelane" 16 "Keur Mbouki" 17 "Diamal" 18 "Ndiognick" 19 "Mabo" 20 "Boulel" 21 "Kahi" 22 "Kaffrine" 23 "Medinatoul Salam 2" 24 "Diokoul Diawrigne" 25 "Ndande" 26 "Kébémer" 27 "Dahra" 28 "Barkédji" 29 "Thiargny" 30 "Kambe"

replace SampleCommune_label="1" if SampleCommune=="2pTxaqHn"
replace SampleCommune_label="2" if SampleCommune=="wnrgWr8m"
replace SampleCommune_label="3" if SampleCommune=="jXRT5lgU"
replace SampleCommune_label="4" if SampleCommune=="x1dxT3tS"
replace SampleCommune_label="5" if SampleCommune=="hCkgFN60"
replace SampleCommune_label="6" if SampleCommune=="hyv11sIb"
replace SampleCommune_label="7" if SampleCommune=="38ITPY00"
replace SampleCommune_label="8" if SampleCommune=="qjhCehEV"
replace SampleCommune_label="9" if SampleCommune=="zNdfyxkM"
replace SampleCommune_label="10" if SampleCommune=="Mqau0Bao"
replace SampleCommune_label="11" if SampleCommune=="8jOqqQjp"
replace SampleCommune_label="12" if SampleCommune=="9O57sus5"
replace SampleCommune_label="13" if SampleCommune=="dBW9QCLE"
replace SampleCommune_label="14" if SampleCommune=="qgwKt8C5"
replace SampleCommune_label="15" if SampleCommune=="k8kJz9DM"
replace SampleCommune_label="16" if SampleCommune=="0OaSaQ1Z"
replace SampleCommune_label="17" if SampleCommune=="320Jac3Z"
replace SampleCommune_label="18" if SampleCommune=="YnjRDMY5"
replace SampleCommune_label="19" if SampleCommune=="eOSqS2rh"
replace SampleCommune_label="20" if SampleCommune=="iW1AeIOF"
replace SampleCommune_label="21" if SampleCommune=="qPe4lRMs"
replace SampleCommune_label="22" if SampleCommune=="CeeO4a3T"
replace SampleCommune_label="23" if SampleCommune=="IciPHrN7"
replace SampleCommune_label="24" if SampleCommune=="ja4GKNUj"
replace SampleCommune_label="25" if SampleCommune=="GRlpl6t8"
replace SampleCommune_label="26" if SampleCommune=="xThg2bBj"
replace SampleCommune_label="27" if SampleCommune=="FaqFmP6t"
replace SampleCommune_label="28" if SampleCommune=="Rjow2MeI"
replace SampleCommune_label="29" if SampleCommune=="vlhJjJHb"
replace SampleCommune_label="30" if SampleCommune=="6w1Fyjli"

destring SampleCommune_label, replace
ren SampleCommune_label Commune
lab values Commune comm
order Commune,after(Arrondissement)

**Ecole
lab define sch 1 "ee amady barro diouf" 2 "ee diandoum" 3 "ee ndokh" 4 "ee ngangarlam" 5 "ee ngayokheme" 6 "ee nghonine" 7 "ee toucar 2" 8 "ee application" 9 "ee ngor ndame ndiaye ndiaye" 10 "ee poukham ndieme" 11 "ee boure ngom" 12 "ee diakhao 4" 13 "ee ndodj" 14 "ee toffaye" 15 "mbellacadio 2" 16 "ee baaye" 17 "ee keur oumar" 18 "ee keur yoro" 19 "ee lathilor ndong" 20 "ee ndiomdy" 21 "ee pethie" 22 "ee gague mody" 23 "ee mbam 1" 24 "ee mbam 2" 25 "ee mbassis 2" 26 "ee thiare" 27 "keur mamadou fatouma" 28 "ee babacar ndene diop" 29 "ee dionewar 2" 30 "ee medina santhie" 31 "ee toubacouta 1" 32 "efa medina sangako" 33 "ee birkelane 4" 34 "ee el h. thiendella fall" 35 "ee dara nguer" 36 "ee keur mboucki" 37 "ee ngambou" 38 "ee thicatte gallo" 39 "efa el hadji abdoulaye cisse" 40 "ee kethiewane peulh" 41 "ee keur babou" 42 "ee ndiayene bagana" 43 "ee keur ndongo" 44 "ee medina thiakho peulh" 45 "ee boucar diouf" 46 "ee elhadji lahine faly ndao" 47 "ee de kathiote" 48 "ee diamaguene tp" 49 "ee elhadji aliou fana cisse" 50 "ee elhadji ndene diodio ndiaye" 51 "ee kaffrine 2 sud" 52 "ee kaffrine 3" 53 "ee waly fatha ndiaye" 54 "efa diamaguene tp" 55 "ee ndakhar poste" 56 "ee gade kebe" 57 "ee maka ndiaye" 58 "ee ndiawrigne mamousse" 59 "ee gaty rate" 60 "ee ndande 3" 61 "ee mor madjiguene kebe" 62 "efa ndakhar syll" 63 "ee angle islam" 64 "ee angle ndiakhaye" 65 "ee barkedji montagne" 66 "ee diagaly" 67 "ee tordione" 68 "ee gouyeguenie" 69 "ee thiargny" 70 "ee kamb"

replace SampleSchool_label="1" if SampleSchool=="4SWDO7NY"
replace SampleSchool_label="2" if SampleSchool=="0EwvgiwU"
replace SampleSchool_label="3" if SampleSchool=="PcnkfEpm"
replace SampleSchool_label="4" if SampleSchool=="HsFVBYc4"
replace SampleSchool_label="5" if SampleSchool=="fsjWfogt"
replace SampleSchool_label="6" if SampleSchool=="ePL0DQMp"
replace SampleSchool_label="7" if SampleSchool=="JwaOleJb"
replace SampleSchool_label="8" if SampleSchool=="62JXuHno"
replace SampleSchool_label="9" if SampleSchool=="nag6owCA"
replace SampleSchool_label="10" if SampleSchool=="Mj3Th4Oh"
replace SampleSchool_label="11" if SampleSchool=="Hcp7nDzO"
replace SampleSchool_label="12" if SampleSchool=="mScheDlw"
replace SampleSchool_label="13" if SampleSchool=="Q66xMNmF"
replace SampleSchool_label="14" if SampleSchool=="cRLYFWgZ"
replace SampleSchool_label="15" if SampleSchool=="Oz9Yyvp8"
replace SampleSchool_label="16" if SampleSchool=="fI2ogbl9"
replace SampleSchool_label="17" if SampleSchool=="NBgaqjgh"
replace SampleSchool_label="18" if SampleSchool=="jejgv47t"
replace SampleSchool_label="19" if SampleSchool=="2R2RvuuJ"
replace SampleSchool_label="20" if SampleSchool=="ddtal9pt"
replace SampleSchool_label="21" if SampleSchool=="rAirVtar"
replace SampleSchool_label="22" if SampleSchool=="3eu4FWbp"
replace SampleSchool_label="23" if SampleSchool=="H8iDQJJi"
replace SampleSchool_label="24" if SampleSchool=="DfufFm8h"
replace SampleSchool_label="25" if SampleSchool=="OgSW5Zzn"
replace SampleSchool_label="26" if SampleSchool=="t4todZdt"
replace SampleSchool_label="27" if SampleSchool=="tnZqTspI"
replace SampleSchool_label="28" if SampleSchool=="TMBa5ajj"
replace SampleSchool_label="29" if SampleSchool=="E8tvT6ME"
replace SampleSchool_label="30" if SampleSchool=="FqhV3X1t"
replace SampleSchool_label="31" if SampleSchool=="73mez6BF"
replace SampleSchool_label="32" if SampleSchool=="5M1FqEHp"
replace SampleSchool_label="33" if SampleSchool=="x3a3ZIUj"
replace SampleSchool_label="34" if SampleSchool=="tJpToZOL"
replace SampleSchool_label="35" if SampleSchool=="7NCwpjH7"
replace SampleSchool_label="36" if SampleSchool=="au8aUBKe"
replace SampleSchool_label="37" if SampleSchool=="W0w4z8NS"
replace SampleSchool_label="38" if SampleSchool=="lfDVqCRb"
replace SampleSchool_label="39" if SampleSchool=="axDdedOV"
replace SampleSchool_label="40" if SampleSchool=="OEJJMbQc"
replace SampleSchool_label="41" if SampleSchool=="UlI1lqsP"
replace SampleSchool_label="42" if SampleSchool=="mgA7v5t3"
replace SampleSchool_label="43" if SampleSchool=="X1kszngu"
replace SampleSchool_label="44" if SampleSchool=="RzGXZyG1"
replace SampleSchool_label="45" if SampleSchool=="9oEKY1JV"
replace SampleSchool_label="46" if SampleSchool=="glntRp56"
replace SampleSchool_label="47" if SampleSchool=="dP9FQDer"
replace SampleSchool_label="48" if SampleSchool=="7ZhnixtY"
replace SampleSchool_label="49" if SampleSchool=="i6APPE1N"
replace SampleSchool_label="50" if SampleSchool=="Sjcaw0dY"
replace SampleSchool_label="51" if SampleSchool=="LBxnN4Ou"
replace SampleSchool_label="52" if SampleSchool=="6OLvdruK"
replace SampleSchool_label="53" if SampleSchool=="tlKHK61p"
replace SampleSchool_label="54" if SampleSchool=="vnc1hEAn"
replace SampleSchool_label="55" if SampleSchool=="Cx0spiKp"
replace SampleSchool_label="56" if SampleSchool=="wHqWWLdt"
replace SampleSchool_label="57" if SampleSchool=="HCpD0vP5"
replace SampleSchool_label="58" if SampleSchool=="tNyKtSPd"
replace SampleSchool_label="59" if SampleSchool=="Q32KNoi6"
replace SampleSchool_label="60" if SampleSchool=="PniKmGHC"
replace SampleSchool_label="61" if SampleSchool=="UDzwtakr"
replace SampleSchool_label="62" if SampleSchool=="R8zEzvi4"
replace SampleSchool_label="63" if SampleSchool=="Q2jpVRcR"
replace SampleSchool_label="64" if SampleSchool=="URfXJmLd"
replace SampleSchool_label="65" if SampleSchool=="1bvsxFnZ"
replace SampleSchool_label="66" if SampleSchool=="hM5Mp24i"
replace SampleSchool_label="67" if SampleSchool=="cRnkhoP1"
replace SampleSchool_label="68" if SampleSchool=="7qQWnLqw"
replace SampleSchool_label="69" if SampleSchool=="mcUnARty"
replace SampleSchool_label="70" if SampleSchool=="rPNn9yEo"

destring SampleSchool_label, replace
ren SampleSchool_label School
lab values School sch
order School,after(Commune)

*Group
lab def grp 1 "Traitement" 2 "Comparaison"

replace SampleGroupe_label="1" if SampleGroupe_label=="Traitement"
replace SampleGroupe_label="2" if SampleGroupe_label=="Comparaison" 

destring SampleGroupe_label, replace
ren SampleGroupe_label Groupe
lab values Groupe grp
order Groupe,after(School)

*Language
lab define lan 1"French" 2 "Wolof" 3 "Serer" 4"Pulaar"

replace SampleLanguage_label="2" if SampleLanguage_label=="Wolof"
replace SampleLanguage_label="3" if SampleLanguage_label=="Seereer"
replace SampleLanguage_label="4" if SampleLanguage_label=="Pulaar"

destring SampleLanguage_label, replace
ren SampleLanguage_label Language
lab values Language lan
order Language,after(Groupe)








