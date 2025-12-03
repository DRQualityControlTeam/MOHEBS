*Region
lab define regi 1"Louga" 2"Fatick" 3"Kaffrine"

lab values Region regi

*IEF
lab define ief 1"Fatick" 2"Foundiougne" 3"Birkelane" 4"Kaffrine" 5"Kebemer" 6"Linguere"

lab values IEF ief

*Arrondissement
lab define Arrond 1 "Art Niakhar" 2 "Ville Diakhao" 3 "Art Ndiob" 4 "Ville Fatick" 5 "Art Djilor" 6 "Ville Soum" 7 "Art Toubacouta" 8 "Art keur Mbouki" 9 "Art Mabo" 10 "Ville Birkelane" 11 "Ville Kaffrine" 12 "Art Katakel" 13 "Art Gniby" 14 "Ville Kébémer" 15 "Art Ndande" 16 "Ville Dahra" 17 "Art Barkedji" 18 "Art Yang Yang"

* Clone 15 copies automatically
forvalues i = 2/15 {
    gen Arr`i' = .
}

* Apply the recodes to each variable
replace Arr2  = 18 if Arrondissement == 19
replace Arr3  = 17 if Arrondissement == 18
replace Arr4  = 16 if Arrondissement == 17
replace Arr5  = 14 if Arrondissement == 16
replace Arr6  = 13 if Arrondissement == 12
replace Arr7  = 12 if Arrondissement == 14
replace Arr8  = 11 if Arrondissement == 13
replace Arr9  = 10 if Arrondissement == 9
replace Arr10 = 9  if Arrondissement == 11
replace Arr11 = 8  if Arrondissement == 10
replace Arr12 = 7  if Arrondissement == 8
replace Arr13 = 4  if Arrondissement == 2
replace Arr14 = 3  if Arrondissement == 4
replace Arr15 = 2  if Arrondissement == 3

egen newArr = rowtotal(Arr2 Arr3 Arr4 Arr5 Arr6 Arr7 Arr8 Arr9 Arr10 Arr11 Arr12 Arr13 Arr14 Arr15)

replace Arrondissement = newArr

drop newArr Arr2 Arr3 Arr4 Arr5 Arr6 Arr7 Arr8 Arr9 Arr10 Arr11 Arr12 Arr13 Arr14 Arr15

lab values Arrondissement Arrond

*Commune
lab define comm 1 "Niakhar" 2 "Ngayokhene" 3 "Diakhao" 4 "Ndiob" 5 "Mbellacadiao" 6 "Diaoule" 7 "Fatick" 8 "Djilor" 9 "Mbam" 10 "Diagane Barka" 11 "Soum" 12 "Toubacouta" 13 "Touba Mbella" 14 "Diamal" 15 "Keur Mbouki" 16 "Ndiognick" 17 "Birkelane" 18 "Kaffrine" 19 "Medinatoul Salam 2" 20 "Boulel" 21 "Kahi" 22 "Kébémer" 23 "Ndande" 24 "Diokoul Diawrigne" 25 "Dahra" 26 "Thiargny" 27 "Barkédji" 28 "Kambe"

* Clone 15 copies automatically
forvalues i = 1/24 {
    gen coms`i' = .
}


replace coms1 = 4  if Commune == 5      // Ndiob
replace coms2 = 2  if Commune == 6      // Ngayokhene
replace coms3 = 5  if Commune == 8      // Mbellacadiao
replace coms4 = 6  if Commune == 31     // Diaoule
replace coms5 = 7  if Commune == 2      // Fatick
replace coms6 = 8  if Commune == 9      // Djilor
replace coms7 = 9  if Commune == 12     // Mbam
replace coms8 = 10 if Commune == 14     // Diagane Barka
replace coms9 = 11 if Commune == 10     // Soum
replace coms10 = 12 if Commune == 13     // Toubacouta
replace coms11 = 13 if Commune == 32     // Touba Mbella
replace coms12 = 16 if Commune == 17     // Ndiognick
replace coms13 = 14 if Commune == 19     // Diamal
replace coms14 = 15 if Commune == 16     // Keur Mbouki
replace coms15 = 17 if Commune == 15     // Birkelane
replace coms16 = 18 if Commune == 21     // Kaffrine
replace coms17 = 19 if Commune == 23     // Medinatoul Salam 2
replace coms18 = 21 if Commune == 22     // Kahi
replace coms19 = 22 if Commune == 26     // Kébémer
replace coms20 = 23 if Commune == 25     // Ndande
replace coms21 = 25 if Commune == 27     // Dahra
replace coms22 = 26 if Commune == 29     // Thiargny
replace coms23 = 27 if Commune == 28     // Barkédji
replace coms24 = 28 if Commune == 30     // Kambe

lab values Commune comm

egen coms_total = rowtotal(coms1-coms24)

replace Commune = coms_total

drop coms_total coms1-coms24

lab values Commune comm


*Enchantallion
lab define echa 1 "Échantillon" 2 "Remplacement"

lab values Sample echa

