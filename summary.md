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
  except for…. Variable names in the data were indicated below
  - See also: Table 1 of the manuscript
- Early life experiences (See [the questions in
  AHS-1](./images/AHS1_Q37.png))
  - Warm parenting: `mwarm`, `fwarm`
  - Cold parenting: `mcold`, `fcold`
  - Parent situation:
  - Raised by:
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

## Descriptive table

|  | level | Non-case | Case | p | test |
|:---|:---|:---|:---|:---|:---|
| n |  | 3000 | 136 |  |  |
| agecat (%) | 20-29 | 209 ( 7.0) | 17 (12.5) | 0.002 |  |
|  | 30-39 | 757 (25.2) | 47 (34.6) |  |  |
|  | 40-49 | 962 (32.1) | 41 (30.1) |  |  |
|  | 50-59 | 822 (27.4) | 26 (19.1) |  |  |
|  | 60+ | 250 ( 8.3) | 5 ( 3.7) |  |  |
| agein (mean (SD)) |  | 45.50 (10.29) | 41.80 (10.02) | \<0.001 |  |
| bmicat (%) | \<25 | 1957 (71.5) | 91 (76.5) | 0.215 |  |
|  | 25-\<30 | 542 (19.8) | 23 (19.3) |  |  |
|  | 30+ | 237 ( 8.7) | 5 ( 4.2) |  |  |
| ahs1_bmi (mean (SD)) |  | 23.69 (4.17) | 22.87 (3.37) | 0.035 |  |
| educat3 (%) | Less than HS | 630 (21.0) | 25 (18.4) | 0.678 |  |
|  | Some college | 1439 (48.1) | 70 (51.5) |  |  |
|  | College grad+ | 925 (30.9) | 41 (30.1) |  |  |
| employ2 (%) | No | 1116 (37.8) | 56 (43.1) | 0.258 |  |
|  | Yes | 1840 (62.2) | 74 (56.9) |  |  |
| marital3 (%) | Not married | 173 ( 5.8) | 8 ( 5.9) | 0.702 |  |
|  | Married | 2557 (85.3) | 113 (83.1) |  |  |
|  | Wid/Div/Sep | 268 ( 8.9) | 15 (11.0) |  |  |
| smoke2 (%) | Never | 2681 (90.4) | 105 (80.2) | \<0.001 |  |
|  | Ever | 285 ( 9.6) | 26 (19.8) |  |  |
| parent_warm (%) | None | 340 (11.3) | 20 (14.7) | 0.006 |  |
|  | One | 880 (29.3) | 54 (39.7) |  |  |
|  | Both | 1780 (59.3) | 62 (45.6) |  |  |
| parent_cold (%) | None | 2040 (68.0) | 80 (58.8) | 0.048 |  |
|  | One | 769 (25.6) | 42 (30.9) |  |  |
|  | Both | 191 ( 6.4) | 14 (10.3) |  |  |
| parent_situ (%) | Married in home | 2422 (88.9) | 113 (89.7) | 0.901 |  |
|  | One died/sep/div | 302 (11.1) | 13 (10.3) |  |  |
| raised_by (%) | Both | 2422 (89.3) | 113 (88.3) | 0.405 |  |
|  | One | 231 ( 8.5) | 10 ( 7.8) |  |  |
|  | Non-parents | 58 ( 2.1) | 5 ( 3.9) |  |  |
| depression4 (%) | 0 | 1448 (50.6) | 48 (38.1) | \<0.001 |  |
|  | 1 | 783 (27.4) | 31 (24.6) |  |  |
|  | 2 | 443 (15.5) | 29 (23.0) |  |  |
|  | 3 | 185 ( 6.5) | 18 (14.3) |  |  |
| hostility3 (%) | 0 | 1296 (43.9) | 42 (32.3) | 0.011 |  |
|  | 1 | 1238 (41.9) | 60 (46.2) |  |  |
|  | 2 | 420 (14.2) | 28 (21.5) |  |  |
| authority4 (%) | 0 | 630 (21.6) | 17 (13.2) | 0.110 |  |
|  | 1 | 1414 (48.5) | 65 (50.4) |  |  |
|  | 2 | 707 (24.3) | 38 (29.5) |  |  |
|  | 3 | 162 ( 5.6) | 9 ( 7.0) |  |  |
| urgency4 (%) | 4-14 | 156 ( 5.4) | 4 ( 3.1) | 0.682 |  |
|  | 15-25 | 1446 (50.2) | 64 (49.6) |  |  |
|  | 26-29 | 638 (22.1) | 31 (24.0) |  |  |
|  | 30+ | 642 (22.3) | 30 (23.3) |  |  |
| jobstress (%) | Low frus or hi satis | 2887 (97.7) | 124 (94.7) | 0.050 |  |
|  | Hi frus & low satis | 67 ( 2.3) | 7 ( 5.3) |  |  |

## Logistic models
