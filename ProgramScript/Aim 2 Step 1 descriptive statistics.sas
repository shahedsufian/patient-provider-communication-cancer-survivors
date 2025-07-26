/*Use the following file path while working on ACHI desktop*/
libname phdtheis v8 "D:\SS_dissertation\Data sets";

proc contents data=phdtheis.PPC_cat_MC;
run;

proc format;

  value agefmt
    . = "Missing"  /* Label for missing */
    1 = "18-44"
    2 = "45-64"
    3 = "65+";

  value sexfmt
    . = "Missing"  /* Label for missing */
    1 = "Male"
    2 = "Female";

  value racefmt /* Format for RACETHX */
    . = "Missing"
   -8 = "Missing" /* DK */
   -1 = "Missing" /* Inapplicable */
    1 = "Hispanic"
    2 = "non-Hispanic White only"
    3 = "non-Hispanic Black only"
    4 = "non-Hispanic Asian only"
    5 = "non-Hispanic other or multiple race";

  value rgonfmt /* Format for REGION */
     . = "Missing"
    -1 = "Missing" /* Inapplicable */
     1 = "NORTHEAST"
     2 = "MIDWEST"
     3 = "SOUTH"
     4 = "WEST";

  value pvtpfmt /* Format for PROVTY42_PROVIDER_TYPE */
     . = "Missing"
    -1 = "Missing" /* Inapplicable */
     1 = "Facility"
     2 = "Person"
     3 = "Person in facility provider";

  /* --- New Formats --- */
  value mcrfmt
    . = "Missing"  /* Label for missing */
    0 = "Not Eligible (Under 65)"
    1 = "Eligible (65+)";

  value marryfmt /* Format for Marrital_status */
    . = "Missing"  /* Label for missing */
    1 = "Currently married"
    2 = "Not married";

  value incmfmt /* Format for Income_status */
    . = "Missing"  /* Label for missing */
    1 = "Low"
    2 = "Middle"
    3 = "High";

  value emplyfmt /* Format for Employment_status */
    . = "Missing"  /* Label for missing */
    1 = "Employed"
    2 = "Not Employed"
    3 = "Missing"; /* Category 3 represents Missing/Other */

  value cmrbdfmt /* Format for Comorbidities */
    . = "Missing"  /* Label for missing */
    0 = "0"
    1 = "1"
    2 = "2"
    3 = "3+";

  value visitfmt /* Format for Officevisits_12m */
    . = "Missing"  /* Label for missing */
    1 = "Zero visits"
    2 = "1-3 visits"
    3 = "4+ visits";

  value tpprvfmt /* Format for TYPE_OF_PROVIDER */
    . = "Missing"  /* Label for missing */
    1 = "MD-general or internal med"
    2 = "Other MD"
    3 = "Nurse, phy’s assistant, and others";


  value ppcfmt
    . = "Missing" /* Handle missing */
    1 = "Low"     /* Tertile 1 */
    2 = "Medium"  /* Tertile 2 */
    3 = "High";   /* Tertile 3 */

/* Format for new Educat_WM variable */
  value eduwm
    . = "Missing (Technical)" /* Should not occur if logic is right */
    1 = "Less than high school"
    2 = "High school graduate"
    3 = "Some college or higher"
    99 = "Missing Educat Data"; /* New category for originally missing */

  /* Format for new Cancer_type_WM variable */
  value ctypwm
    . = "Missing (Technical)"
    1 = "Multiple"
    2 = "Female Breast"
    3 = "Colorectal"
    4 = "Prostate"
    5 = "Melanoma"
    6 = "Cervical"
    7 = "Uterine"
    8 = "Other"
    99 = "Missing Cancer Type";

  /* Format for new Cancer_type_sex_WM variable */
  value ctsxwm
    . = "Missing (Technical)"
    1 = "Prostate cancer only"
    2 = "Male other"
    3 = "Female breast cancer only"
    4 = "Female other"
    99 = "Missing Cancer Type Sex";

  /* Format for new Cancer_tx_history_WM variable */
  value ctxhwm
    . = "Missing (Technical)"
    1 = "On treatment"
    2 = "<5 years ago"
    3 = "5 to <10 years ago"
    4 = "10+ years ago"
    5 = "Never treated"
    99 = "Missing Cancer Tx History";

  /* Format for new Smoking_status_WM variable */
  value smkwm
    . = "Missing (Technical)"
    1 = "Current smoker"
    2 = "Non-current smoker"
    99 = "Missing Smoking Status";

  /* Format for new Have_USC_Prov_WM variable */
  value ynwm
    . = "Missing (Technical)"
    1 = "Yes"
    2 = "No"
    99 = "Missing USC Prov Status";

  /* Redefined Format for MNHLTH31/RTHLTH31 to handle missing/DK */
  /* Used after imputation */
  value hstatfmt
     . = "Missing"
    -9 = "Missing" /* Refused */
    -8 = "Missing" /* Don't Know */
    -1 = "Missing" /* Inapplicable */
     1 = "Excellent"
     2 = "Very good"
     3 = "Good"
     4 = "Fair"
     5 = "Poor";

  value insfmt
    . = "Missing" /* Label for missing - consistent with previous request */
    1 = "Any private"
    2 = "Medicare"
    3 = "Other public"
    4 = "Uninsured";

