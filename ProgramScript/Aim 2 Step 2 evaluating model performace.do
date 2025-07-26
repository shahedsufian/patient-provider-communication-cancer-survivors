clear all
set more off
use "D:\SS_dissertation\Data sets\ppc_cat_nm.dta"

global controls "i.YEAR ib3.Age_category ib2.SEX i.Marrital_status ib2.RACETHX ib3.Educat_WM ib3.REGION i.Income_status ib2.Employment_status ib2.Health_insurance_status ib3.Comorbidities ib2.Cancer_type_WM ib4.Cancer_tx_history_WM i.MNHLTH31_PER_MENTAL_HEALTH_STAT i.RTHLTH31_PER_HEALTH_STAT ib2.Smoking_status_WM i.Have_USC_Prov_WM"

//**************************************************************
// AIC/BIC Comparison Among Three Models
//**************************************************************

// Unweighted Plain Poisson
poisson Home_health_days i.Composite_PPC_CAT $controls if Home_health_days != -9
scalar ll_poisson = e(ll)
scalar k_poisson  = e(df_m) + 1 // +1 for the constant if not in df_m, or for dispersion if estimated
                                 // For poisson, df_m is usually number of predictors. k should be #coeffs.
scalar k_poisson = e(k)          // e(k) is number of parameters (coefficients + ancillary)
scalar N_sample   = e(N)         // Use a consistent N for all BIC calculations
scalar AIC_poisson = -2*ll_poisson + 2*k_poisson
scalar BIC_poisson = -2*ll_poisson + ln(N_sample)*k_poisson
display as text "Unweighted Poisson: AIC = " %9.2f AIC_poisson ", BIC = " %9.2f BIC_poisson
estimates store unweighted_poisson

// Unweighted Plain NB (NB2 by default)
nbreg Home_health_days i.Composite_PPC_CAT $controls if Home_health_days != -9
scalar ll_NB  = e(ll)
scalar k_NB   = e(k) // Number of parameters including /lnalpha
scalar AIC_NB = -2*ll_NB + 2*k_NB
scalar BIC_NB = -2*ll_NB + ln(N_sample)*k_NB
display as text "Unweighted NB:      AIC = " %9.2f AIC_NB ",      BIC = " %9.2f BIC_NB
estimates store unweighted_NB

// Unweighted Two-Part (Hurdle) Model - Logistic + Truncated NB
// Create the binary dependent variable for the first part
capture drop pos_visits
gen byte pos_visits = (Home_health_days > 0 & Home_health_days != -9) if !missing(Home_health_days)
label var pos_visits "Had any office visits (1=Yes, 0=No)"

// Logistic part (Unweighted)
logit pos_visits i.Composite_PPC_CAT $controls if Home_health_days != -9
scalar ll_log = e(ll)
scalar k_log  = e(k) // Number of parameters in logit

// Truncated NB part on positives (Unweighted)
// Using tnbreg for the second part of the hurdle.
tnbreg Home_health_days i.Composite_PPC_CAT $controls if pos_visits == 1 & Home_health_days != -9, ll(0)
scalar ll_truncNB = e(ll)
scalar k_truncNB  = e(k) // Number of parameters in tnbreg (including /lnalpha)

// Combine for hurdle AIC/BIC (use full-sample N from one of the base models for BIC consistency)
scalar ll_HUR_NB  = ll_log + ll_truncNB
scalar k_HUR_NB   = k_log  + k_truncNB // Sum of parameters from distinct models
scalar AIC_HUR_NB = -2*ll_HUR_NB + 2*k_HUR_NB
scalar BIC_HUR_NB = -2*ll_HUR_NB + ln(N_sample)*k_HUR_NB
display as text "Unweighted Hurdle NB: AIC = " %9.2f AIC_HUR_NB ", BIC = " %9.2f BIC_HUR_NB

// AIC/BIC Comparison Table
matrix stats_AIC_BIC = (AIC_poisson, BIC_poisson \ ///
                        AIC_NB,      BIC_NB      \ ///
                        AIC_HUR_NB,  BIC_HUR_NB)
matrix rownames stats_AIC_BIC = Poisson NB HurdleNB
matrix colnames stats_AIC_BIC = AIC BIC

display _newline as text _col(20) "--- AIC/BIC Comparison Table ---"
matrix list stats_AIC_BIC
