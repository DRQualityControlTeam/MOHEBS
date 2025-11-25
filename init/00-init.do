*----------------------------------------------------------------------------------------------------*
*	   MOHEBS Set up do file to run the quality control:
*----------------------------------------------------------------------------------------------------*
global suser = c(username)

clear all
set more off
set maxvar 10000
set seed 71195642
set sortseed 11041955

*Supervisor
* Okuda Pascal
if (inlist("${suser}","okuda")) {	
	*Local directory of your checked out copy of the code
	local swdLocal = ""
	*Directory where the Data folder can be located
	local sdwBox = ""

}
 
*QC Staff Executor
* Olang castro
else if (inlist("${suser}", "Oyoo")) {
	*Local directory of your checked out copy of the code
	local swdLocal = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS"
	*Directory where the Data folder can be located
	local sdwBox = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Data"
}

*Other team stand by Collaborator
*Alvin
else if (inlist("${suser}", "user")) {
	local swdLocal = ""
	local sdwBox = ""
}

*Naomi
else if (inlist("${suser}", "user")) {
	local swdLocal = ""
	local sdwBox = ""
}

*Client set up - optional
else if (inlist("${suser}", "")) {
	local swdLocal = ""
	local sdwBox = ""
}	
else {
	di as error "Configure work environment in init.do before running the code."
	error 1
}


* Define filepaths to your main Folders.
global gsdCode = "`swdLocal'\Codes"
global gsdData = "`sdwBox'"
global gsdQChecks = "`swdLocal'\Quality Control Checks"
global gsdProgress = "`swdLocal'\Progress"
*----------------------------------------------------------------------------------------------------*

*if needed install the necessary commands
local commands = "spmap shp2dta aaplot bimap confirmdir"

foreach c of local commands {
	qui capture which `c'
	qui if _rc!=0 {
		noisily di "This command requires '`c''. The package will now be downloaded and installed."
		ssc install `c'
	}
}

macro list

*If needed, install the directories and packages used in the process
confirmdir  "`swdLocal'/Data"
scalar define n_data=_rc
confirmdir "`swdLocal'/Codes"
scalar define n_code=_rc
confirmdir "`swdLocal'/Open ends"
scalar define n_open=_rc
confirmdir "`swdLocal'/Progress"
scalar define n_progress=_rc
confirmdir "`swdLocal'/Quality Control Checks"
scalar define n_qc=_rc
confirmdir "`swdLocal'/Tools"
scalar define n_tools=_rc

confirmdir "`swdLocal'/Tools"
scalar define n_tools=_rc
// confirmdir "`swdLocal'/Documents"
// scalar define n_documents=_rc
di n_data
scalar define check=n_data+n_code+n_open+n_progress +n_qc +n_tools
di check

// Main directories
capture mkdir "${gsdData}"
capture mkdir "${gsdData}/Raw"
capture mkdir "${gsdData}/Processed"
capture mkdir "${gsdData}/Clean"

// Main directories
capture mkdir "${gsdProgress}"
capture mkdir "${gsdProgress}/Main"
capture mkdir "${gsdProgress}/Pilot"

// Main directories
capture mkdir "${gsdCode}"
capture mkdir "${gsdCode}/Acumen-Project/Cleaning do file"
capture mkdir "${gsdCode}/Acumen-Project/Daily update SPSS"
capture mkdir "${gsdCode}/Acumen-Project/Set up do file"

*Creating to the folders for main pilot and test data.

 // Raw subfolders
 foreach f in Raw Processed Clean{
	capture mkdir "${gsdData}/`f'/Main"
	capture mkdir "${gsdData}/`f'/Pilot"
	capture mkdir "${gsdData}/`f'/Test"
	}
*----------------------------------------------------------------------------------------------------*