run;

data phdtheis.PPC_cat_MC;
	set phdtheis.PPC_cat_MC;
  	format
	    Medicare_eligibility mcrfmt.
	    Age_category agefmt.
	    SEX sexfmt.
	    Marrital_status marryfmt. /* Format for the new marital category variable */
	    RACETHX racefmt. /* Format existing variable */
	    REGION rgonfmt. /* Format existing variable */
	    Income_status incmfmt.
	    Employment_status emplyfmt.
	    Comorbidities cmrbdfmt.
	    Officevisits_12m visitfmt.
	    PROVTY42_PROVIDER_TYPE pvtpfmt. /* Format existing variable */
	    TYPE_OF_PROVIDER tpprvfmt.
		Composite_PPC_CAT 		ppcfmt.
	    Educat_WM               eduwm.
	    Cancer_type_WM          ctypwm.
	    Cancer_type_sex_WM      ctsxwm.
	    Cancer_tx_history_WM    ctxhwm.
	    Smoking_status_WM       smkwm.
	    Have_USC_Prov_WM        ynwm.
	    MNHLTH31_PER_MENTAL_HEALTH_STAT hstatfmt. /* Apply updated format */
	    RTHLTH31_PER_HEALTH_STAT        hstatfmt. /* Apply updated format */
		Health_insurance_status insfmt.
	    ;
run;

* --- Generate sample frequency and unweighted percentage --- ;
proc freq data=phdtheis.PPC_cat_MC;
  where Educat_WM ne 99 and Employment_status ne 3;
  tables Composite_PPC_CAT Year FOLLOWUP_CARE_b SIDE_EFFECTS_b EMOSOC_NEEDS_b DISCUSS_LIFESTYLE_b 
	/*Medicare_eligibility*/ Age_category SEX Marrital_status 
	RACETHX Educat_WM REGION Income_status Employment_status Health_insurance_status Comorbidities 
	Cancer_type_WM Cancer_tx_history_WM MNHLTH31_PER_MENTAL_HEALTH_STAT 
	RTHLTH31_PER_HEALTH_STAT Smoking_status_WM Have_USC_Prov_WM 
	/ missing missprint nocum; /* Use MISSING option */
run;

* --- Generate sample frequency and survey-weighted percentage --- ;
* --- Define Input Dataset and Variable List --- ;
%let input_ds = phdtheis.PPC_cat_MC; /* Your SAS dataset */
%let vars_for_freq =
    Composite_PPC_CAT Year FOLLOWUP_CARE_b SIDE_EFFECTS_b 
	EMOSOC_NEEDS_b DISCUSS_LIFESTYLE_b CMCFUP31_DISCUSS_FOLLOWUP_CARE 
	CMCEFF31_DISCUSS_SIDE_EFFECTS CMCPSY31_DISCUSS_EMOSOC_NEEDS 
	CMCSTY31_DISCUSS_LIFESTYLE Age_category SEX Marrital_status
    RACETHX Educat_WM REGION Income_status Employment_status
    Health_insurance_status Comorbidities Cancer_type_WM
    Cancer_tx_history_WM MNHLTH31_PER_MENTAL_HEALTH_STAT
    RTHLTH31_PER_HEALTH_STAT Smoking_status_WM Have_USC_Prov_WM;

* --- Calculate Sample Frequencies and Survey-Weighted Percentages --- ;
proc surveyfreq data=&input_ds. nosummary; /* nosummary suppresses overall survey design summary */
  where Educat_WM ne 99 and Employment_status ne 3;
  /* Specify Survey Design Parameters */
  weight CSAQWF;      /* Weight variable */
  strata VARSTR;      /* Stratification variable */
  cluster VARPSU;     /* Primary Sampling Unit (PSU) / Cluster variable */

  /* List variables for which frequencies are needed */
  /* This will produce a separate table for each variable */
  tables &vars_for_freq.;

  title "Sample Frequencies and Survey-Weighted Percentages";
run;
title; /* Clear title */

*-------------------------------------------------------------------------------;
* Perform Survey-Weighted Chi-Square Tests                            *;
*-------------------------------------------------------------------------------;

