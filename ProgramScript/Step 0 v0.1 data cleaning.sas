/*Use the following file path while working on laptop*/
libname phdtheis v8 "D:/UAMS/Dissertation/Data sets";

/*Use the following file path while working on ACHI desktop*/
libname phdtheis v8 "D:\SS_dissertation\Data sets";

/*Import the Full Year Consolidated Data Files to SAS*/
filename fycdf17 'D:/UAMS/Dissertation/Data sets/h201.ssp'; /*fycdf: Full Year Consolidated Data File, h201 is of 2017*/

proc cimport file=fycdf17 lib=phdtheis compress=char;
run;

filename fycdf16 'D:/UAMS/Dissertation/Data sets/h192.ssp'; /*h192 is of 2016*/

proc xcopy in=fycdf16 out=phdtheis import;
run;

filename fycdf11 'D:/UAMS/Dissertation/Data sets/h147.ssp'; /*h147 is of 2011*/

proc xcopy in=fycdf11 out=phdtheis import;
run;

/*Check distinct count of dupersid in each file*/
proc sql;
	select count(*) as n from (select distinct dupersid from phdtheis.h201); 
quit;/*31,880 individuals, 718 responded to the ECSS*/

proc sql;
	select count(*) as n from (select distinct dupersid from phdtheis.h192); 
quit;/*34,665 individuals, 1,236 responded to the ECSS*/

proc sql;
	select count(*) as n from (select distinct dupersid from phdtheis.h147); 
quit;/*35,313 individuals, 1,419 responded to the ECSS*/

/*Keep and rename required variables*/
data ecss17; /*718*/
  set phdtheis.h201;
  if CDIAG31 = 2;
  length YEAR 8.;
  YEAR = '2017';
  keep DUPERSID PANEL YEAR CCNRDI31 CDIAG31 AGE17X AGE31X AGE42X 
	AGE53X SEX GENDRP42 MARRY17X RACETHX HSPLAP42 WHITPR42 BLCKPR42 ASIANP42 NATAMP42 PACISP42 
	OTHRCP42 REGION17 REGION31 REGION42 REGION53 EDUCYR POVLEV17 POVCAT17 INSCOV17 INSURC17 PRVEV17 TRIEV17 MCDEV17 
	MCREV17 OPAEV17 OPBEV17 UNINS17 EMPST42 HIBPDX CHDDX ANGIDX MIDX OHRTDX STRKDX EMPHDX CHBRON31 
	CHOLDX DIABDX JTPAIN31 ARTHDX ASTHDX CANCERDX CABLADDR CABREAST CACERVIX CACOLON CALUNG 
	CALYMPH CAMELANO CAOTHER CAPROSTA CASKINDK CASKINNM CAUTERUS RTHLTH42 RTHLTH31 RTHLTH53 
	MNHLTH42 MNHLTH31 MNHLTH53 CTRTMT31 CLSTRT31 CBCK31 ADSMOK42 HAVEUS42 ADAPPT42 PROVTY42 
	PLCTYP42 TYPEPE42 LOCATN42 CMCFUP31 CMCEFF31 CMCPSY31 CMCSTY31 CMCOST31 CMCTRT31 OBTOTV17 OPTOTV17 ERTOT17 
	IPDIS17 IPNGTD17 RXTOT17 DVTOT17 HHTOTD17 CEFPHL31 CEFPAC31 CEFPIN31 CEFFTG31 CEFQLF31 CEFMHL31 
	CEFRLT31 CEFMPR31 ADLIST42 ADEXPL42 ADRESP42 ADPRTM42 TREATM42 DECIDE42 EXPLOP42 RESPCT42  
 	CFNDBT31 CFNVAC31 CFNPUR31 CFNSPD31 CFNSAV31 CFNLIV31 CFNOTH31 CFNUNB31 CFNBNK31 CFNPMT31 
	OTHLANG LANGSPK HWELLSPE PRVSPK42 CSAQW17F PERWT17F SAQWT17F VARSTR VARPSU;
  rename AGE17X=Age_yearend AGE31X=Age MARRY17X=Marrital_status 
	REGION17=REGION_yearend REGION31=REGION POVLEV17=POVLEV POVCAT17=POVCAT INSCOV17=INSCOV INSURC17=INSURC 
	PRVEV17=PRVEV TRIEV17=TRIEV MCDEV17=MCDEV MCREV17=MCREV OPAEV17=OPAEV OPBEV17=OPBEV UNINS17=UNINS
	OBTOTV17=Office_visits OPTOTV17=Outpatient_visits ERTOT17=ER_visits IPDIS17=IP_discharges 
	IPNGTD17=IP_nights RXTOT17=Rx_fills_refills DVTOT17=Dental_visits HHTOTD17=Home_health_days 
	CSAQW17F=CSAQWF PERWT17F=PERWTF SAQWT17F=SAQWTF;
run;

data ecss16; /*1,236*/
  set phdtheis.h192;
  if CDIAG31 = 2;
  length YEAR 8.;
  YEAR = '2016';
  keep DUPERSID PANEL YEAR CCNRDI31 CDIAG31 AGE16X AGE31X AGE42X 
	AGE53X SEX GENDRP42 MARRY16X RACETHX HSPLAP42 WHITPR42 BLCKPR42 ASIANP42 NATAMP42 PACISP42 
	OTHRCP42 REGION16 REGION31 REGION42 REGION53 EDUCYR POVLEV16 POVCAT16 INSCOV16 INSURC16 PRVEV16 TRIEV16 MCDEV16 
	MCREV16 OPAEV16 OPBEV16 UNINS16 EMPST42 HIBPDX CHDDX ANGIDX MIDX OHRTDX STRKDX EMPHDX CHBRON31 
	CHOLDX DIABDX JTPAIN31 ARTHDX ASTHDX CANCERDX CABLADDR CABREAST CACERVIX CACOLON CALUNG 
	CALYMPH CAMELANO CAOTHER CAPROSTA CASKINDK CASKINNM CAUTERUS RTHLTH42 RTHLTH31 RTHLTH53 
	MNHLTH42 MNHLTH31 MNHLTH53 CTRTMT31 CLSTRT31 CBCK31 ADSMOK42 HAVEUS42 ADAPPT42 PROVTY42 
	PLCTYP42 TYPEPE42 LOCATN42 CMCFUP31 CMCEFF31 CMCPSY31 CMCSTY31 CMCOST31 CMCTRT31 OBTOTV16 OPTOTV16 ERTOT16 
	IPDIS16 IPNGTD16 RXTOT16 DVTOT16 HHTOTD16 CEFPHL31 CEFPAC31 CEFPIN31 CEFFTG31 CEFQLF31 CEFMHL31 
	CEFRLT31 CEFMPR31 ADLIST42 ADEXPL42 ADRESP42 ADPRTM42 TREATM42 DECIDE42 EXPLOP42 RESPCT42  
 	CFNDBT31 CFNVAC31 CFNPUR31 CFNSPD31 CFNSAV31 CFNLIV31 CFNOTH31 CFNUNB31 CFNBNK31 CFNPMT31 
	OTHLANG LANGSPK HWELLSPE PRVSPK42 CSAQW16F PERWT16F SAQWT16F VARSTR VARPSU;
  rename AGE16X=Age_yearend AGE31X=Age MARRY16X=Marrital_status 
	REGION16=REGION_yearend REGION31=REGION POVLEV16=POVLEV POVCAT16=POVCAT INSCOV16=INSCOV INSURC16=INSURC 
	PRVEV16=PRVEV TRIEV16=TRIEV MCDEV16=MCDEV MCREV16=MCREV OPAEV16=OPAEV OPBEV16=OPBEV UNINS16=UNINS
	OBTOTV16=Office_visits OPTOTV16=Outpatient_visits ERTOT16=ER_visits IPDIS16=IP_discharges 
	IPNGTD16=IP_nights RXTOT16=Rx_fills_refills DVTOT16=Dental_visits HHTOTD16=Home_health_days 
	CSAQW16F=CSAQWF PERWT16F=PERWTF SAQWT16F=SAQWTF;
