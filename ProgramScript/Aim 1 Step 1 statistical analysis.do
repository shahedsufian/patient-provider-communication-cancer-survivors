version 19.5 // Specifies Stata version compatibility

clear all     // Clears memory, good practice at start
set more off  // Prevents Stata from pausing output

* --- Load the Dataset ---
// If Working from personal laptop
use "D:\UAMS\Dissertation\Data sets\PPC_aim1_w65.dta"

ssc install rdrobust
rdrobust Composite_PPC_wDR Age, c(65)

// The Imbens–Kalyanaraman bandwidth‐selection informs 7 years as the 
// bandwidth. 58 ≤ Age ≤ 64 AND 66 ≤ Age ≤ 72

* Create dichotomous health insurance status variable
gen byte Health_insurance_status_b = cond(inlist(Health_insurance_status,1,2,3), 1, 0)

* drop exact age 65
keep if Age != 65

* save the new dataset
save "PPC_aim1_wo65.dta", replace

* Load data & define age group
use "PPC_aim1_wo65.dta", clear
	gen byte rd_group = .
replace rd_group = 0 if inrange(Age,58,64)
replace rd_group = 1 if inrange(Age,66,72)
keep if rd_group==0 | rd_group==1 //n=795

* Survey design
svyset VARPSU [pweight=CSAQWF], strata(VARSTR) singleunit(centered)

* PART 1: Survey-Weighted Unadjusted Percentages/Scores by rd_group (58-64 vs 66-72)

svy: tab SEX rd_group, col se ci
svy: tab Employment_status rd_group if Employment_status != 3, col se ci

svy: mean Composite_PPC_wDR, over(rd_group)

// Prepare variables for RD analysis (Parts 2 and 3)
// Running variable centered at the cutoff
gen age_centered = Age - 65
// Quadratic term for age_centered
gen age_centered_sq = age_centered^2

//-------------------------------------------------------------------------------
// PART 2: Unadjusted Regression Discontinuity Estimates (Covariate Balance)
//-------------------------------------------------------------------------------

// --- For Primary Outcomes (as unadjusted RD) ---
// Health_insurance_status_b quadratic age trend (already 0=uninsured, 1=insured)
// svy, subpop(if rd_group != .): reg Health_insurance_status_b i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

// Global Linear Trend (using your full 7-year bandwidth on each side) allowing different slopes on both sides of the cutoff
// svy, subpop(if rd_group != .): reg Health_insurance_status_b i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered

// svy, subpop(if rd_group != .): reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered


// Linear age trend is parallel on both sides of the cutoff
svy: reg Health_insurance_status_b i.Medicare_eligibility c.age_centered

svy: reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered

// --- For Binary Covariates (e.g., SEX) ---

gen byte is_female = (SEX == 2) if SEX != . // Dummy for female
gen byte is_male = (SEX == 1) if SEX != .   // Dummy for male

// svy, subpop(if rd_group != .): reg is_female i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered

svy: reg is_female i.Medicare_eligibility c.age_centered

gen byte is_married = ( Marrital_status== 1) if Marrital_status != . 
gen byte is_nmarried = (Marrital_status == 2) if Marrital_status != . 

// svy, subpop(if rd_group != .): reg is_nmarried i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered

svy: reg is_nmarried i.Medicare_eligibility c.age_centered

// --- For Multi-Category Covariates (checking balance for each category) ---
tabulate Smoking_status_WM, generate(smkn_cat) // Creates inc_cat1, inc_cat2, etc.

svy: reg smkn_cat3 i.Medicare_eligibility c.age_centered

svy: reg emp_cat2 i.Medicare_eligibility c.age_centered if Employment_status != 3

// PART 3: Adjusted Parametric RD Estimates with LINEAR Age Trend
svy: reg Health_insurance_status_b i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib2.Employment_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99
	
svy: reg Health_insurance_status_b i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99
	
svy: reg Health_insurance_status_b i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    c.age_centered_sq i.Medicare_eligibility#c.age_centered_sq ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99



svy: reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib2.Employment_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99
	
svy: reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99

