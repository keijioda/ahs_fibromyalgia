
# Required packages
pacs <- c("tidyverse", "readxl", "janitor", "broom", "haven", "tableone", "gtsummary")
sapply(pacs, require, character.only = TRUE)

# Read SAS data
# n.obs = 5067
overlap0 <- read_excel("./data/choi_principle.xls", na = ".Z") %>% 
  clean_names() %>% 
  rename(analysisid = ahs1_qid_to_analysis_id)

# Check ID variables
# Should have 5067 -- all unique
overlap0 %>% 
  distinct(analysisid, ahs2_qid) %>% 
  nrow()

# Sex
# n.females = 3136
overlap0 %>% count(across(c(ahs1_sex, sex)))


# Overlap population, female only -----------------------------------------

# n = 3136 women
overlap_f <- overlap0 %>% 
  filter(sex == 0) %>% 
  
  # Define incident cases of fibromyalgia
  mutate(
    fibro_inc = case_when(
      (fibroy >= 1 & fibroy <= 4) | fibro == 2 ~ 1,
      TRUE ~ 0
      ),
    fm_stat = factor(fibro_inc, labels = c("Non-case", "Case"))
  ) %>%

  # Demographics and lifestyles
  mutate(
    agecat = cut(agein, breaks = c(20, 30, 40, 50, 60, Inf), right = FALSE),
    agecat = factor(agecat, labels = c("20-29", "30-39", "40-49", "50-59", "60+")),
    
    bmicat = cut(ahs1_bmi, breaks = c(0, 25, 30, Inf), right = FALSE),
    bmicat = factor(bmicat, labels = c("<25", "25-<30", "30+")),
      
    educat3 = recode(educcq, 1, 1, 1, 2, 3, 3),
    educat3 = factor(educat3, labels = c("Less than HS", "Some college", "College grad+")),
    
    marital3 = recode(maritlcq, 1, 2, 3, 3),
    marital3 = factor(marital3, labels = c("Not married", "Married", "Wid/Div/Sep")),
    
    smoke2 = recode(smoke, 1, 1, 0),
    smoke2 = factor(smoke2, labels = c("Never", "Ever")),
    
    employ2 = factor(workpay, labels = c("No", "Yes"))
  ) %>% 
  
  # Parenting
  mutate(
    parent_cold = case_when(
      (mcold == 1 & fcold == 0) | (mcold == 0 & fcold == 1) ~ 1,
      mcold == 1 & fcold == 1 ~ 2,
      mcold == 2 & fcold == 2 ~ NA_integer_,
      TRUE ~ 0
    ),
    parent_cold = factor(parent_cold, labels = c("None", "One", "Both")),
    
    cold_mother = case_when(
      mcold == 0 ~ 0,
      mcold == 1 ~ 1,
      mcold == 2 ~ NA_integer_
    ),
    cold_mother = factor(cold_mother, labels = c("No", "Yes")),
    
    cold_father = case_when(
      fcold == 0 ~ 0,
      fcold == 1 ~ 1,
      fcold == 2 ~ NA_integer_
    ),
    cold_father = factor(cold_father, labels = c("No", "Yes")),
    
    parent_warm = case_when(
      (mwarm == 1 & fwarm == 0) | (mwarm == 0 & fwarm == 1) ~ 1,
      mwarm == 1 & fwarm == 1 ~ 2,
      mwarm == 2 & fwarm == 2 ~ NA_integer_,
      TRUE ~ 0
    ),
    parent_warm = factor(parent_warm, labels = c("None", "One", "Both")),
    
    # Parent situation -- Need to check
    # parent_situ = case_when(
    #   raised %in% 1:2 ~ 0,
    #   e2q9r1 == 1 | e2q9r2 == 1 | e2q9r3 == 1 | e2q9r4 == 1 ~ 1
    # ),
    # parent_situ = factor(parent_situ, labels = c("Married in home", "One died/sep/div")),
    
    # Raised by -- Need to check
    fam_struct = case_when(
      raised == 1 ~ 0,
      raised == 2 ~ 1,
      raised %in% 3:4 ~ 2,
      raised == 5     ~ 3
    ),
    fam_struct = factor(fam_struct, labels = c("Two birthparents", "Two parents*", "Single-birthparent", "Other")),
    
    # Personality traits
    # Note reversed signs -- Need to check
    urgency     = (11 - rushed) + competv + tasks + (11 - fasteat),
    urgency4    = cut(urgency, breaks = c(4, 15, 26, 30, Inf), right = FALSE),
    urgency4    = factor(urgency4, labels = c("4-14", "15-25", "26-29", '30+')),
    
    depression  = (2 - overcome) + (2 - happy) + (family - 1),
    depression4 = factor(depression),
    
    authority   = (2 - respect) + (2 - counton) + (2 - showfel),
    authority4  = factor(authority),
    
    hostility   = case_when(
      geteven == 2 & dislike == 1 ~ 0,
      (geteven == 1 & dislike == 1) | (geteven == 2 & dislike == 2) ~ 1, 
      geteven == 1 & dislike == 2 ~ 2,
    ),
    hostility3  = factor(hostility),
    
    jobstress = case_when(
      jobsat %in% 1:2 | jobfrus %in% 3:4 ~ 0,
      jobsat %in% 3:4 & jobfrus %in% 1:2 ~ 1
    ),
    # jobstress = ifelse(is.na(jobsat) | is.na(jobfrus), NA_integer_, jobstress),
    jobstress = factor(jobstress, labels = c("Low frus or hi satis", "Hi frus & low satis"))
  )