run;

data ecss11; /*1,419*/
  set phdtheis.h147;
  if CDIAG53 = 2;
  length YEAR 8.;
  YEAR = '2011';
  keep DUPERSID PANEL YEAR CCNRDI53 CDIAG53 AGE11X AGE31X AGE42X 
	AGE53X SEX GENDRP42 MARRY11X RACETHNX HSPLAP42 WHITPR42 BLCKPR42 ASIANP42 NATAMP42 PACISP42 
	OTHRCP42 REGION11 REGION31 REGION42 REGION53 EDUCYR POVLEV11 POVCAT11 INSCOV11 INSURC11 PRVEV11 TRIEV11 MCDEV11 
	MCREV11 OPAEV11 OPBEV11 UNINS11 EMPST42 HIBPDX CHDDX ANGIDX MIDX OHRTDX STRKDX EMPHDX CHBRON31 
	CHOLDX DIABDX JTPAIN31 ARTHDX ASTHDX CANCERDX CABLADDR CABREAST CACERVIX CACOLON CALUNG 
	CALYMPH CAMELANO CAOTHER CAPROSTA CASKINDK CASKINNM CAUTERUS RTHLTH42 RTHLTH31 RTHLTH53 
	MNHLTH42 MNHLTH31 MNHLTH53 CTRTMT53 CLSTRT53 CBCK53 ADSMOK42 HAVEUS42 ADAPPT42 PROVTY42 
	PLCTYP42 TYPEPE42 LOCATN42 CMCFUP53 CMCEFF53 CMCPSY53 CMCSTY53 OBTOTV11 OPTOTV11 ERTOT11 
	IPDIS11 IPNGTD11 RXTOT11 DVTOT11 HHTOTD11 ADLIST42 ADEXPL42 ADRESP42 ADPRTM42 TREATM42 DECIDE42 EXPLOP42 RESPCT42  
 	CFNDBT53 CFNSAC53 CFNUNB53 CFNBNK53 CFNPMT53 CSAQW11F PERWT11F SAQWT11F VARSTR VARPSU;
  rename CCNRDI53=CCNRDI31 CDIAG53=CDIAG31 AGE11X=Age_yearend AGE31X=Age MARRY11X=Marrital_status RACETHNX=RACETHX
	REGION11=REGION_yearend REGION31=REGION POVLEV11=POVLEV POVCAT11=POVCAT INSCOV11=INSCOV INSURC11=INSURC 
	PRVEV11=PRVEV TRIEV11=TRIEV MCDEV11=MCDEV MCREV11=MCREV OPAEV11=OPAEV OPBEV11=OPBEV UNINS11=UNINS
	OBTOTV11=Office_visits OPTOTV11=Outpatient_visits ERTOT11=ER_visits IPDIS11=IP_discharges 
	IPNGTD11=IP_nights RXTOT11=Rx_fills_refills DVTOT11=Dental_visits HHTOTD11=Home_health_days 
	CTRTMT53=CTRTMT31 CLSTRT53=CLSTRT31 CBCK53=CBCK31 CMCFUP53=CMCFUP31 CMCEFF53=CMCEFF31 
	CMCPSY53=CMCPSY31 CMCSTY53=CMCSTY31 CFNDBT53=CFNDBT31 CFNSAC53=CFNSAC31 CFNUNB53=CFNUNB31 
	CFNBNK53=CFNBNK31 CFNPMT53=CFNPMT31 CSAQW11F=CSAQWF PERWT11F=PERWTF SAQWT11F=SAQWTF;
run;

proc sort data = ecss11;
	by DUPERSID;
run;

proc sort data = ecss16;
	by DUPERSID;
run;

proc sort data = ecss17;
	by DUPERSID;
run;

/* Append the datasets */
data phdtheis.ecss; /*3,373*/
  set ecss11 ecss16 ecss17;
run;

proc sql;
  select DUPERSID, count(*) as Count
  from phdtheis.ecss
  group by DUPERSID
  having count(*) > 1;
quit;

proc sort data=phdtheis.ecss; /* Use this dataset in case the duplicate DUPERSID is not a concern. 
The duplicate pair doesn't seem like the same individual. Most likely a coding issue by MEPS.*/
  by DUPERSID;
run;

data duplicates;
  set phdtheis.ecss;
  by DUPERSID;
  if not (first.DUPERSID and last.DUPERSID); /* Keep if not both first and last */
run;

proc print data=duplicates;
  title "Duplicate DUPERSID Values";
run;

/* 17 DUPERSID appeared both in 2011 and 2016 totalling 34 records. The age variable 
seemed incrogrous between the two records for each duplicate group.*/

/* Sort by DUPERSID and YEAR (ascending YEAR) */
proc sort data=phdtheis.ecss out=ecss_sorted;
  by DUPERSID YEAR; /* Ascending YEAR is crucial here */
run;

/* Keep only the LAST record for each DUPERSID */
data phdtheis.ecss_deduped; /*3,356, dropped the duplicate records that appeared in 2011 as 
those rows have less complete data and the 2016 records will aid the sample size for Aim 3.*/
  set ecss_sorted;
  by DUPERSID;
  if last.DUPERSID; /* Subsetting IF: Keep only the last record */
run;

/* Check the % of valid values in the quality of cancer survivorship PPC measures */
proc freq data=phdtheis.ecss_deduped;
  tables CMCFUP31 CMCEFF31 CMCPSY31 CMCSTY31;
run;

/*Include DUPERSID that have complete data on quality of cancer survivorship PPC measures.*/
data phdtheis.ecss_ppcdata;/*3,100, lost 256, includes DUPERSID that have complete data on quality of cancer survivorship PPC measures.*/
	set phdtheis.ecss_deduped;
	if (CMCFUP31>0 and CMCEFF31>0 and CMCPSY31>0 and CMCSTY31>0) then output;
run;

/*Exclude individuals whose only cancer diagnosis is non-melanoma skin cancer (CASKINNM = 1) or skin cancer of unknown type (CASKINDK = 1).*/
data phdtheis.ecss_skca_excluded; /* 2,400 */
  set phdtheis.ecss_ppcdata;

  /* Check if any relevant non-skin cancers are present (value = 1) */
  NonSCPresent = sum(
      (CABLADDR = 1),
      (CABREAST = 1),
      (CACERVIX = 1),
      (CACOLON = 1),
      (CALUNG = 1),
      (CALYMPH = 1),
      (CAMELANO = 1),
      (CAOTHER = 1),
      (CAPROSTA = 1),
      (CAUTERUS = 1)
  );

  /* Delete if CASKINDK=1 or CASKINNM=1 AND no other relevant cancers are present */
  if (CASKINDK = 1 or CASKINNM = 1) and NonSCPresent = 0 then delete;

  /* Optionally drop the temporary variable */
  drop NonSCPresent;
run;

/* Check that no 'only non-melanoma skin cancer or skin cancer of unknown type' individuals 
are not available in the new dataset */
proc freq data=phdtheis.ecss_skca_excluded;
  /* Apply the exact exclusion logic in the WHERE statement */
  where (CASKINNM = 1 or CASKINDK = 1) /* Condition 1: Has specific skin cancer */
    and
        /* Condition 2: Has NO other relevant cancer type */
        sum((CABLADDR = 1), (CABREAST = 1), (CACERVIX = 1), (CACOLON = 1),
            (CALUNG = 1), (CALYMPH = 1), (CAMELANO = 1), (CAOTHER = 1),
            (CAPROSTA = 1), (CAUTERUS = 1)) = 0;

  /* We need a TABLES statement, but the result is in the overall count */
  tables CASKINNM;
  title "Verification: Checking for Individuals Who Should Have Been Excluded";
  title2 "(Frequency count should be 0 if exclusion worked)";
run;
title; /* Clear title */

