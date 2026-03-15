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
  - Family structure during early years of life has missing values for
    ~9.5% of the subjects
- Multiple imputation was performed using chained equations ([van Buuren
  & Groothuis-Oudshoorn,
  2011](https://cran.r-project.org/web/packages/mice/citation.html)) in
  the `mice` package, assuming that data are missing at random.
  - Ten imputed datasets were produced from an imputation model
    containing the outcome, exposure variables, and covariates
    (demographics and BMI) that were used in logistic models (described
    later)

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
| cold_mother | Yes | 1.47 | 0.94 | 2.30 | 0.0942 |  |
| cold_father | Yes | 1.53 | 1.06 | 2.22 | 0.0247 |  |
| fam_struct | Two parents\* | 1.95 | 1.13 | 3.36 | 0.0160 | 0.1869 |
| fam_struct | Single-birthparent | 0.99 | 0.51 | 1.90 | 0.9684 |  |
| fam_struct | Other | 1.83 | 0.72 | 4.64 | 0.2058 |  |
| depression4 | 1 | 1.24 | 0.78 | 1.99 | 0.3600 | 5.3e-06 |
| depression4 | 2 | 2.01 | 1.26 | 3.21 | 0.0034 |  |
| depression4 | 3 | 3.29 | 1.91 | 5.67 | 0.0000 |  |
| hostility3 | 1 | 1.50 | 1.01 | 2.24 | 0.0456 | 0.0038 |
| hostility3 | 2 | 2.03 | 1.23 | 3.33 | 0.0055 |  |
| authority4 | 1 | 1.68 | 0.97 | 2.90 | 0.0639 | 0.0263 |
| authority4 | 2 | 1.97 | 1.09 | 3.56 | 0.0244 |  |
| authority4 | 3 | 2.05 | 0.89 | 4.73 | 0.0913 |  |
| urgency4 | 21-24 | 1.05 | 0.61 | 1.79 | 0.8690 | 0.2036 |
| urgency4 | 25-29 | 1.39 | 0.84 | 2.28 | 0.1955 |  |
| urgency4 | 30-40 | 1.29 | 0.76 | 2.17 | 0.3443 |  |
| jobstress | Hi frus & low satis | 2.37 | 1.07 | 5.28 | 0.0342 |  |

### Odds ratios, adjusted for demographics, lifestyles and stomach ulcer

- This time, we fit multivariable logistic models adjusting for:

  - Age as continuous
  - BMI as continuous
    - ~~**\[TO DO\]** Check for non-linearity, possibly using a GAM
      model~~
    - Linearity assumption was checked for BMI using a generalized
      additive model that includes a non-linear term for BMI, adjusting
      for demographic variables
    - The non-linear term of BMI was not significant (p = 0.26) and its
      effective df was close to 1 (EDF = 1.441), suggesting that the
      association between incident fibromyalgia and BMI is (if any)
      linear on logit scale when adjusting for demographic variables
  - Education as categorical
  - Employment as binary (employed/unemployed)
  - Marital status as categorical
  - Smoking as binary (Never/ever)
  - Stomach ulcer (No/Yes)
    - From AHS-1 questionnaire: “Has a doctor EVER told you that you
      had…”

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
| parent_warm_rev | One | 1.74 | 1.18 | 2.55 | 0.0048 | 0.0085 |
| parent_warm_rev | None | 1.66 | 0.98 | 2.82 | 0.0586 |  |
| parent_cold | One | 1.33 | 0.90 | 1.97 | 0.1535 | 0.0281 |
| parent_cold | Both | 1.82 | 1.00 | 3.32 | 0.0496 |  |
| cold_mother | Yes | 1.40 | 0.88 | 2.21 | 0.1528 |  |
| cold_father | Yes | 1.49 | 1.02 | 2.18 | 0.0368 |  |
| fam_struct | Two parents\* | 1.68 | 0.96 | 2.93 | 0.0707 | 0.3082 |
| fam_struct | Single-birthparent | 0.96 | 0.50 | 1.87 | 0.9155 |  |
| fam_struct | Other | 1.70 | 0.66 | 4.37 | 0.2744 |  |
| depression4 | 1 | 1.26 | 0.79 | 2.03 | 0.3318 | 7.1e-06 |
| depression4 | 2 | 2.03 | 1.26 | 3.26 | 0.0038 |  |
| depression4 | 3 | 3.44 | 1.94 | 6.08 | 0.0000 |  |
| hostility3 | 1 | 1.39 | 0.93 | 2.09 | 0.1069 | 0.0308 |
| hostility3 | 2 | 1.70 | 1.02 | 2.84 | 0.0411 |  |
| authority4 | 1 | 1.71 | 0.98 | 2.99 | 0.0569 | 0.0041 |
| authority4 | 2 | 2.22 | 1.21 | 4.07 | 0.0103 |  |
| authority4 | 3 | 2.75 | 1.17 | 6.47 | 0.0201 |  |
| urgency4 | 21-24 | 1.04 | 0.60 | 1.80 | 0.8901 | 0.2531 |
| urgency4 | 25-29 | 1.30 | 0.78 | 2.16 | 0.3072 |  |
| urgency4 | 30-40 | 1.28 | 0.75 | 2.21 | 0.3668 |  |
| jobstress | Hi frus & low satis | 2.06 | 0.90 | 4.69 | 0.0866 |  |

## Multiple exposure models

### Cold parent + psychological variables

- Following four logistic models were fitted:
  - Includes either one of psychological variables, depression,
    hostility, authority, or time urgency
  - Always includes cold parent (none/one/both, none as the reference)
  - Also adjusting for age, BMI, education, employment, marital status,
    smoking, and stomach ulcer
  - using data that include only those subjects who were raised by
    either “two birthparents” or “two parents (one or both were not
    birth parent)
- [See the Excel table for odds ratios in the four
  models](./results/pooled_results_OR_multi_exposure_models_cold_parent.xlsx)

![](./images/pooled_results_OR_multi_exposure_models_cold_parent.png)

- In all the four models, higher odds of developing FM were observed
  when one or both parents were perceived cold, but ORs were not
  statistically significant (OR = 1.15 to 1.28 for one cold parent; 1.51
  to 1.63 for both cold)

- Among psychological characteristics:

  - Depression and authority scales were associated with significantly
    higher odds of FM in a “dose-response” manner, adjusting for cold
    parenting, demographics/lifestyle and stomach ulcer
  - However, there were no statistically significant ORs for hostility
    and time urgency scales

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

- In all the four models, significantly higher odds of developing FM
  were observed when only one of parents were perceived warm (OR = 1.59
  to 1.77). The ORs associated with no warm parents were slightly lower
  and not statistically significant (OR = 1.55 to 1.70)

- Depression and authority scales were associated with significantly
  higher odds of FM in a “dose-response” manner, adjusting for warm
  parenting, demographics/lifestyle and stomach ulcer

  - However, there were no statistically significant ORs for hostility
    and time urgency scales

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

- In all the four models, higher odds of developing FM were observed
  with cold mother, but the ORs were not statistically significant (OR =
  1.22 to 1.33).

- Depression and authority scales were associated with significantly
  higher odds of FM in a “dose-response” manner, adjusting for cold
  mother, demographics/lifestyle and stomach ulcer

  - However, there were no statistically significant ORs for hostility
    and time urgency scales

## Change log

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