**Ecole
lab define sch 1 "ee bibane" 2 "ee sanghaie" 3 "ee sorokh" 4 "ee amady barro diouf" 5 "ee nghonine" 6 "ee ngayokheme" 7 "ee toucar 2" 8 "ee barry sine" 9 "ee sass ndiafadji" 10 "ee boure ngom" 11 "ee diakhao 4" 12 "ee ndioudiouf (ndiob)" 13 "ee ngouloul peulh" 14 "mbellacadio 2" 15 "ee mbotil coop" 16 "ee ouyal sande serere" 17 "ee sakhao" 18 "ee tene toubab" 19 "ee application" 20 "ee ngor ndame ndiaye ndiaye" 21 "ee poukham ndieme" 22 "ee baaye" 23 "ee boly" 24 "ee lambaye" 25 "ee keur oumar" 26 "ee keur yoro" 27 "ee lathilor ndong" 28 "ee djilor 2" 29 "ee keur mor diop" 30 "ee pethie" 31 "ee mbam 1" 32 "ee mbam 2" 33 "ee thiare" 34 "ee gague mody" 35 "ee mbassis 2" 36 "ee ndiomborel" 37 "keur mamadou fatouma" 38 "ee babacar ndene diop" 39 "ee medina santhie" 40 "ee dianko mane" 41 "ee djinack bara" 42 "ee diacke samba" 43 "ee yalal diacke" 44 "ee lougol" 45 "ee ngambou" 46 "ee dara nguer" 47 "ee keur mboucki" 48 "ee keur magaye" 49 "ee ndiayene waly" 50 "ee goback" 51 "ee ndrame" 52 "ee segre secco" 53 "ee keur babou" 54 "ee ndiayene bagana" 55 "ee daga birame" 56 "ee ngouye" 57 "efa ndiamacolong" 58 "ee birkelane 4" 59 "ee el h. thiendella fall" 60 "ee diamaguene tp" 61 "ee kaffrine 2 sud" 62 "efa diamaguene tp" 63 "ee de kathiote" 64 "ee elhadji ndene diodio ndiaye" 65 "ee kaffrine 10" 66 "ee kaffrine 6" 67 "ee elhadji aliou fana cisse" 68 "ee kelimane gouye" 69 "ee medina kebe" 70 "efa touba saloum" 71 "efa boulel" 72 "ee boucar diouf" 73 "ee diouthnguel" 74 "ee kheinde" 75 "ee lanel" 76 "ee elhadji andala wilane" 77 "ee kebemer 9" 78 "ee ndiaby fall" 79 "ee mbaye fatma kebe" 80 "ee ndande 4" 81 "ee niokhoul fall" 82 "ee ndande 3" 83 "ee ndiaye boumi" 84 "ee gade kebe" 85 "ee ndiawrigne mamousse" 86 "ee saly" 87 "ee thienaba seck" 88 "ee 3 wagons" 89 "ee angle islam" 90 "ee ngome" 91 "ee sidy alboury ndiaye" 92 "ee dahra montagne" 93 "ee lol lol" 94 "ee thiargny" 95 "ee linde" 96 "ee loumbal lana" 97 "ee niaka soringha" 98 "ee barkedji montagne" 99 "ee kamb" 100 "ee legne"