/* Check the frequencies of the skin cancer variables in the new dataset */
proc freq data=phdtheis.ecss_skca_excluded;
  title "Frequencies in Excluded Dataset (ecss_skca_excluded)";
  tables CASKINDK CASKINNM;
run;

proc sort data=phdtheis.ecss_ppcdata;
  by DUPERSID;
run;

proc sort data=phdtheis.ecss_skca_excluded;
  by DUPERSID;
run;

/* More detailed check: Create a dataset of the deleted records */
data deleted_records;
   merge phdtheis.ecss_ppcdata (in=a)
         phdtheis.ecss_skca_excluded (in=b keep=DUPERSID);
   by DUPERSID; 
   if a and not b; /* Keep records from original that are NOT in the new dataset */
run;

/*Verification*/
proc print data=deleted_records;
  title "Records Deleted by the Filter";
  var DUPERSID CASKINDK CASKINNM CABLADDR CABREAST CACERVIX CACOLON CALUNG CALYMPH CAMELANO CAOTHER CAPROSTA CAUTERUS;
run;

/*Verified that the phdtheis.ecss_skca_excluded do not have any individuals whose only cancer diagnosis is non-melanoma skin cancer or skin cancer of unknown type*/
proc freq data=deleted_records;
  title "Frequencies of non-skin cancers in the deleted records";
  tables CABLADDR CABREAST CACERVIX CACOLON CALUNG CALYMPH CAMELANO CAOTHER CAPROSTA CAUTERUS;
run;


proc contents data=phdtheis.ecss_skca_excluded;
run;

proc freq data=phdtheis.ecss_skca_excluded;
  tables ADAPPT42;
run;

data phdtheis.ecss_recoded;
  set phdtheis.ecss_skca_excluded;
  rename ADAPPT42=ADAPPT42_Officevisits_12m ADEXPL42=ADEXPL42_Doc_explained ADLIST42=ADLIST42_Doc_listened ADPRTM42=ADPRTM42_Doc_spenttime 
  ADRESP42=ADRESP42_Doc_respected ADSMOK42=ADSMOK42_Smoking_status CBCK31=CBCK31_cancer_recur CCNRDI31=CCNRDI31_cancer_dx_byprovider CDIAG31=CDIAG31_cancerdx_bfr18 
  CEFFTG31=CEFFTG31_Fatigue CEFMHL31=CEFMHL31_Mental_health_rating CEFMPR31=CEFMPR31_Emotional_problem CEFPAC31=CEFPAC31_Physical_activity 
  CEFPHL31=CEFPHL31_Physical_health_rating CEFPIN31=CEFPIN31_Pain CEFQLF31=CEFQLF31_Quality_of_life CEFRLT31=CEFRLT31_Social_activity 
  CFNBNK31=CFNBNK31_BANKRUPTCY CFNDBT31=CFNDBT31_Money_borrow_debt CFNLIV31=CFNLIV31_Sacrificed_living CFNOTH31=CFNOTH31_Sacrificed_othercost 
  CFNPMT31=CFNPMT31_Worry_topaybill CFNPUR31=CFNPUR31_Sacrificed_purchase CFNSAC31=CFNSAC31_Financial_sacrifice CFNSAV31=CFNSAV31_Sacrificed_savings 
  CFNSPD31=CFNSPD31_Sacr_basicspending CFNUNB31=CFNUNB31_Unable_medical_bills CFNVAC31=CFNVAC31_Sacrificed_leisure CLSTRT31=CLSTRT31_Cancer_tx_history 
  CMCEFF31=CMCEFF31_DISCUSS_SIDE_EFFECTS CMCFUP31=CMCFUP31_DISCUSS_FOLLOWUP_CARE CMCOST31=CMCOST31_DISCUSS_COSTS CMCPSY31=CMCPSY31_DISCUSS_EMOSOC_NEEDS 
  CMCSTY31=CMCSTY31_DISCUSS_LIFESTYLE CMCTRT31=CMCTRT31_DISCUSS_CANCER_Tx CTRTMT31=CTRTMT31_CURRENTLY_TREATED DECIDE42=DECIDE42_PROV_HELPS_DECIDE 
  EDUCYR=EDUCYR_YEARS_OF_EDUC EMPST42=EMPST42_EMPLOYMENT_STATUS EXPLOP42=EXPLOP42_PROV_EXPLNS_OPTIONS GENDRP42=GENDRP42_Provider_Sex HAVEUS42=HAVEUS42_have_USC_Prov 
  HWELLSPE=HWELLSPE_HOW_WELL_ENGLISH LANGSPK=LANGSPK_LANG_OTHER_THAN_ENGL MNHLTH31=MNHLTH31_PER_MENTAL_HEALTH_STAT 
  OTHLANG=OTHLANG_SPKNG_OTHER_LANG PLCTYP42=PLCTYP42_USC_TYPE_OF_PLACE POVLEV=POVLEV_Poverty_level PROVTY42=PROVTY42_PROVIDER_TYPE 
  PRVSPK42=PRVSPK42_PROV_LANG_CNCRDN RESPCT42=RESPCT42_PROV_SHOWS_RESPECT RTHLTH31=RTHLTH31_PER_HEALTH_STAT TREATM42=TREATM42_PROV_ASKS_TREATMENTS 
  TYPEPE42=TYPEPE42_USC_TYPE_OF_PROVIDER Marrital_status=Marry;
run;

proc contents data=phdtheis.ecss_recoded;
run;

proc freq data=phdtheis.ecss_recoded;
  tables UNINS;
run;

/* Define the format for the new Health_insurance_status variable */
proc format;
  value insfmt
    . = "Missing" /* Label for missing - consistent with previous request */
    1 = "Any private"
    2 = "Medicare"
    3 = "Other public"
    4 = "Uninsured";
run;

/* Create the new dataset with the Health_insurance_status variable with mutually exclusive categories*/
data phdtheis.ecss_recoded2;
  set phdtheis.ecss_recoded; 

  /* Create Health_insurance_status based on the specified logic */
  /* Using IF/ELSE IF structure to ensure mutually exclusive assignment */

  /* Initialize to missing */
  Health_insurance_status = .;

  /* Apply the logic in a specific order. Check UNINS first. */
  if UNINS = 1 then Health_insurance_status = 4; /* Presumes UNINS variable exists and UNINS=1 means uninsured */
  else if INSURC = 1 then Health_insurance_status = 1; /* Any Private */
  else if INSURC in (4, 5, 6) then Health_insurance_status = 2; /* Prioritize Medicare if INSURC indicates it */
  else if INSURC = 2 then do; /* Public Only group */
      if MCREV = 1 then Health_insurance_status = 2; /* Medicare */
      /* If not Medicare, check for Medicaid/Other Public */
      else if MCREV = 2 and (MCDEV = 1 or OPAEV = 1 or OPBEV = 1) then Health_insurance_status = 3; /* Other public */
      /* Note: Cases with INSURC=2, MCREV=2 and NO MCDEV/OPAEV/OPBEV=1 are not covered */
  end;
  else if INSURC = 8 then do; 
      /* Check for Private/TRICARE only (no Medicare/Medicaid/Other Public) */
      if (PRVEV = 1 or TRIEV = 1) and (MCDEV = 2 and MCREV = 2 and OPAEV = 2 and OPBEV = 2) then Health_insurance_status = 1; /* Any private */
      /* Check for Medicaid/Other Public only (no Private/TRICARE/Medicare) */
      else if (MCDEV = 1 or OPAEV = 1 or OPBEV = 1) and (PRVEV = 2 and TRIEV = 2 and MCREV = 2) then Health_insurance_status = 3; /* Other public */
  end;

  /* Apply the format */
  format Health_insurance_status insfmt.;

  /* Keep all existing variables plus the new one */

run;

/* --- Verification Steps --- */

/* Check the frequency of the new variable */
proc freq data=phdtheis.ecss_recoded2;
  title "Frequency of Health_insurance_status";
  tables Health_insurance_status / missing; /* Use MISSING option to check for unassigned cases */