overlap_f %>% 
  filter(raised == 1) %>% 
  select(starts_with('e2')) %>% 
  distinct() %>% 
  print(n = Inf)

overlap_f %>% 
  filter(raised == 5) %>% 
  count(across(starts_with("e2q9r")), sort = TRUE)

# Fibromyalgia cases ------------------------------------------------------

# Fibromyalgia variables -- years and treated
names(overlap_f) %>% 
  grep("fibro", ., value = TRUE) %>% 
  map(~ count(overlap_f, across(all_of(.x))))

# Those who have ever diagnosed among females (self-report)
# n = 127
overlap_f %>% 
  filter(fibroy > 0) %>% 
  nrow()

# Those who have treated in the last 12 mo among females (self-report)
# n = 64
overlap_f %>% 
  filter(fibro == 2) %>% 
  nrow()

# Those who diagnosed or treated among females
# n = 136
overlap_f %>% 
  filter(fibroy > 0 | fibro == 2) %>% 
  nrow()

overlap_f %>% 
  count(fibro_inc) %>% 
  mutate(pct = n / sum(n) * 100)

overlap_f %>%
  mutate(
    fibroy = factor(fibroy, labels = c("<5 yrs", "5-9 yrs", "10-14 yrs", "15-19 yrs", "20+ yrs"), levels = 1:5),
    fibro  = factor(fibro,  labels = c("No", "Yes"))
    ) %>% 
  tabyl(fibroy, fibro) %>% 
  adorn_totals(where = c("row", "col"))

 # Table 1 -----------------------------------------------------------------

# Variables to be included 
# It appears that all vars come from AHS-1
table_vars <- c(
  "agecat",
  "agein",
  "bmicat",
  "ahs1_bmi",
  "educat3",
  "employ2",
  "marital3",
  "smoke2",
  "parent_warm",
  "parent_cold",
  "cold_mother",
  "cold_father",
  # "parent_situ",
  # "raised_by",
  "fam_struct",
  "depression4",
  "hostility3",
  "authority4",
  "urgency4",
  "jobstress"
)

# overlap_f %>% CreateTableOne(
#   vars = table_vars, 
#   strata = "fm_stat", 
#   data = .,
#   includeNA = TRUE
#   ) %>% 
#   print(showAllLevels = TRUE)

overlap_f %>%
  select(all_of(table_vars), fm_stat) %>% 
  tbl_summary(
    by = "fm_stat",
    statistic = list(all_continuous() ~ "{mean} ({sd})"),
    digits = all_continuous() ~ 1,
    type = list(employ2 ~ "categorical", cold_mother ~ "categorical", cold_father ~ "categorical"),
    missing = "always",
    missing_text = "(Missing)"
  ) %>%
  add_p(
    test = list(all_continuous() ~ "t.test"),
    pvalue_fun = label_style_pvalue(digits = 3),
  )

# Check the number of missing values
overlap_f %>% 
  select(all_of(table_vars)) %>%
  select(-agecat, -bmicat) %>% 
  map(~ sum(is.na(.x))) %>% 
  data.frame(n.miss = unlist(.)) %>% 
  select(n.miss) %>% 
  mutate(pct_miss = round(n.miss / nrow(overlap_f) * 100, 2))


# Distribution of continuous covariates -----------------------------------

overlap_f %>% 
  select(agein, ahs1_bmi) %>% 
  pivot_longer(1:2, names_to = "Variable", values_to = "Value") %>% 
  ggplot(aes(x = Value)) +
  geom_histogram(aes(y = after_stat(density)), fill = "gray") +
  geom_density(color = "cornflowerblue", linewidth = 1) +
  facet_wrap(~ Variable, scales = "free")

# Exposure of interest ----------------------------------------------------

