AHS Overlap Population Fibromyalgia Study
================

## Datasets

- The overlap population between AHS-1 and AHS-2
  - See the manuscript how record linkage was done
- Contains 5067 subjects. Among them, there were n = 3136 women.

## Exclusion criteria

- The dataset appears to have already excluded those who were diagnosed
  for fibromyalgia 20 or more years ago
  - (See the Outcome section below as well)
  - (The manuscript reports the original sample size of n = 3156, and
    then 20 subjects were excluded for prevalent cases)

## Outcome

- Self-reported diagnosis of fibromyalgia from **AHS-2 baseline**
  questionnaire ([Page A4, under the section of musculoskeletal
  system](https://wiki.ahs2.org/_media/baseline:ahs_baseline_v3_-_page_a4.jpg))
  - Years since first diagnosis: Less than 5 years ago, 5-9 yrs ago,
    10-14 yrs ago, 20+ yrs ago
  - Have you been treated for this in the last 12 months?: No or Yes
  - See the crosstab below
    - 127 females reported their FM diagnosis. ~~None of these were
      diagnosed 20+ years ago~~
      - The dataset appears to have excluded those who were diagnosed
        for FM 20 or more years ago (See the manuscript)
    - 64 females were treated in the last 12 month. Among them, 9
      females did not indicate their diagnosis year
  - If diagnosed \< 20 years ago or treated within the last 12 months,
    they were considered as incident cases
    - According to this classification rule, there are 136 incident
      cases (4.3%) out of 3136 women

| fibroy    |  No | Yes | NA\_ | Total |
|:----------|----:|----:|-----:|------:|
| \<5 yrs   |  15 |  25 |   13 |    53 |
| 5-9 yrs   |  13 |  15 |   10 |    38 |
| 10-14 yrs |   9 |  11 |    3 |    23 |
| 15-19 yrs |   3 |   4 |    6 |    13 |
| 20+ yrs   |   0 |   0 |    0 |     0 |
| NA        | 236 |   9 | 2764 |  3009 |
| Total     | 276 |  64 | 2796 |  3136 |

## Exposure of interest

- All of the followings were derived from **AHS-1 questionnaire**,
  except for family structure in early life. Variable names in the data
  were indicated below
  - See also: Table 1 of the manuscript
- Early life experiences (See [the questions in
  AHS-1](./images/AHS1_Q37.png))
  - Warm parenting: `mwarm` and `fwarm` combined
  - Cold parenting: `mcold` and `fcold` combined
  - ~~Parent situation~~: Removed or replaced with “family structure”
  - Family structure
    - Replace “Raised by” variable
    - Based on AHS-2 BQ, Page E2, Q8, asking “Up through age 16 years,
      were you mostly raised with” (See [the questions in
      AHS-2](./images/AHS2_BQ_E2Q8.png))
    - If answered “Your two birth parents”, then categorized into “Two
      birthparents”
    - If answered “Two parents, but one or both…”, then categorized into
      “Two parents\*” (one or both were not birth parent)
    - If answered “A female birthparent only” or “A male birthparent
      only”, then categorized into “Single-birthparent”
    - If answered “Other” then categorized into “Other”
    - If not answered (missing) then categorized into “Unknown” (missing
      values were not imputed)
- Psychologic characteristics (See [the questions in
  AHS-1](./images/AHS1_Q52.png))
  - Depression index score:
    - `family`, `happy`, `overcome`
    - yes/no
    - A negative response gets 1, otherwise 0
    - Points were summed up, ranging from 0 to 3
  - Hostility index score:
    - `dislike`, `geteven`
    - yes/no or agree/disagree
    - A negative response gets 1, otherwise 0
    - Points were summed up, ranging from 0 to 2
  - Authoritarian index score:
    - `counton`, `showfel`, `respect`
    - agree/disagree
    - A negative response gets 1, otherwise 0
    - Points were summed up, ranging from 0 to 3
  - Time urgency index score: (See [the questions in
    AHS-1](./images/AHS1_Q61.png))
    - `rushed`, `competv`, `tasks`, `fasteat`
    - 10-point likert scale
    - Scales were reversed for `rushed` and `fasteat` (see AHS-1
      questionnaire) before summing up
    - Possible range: from 4 to 40
      - ~~The distribution of this score does **NOT** match with those
        shown in Table 3 of the manuscript~~
    - Cut-off values were changed as follows: 4-20, 21-24, 25-29, 30-40
      - With these groupings, the numbers match up with those in Table 3
        of the manuscript
      - Apparently, the labels were incorrect in the manuscript
- Job stress
  - Based on AHS-1 Q21 and Q22 (See [the questions in
    AHS-1](./images/AHS1_Q21.png))
    - `jobsat`: How well satisfied are you with job
    - `jobfrus`: How often are you irritated or frustrated by your job
    - If answered (“Not too satisfied” OR “Not at all satisfied”) AND
      (“Always” OR “Often”), then categorized to “High frustration and
      low satisfaction”
      - Otherwise categorized to “Low frustration or high satisfaction”

## Multiple imputation

- Data have some missing values. For example:
  - BMI is missing in about 9% of n = 3,136
  - ~~Family structure during early years of life has missing values for
    about 9.5% of the subjects~~ (decided not to impute)
- Multiple imputation was performed using chained equations ([van Buuren
  & Groothuis-Oudshoorn,
  2011](https://cran.r-project.org/web/packages/mice/citation.html)) in
  the `mice` package, assuming that data are missing at random.
  - Ten imputed datasets were produced from an imputation model
    containing the outcome, exposure variables, and covariates
    (demographics, BMI, comorbidity) that were used in logistic models
    (described later)

## Descriptive table

- All of the followings were derived from **AHS-1 questionnaire**,
  except for family structure (see the section above)

- See below for some of demographic/lifestyle variables:

  - Education: Based on the AHS-1 variable `EducCQ`, categorized into 3
    levels as shown in the table
  - Employment: Based on AHS-1 Q20, categorized into 2 levels: Employed
    or Unemployed
    - Employed: Self-employed, full time or part time employed
    - Unemployed: Out of work, student, homemaker, volunteer worker,
      retired
  - Marital status: Based on the AHS-1 variable `MaritalCQ`, categorized
    into 3 levels as shown in the table
  - Smoking status: Based on AHS-1 Q27, categorized into 2 levels: Never
    or Ever
  - Prevalent stomach ulcer: Based on AHS-1 Q5: No or Yes
  - Prevalent rheumatism: Based on AHS-1 Q5: No or Yes

- (The descriptive table below was produced using the first imputed
  dataset)

- ~~Note the number of missing values as well. How should we handle the
  missing values?~~

  - ~~**\[TO DO\]** We will perform multiple imputation assuming missing
    at random (MAR)~~
  - ~~**\[TO DO\]** Descriptive table below will be replaced with one
    created from the imputed dataset~~

<img src="summary_files/figure-gfm/descriptive_table-1.png" alt="" width="50%" />

## Distribution for age and BMI

- See below for distributions of age and BMI:
  - The distribution of BMI (`ahs1_bmi`) is right-skewed as expected,
    but there are no extreme/unusual outliers.

![](summary_files/figure-gfm/check_distribution-1.png)<!-- -->

### Correlations among exposure variables

- A Spearman correlation matrix among exposure variables is shown below:
  - A high correlation was observed between `parent_warm` and
    `parent_cold` (cor = -0.79), which is expected
  - `cold_mother` and `cold_father` was only weakly correlated with each
    other (corr = 0.20)
- Except for warm and cold parents, the correlations were not very
  strong. Multicollinearity should not pose a concern unless
  warm-parents and cold-parents are entered into the model
  simultaneously

![](summary_files/figure-gfm/correlation_matrix-1.png)<!-- -->

## Logistic models

- For each exposure variable of interest, first we fit logistic models
  using incident fibromyalgia as the outcome to obtain unadjusted odds
  ratios associated with the exposure variable

- Logistic models were fitted for each of 10 imputed datasets, and the
  results were pooled using Rubin’s rules

- ([See the table of unadjusted and adjusted odds ratio here in Excel
  format](./results/pooled_results_OR_unadj_and_adj_for_demog.xlsx))

### Unadjusted odds ratios

- Unadjusted odds ratios for each exposure variable are shown below
  - Note that reference groups are not shown in the table
    - For warm parenting, the reference is “Both”
    - For other exposure variables, the reference is the first level
      shown in the descriptive table
- There was a significant trend for warm/cold parenting, depression,
  hostility, authority

| predictor | term | odds.ratio | conf.low | conf.high | p.value | trend.p |
|:---|:---|---:|---:|---:|---:|:---|
| parent_warm_rev | One | 1.76 | 1.21 | 2.56 | 0.0030 | 0.0051 |
| parent_warm_rev | None | 1.69 | 1.01 | 2.83 | 0.0471 |  |
| parent_cold | One | 1.39 | 0.95 | 2.04 | 0.0898 | 0.0145 |
| parent_cold | Both | 1.87 | 1.04 | 3.36 | 0.0368 |  |
| cold_mother | Yes | 1.44 | 0.92 | 2.23 | 0.1074 |  |
| cold_father | Yes | 1.49 | 1.03 | 2.16 | 0.0339 |  |
| fam_struct | Two parents\* | 2.03 | 1.17 | 3.52 | 0.0117 |  |
| fam_struct | Single-birthparent | 1.00 | 0.51 | 1.94 | 0.9993 |  |
| fam_struct | Other | 1.99 | 0.78 | 5.08 | 0.1494 |  |
| fam_struct | Unknown | 0.64 | 0.31 | 1.33 | 0.2305 |  |
| depression4 | 1 | 1.18 | 0.74 | 1.87 | 0.4808 | 1.1e-05 |
| depression4 | 2 | 1.99 | 1.26 | 3.15 | 0.0034 |  |
| depression4 | 3 | 3.21 | 1.84 | 5.59 | 0.0000 |  |
| hostility3 | 1 | 1.52 | 1.02 | 2.26 | 0.0373 | 0.0023 |
| hostility3 | 2 | 2.09 | 1.28 | 3.43 | 0.0034 |  |
| authority4 | 1 | 1.67 | 0.97 | 2.89 | 0.0645 | 0.0255 |
| authority4 | 2 | 1.99 | 1.12 | 3.54 | 0.0195 |  |
| authority4 | 3 | 1.99 | 0.87 | 4.56 | 0.1053 |  |
| urgency4 | 21-24 | 1.06 | 0.62 | 1.82 | 0.8307 | 0.2128 |
| urgency4 | 25-29 | 1.42 | 0.87 | 2.30 | 0.1579 |  |
| urgency4 | 30-40 | 1.26 | 0.74 | 2.15 | 0.3846 |  |
| jobstress | Hi frus & low satis | 2.40 | 1.06 | 5.41 | 0.0353 |  |

### Odds ratios, adjusted for demographics, lifestyles and comorbidity

- This time, we fit multivariable logistic models adjusting for:

  - Age as continuous
  - BMI as continuous
    - ~~**\[TO DO\]** Check for non-linearity, possibly using a GAM
      model~~
    - Linearity assumption was checked for BMI using a generalized
      additive model that includes a non-linear term for BMI, adjusting
      for demographic variables and comorbidity
    - The non-linear term of BMI was not significant (p = 0.13) and its
      effective df was close to 1 (EDF = 1.435), suggesting that the
      association between incident fibromyalgia and BMI is (if any)
      linear on logit scale when adjusting for other variables
  - Education as categorical
  - Employment as binary (employed/unemployed)
  - Marital status as categorical
  - Smoking as binary (Never/ever)
  - Comorbidity: Stomach ulcer and rheumatism (No/Yes)
    - From [AHS-1 questionnaire Q5](./images/AHS1_Q5.png): “Has a doctor
      EVER told you that you had…”

- Again, the logistic models were fitted for each of 10 imputed
  datasets, and the results were pooled using Rubin’s rules

- Adjusted odds ratios for each exposure variable are shown below

  - Note that reference groups are not shown in the table
    - For warm parenting, the reference is “Both”
    - For other exposure variables, the reference is the first level
      shown in the descriptive table

- There was a significant trend for warm/cold parenting, depression,
  hostility, authority

| predictor | term | odds.ratio | conf.low | conf.high | p.value | trend.p |
|:---|:---|---:|---:|---:|---:|:---|
| parent_warm_rev | One | 1.71 | 1.16 | 2.51 | 0.0066 | 0.0137 |
| parent_warm_rev | None | 1.61 | 0.94 | 2.73 | 0.0813 |  |
| parent_cold | One | 1.29 | 0.87 | 1.92 | 0.2002 | 0.0566 |
| parent_cold | Both | 1.68 | 0.92 | 3.08 | 0.0942 |  |
| cold_mother | Yes | 1.31 | 0.83 | 2.07 | 0.2462 |  |
| cold_father | Yes | 1.39 | 0.95 | 2.03 | 0.0892 |  |
| fam_struct | Two parents\* | 1.72 | 0.97 | 3.06 | 0.0628 |  |
| fam_struct | Single-birthparent | 1.04 | 0.53 | 2.06 | 0.9026 |  |
| fam_struct | Other | 1.93 | 0.74 | 5.03 | 0.1804 |  |
| fam_struct | Unknown | 0.70 | 0.33 | 1.47 | 0.3511 |  |
| depression4 | 1 | 1.17 | 0.73 | 1.87 | 0.5030 | 3.3e-05 |
| depression4 | 2 | 1.98 | 1.23 | 3.17 | 0.0047 |  |
| depression4 | 3 | 3.13 | 1.75 | 5.58 | 0.0001 |  |
| hostility3 | 1 | 1.41 | 0.94 | 2.10 | 0.0976 | 0.0235 |
| hostility3 | 2 | 1.75 | 1.05 | 2.91 | 0.0316 |  |
| authority4 | 1 | 1.70 | 0.98 | 2.95 | 0.0599 | 0.0046 |
| authority4 | 2 | 2.18 | 1.21 | 3.93 | 0.0100 |  |
| authority4 | 3 | 2.70 | 1.14 | 6.38 | 0.0234 |  |
| urgency4 | 21-24 | 1.00 | 0.57 | 1.73 | 0.9902 | 0.3532 |
| urgency4 | 25-29 | 1.27 | 0.77 | 2.09 | 0.3435 |  |
| urgency4 | 30-40 | 1.19 | 0.68 | 2.07 | 0.5349 |  |
| jobstress | Hi frus & low satis | 2.08 | 0.89 | 4.85 | 0.0890 |  |

## Multiple exposure models

### Cold parent + psychological variables

- Following four logistic models were fitted:
  - Includes either one of psychological variables, depression,
    hostility, authority, or time urgency
  - Always includes cold parent (none/one/both, none as the reference)
  - Also adjusting for age, BMI, education, employment, marital status,
    smoking, and comorbidity variables
  - using data that include only those subjects who were raised by
    either “two birthparents” or “two parents (one or both were not
    birth parent)
- [See the Excel table for odds ratios in the four
  models](./results/pooled_results_OR_multi_exposure_models_cold_parent.xlsx)

![](./images/pooled_results_OR_multi_exposure_models_cold_parent.png)

- In all the four models, higher odds of developing FM were observed
  when one or both parents were perceived cold, but ORs were not
  statistically significant (OR = 1.02 to 1.13 for one cold parent; 1.27
  to 1.34 for both cold)

- Among psychological characteristics:

  - Depression was associated with significantly higher odds of FM in a
    “dose-response” manner, adjusting for cold parenting,
    demographics/lifestyle and stomach ulcer
  - Hostility and authority scales showed elevated ORs, but some of them
    were not statistically significant
  - However, there were no statistically significant ORs for time
    urgency scale

- Sensitivity analysis was conducted, excluding those with rheumatism.

  - [See the result
    here](./images/pooled_results_OR_multi_exposure_models_cold_parent_excludes_rheumatism.png)
  - [See the result in Excel
    format](./results/pooled_results_OR_multi_exposure_models_cold_parent_excludes_rheumatism.xlsx)

### Warm parent + psychological variables

- Similarly, four logistic models were fitted, this time replacing cold
  parent with warm parent
  - Includes either one of psychological variables, depression,
    hostility, authority, or time urgency
  - Always includes warm parent (none/one/both, both as the reference)
  - Also adjusting for age, BMI, education, employment, marital status,
    smoking, and stomach ulcer
  - using data that include only those subjects who were raised by
    either “two birthparents” or “two parents (one or both were not
    birth parent)
- [See the Excel table for odds ratios in the four
  models](./results/pooled_results_OR_multi_exposure_models_warm_parent.xlsx)

![](./images/pooled_results_OR_multi_exposure_models_warm_parent.png)

- Except for Model 1, significantly higher odds of developing FM were
  observed when only one of parents were perceived warm (OR = 1.47 to
  1.63). The ORs associated with no warm parents were slightly lower and
  not statistically significant (OR = 1.40 to 1.52)

- Depression was associated with significantly higher odds of FM in a
  “dose-response” manner, adjusting for warm parenting,
  demographics/lifestyle and comorbidity

  - Hostility and authority scales showed elevated ORs, but some of them
    were not statistically significant
  - However, there were no statistically significant ORs for time
    urgency scale

- Sensitivity analysis was conducted, excluding those with rheumatism.

  - [See the result
    here](./images/pooled_results_OR_multi_exposure_models_warm_parent_excludes_rheumatism.png)
  - [See the result in Excel
    format](./results/pooled_results_OR_multi_exposure_models_warm_parent_excludes_rheumatism.xlsx)

### Cold mother + psychological variables

- Similarly, four logistic models were fitted, this time replacing
  cold/warm parent with **cold mother**
  - Includes either one of psychological variables, depression,
    hostility, authority, or time urgency
  - Always includes cold mother (no/yes; no as the reference)
  - Also adjusting for age, BMI, education, employment, marital status,
    smoking, and stomach ulcer
  - using data that include only those subjects who were raised by
    either “two birthparents”, “two parents (one or both were not birth
    parent), or single female birthparent
- [See the Excel table for odds ratios in the four
  models](./results/pooled_results_OR_multi_exposure_models_cold_mother.xlsx)

![](./images/pooled_results_OR_multi_exposure_models_cold_mother.png)

- In all the four models, cold mother was not associated with FM after
  adjusting for other variables.

- Depression and authority scales were associated with significantly
  higher odds of FM in a “dose-response” manner, adjusting for cold
  mother, demographics/lifestyle and comorbidity

  - However, there were no statistically significant ORs for hostility
    and time urgency scales

- Sensitivity analysis was conducted, excluding those with rheumatism.

  - [See the result
    here](./images/pooled_results_OR_multi_exposure_models_cold_mother_excludes_rheumatism.png)
  - [See the result in Excel
    format](./results/pooled_results_OR_multi_exposure_models_cold_mother_excludes_rheumatism.xlsx)

## Change/Meeting log

- **03/16/2026**:
  - Exclude or adjust for prevalent cases of rheumatism?
    - For sensitivity analysis
      - **\[Done\]** Adjust for it if kept in the data
      - **\[Done\]** Then exclude them for model comparison
  - Family structure:
    - **\[Done\]** Missing (“Unknown”) as another level of family
      structure (Do not impute)
    - Sensitivity analysis excluding unknown
  - Logistic models: Remove the parenting variable and include two or
    more of the personality types?
- **03/14/2026**:
  - For logistic models:
    - Added two more covariates: Smoking status (Never/Ever) and stomach
      ulcer (No/Yes). See the section of “Descriptive table”
      - Somehow, even though smoking was associated with the outcome in
        the descriptive table, this variable was never adjusted in
        logistic models in the manuscript
      - Stomach ulcer was associated with the outcome and thus added
        into the models as a covariate
  - Added more multiple exposure models
    - Warm parent + psychological variables
    - Cold mother + psychological variables
- **03/07/2026**:
  - Added the following sections:
    - Exclusion criteria
    - Multiple imputation
    - Correlation among exposure variables
    - Multiple exposure models
  - Due to missing values, multiple imputation by chain equations was
    implemented. See the section of “Multiple imputation”
  - For preliminary analyses, Spearman correlations among exposure
    variables were examined
  - Some multiple exposure models were added: Cold parent + one of
    psychological variables
    - The excel file containing the model summary was added into the
      repository