run;

/* Print cases where Health_insurance_status is missing */ /* For four DUPERSID while INSURC=7(65+ uninsured), INSCOV=1(any private) and PRVEV=1. So I can recode them as having any private insurance */
proc print data=phdtheis.ecss_recoded2;
    where missing(Health_insurance_status);
    title "Observations Where Health_insurance_status is Missing";
    var DUPERSID INSCOV INSURC MCREV MCDEV OPAEV OPBEV PRVEV TRIEV UNINS;
run;

/* As mentioned earlier, recodes the missing Health_insurance_status as any private */
data phdtheis.ecss_recoded3;
  set phdtheis.ecss_recoded2; /* Read from the previous dataset */

  /* Assign Health_insurance_status = 1 if it's currently missing */
  if missing(Health_insurance_status) then Health_insurance_status = 1;

  /* Re-apply the format (good practice, though it typically carries over) */
  /* Ensures the label "Any private" is associated with the newly assigned 1s */
  format Health_insurance_status insfmt.;

run;

/* Check the frequency */
proc freq data=phdtheis.ecss_recoded3;
  title "Frequency of Health_insurance_status";
  tables Health_insurance_status / missing; /* Use MISSING option to check for unassigned cases */
run;

proc contents data=phdtheis.ecss_recoded3;
run;

proc freq data=phdtheis.ecss_recoded3;
  tables HAVEUS42_have_USC_Prov ADAPPT42_Officevisits_12m PROVTY42_PROVIDER_TYPE PLCTYP42_USC_TYPE_OF_PLACE TYPEPE42_USC_TYPE_OF_PROVIDER LOCATN42;
run;

proc freq data=phdtheis.ecss_recoded3;
  tables Age_yearend Age Marry SEX EDUCYR_YEARS_OF_EDUC RACETHX REGION_yearend REGION EMPST42_EMPLOYMENT_STATUS CTRTMT31_CURRENTLY_TREATED CLSTRT31_Cancer_tx_history MNHLTH31_PER_MENTAL_HEALTH_STAT 
		RTHLTH31_PER_HEALTH_STAT ADSMOK42_Smoking_status HAVEUS42_have_USC_Prov ADAPPT42_Officevisits_12m 
		PROVTY42_PROVIDER_TYPE TYPEPE42_USC_TYPE_OF_PROVIDER;
run;

* --- Step 1: Define ALL Formats --- ;
proc format;
  /* --- Existing/Modified Formats --- */
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

  value hlthfmt /* Format for MNHLTH31_PER_MENTAL_HEALTH_STAT, RTHLTH31_PER_HEALTH_STAT */
     . = "Missing"
    -8 = "Missing" /* DK */
    -1 = "Missing" /* Inapplicable - Added just in case */
     1 = "Excellent"
     2 = "Very good"
     3 = "Good"
     4 = "Fair"
     5 = "Poor";

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

  value edufmt /* Format for Educat */
    . = "Missing"  /* Label for missing */
    1 = "Less than high school"
    2 = "High school graduate"
    3 = "Some college or higher";

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

  value ctypfmt /* Format for Cancer_type */
    . = "Missing"  /* Label for missing */
    1 = "Multiple"
    2 = "Female Breast"
    3 = "Colorectal"
    4 = "Prostate"
    5 = "Melanoma"
    6 = "Cervical"
    7 = "Uterine"
    8 = "Other";

  value ctpsxfmt /* Format for Cancer_type_sex */
    . = "Missing"  /* Label for missing */
    1 = "Prostate cancer only"
    2 = "Male other"
    3 = "Female breast cancer only"
    4 = "Female other";

  value chxfmt /* Format for Cancer_tx_history */
    . = "Missing"  /* Label for missing */
    1 = "On treatment"
    2 = "<5 years ago"
    3 = "5 to <10 years ago"
    4 = "10+ years ago"
    5 = "Never treated";

  value smokefmt /* Format for Smoking_status */
    . = "Missing"  /* Label for missing */
    1 = "Current smoker"
    2 = "Non-current smoker";

  value yesnofmt /* Format for Have_USC_Prov */
    . = "Missing"  /* Label for missing */
    1 = "Yes"
    2 = "No";

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
run;


* --- Step 2: Calculate Income Tertiles using PROC RANK --- ;
/* Creates ranks 0, 1, 2 for tertiles based on POVLEV_Poverty_level */
/* Missing POVLEV_Poverty_level gets missing rank */
proc rank data=phdtheis.ecss_recoded3 groups=3 out=work.pov_ranked;
  var POVLEV_Poverty_level;
  ranks rank_povlev;
run;

* --- Step 3: Sort datasets before merging --- ;
proc sort data=phdtheis.ecss_recoded3;
  by DUPERSID; /* Ensure input is sorted by Person ID */
run;
proc sort data=work.pov_ranked;
  by DUPERSID; /* Ensure ranks are sorted by Person ID */
run;