# Exposure variables of interest
ind_vars <- c(
  "parent_warm",
  "parent_cold",
  "cold_mother",
  "cold_father",
  # "parent_situ",
  # "raised_by",
  "fam_struct",
  "depression4",
  "hostility3",
  "authority4",
  "urgency4",
  "jobstress"
)

# Covariates
covars <- c(
  "agein",
  "ahs1_bmi",
  "educat3",
  "employ2",
  "marital3"
)

# Logistic regression: Unadjusted ORs -------------------------------------

# Reverse order for parent_warm
overlap_f2 <- overlap_f %>% 
  mutate(parent_warm = fct_rev(parent_warm))

# Unadjusted ORs
# Create models
model_formulas <- map(ind_vars, ~reformulate(.x, response = "fibro_inc")) %>% 
  setNames(ind_vars)

# Run models
unadjusted_results <- map(model_formulas, ~glm(.x, data = overlap_f2, family = "binomial"))

# Multivariate Wald tests
# Significant: parent_warm, depression4, hostility3
unadjusted_results %>% 
  map_dfc(~anova(.x)[["Pr(>Chi)"]]) 

# Get unadjusted ORs
unadj_OR <- map_dfr(unadjusted_results, tidy, .id = "predictor") %>%
  mutate(
    odds_ratio = exp(estimate), 
    conf_low = exp(estimate - 1.96 * std.error),
    conf_high = exp(estimate + 1.96 * std.error)
  ) %>%
  filter(term != "(Intercept)")

unadj_OR <- unadj_OR %>%  
  mutate(predictor = factor(predictor, levels = unique(unadj_OR$predictor))) %>% 
  select(predictor, term, odds_ratio, conf_low, conf_high, p.value) %>% 
  mutate(term = gsub(paste0(ind_vars, collapse = "|"), "", term))

unadj_OR %>% split(.$predictor)

# unadj_OR %>% 
#   write_csv("./results/All_models_unadjusted_ORs.csv")

# Trend p-values
ind_vars_num <- paste0("as.numeric(", ind_vars, ")")
model_formulas <- map(ind_vars_num, ~reformulate(.x, response = "fibro_inc")) %>% 
  setNames(ind_vars)

trend_p <- model_formulas %>% 
  map(~ glm(.x, data = overlap_f2, family = "binomial")) %>% 
  map_dbl(~ coef(summary(.x))[2, "Pr(>|z|)"])

trend_p_df <- data.frame(trend_p = trend_p) %>% 
  rownames_to_column("predictor") %>% 
  filter(predictor != "jobstress") %>% 
  mutate(trend_p = format.pval(trend_p, digits = 2))

map(trend_p_df, class)

unadj_OR %>% 
  left_join(trend_p_df, by = "predictor") %>% 
  group_by(predictor) %>%
  mutate(trend_p = if_else(row_number() == 1, trend_p, NA_character_)) %>%
  ungroup()

# Logistic regression: Adjusted ORs ---------------------------------------

# Adjusted ORs
# Create models
model_formulas <- map(ind_vars, ~reformulate(c(.x, covars), response = "fibro_inc")) %>% 
  setNames(ind_vars)

# Run models
adjusted_results <- map(model_formulas, ~glm(.x, data = overlap_f2, family = "binomial"))

# Get adjusted ORs
adjusted_OR <- map_dfr(adjusted_results, tidy, .id = "predictor") %>%
  mutate(
    odds_ratio = exp(estimate), 
    conf_low = exp(estimate - 1.96 * std.error),
    conf_high = exp(estimate + 1.96 * std.error)
  ) %>%
  filter(term != "(Intercept)") %>% 
  select(predictor, term, odds_ratio, conf_low, conf_high, p.value) 

# adjusted_OR %>% 
#   write_csv("./results/All_models_adjusted_ORs.csv")

# Trend p-values
ind_vars_num <- paste0("as.numeric(", ind_vars, ")")
model_formulas <- map(ind_vars_num, ~reformulate(c(.x, covars), response = "fibro_inc")) %>% 
  setNames(ind_vars)

trend_p <- model_formulas %>% 
  map(~ glm(.x, data = overlap_f2, family = "binomial")) %>% 
  map_dbl(~ coef(summary(.x))[2, "Pr(>|z|)"])

trend_p_df <- data.frame(trend_p = trend_p) %>% 
  rownames_to_column("predictor") %>% 
  filter(predictor != "jobstress") %>% 
  mutate(trend_p = format.pval(trend_p, digits = 2))

adjusted_OR %>% 
  filter(grepl(paste0(ind_vars, collapse = "|"), term)) %>% 
  left_join(trend_p_df, by = "predictor") %>% 
  group_by(predictor) %>%
  mutate(trend_p = if_else(row_number() == 1, trend_p, NA_character_)) %>%
  ungroup()
