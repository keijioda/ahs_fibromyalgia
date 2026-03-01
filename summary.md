AHS Overlap Population Fibromyalgia Study
================

## Datasets

- The overlap population between AHS-1 and AHS-2
  - See the manuscript how record linkage was done
- Contains 5067 subjects. Among them, there were n = 3136 women.

## Outcome

- Self-reported diagnosis of fibromyalgia from **AHS-2 baseline**
  questionnaire ([Page A4, under the section of musculoskeletal
  system](https://wiki.ahs2.org/_media/baseline:ahs_baseline_v3_-_page_a4.jpg))
  - Years since first diagnosis: Less than 5 years ago, 5-9 yrs ago,
    10-14 yrs ago, 20+ yrs ago
  - Have you been treated for this in the last 12 months?: No or Yes
  - See the crosstab below
    - 127 females reported their FM diagnosis. None of these were
      diagnosed 20+ years ago
    - 64 females were treated in the last 12 month. Among them, 9
      females did not indicate their diagnosis year
  - \[**Need to check**\] If diagnosed \< 20 years ago or treated within
    the last 12 months, they were considered as incident cases
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
  - Warm parenting: `mwarm`, `fwarm`
  - Cold parenting: `mcold`, `fcold`
  - ~~Parent situation~~: Removed or replaced with “family structure”
  - \[**Need to check**\] Family structure
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
    - \[**Need to check**\] The distribution of this score does **NOT**
      match with those shown in Table 3 of the manuscript
- Job stress
  - Based on AHS-1 Q21 and Q22 (See [the questions in
    AHS-1](./images/AHS1_Q21.png))
    - `jobsat`: How well satisfied are you with job
    - `jobfrus`: How often are you irritated or frustrated by your job
    - If answered (“Not too satisfied” OR “Not at all satisfied”) AND
      (“Always” OR “Often”), then categorized to “High frustration and
      low satisfaction”
      - Otherwise categorized to “Low frustration or high satisfaction”

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

- \[**Need to check**\] Note the number of missing values as well. **How
  should we handle the missing values?** Any inclusion/exclusion
  criteria?

<img src="summary_files/figure-gfm/descriptive_table-1.png" alt="" width="50%" />

## Distribution for age and BMI

- See below for distributions of age and BMI:

![](summary_files/figure-gfm/check_distribution-1.png)<!-- -->

## Logistic models

- For each exposure variable of interest, first we fit logistic models
  using incident fibromyalgia as the outcome to obtain unadjusted odds
  ratios associated with the exposure variable

### Unadjusted odds ratios

- Unadjusted odds ratios for each exposure variable are shown below
  - Note that reference groups are not shown in the table
    - For warm parenting, the reference is “Both”
    - For other exposure variables, the reference is the first level
      shown in the descriptive table
- There was a significant trend for warm/cold parenting, depression,
  hostility, authority

| predictor   | term                | odds_ratio | conf_low | conf_high | p.value | trend.p |
|:------------|:--------------------|-----------:|---------:|----------:|--------:|:--------|
| parent_warm | One                 |       1.76 |     1.21 |      2.56 |  0.0030 | 0.0051  |
| parent_warm | None                |       1.69 |     1.01 |      2.83 |  0.0471 |         |
| parent_cold | One                 |       1.39 |     0.95 |      2.04 |  0.0897 | 0.0144  |
| parent_cold | Both                |       1.87 |     1.04 |      3.36 |  0.0367 |         |
| fam_struct  | Two parents\*       |       2.03 |     1.17 |      3.52 |  0.0116 | 0.1382  |
| fam_struct  | Single-birthparent  |       1.00 |     0.51 |      1.94 |  0.9993 |         |
| fam_struct  | Other               |       1.99 |     0.78 |      5.08 |  0.1493 |         |
| depression4 | 1                   |       1.19 |     0.75 |      1.89 |  0.4491 | 4.1e-05 |
| depression4 | 2                   |       1.97 |     1.23 |      3.17 |  0.0048 |         |
| depression4 | 3                   |       2.94 |     1.67 |      5.15 |  0.0002 |         |
| hostility3  | 1                   |       1.50 |     1.00 |      2.24 |  0.0497 | 0.0030  |
| hostility3  | 2                   |       2.06 |     1.26 |      3.36 |  0.0040 |         |
| authority4  | 1                   |       1.70 |     0.99 |      2.93 |  0.0541 | 0.0248  |
| authority4  | 2                   |       1.99 |     1.11 |      3.56 |  0.0203 |         |
| authority4  | 3                   |       2.06 |     0.90 |      4.70 |  0.0867 |         |
| urgency4    | 15-25               |       1.73 |     0.62 |      4.80 |  0.2959 | 0.4409  |
| urgency4    | 26-29               |       1.89 |     0.66 |      5.45 |  0.2354 |         |
| urgency4    | 30+                 |       1.82 |     0.63 |      5.25 |  0.2661 |         |
| jobstress   | Hi frus & low satis |       2.43 |     1.09 |      5.41 |  0.0292 |         |

### Adjusted odds ratios

- This time, we fit multivariable logistic models adjusting for:
  - Age as continuous
  - BMI as continuous
  - Education as categorical
  - Employment as binary (no/yes)
  - Marital status as categorical
- Adjusted odds ratios for each exposure variable are shown below
  - Note that reference groups are not shown in the table
    - For warm parenting, the reference is “Both”
    - For other exposure variables, the reference is the first level
      shown in the descriptive table
- There was a significant trend for warm/cold parenting, depression,
  hostility, authority

| predictor   | term                | odds_ratio | conf_low | conf_high | p.value | trend.p |
|:------------|:--------------------|-----------:|---------:|----------:|--------:|:--------|
| parent_warm | One                 |       1.89 |     1.26 |      2.83 |  0.0020 | 0.0145  |
| parent_warm | None                |       1.53 |     0.83 |      2.81 |  0.1696 |         |
| parent_cold | One                 |       1.55 |     1.03 |      2.34 |  0.0364 | 0.0065  |
| parent_cold | Both                |       2.05 |     1.08 |      3.90 |  0.0285 |         |
| fam_struct  | Two parents\*       |       2.07 |     1.14 |      3.76 |  0.0173 | 0.1706  |
| fam_struct  | Single-birthparent  |       1.24 |     0.63 |      2.44 |  0.5355 |         |
| fam_struct  | Other               |       1.40 |     0.42 |      4.60 |  0.5828 |         |
| depression4 | 1                   |       1.29 |     0.79 |      2.12 |  0.3075 | 7.8e-05 |
| depression4 | 2                   |       2.05 |     1.22 |      3.44 |  0.0066 |         |
| depression4 | 3                   |       3.14 |     1.69 |      5.83 |  0.0003 |         |
| hostility3  | 1                   |       1.46 |     0.95 |      2.25 |  0.0865 | 0.0179  |
| hostility3  | 2                   |       1.85 |     1.08 |      3.17 |  0.0246 |         |
| authority4  | 1                   |       1.66 |     0.92 |      2.97 |  0.0909 | 0.0071  |
| authority4  | 2                   |       2.10 |     1.12 |      3.95 |  0.0215 |         |
| authority4  | 3                   |       2.79 |     1.18 |      6.60 |  0.0200 |         |
| urgency4    | 15-25               |       1.92 |     0.59 |      6.26 |  0.2782 | 0.3896  |
| urgency4    | 26-29               |       2.12 |     0.63 |      7.18 |  0.2256 |         |
| urgency4    | 30+                 |       2.10 |     0.62 |      7.12 |  0.2342 |         |
| jobstress   | Hi frus & low satis |       2.71 |     1.19 |      6.14 |  0.0172 |         |