* --- Step 4: Main Data Step to Create Variables --- ;
data phdtheis.ecss_recoded4;
  merge phdtheis.ecss_recoded3 (in=a)
        work.pov_ranked (keep=DUPERSID rank_povlev in=b);
  by DUPERSID;
  if a; /* Keep only records from the original dataset */

  /* --- Demographics --- */

  /* Medicare Eligibility */
  if Age=-1 then Medicare_eligibility = .;
  else if 18<= Age < 65 then Medicare_eligibility = 0;
  else if Age >= 65 then Medicare_eligibility = 1;

  /* Age Category */
  if Age=-1 then Age_category = .;
  else if 18 <= Age <= 44 then Age_category = 1;
  else if 45 <= Age <= 64 then Age_category = 2;
  else if Age >= 65 then Age_category = 3;

  /* Marital Status */
  if Marry = 1 then Marrital_status = 1;
  else if Marry in (2, 3, 4, 5) then Marrital_status = 2;
  else Marrital_status = .; /* Handle other codes like missing */

  /* Education */
  if missing(EDUCYR_YEARS_OF_EDUC) or EDUCYR_YEARS_OF_EDUC < 0 then Educat = .; /* Handle missing and negatives */
  else if EDUCYR_YEARS_OF_EDUC <= 11 then Educat = 1;
  else if EDUCYR_YEARS_OF_EDUC = 12 then Educat = 2;
  else if EDUCYR_YEARS_OF_EDUC >= 13 then Educat = 3;

  /* Income Status (Tertiles) */
  /* Convert rank (0, 1, 2) to categories (1, 2, 3) */
  if missing(rank_povlev) then Income_status = .;
  else Income_status = rank_povlev + 1;

  /* Employment Status */
  if EMPST42_EMPLOYMENT_STATUS in (1, 2, 3) then Employment_status = 1; /* Employed */
  else if EMPST42_EMPLOYMENT_STATUS = 4 then Employment_status = 2; /* Not Employed */
  else Employment_status = 3; /* Assign 3 if missing (-1, -8 etc) or other */

  /* --- Health Conditions --- */

  /* Heart Disease Binary */
  HEARTDX = 0; /* Initialize to No */
  if (CHDDX=1 or ANGIDX=1 or MIDX=1 or OHRTDX=1) then HEARTDX = 1; /* Set to Yes if any condition is 1 */
  /* Treats missing inputs as 0 (No) */

  /* Comorbidities Count */
  Comorbid_count = sum(HIBPDX=1, HEARTDX=1, STRKDX=1, EMPHDX=1,
                       CHBRON31=1, CHOLDX=1, DIABDX=1, JTPAIN31=1,
                       ARTHDX=1, ASTHDX=1);
  /* Categorize the count */
  if missing(Comorbid_count) then Comorbidities = .; /* Should not happen with SUM unless all inputs missing? */
  else if Comorbid_count = 0 then Comorbidities = 0;
  else if Comorbid_count = 1 then Comorbidities = 1;
  else if Comorbid_count = 2 then Comorbidities = 2;
  else if Comorbid_count >= 3 then Comorbidities = 3;

  /* --- Cancer Details --- */

  /* Cancer Type */
  Cancer_count = sum(CABLADDR=1, CABREAST=1, CACERVIX=1, CACOLON=1,
                     CALUNG=1, CALYMPH=1, CAMELANO=1, CAOTHER=1,
                     CAPROSTA=1, CAUTERUS=1);
  if missing(Cancer_count) or Cancer_count = 0 then Cancer_type = .; /* No cancer = missing type */
  else if Cancer_count > 1 then Cancer_type = 1; /* Multiple */
  else if CABREAST = 1 then Cancer_type = 2;
  else if CACOLON = 1 then Cancer_type = 3;
  else if CAPROSTA = 1 then Cancer_type = 4;
  else if CAMELANO = 1 then Cancer_type = 5;
  else if CACERVIX = 1 then Cancer_type = 6;
  else if CAUTERUS = 1 then Cancer_type = 7;
  else if (CABLADDR=1 or CALUNG=1 or CALYMPH=1 or CAOTHER=1) then Cancer_type = 8; /* Other Single */
  /* else Cancer_type = .; */ /* Already handled by initial missing check */

  /* Cancer Type by Sex (Corrected Logic) */
  /* Uses Cancer_count calculated earlier */
  if missing(Sex) or missing(Cancer_count) or Cancer_count = 0 then Cancer_type_sex = .; /* Handle missing Sex or no cancer */
  else if Sex = 1 then do; /* --- Handle Males --- */
      /* Check for Prostate ONLY first */
      if CAPROSTA = 1 and Cancer_count = 1 then Cancer_type_sex = 1; /* Prostate cancer only */
      /* Otherwise, if male and has any cancer, it's Male Other */
      else if Cancer_count >= 1 then Cancer_type_sex = 2; /* Male other (covers CAPROSTA+other, or just other) */
  end;
  else if Sex = 2 then do; /* --- Handle Females --- */
      /* Check for Breast ONLY first */
      if CABREAST = 1 and Cancer_count = 1 then Cancer_type_sex = 3; /* Female breast cancer only */
      /* Otherwise, if female and has any cancer, it's Female Other */
      else if Cancer_count >= 1 then Cancer_type_sex = 4; /* Female other (covers CABREAST+other, or just other) */
  end;
  /* No final ELSE needed as all conditions with Sex=1 or Sex=2 and Cancer_count>=1 are covered */

  /* Cancer Treatment History */
  if CTRTMT31_CURRENTLY_TREATED = 1 then Cancer_tx_history = 1; /* On treatment */
  else if CTRTMT31_CURRENTLY_TREATED ne 1 and not missing(CTRTMT31_CURRENTLY_TREATED) then do; /* Not currently treated, AND status is known */
      /* Now check CLSTRT31_Cancer_tx_history based on your logic */
      if CLSTRT31_Cancer_tx_history in (1, 2, 3) then Cancer_tx_history = 2; /* <5 years ago */
      else if CLSTRT31_Cancer_tx_history = 4 then Cancer_tx_history = 3; /* 5 to <10 years ago */
      else if CLSTRT31_Cancer_tx_history in (5, 6) then Cancer_tx_history = 4; /* 10+ years ago */
      else if CLSTRT31_Cancer_tx_history = 7 then Cancer_tx_history = 5; /* Never treated */
      /* else if CLSTRT31 = -9 then Cancer_tx_history = .; */ /* Explicitly handle -9 as missing below */
      else Cancer_tx_history = .; /* Assign missing for -9, -8, -1, other unexpected codes */
  end;
  else Cancer_tx_history = .; /* Assign missing if CLSTRT31_Cancer_tx_history is missing or other non-1 value not handled above */

  /* --- Health Status & Behaviors --- */

  /* Smoking Status */
  if ADSMOK42_Smoking_status = 1 then Smoking_status = 1; /* Current smoker */
  else if ADSMOK42_Smoking_status = 2 then Smoking_status = 2; /* Non-current smoker */
  else Smoking_status = .; /* Missing for -9, -1, others */

  /* --- Health Care Access/Use --- */

  /* Have USC Provider */
  if HAVEUS42_have_USC_Prov = 1 then Have_USC_Prov = 1; /* Yes */
  else if HAVEUS42_have_USC_Prov = 2 then Have_USC_Prov = 2; /* No */
  else Have_USC_Prov = .; /* Missing for -1, -8 etc. */

  /* Office Visits 12m */
  if missing(ADAPPT42_Officevisits_12m) or ADAPPT42_Officevisits_12m < 0 then Officevisits_12m = .; /* Handle missing and negatives */
  else if ADAPPT42_Officevisits_12m = 0 then Officevisits_12m = 1; /* Zero visits */
  else if ADAPPT42_Officevisits_12m <= 3 then Officevisits_12m = 2; /* 1-3 visits */
  else if ADAPPT42_Officevisits_12m >= 4 then Officevisits_12m = 3; /* 4+ visits */

  /* Type of Provider (MD/Other) */
  /* Assuming TYPEPE42_USC_TYPE_OF_PROVIDER is TYPEPE42 (Var #67) */
  if TYPEPE42_USC_TYPE_OF_PROVIDER in (1, 2) then TYPE_OF_PROVIDER = 1;
  else if TYPEPE42_USC_TYPE_OF_PROVIDER in (3, 4, 5, 6, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23) then TYPE_OF_PROVIDER = 2;
  else if TYPEPE42_USC_TYPE_OF_PROVIDER in (7, 9, 10, 12, 24) then TYPE_OF_PROVIDER = 3;
  else TYPE_OF_PROVIDER = .; /* Handle missing -1, -8 etc. */

  /* --- Apply ALL Formats --- */
  format
    Medicare_eligibility mcrfmt.
    Age_category agefmt.
    SEX sexfmt.
    Marrital_status marryfmt. /* Format for the new marital category variable */
    RACETHX racefmt. /* Format existing variable */
    Educat edufmt.
    REGION rgonfmt. /* Format existing variable */
    Income_status incmfmt.
    Employment_status emplyfmt.
    Comorbidities cmrbdfmt.
    Cancer_type ctypfmt.
    Cancer_type_sex ctpsxfmt.
    Cancer_tx_history chxfmt.
    MNHLTH31_PER_MENTAL_HEALTH_STAT hlthfmt. /* Format existing variable */
    RTHLTH31_PER_HEALTH_STAT hlthfmt. /* Format existing variable */
    Smoking_status smokefmt.
    Have_USC_Prov yesnofmt.
    Officevisits_12m visitfmt.
    PROVTY42_PROVIDER_TYPE pvtpfmt. /* Format existing variable */
    TYPE_OF_PROVIDER tpprvfmt.
    ;

  /* Drop temporary variables */
  drop rank_povlev Comorbid_count Cancer_count;

run;

/* Clean up work dataset */
proc delete data=work.pov_ranked;
run;

* --- Step 5: Verification --- ;
/* Check frequencies for ALL new and newly formatted variables */
proc freq data=phdtheis.ecss_recoded4;
  title "Verification Frequencies in ecss_recoded4";
  tables Medicare_eligibility Age_category SEX Marrital_status 
RACETHX Educat REGION Income_status Employment_status Comorbidities 
Cancer_type Cancer_type_sex Cancer_tx_history MNHLTH31_PER_MENTAL_HEALTH_STAT 
RTHLTH31_PER_HEALTH_STAT Smoking_status Have_USC_Prov Officevisits_12m PROVTY42_PROVIDER_TYPE TYPE_OF_PROVIDER
  / missing missprint nocum; /* Use MISSING option */
run;

  /* Check comorbidities Count */
