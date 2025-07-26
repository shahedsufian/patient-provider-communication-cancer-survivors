version 19.5 // Specifies Stata version compatibility

clear all     // Clears memory, good practice at start
set more off  // Prevents Stata from pausing output

* --- Load the Dataset ---
// If Working from ACHI desktop
use "D:\SS_dissertation\Data sets\PPC_hrqol.dta"

* --- Load the Dataset ---
// If Working from personal laptop
use "D:\UAMS\Dissertation\Data sets\PPC_hrqol.dta"

************************************************************************
*-----------------------------------------------------------*
* Declare survey design
*-----------------------------------------------------------*
svyset VARPSU [pweight=CSAQWF], strata(VARSTR) singleunit(centered)

*-----------------------------------------------------------*
* Generate survey-weighted statistics
*-----------------------------------------------------------*

svy, over(YEAR): mean GPH_T_score // Displays Mean, Std. Err., N (Subpop. no. obs in header)
estat sd // Displays Survey-Weighted Standard Deviation for the means just computed

svy, over(YEAR): mean GMH_T_score // Displays Mean, Std. Err., N
estat sd // Displays Survey-Weighted Standard Deviation

svy: mean GPH_T_score // Displays Mean, Std. Err., N (Subpop. no. obs in header)
estat sd // Displays Survey-Weighted Standard Deviation for the means just computed

svy: mean GMH_T_score // Displays Mean, Std. Err., N
estat sd // Displays Survey-Weighted Standard Deviation

*-----------------------------------------------------------*
* Bivariate survey-weighted regressions for GPH_T_score
*-----------------------------------------------------------*
svy: regress GPH_T_score i.Composite_PPC_CAT
svy: regress GPH_T_score i.YEAR
svy: regress GPH_T_score ib3.Age_category
svy: regress GPH_T_score ib2.SEX
svy: regress GPH_T_score i.Marrital_status
svy: regress GPH_T_score ib2.RACETHX
svy: regress GPH_T_score ib3.Educat_WM
svy: regress GPH_T_score ib3.REGION
svy: regress GPH_T_score i.Income_status
svy: regress GPH_T_score ib2.Employment_status
svy: regress GPH_T_score ib2.Health_insurance_status
svy: regress GPH_T_score ib3.Comorbidities
svy: regress GPH_T_score ib2.Cancer_type_WM
svy: regress GPH_T_score ib3.Cancer_type_sex_WM
svy: regress GPH_T_score ib4.Cancer_tx_history_WM
svy: regress GPH_T_score ib2.Smoking_status_WM
svy: regress GPH_T_score i.Have_USC_Prov_WM

*-----------------------------------------------------------*
* 3) Bivariate survey-weighted regressions for GMH_T_score
*-----------------------------------------------------------*
svy: regress GMH_T_score i.Composite_PPC_CAT
svy: regress GMH_T_score i.YEAR
svy: regress GMH_T_score ib3.Age_category
svy: regress GMH_T_score ib2.SEX
svy: regress GMH_T_score i.Marrital_status
svy: regress GMH_T_score ib2.RACETHX
svy: regress GMH_T_score ib3.Educat_WM
svy: regress GMH_T_score ib3.REGION
svy: regress GMH_T_score i.Income_status
svy: regress GMH_T_score ib2.Employment_status
svy: regress GMH_T_score ib2.Health_insurance_status
svy: regress GMH_T_score ib3.Comorbidities
svy: regress GMH_T_score ib2.Cancer_type_WM
svy: regress GMH_T_score b4.Cancer_type_sex_WM
svy: regress GMH_T_score ib4.Cancer_tx_history_WM
svy: regress GMH_T_score ib2.Smoking_status_WM
svy: regress GMH_T_score i.Have_USC_Prov_WM

* Bivariate survey‐weighted GLM for GPH_T_score
svy: glm GPH_T_score i.YEAR, ///
     family(gaussian) link(identity)

* Bivariate survey‐weighted GLM for GMH_T_score
svy: glm GMH_T_score i.YEAR, ///
     family(gaussian) link(identity)
	 
*-----------------------------------------------------------*
* 2) Multivariable survey‐weighted GLM for GPH_T_score
*    (Gaussian family, identity link = linear regression)
*-----------------------------------------------------------*
svy: glm GPH_T_score i.Composite_PPC_CAT i.YEAR ib3.Age_category i.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION i.Income_status ib2.Health_insurance_status ib3.Comorbidities ib3.Cancer_type_sex_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM i.Have_USC_Prov_WM, family(gaussian) link(identity)

*-----------------------------------------------------------*
* 3) Multivariable survey‐weighted GLM for GMH_T_score
*-----------------------------------------------------------*
svy: glm GMH_T_score i.Composite_PPC_CAT i.YEAR ib3.Age_category i.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION i.Income_status ib2.Health_insurance_status ib3.Comorbidities ib3.Cancer_type_sex_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM i.Have_USC_Prov_WM, family(gaussian) link(identity)

*-----------------------------------------------------------*
* Interpretation:
*
* • Each coefficient for Medium and High in Composite_PPC_CAT
*   is the **adjusted mean difference** in T-score versus the Low
*   group, holding all listed covariates constant.
*
* • A positive coefficient (e.g. 2.3 for High) means that, after 
*   adjustment, survivors with High communication quality 
*   score on average 2.3 points higher on the T-score than those 
*   with Low quality (the reference).
*
* • The continuous covariates' coefficients are interpreted 
*   similarly: a coefficient of –1.5 for Comorbidities=1 means 
*   survivors with one comorbidity score 1.5 points lower on
*   average than those with zero.
*
* • The overall Wald χ² (and its p-value) tests whether, jointly,
*   all levels of a categorical predictor differ from the reference.
*
* • No R² is shown by default for svy: glm; you can add
*   `estat gof` afterward if you wish a pseudo-R².
*-----------------------------------------------------------*

svy: glm GPH_T_score i.Composite_PPC_CAT##ib2.RACETHX i.YEAR ib3.Age_category i.Marrital_status ib3.Educat_WM ib3.REGION i.Income_status ib2.Health_insurance_status ib3.Comorbidities ib3.Cancer_type_sex_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM i.Have_USC_Prov_WM, family(gaussian) link(identity)

* 1) Estimated mean GPH by communication × race:
margins RACETHX#Composite_PPC_CAT

* 2) Test whether the effect of communication differs by race:
margins, dydx(Composite_PPC_CAT) at(RACETHX=(1 2 3 4 5))  // replace (1 2 3) with your race codes

margins RACETHX, dydx(Composite_PPC_CAT)

svy: glm GMH_T_score i.Composite_PPC_CAT##ib2.RACETHX i.YEAR ib3.Age_category i.Marrital_status ib3.Educat_WM ib3.REGION i.Income_status ib2.Health_insurance_status ib3.Comorbidities ib3.Cancer_type_sex_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM i.Have_USC_Prov_WM, family(gaussian) link(identity)