svy: reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    c.age_centered_sq i.Medicare_eligibility#c.age_centered_sq ib2.SEX ib1.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION ib1.Income_status ib3.Comorbidities ///
    ib2.Cancer_type_WM ib4.Cancer_tx_history_WM ib2.Smoking_status_WM if Educat_WM != 99

	
svy, subpop(if rd_group != .): reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered i.Medicare_eligibility#c.age_centered ///
    i.SEX i.Marrital_status i.RACETHX i.Educat_WM i.REGION i.Income_status i.Employment_status i.Comorbidities ///
    i.Cancer_type_WM i.Cancer_tx_history_WM i.Smoking_status_WM i.Have_USC_Prov_WM


display ""
display "Unadjusted RD for: Composite_PPC_wDR"
svy, subpop(if rd_group != .): reg Composite_PPC_wDR i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

// --- For Binary Covariates (e.g., SEX) ---
// SEX is coded 1=male, 2=female. Create dummies for each category to report.
gen byte is_female = (SEX == 2) if SEX != .
gen byte is_male = (SEX == 1) if SEX != .

display ""
display "Unadjusted RD for: Proportion Female (is_female)"
svy, subpop(if rd_group != .): reg is_female i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

display ""
display "Unadjusted RD for: Proportion Male (is_male)"
svy, subpop(if rd_group != .): reg is_male i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

// --- For Multi-Category Covariates (checking balance for each category) ---
// Example for Income_status
display ""
display "Creating dummy variables for Income_status categories..."
tabulate Income_status, generate(inc_cat) // Creates inc_cat1, inc_cat2, etc.

// You need to know how many categories 'inc_cat#' were created. Let's assume 4.
display ""
display "Unadjusted RD for: Income_status Category 1 (inc_cat1)"
svy, subpop(if rd_group != .): reg inc_cat1 i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

display ""
display "Unadjusted RD for: Income_status Category 2 (inc_cat2)"
svy, subpop(if rd_group != .): reg inc_cat2 i.Medicare_eligibility c.age_centered c.age_centered_sq i.Medicare_eligibility#c.age_centered i.Medicare_eligibility#c.age_centered_sq

// ... (repeat for inc_cat3, inc_cat4, etc., for all categories of Income_status)

display ""
display ">>> IMPORTANT FOR PART 2: For EACH variable you want to check for balance:"
display ">>> 1. If it's already 0/1 representing the category of interest (like Health_insurance_status_b),"
display ">>>    use it directly as the outcome in the RD regression."
display ">>> 2. If it's binary but not 0/1 (like SEX=1/2), or if you want to report for each of the two categories,"
display ">>>    create 0/1 dummies for each category (e.g., is_male, is_female) and run RD on each."
display ">>> 3. For multi-category variables (Marrital_status, RACETHX, Educat_WM, etc.), use"
display ">>>    `tabulate VARIABLE, generate(PREFIX)` to create dummies for all its categories."
display ">>>    Then, run the RD regression with EACH generated dummy (PREFIX1, PREFIX2, etc.) as the outcome."

// (Part 3 code would follow as previously outlined, using appropriate covariates
//  which can include these original or dummied characteristics)


* example for Health_insurance_status_b
gen byte his_b = (Health_insurance_status_b==1)
svy: regress his_b rd_group

svy: regress Composite_PPC_wDR rd_group



* 3) Adjusted comparison (average block difference)
svy: regress Composite_PPC_wDR rd_group i.SEX i.Marrital_status i.RACETHX i.Educat_WM i.REGION i.Income_status i.Employment_status i.Health_insurance_status i.Comorbidities i.Cancer_type_WM i.Cancer_tx_history_WM i.Smoking_status_WM i.Have_USC_Prov_WM i.YEAR

* 4) Parametric RD with quadratic age trend
gen cAge = Age - 65
svy: regress Composite_PPC_wDR rd_group cAge cAge#cAge rd_group#cAge rd_group#cAge#cAge i.SEX i.Marrital_status i.RACETHX i.Educat_WM i.REGION i.Income_status i.Employment_status i.Health_insurance_status i.Comorbidities i.Cancer_type_WM i.Cancer_tx_history_WM i.Smoking_status_WM i.Have_USC_Prov_WM i.YEAR