proc print data=phdtheis.ecss_recoded4;
  /* Select only rows where Comorbidities is 0 */
  where Comorbidities = 0;

  /* Specify the variables you want to see */
  var DUPERSID Comorbidities /* Include Comorbidities to confirm it's 0 */
      HIBPDX HEARTDX STRKDX EMPHDX CHBRON31 CHOLDX DIABDX JTPAIN31 ARTHDX ASTHDX;

  /* Add a title for clarity */
  title "Checking Underlying Conditions for Individuals with Comorbidities = 0";
run;

/* Clear the title after use */
title;

proc contents data=phdtheis.ecss_recoded4;
run;

  /* Check Cancer Type, Even though 151 out of 153 who had Cancer_type=Missing had CANCERDX=1, 
as the indididual cancer variables had non-yes values, these were identified as missing Cancer_type. 
152 of the 153 Cancer_type=Missing were from 2011. The other is from 2017. */
proc print data=phdtheis.ecss_recoded4;
  /* Select only rows where Cancer_type is missing */
  where missing(Cancer_type);

  /* Specify the variables you want to see */
  var DUPERSID Cancer_type CCNRDI31_cancer_dx_byprovider CDIAG31_cancerdx_bfr18 CANCERDX CTRTMT31_CURRENTLY_TREATED CLSTRT31_Cancer_tx_history
      CABLADDR CABREAST CACERVIX CACOLON CALUNG CALYMPH CAMELANO CAOTHER CAPROSTA CAUTERUS CASKINDK CASKINNM Year;

  /* Add a title for clarity */
  title "Checking Observations Where Cancer_type is Missing";
run;

/* Clear the title */
title;

  /* Check Cancer Type by Sex */
proc print data=phdtheis.ecss_recoded4 noobs; /* noobs suppresses row numbers */
  /* Select only rows where Cancer_type_sex is missing */
  where missing(Cancer_type_sex);

  /* Specify the variables you want to see */
  var DUPERSID Cancer_type_sex SEX Cancer_type /* Include related cancer type */
      CABLADDR CABREAST CACERVIX CACOLON CALUNG CALYMPH CAMELANO CAOTHER CAPROSTA CAUTERUS;

  /* Add a title for clarity */
  title "Checking Observations Where Cancer_type_sex is Missing";
run;

/* Clear the title */
title;

  /* Check Cancer_tx_history */
proc print data=phdtheis.ecss_recoded4 noobs;
  /* Select only rows where Cancer_tx_history is missing */
  where missing(Cancer_tx_history);

  var DUPERSID Cancer_tx_history CTRTMT31_CURRENTLY_TREATED CLSTRT31_Cancer_tx_history;

  /* Add a title for clarity */
  title "Checking Observations Where Cancer_tx_history is Missing";
  title2 "Displaying relevant input variables CTRTMT31 and CLSTRT31";
run;

/* Clear the title */
title;

* --- End of Verification --- ;

proc freq data=phdtheis.ecss_recoded4;
  tables CMCFUP31_DISCUSS_FOLLOWUP_CARE CMCEFF31_DISCUSS_SIDE_EFFECTS CMCPSY31_DISCUSS_EMOSOC_NEEDS CMCSTY31_DISCUSS_LIFESTYLE
  / missing missprint nocum; /* Use MISSING option */
run;

* --- Create a Composite score of quality of PPC keeping and scoring Don’t remember=1 and check variance equality hypothesis --- ;

* --- Step 0: Define Input/Output Libnames/Datasets --- ;
%let input_ds = phdtheis.ecss_recoded4;
%let output_ds = phdtheis.compositePPC_wDR; /* Creating the next dataset */
%let temp_scored = work.ppc_scored;      /* Temporary dataset for scored variables */
%let temp_norm = work.ppc_normalized;    /* Temporary dataset for normalized variables */

* --- Step 1: Recode Original Responses into Scored Variables --- ;
data &temp_scored.(keep=DUPERSID FOLLOWUP_CARE_wDR SIDE_EFFECTS_wDR EMOSOC_NEEDS_wDR DISCUSS_LIFESTYLE_wDR);
  set &input_ds.;

  /* Recode CMCFUP31 (Follow Up Care) */
  if CMCFUP31_DISCUSS_FOLLOWUP_CARE = 1 then FOLLOWUP_CARE_wDR = 3; /* Discussed in detail=3 */
  else if CMCFUP31_DISCUSS_FOLLOWUP_CARE = 2 then FOLLOWUP_CARE_wDR = 2; /* Briefly discussed=2 */
  else if CMCFUP31_DISCUSS_FOLLOWUP_CARE in (3, 4) then FOLLOWUP_CARE_wDR = 1; /* Did not discuss=1, Don’t remember=1 */
  else FOLLOWUP_CARE_wDR = .; /* Handle missing (-1, -8, -9, .) */

  /* Recode CMCEFF31 (Side Effects) */
  if CMCEFF31_DISCUSS_SIDE_EFFECTS = 1 then SIDE_EFFECTS_wDR = 3;
  else if CMCEFF31_DISCUSS_SIDE_EFFECTS = 2 then SIDE_EFFECTS_wDR = 2;
  else if CMCEFF31_DISCUSS_SIDE_EFFECTS in (3, 4) then SIDE_EFFECTS_wDR = 1;
  else SIDE_EFFECTS_wDR = .;

  /* Recode CMCPSY31 (Emo/Soc Needs) */
  if CMCPSY31_DISCUSS_EMOSOC_NEEDS = 1 then EMOSOC_NEEDS_wDR = 3;
  else if CMCPSY31_DISCUSS_EMOSOC_NEEDS = 2 then EMOSOC_NEEDS_wDR = 2;
  else if CMCPSY31_DISCUSS_EMOSOC_NEEDS in (3, 4) then EMOSOC_NEEDS_wDR = 1;
  else EMOSOC_NEEDS_wDR = .;

  /* Recode CMCSTY31 (Lifestyle) */
  if CMCSTY31_DISCUSS_LIFESTYLE = 1 then DISCUSS_LIFESTYLE_wDR = 3;
  else if CMCSTY31_DISCUSS_LIFESTYLE = 2 then DISCUSS_LIFESTYLE_wDR = 2;
  else if CMCSTY31_DISCUSS_LIFESTYLE in (3, 4) then DISCUSS_LIFESTYLE_wDR = 1;
  else DISCUSS_LIFESTYLE_wDR = .;

run;

* --- Step 2: Normalize the Scored Variables (Z-scores) --- ;
/* PROC STDIZE calculates mean/std dev and outputs standardized variables */
proc stdize data=&temp_scored.
            out=&temp_norm.(rename=(FOLLOWUP_CARE_wDR = FOLLOWUP_CARE_norm
                                    SIDE_EFFECTS_wDR  = SIDE_EFFECTS_norm
                                    EMOSOC_NEEDS_wDR  = EMOSOC_NEEDS_norm
                                    DISCUSS_LIFESTYLE_wDR = DISCUSS_LIFESTYLE_norm))
            method=std;    /* Use Standard Deviation method (Z-score) */
                           /* Mean=0 and Std=1 are implicit with METHOD=STD */
  var FOLLOWUP_CARE_wDR SIDE_EFFECTS_wDR EMOSOC_NEEDS_wDR DISCUSS_LIFESTYLE_wDR;
run;

* --- Step 3: Merge Normalized Scores and Create Composite Score --- ;
/* Sort datasets before merging to ensure correct alignment */
proc sort data=&input_ds.; by DUPERSID; run;
proc sort data=&temp_scored.; by DUPERSID; run; /* Sort the scored dataset */
proc sort data=&temp_norm.; by DUPERSID; run;   /* Sort the normalized dataset */

* --- Step 4: Merge All Datasets and Create Composite Score --- ;
/* Merge original data, scored data, and normalized data */
data &output_ds.;
  merge &input_ds.(in=a)      /* Original data */
        &temp_scored.(in=b)   /* Scored _wDR variables */
        &temp_norm.(in=c);    /* Normalized _norm variables */
  by DUPERSID;
  if a; /* Keep only records that were in the original dataset */

  /* Create the Composite Score by summing the normalized variables */
  Composite_PPC_wDR = sum(FOLLOWUP_CARE_norm, SIDE_EFFECTS_norm, EMOSOC_NEEDS_norm, DISCUSS_LIFESTYLE_norm);

  /* Now all variables (_wDR and _norm) are present */