/* Set a title for the output */
title "Survey-Weighted Chi-Square Tests: Covariate Distribution by Composite_PPC_CAT Tertiles";

/* Use PROC SURVEYFREQ for survey-adjusted cross-tabulations and tests */
proc surveyfreq data=phdtheis.ppc_cat_mc; /* Replace work.ppc_cat_mc if using a permanent dataset */

  	where Educat_WM ne 99 and Employment_status ne 3;
 
    /* Specify survey design variables */
    weight CSAQWF;     /* Weight variable */
    strata VARSTR;     /* Stratification variable */
    cluster VARPSU;    /* Primary Sampling Unit (PSU) / Cluster variable */

    /* Specify the cross-tabulations to generate */
    /* Composite_PPC_CAT is the row variable */
    /* The list in parentheses contains the column variables */
    tables DISCUSS_LIFESTYLE_b * (
             Year
             Age_category
             SEX
             Marrital_status
             RACETHX
             Educat_WM
             REGION
             Income_status
             Employment_status
             Health_insurance_status
             Comorbidities
             Cancer_type_WM
             Cancer_tx_history_WM
             MNHLTH31_PER_MENTAL_HEALTH_STAT
             RTHLTH31_PER_HEALTH_STAT
             Smoking_status_WM
             Have_USC_Prov_WM
           ) / 
           chisq     /* Request Rao-Scott chi-square test (design-adjusted) */
           row       /*for each level of Composite_PPC_CAT (low/medium/high), shows the distribution of the covariate levels summing to 100%. */
		   col		 /*for each level of the covariate (e.g. Male vs. Female), shows the distribution of Composite_PPC_CAT summing to 100%. */
           cv        /* Optional: Request Coefficient of Variation for estimates */
           /* Use CHISQ(MODIFIED) for explicit second-order correction if needed, default usually good */
           ; 
run;

/* Clear the title */
title;


* --- Generate statistics and plots for utilization variables --- ;
proc univariate data=phdtheis.PPC_cat_MC plots; /* 'plots' generates histograms & other plots */

  	where Educat_WM ne 99 and Employment_status ne 3;

  /* List the utilization variables */
  var Outpatient_visits
      Office_visits
      IP_nights
      ER_visits
	  Home_health_days
	  Rx_fills_refills
	  ;

  /* Create histograms for visual inspection */
  /* 'odstitle' helps label the plots clearly */
  histogram Outpatient_visits Office_visits IP_nights ER_visits Home_health_days Rx_fills_refills
      / odstitle = 'Frequency Distribution';

  /* Optional: Add inset for key stats directly on histogram */
  /* inset nmiss n mean var ('Variance') / pos=ne header='Summary Stats'; */
  /* Uncommenting 'inset' adds stats; might make plots busy */

  title "Distribution Analysis of Healthcare Utilization Variables";
run;
title; /* Clear title */

/* Example for one variable if UNIVARIATE isn't clear on zeros */
proc freq data=phdtheis.PPC_cat_MC;
  where Educat_WM ne 99 and Employment_status ne 3 /*and Home_health_days ne -9*/;
  tables Outpatient_visits/ nocum;
  title "Frequency Count for Outpatient_visits (Check Zeros)";
run;
title;

proc univariate data=phdtheis.PPC_cat_MC;
  where Educat_WM ne 99 and Employment_status ne 3;
  var ER_visits;
  histogram ER_visits
    / midpoints = 0 to 11 by 1
      odstitle   = "ER Visits Histogram"
      ;
run;


* --- Define Input SAS Dataset and Output Stata File Path --- ;

/* Specify the library and member name of your SAS dataset */
%let sas_lib = phdtheis;
%let sas_ds = PPC_cat_MC;

/* Specify the FULL PATH and desired FILENAME for the output Stata file !! */
%let stata_outfile_path = "D:\SS_dissertation\Data sets\ppc_cat_mc.dta";


* --- Export SAS Dataset to Stata Format --- ;
proc export data=&sas_lib..&sas_ds.
    outfile=&stata_outfile_path. /* Use the path defined above */
    dbms=STATA /* Specify Stata file type */
    replace; /* Optional: Overwrites the Stata file if it already exists */
run;

%put NOTE: Export complete. Stata file saved as &stata_outfile_path.;

/* Use PROC SURVEYMEANS to get weighted counts for a subpopulation */
PROC SURVEYMEANS DATA=phdtheis.PPC_cat_MC;
    /* Specify the survey design components */
    WEIGHT CSAQWF;
    STRATA VARSTR;
    CLUSTER VARPSU;

    /* Filter the data to include only observations with one or more outpatient visits */
    WHERE Outpatient_visits > 0 and Educat_WM ne 99 and Employment_status ne 3;
RUN;