* Generate eco2 to eco100 variables
forvalues i = 2/100 {
    gen eco`i' = .
}

* Assign values based on your mapping
replace eco2  = 10  if School == 2      // ee boure ngom
replace eco3  = 12  if School == 3      // ee ndioudiouf (ndiob)
replace eco4  = 5   if School == 4      // ee nghonine
replace eco5  = 13  if School == 5      // ee ngouloul peulh
replace eco6  = 2   if School == 6      // ee sanghaie
replace eco7  = 3   if School == 7      // ee sorokh
replace eco8  = 18  if School == 8      // ee tene toubab
replace eco9  = 4   if School == 9      // ee amady barro diouf
replace eco10 = 19  if School == 10     // ee application

replace eco12 = 6   if School == 12     // ee ngayokheme
replace eco13 = 20  if School == 13     // ee ngor ndame ndiaye ndiaye
replace eco14 = 21  if School == 14     // ee poukham ndieme
replace eco15 = 7   if School == 15     // ee toucar 2
replace eco16 = 14  if School == 16     // mbellacadio 2
replace eco17 = 22  if School == 17     // ee baaye
replace eco18 = 23  if School == 18     // ee boly
replace eco19 = 24  if School == 19     // ee lambaye
replace eco20 = 31  if School == 20     // ee mbam 1
replace eco21 = 32  if School == 21     // ee mbam 2
replace eco22 = 36  if School == 22     // ee ndiomborel
replace eco23 = 33  if School == 23     // ee thiare
replace eco24 = 38  if School == 24     // ee babacar ndene diop
replace eco25 = 34  if School == 25     // ee gague mody
replace eco26 = 25  if School == 26     // ee keur oumar
replace eco27 = 26  if School == 27     // ee keur yoro
replace eco28 = 27  if School == 28     // ee lathilor ndong
replace eco29 = 35  if School == 29     // ee mbassis 2
replace eco30 = 39  if School == 30     // ee medina santhie
replace eco31 = 37  if School == 31     // keur mamadou fatouma
replace eco32 = 8   if School == 32     // ee barry sine
replace eco33 = 15  if School == 33     // ee mbotil coop
replace eco34 = 16  if School == 34     // ee ouyal sande serere
replace eco35 = 17  if School == 35     // ee sakhao
replace eco36 = 9   if School == 36     // ee sass ndiafadji
replace eco37 = 40  if School == 37     // ee dianko mane
replace eco38 = 28  if School == 38     // ee djilor 2
replace eco39 = 41  if School == 39     // ee djinack bara
replace eco40 = 29  if School == 40     // ee keur mor diop
replace eco41 = 30  if School == 41     // ee pethie

replace eco43 = 50  if School == 43     // ee goback

replace eco45 = 51  if School == 45     // ee ndrame
replace eco46 = 45  if School == 46     // ee ngambou
replace eco47 = 52  if School == 47     // ee segre secco
replace eco48 = 43  if School == 48     // ee yalal diacke
replace eco49 = 58  if School == 49     // ee birkelane 4
replace eco50 = 46  if School == 50     // ee dara nguer
replace eco51 = 59  if School == 51     // ee el h. thiendella fall
replace eco52 = 53  if School == 52     // ee keur babou
replace eco53 = 47  if School == 53     // ee keur mboucki

replace eco55 = 60  if School == 55     // ee diamaguene tp
replace eco56 = 61  if School == 56     // ee kaffrine 2 sud
replace eco57 = 68  if School == 57     // ee kelimane gouye
replace eco58 = 69  if School == 58     // ee medina kebe
replace eco59 = 62  if School == 59     // efa diamaguene tp
replace eco60 = 70  if School == 60     // efa touba saloum
replace eco61 = 63  if School == 61     // ee de kathiote
replace eco62 = 76  if School == 62     // ee elhadji andala wilane
replace eco63 = 64  if School == 63     // ee elhadji ndene diodio ndiaye
replace eco64 = 65  if School == 64     // ee kaffrine 10
replace eco65 = 66  if School == 65     // ee kaffrine 6
replace eco66 = 71  if School == 66     // efa boulel
replace eco67 = 55  if School == 67     // ee daga birame
replace eco68 = 48  if School == 68     // ee keur magaye
replace eco69 = 49  if School == 69     // ee ndiayene waly
replace eco70 = 56  if School == 70     // ee ngouye
replace eco71 = 57  if School == 71     // efa ndiamacolong

replace eco74 = 67  if School == 74     // ee elhadji aliou fana cisse
replace eco75 = 74  if School == 75     // ee kheinde
replace eco76 = 75  if School == 76     // ee lanel

replace eco78 = 80  if School == 78     // ee ndande 4
replace eco79 = 78  if School == 79     // ee ndiaby fall
replace eco80 = 84  if School == 80     // ee gade kebe
replace eco81 = 79  if School == 81     // ee mbaye fatma kebe
replace eco82 = 81  if School == 82     // ee niokhoul fall
replace eco83 = 88  if School == 83     // ee 3 wagons
replace eco84 = 93  if School == 84     // ee lol lol
replace eco85 = 96  if School == 85     // ee loumbal lana
replace eco86 = 97  if School == 86     // ee niaka soringha
replace eco87 = 89  if School == 87     // ee angle islam
replace eco88 = 98  if School == 88     // ee barkedji montagne
replace eco89 = 99  if School == 89     // ee kamb
replace eco90 = 94  if School == 90     // ee thiargny
replace eco91 = 82  if School == 91     // ee ndande 3
replace eco92 = 85  if School == 92     // ee ndiawrigne mamousse
replace eco93 = 83  if School == 93     // ee ndiaye boumi
replace eco94 = 86  if School == 94     // ee saly
replace eco95 = 87  if School == 95     // ee thienaba seck
replace eco96 = 100 if School == 96     // ee legne
replace eco97 = 95  if School == 97     // ee linde
replace eco98 = 90  if School == 98     // ee ngome
replace eco99 = 91  if School == 99     // ee sidy alboury ndiaye
replace eco100 = 92 if School == 100    // ee dahra montagne

* Calculate row total of all eco variables
egen eco_total = rowtotal(eco2-eco100)

replace School = eco_total
drop eco2-eco100 eco_total

lab values School sch

*Group
lab def grp 1 "Traitement" 2 "Comparaison"

gen grppp1 = Group

replace Group = 2 if grppp1 == 1
replace Group = 1 if grppp1 == 2

lab values Group grp

*Language
lab define lan 1"French" 2 "Wolof" 3 "Serer" 4"Pulaar"

gen lan1 =  Language

replace Language = 2 if lan1 == 1
replace Language = 3 if lan1 == 2
replace Language = 4 if lan1 == 3

lab values Language lan