run;

* --- Step 4: Verification of New Variables --- ;
/* Check the distributions of the intermediate and final variables */
proc means data=&output_ds. n mean std min max median;
  title "Descriptive Statistics for Scored, Normalized, and Composite PPC Variables";
  var FOLLOWUP_CARE_wDR SIDE_EFFECTS_wDR EMOSOC_NEEDS_wDR DISCUSS_LIFESTYLE_wDR /* Scored */
      FOLLOWUP_CARE_norm SIDE_EFFECTS_norm EMOSOC_NEEDS_norm DISCUSS_LIFESTYLE_norm /* Normalized */
      Composite_PPC_wDR; /* Composite */
run;
title;

* --- Step 5: Variance Equality Hypothesis Test --- ;

/* Calculate Variances of ORIGINAL communication variables */
/* This allows numerical comparison */
/* The null hypothesis, which posits that the variances across the different questions are equal, can be rejected. */
proc means data=&input_ds. n var mean stddev;
    title "Variances of Original Patient-Provider Communication Variables";
    /* Using original variable names from PROC CONTENTS */
    var CMCFUP31_DISCUSS_FOLLOWUP_CARE CMCEFF31_DISCUSS_SIDE_EFFECTS CMCPSY31_DISCUSS_EMOSOC_NEEDS CMCSTY31_DISCUSS_LIFESTYLE;
run;
title;


* --- Step 6: Clean up temporary work datasets --- ;
proc delete data=&temp_scored.;
run;

proc delete data=&temp_norm.;
run;

* --- End of creating a Composite score of quality of PPC keeping and scoring Don’t remember=1 and checking variance equality hypothesis --- ;

* --- Step 0: Define Input/Output Libnames/Datasets --- ;
%let input_ds = phdtheis.compositePPC_wDR;
%let output_ds = phdtheis.PPC_cat; 
%let temp_ppc_ranked = work.ppc_ranked;

* --- Step 1: Define Format for the New Tertile Variable --- ;
proc format;
  value ppcfmt
    . = "Missing" /* Handle missing */
    1 = "Low"     /* Tertile 1 */
    2 = "Medium"  /* Tertile 2 */
    3 = "High";   /* Tertile 3 */
run;

* --- Step 2: Calculate Tertile Ranks using PROC RANK --- ;
/* Ensure DUPERSID (or your unique ID) is kept along with the variable to rank */
proc rank data=&input_ds.(keep=DUPERSID Composite_PPC_wDR) groups=3 out=&temp_ppc_ranked.;
    var Composite_PPC_wDR;
    ranks rank_ppc; /* Output variable: 0, 1, or 2 */
run;

* --- Step 3: Sort datasets before merging --- ;
proc sort data=&input_ds.;
  by DUPERSID;
run;
proc sort data=&temp_ppc_ranked.;
  by DUPERSID;
run;

* --- Step 4: Merge Ranks and Create Categorical Variable --- ;
data &output_ds.;
  merge &input_ds.(in=a) /* Original data */
        &temp_ppc_ranked.(keep=DUPERSID rank_ppc in=b); /* Ranks */
  by DUPERSID;
  if a; /* Keep only records from the original dataset */

  /* Create Composite_PPC_CAT based on the rank */
  if missing(rank_ppc) then Composite_PPC_CAT = .; /* Handle missing input score */
  else Composite_PPC_CAT = rank_ppc + 1; /* Convert rank 0,1,2 -> category 1,2,3 */

  /* Apply the format */
  format Composite_PPC_CAT ppcfmt.;

  /* Drop the temporary rank variable */
  drop rank_ppc;
run;

* --- Step 5: Verification --- ;
/* Check the frequency distribution of the new categorical variable */
proc freq data=&output_ds.;
  title "Frequency Distribution of Composite PPC Tertiles (Composite_PPC_CAT)";
  tables Composite_PPC_CAT / missing;
run;

/* Optional: Check means of the continuous variable within each category */
proc means data=&output_ds. mean;
  title "Mean Composite_PPC_wDR within each Tertile Category";
  class Composite_PPC_CAT;
  var Composite_PPC_wDR;
run;
title; /* Clear title */

* --- Step 6: Clean up temporary work dataset --- ;
proc delete data=&temp_ppc_ranked.;
run;

proc contents data=phdtheis.PPC_cat;
run;


/* Request the count of missing values. No missing values. */
proc means data=phdtheis.PPC_cat nmiss; 

  /* List the numeric variables you want to check */
  var Rx_fills_refills
      Outpatient_visits
      Office_visits
      IP_nights
      Home_health_days
      Dental_visits
      ER_visits;

  title "Check for Missing Values in Specified Numeric Variables";
run;

title; /* Clear the title */

proc freq data=phdtheis.PPC_cat;
  tables Home_health_days Dental_visits/ nocum nopercent;
  title "Frequency Count for Home_health_days Dental_visits (Check Zeros)";
run;
title;


* --- Create Other_visits by Summing --- ;
data phdtheis.PPC_cat;
  set phdtheis.PPC_cat; /* Read the input dataset */

  /* Calculate Other_visits using the SUM function. */
  Other_visits = sum(Home_health_days, Dental_visits);

  label Other_visits = "Sum of Home Health Days and Dental Visits";

run;

* --- Verification --- ;

/* Print a few observations to manually check the calculation */
proc print data=phdtheis.PPC_cat(obs=10);
  title "Sample Observations from PPC_cat";
  var DUPERSID Home_health_days Dental_visits Other_visits;
run;
title; /* Clear title */


proc freq data=phdtheis.PPC_cat;
  tables Year Age Medicare_eligibility Age_category SEX Marrital_status 
RACETHX Educat REGION Income_status Employment_status Health_insurance_status Comorbidities 
Cancer_type Cancer_type_sex Cancer_tx_history MNHLTH31_PER_MENTAL_HEALTH_STAT 
RTHLTH31_PER_HEALTH_STAT Smoking_status Have_USC_Prov Officevisits_12m PROVTY42_PROVIDER_TYPE TYPE_OF_PROVIDER
  / missing missprint nocum; /* Use MISSING option */
run;

proc contents data=phdtheis.PPC_cat;
run;

data check;
	set phdtheis.PPC_cat;
	where RTHLTH31_PER_HEALTH_STAT=-8;
run;

* --- Check missingness of Educat Cancer_type Cancer_tx_history --- ;

* --- Define Input Dataset and Key Variable Lists --- ;
%let input_ds = phdtheis.PPC_cat;
%let work_ds = work.missing_check; /* Temporary dataset */
%let timestamp = %sysfunc(datetime(), datetime20.);
%put NOTE: MCAR Assessment Code Execution started at &timestamp.;

/* Key characteristics for randomness check */
%let key_cont_vars = Age Composite_PPC_wDR;
%let key_cat_vars = Year SEX Marrital_status RACETHX Region Income_status Employment_status Health_insurance_status 
Composite_PPC_CAT RTHLTH31_PER_HEALTH_STAT MNHLTH31_PER_MENTAL_HEALTH_STAT Comorbidities;

* --- Step 1: Create Missing Indicators --- ;
data &work_ds.;
  set &input_ds.;
  /* Create indicators: 1 if the variable is missing (.), 0 otherwise */
  miss_Educat = missing(Educat);
  miss_Cancer_type = missing(Cancer_type);
  miss_Cancer_tx_history = missing(Cancer_tx_history);
  /* Add labels */
  label miss_Educat = "Missing Indicator for Educat"
        miss_Cancer_type = "Missing Indicator for Cancer_type"
        miss_Cancer_tx_history = "Missing Indicator for Cancer_tx_history";
run;

* --- Step 2: Perform Comparisons for Each Missing Variable --- ;

/* ----- A. Assess Educat Missingness ----- */
title "MCAR Check (Educat): Comparing Groups based on Educat Missingness";
proc ttest data=&work_ds.;
  class miss_Educat; /* Groups: missing(Educat)=1 vs missing(Educat)=0 */
  var &key_cont_vars.;
  title2 "T-tests for Continuous Variables";
run;
proc freq data=&work_ds.;
  /* Note: With only 10 missing Educat, Chi-Sq warnings about low cell counts are likely */
  tables miss_Educat * (&key_cat_vars.) / chisq expected norow nocol nopercent fisher;
  title2 "Chi-Square Tests for Categorical Variables";
run;
title; /* Clear title */

/* ----- B. Assess Cancer_type Missingness ----- */
title "MCAR Check (Cancer_type): Comparing Groups based on Cancer_type Missingness";
proc ttest data=&work_ds.;
  class miss_Cancer_type; /* Groups: missing=1 vs missing=0 */
  var &key_cont_vars.;
  title2 "T-tests for Continuous Variables";
run;
proc freq data=&work_ds.;
  tables miss_Cancer_type * (&key_cat_vars.) / chisq expected norow nocol nopercent fisher;
  title2 "Chi-Square Tests for Categorical Variables";
run;
title; /* Clear title */

/* ----- C. Assess Cancer_tx_history Missingness ----- */
title "MCAR Check (Cancer_tx_history): Comparing Groups based on Cancer_tx_history Missingness";
proc ttest data=&work_ds.;
  class miss_Cancer_tx_history; /* Groups: missing=1 vs missing=0 */
  var &key_cont_vars.;
  title2 "T-tests for Continuous Variables";
run;
proc freq data=&work_ds.;
  tables miss_Cancer_tx_history * (&key_cat_vars.) / chisq expected norow nocol nopercent fisher;
  title2 "Chi-Square Tests for Categorical Variables";
run;
title; /* Clear title */

* --- Step 3: Interpretation Reminder --- ;

/*
---------------------------------------------------------------------
INTERPRETATION REQUIRED:
---------------------------------------------------------------------
1. Examine the p-values (Pr > |t| for TTEST, Pr > ChiSq for FREQ) from Step 2.
2. For EACH target variable (Educat, Cancer_type, Cancer_tx_history):
   - If ANY comparison with key variables yields p < 0.05: Conclude likely NOT MCAR.
   - If ALL comparisons yield p >= 0.05: Assume MCAR for practical purposes.

3. Determine Action based on your strategy:

   * Educat (0.42% missing):
      - Not MCAR (p < 0.05): Treat as distinct category (Action: Recode_Category).

   * Cancer_type (6.38% missing):
      - Not MCAR (p < 0.05): Treat as distinct category (Action: Recode_Category).

   * Cancer_tx_history (4.92% missing):
      - Not MCAR (p < 0.05): Treat as distinct category (Action: Recode_Category).
---------------------------------------------------------------------
*/

* --- Clean up --- ;
proc delete data=&work_ds.; run;

%put NOTE: MCAR Assessment Code Execution finished at %sysfunc(datetime(), datetime20.).;

* --- Missingness check complete --- ;

* --- Address missingness --- ;

* --- Define Input/Output Datasets --- ;
%let input_ds = phdtheis.PPC_cat;
%let output_ds = phdtheis.PPC_cat_MC; /* New dataset name */
%let timestamp = %sysfunc(datetime(), datetime20.);
%put NOTE: Missing data handling step started at &timestamp.;

* --- Step 1: Define Formats for New Variables with Missing Category --- ;
proc format;
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
run;

* --- Step 2: Impute Health Vars & Create Categorical Missing Vars --- ;
data &output_ds.;
  set &input_ds.;

  /* --- Impute Health Status (Modify in place) --- */
  /* Assign Round 5 value if Round 3 value is -8 (DK) */
  /* Using exact variable names from PROC CONTENTS */
  if MNHLTH31_PER_MENTAL_HEALTH_STAT = -8 then MNHLTH31_PER_MENTAL_HEALTH_STAT = MNHLTH53;
  if RTHLTH31_PER_HEALTH_STAT = -8 then RTHLTH31_PER_HEALTH_STAT = RTHLTH53;

  /* --- Handle Categorical Missing (Create _WM Vars) --- */
  /* Create new variables (_WM suffix) assigning 99 if original is missing */

  /* Education */
  if missing(Educat) then Educat_WM = 99;
  else Educat_WM = Educat;
  label Educat_WM = "Education Category (Missing=99)";

  /* Cancer Type */
  if missing(Cancer_type) then Cancer_type_WM = 99;
  else Cancer_type_WM = Cancer_type;
  label Cancer_type_WM = "Cancer Type (Missing=99)";

  /* Cancer Type by Sex */
  if missing(Cancer_type_sex) then Cancer_type_sex_WM = 99;
  else Cancer_type_sex_WM = Cancer_type_sex;
  label Cancer_type_sex_WM = "Cancer Type by Sex (Missing=99)";

  /* Cancer Treatment History */
  if missing(Cancer_tx_history) then Cancer_tx_history_WM = 99;
  else Cancer_tx_history_WM = Cancer_tx_history;
  label Cancer_tx_history_WM = "Cancer Tx History (Missing=99)";

  /* Smoking Status */
  if missing(Smoking_status) then Smoking_status_WM = 99;
  else Smoking_status_WM = Smoking_status;
  label Smoking_status_WM = "Smoking Status (Missing=99)";

  /* Have USC Provider */
  if missing(Have_USC_Prov) then Have_USC_Prov_WM = 99;
  else Have_USC_Prov_WM = Have_USC_Prov;
  label Have_USC_Prov_WM = "Have USC Provider Status (Missing=99)";

  /* --- Apply Formats --- */
  format
    Educat_WM               eduwm.
    Cancer_type_WM          ctypwm.
    Cancer_type_sex_WM      ctsxwm.
    Cancer_tx_history_WM    ctxhwm.
    Smoking_status_WM       smkwm.
    Have_USC_Prov_WM        ynwm.
    MNHLTH31_PER_MENTAL_HEALTH_STAT hstatfmt. /* Apply updated format */
    RTHLTH31_PER_HEALTH_STAT        hstatfmt. /* Apply updated format */
    ;

  /* Decide whether to keep original variables or drop them */
  /* drop Educat Cancer_type Cancer_type_sex Cancer_tx_history Smoking_status Have_USC_Prov; */

run;

* --- Step 3: Verification --- ;
proc freq data=&output_ds.;
  tables Educat_WM Cancer_type_WM Cancer_type_sex_WM Cancer_tx_history_WM Smoking_status_WM Have_USC_Prov_WM MNHLTH31_PER_MENTAL_HEALTH_STAT RTHLTH31_PER_HEALTH_STAT / missing missprint;
  title "Frequencies of Variables with Missing Handled in &output_ds.";
run;

/* Check if imputation worked (count remaining -8) */
proc freq data=&output_ds.;
  tables MNHLTH31_PER_MENTAL_HEALTH_STAT RTHLTH31_PER_HEALTH_STAT;
  where MNHLTH31_PER_MENTAL_HEALTH_STAT = -8 or RTHLTH31_PER_HEALTH_STAT = -8;
  title "Check for remaining -8 in Health Status Variables";
run;
title;

%put NOTE: Missing data handling step finished at %sysfunc(datetime(), datetime20.).;

proc freq data=phdtheis.ecss_recoded4;
  tables CEFPHL31_Physical_health_rating CEFPAC31_Physical_activity CEFPIN31_Pain CEFFTG31_Fatigue 
		CEFQLF31_Quality_of_life CEFMHL31_Mental_health_rating CEFRLT31_Social_activity CEFMPR31_Emotional_problem
  / missing missprint nocum; /* Use MISSING option */
  where Year=2016 or Year=2017;
run;

proc contents data=phdtheis.PPC_cat_MC;
run;