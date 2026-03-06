
# Required packages
pacs <- c("tidyverse", "readxl", "janitor", "broom", "mice", "tableone", "gtsummary")
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
    
    # Family structure: Based on AHS-2 variable "RAISED"
    # Replace "Raised by" variable that appears in the manuscript
    fam_struct = case_when(
      raised == 1 ~ 0,
      raised == 2 ~ 1,
      raised %in% 3:4 ~ 2,
      raised == 5     ~ 3
    ),
    fam_struct = factor(fam_struct, labels = c("Two birthparents", "Two parents*", "Single-birthparent", "Other")),
    
    # Personality traits
    # Note reversed signs
    urgency     = (11 - rushed) + competv + tasks + (11 - fasteat),
    urgency4    = cut(urgency, breaks = c(4, 21, 25, 30, Inf), right = FALSE),
    urgency4    = factor(urgency4, labels = c("4-20", "21-24", "25-29", '30-40')),
    
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
    jobstress = factor(jobstress, labels = c("Low frus or hi satis", "Hi frus & low satis"))
  )


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

# Cross-tab between fibroy (dx year) and fibro (treated or not)
overlap_f %>%
  mutate(
    fibroy = factor(fibroy, labels = c("<5 yrs", "5-9 yrs", "10-14 yrs", "15-19 yrs", "20+ yrs"), levels = 1:5),
    fibro  = factor(fibro,  labels = c("No", "Yes"))
    ) %>% 
  tabyl(fibroy, fibro) %>% 
  adorn_totals(where = c("row", "col"))

# Load imputed data -------------------------------------------------------

# Load imputed data (post-processed) from RDS file
imputed_processed <- readRDS("imputed_processed.rds")


 # Table 1 -----------------------------------------------------------------

# Variables to be included 
# all vars come from AHS-1, except for family structure
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
  "fam_struct",
  "depression4",
  "hostility3",
  "authority4",
  "urgency4",
  "jobstress"
)

# Use the first imputation
imp1 <- complete(imputed_processed, action = 1)

imp1 %>%
  select(all_of(table_vars), fm_stat) %>% 
  tbl_summary(
    by = "fm_stat",
    statistic = list(all_continuous() ~ "{mean} ({sd})"),
    digits = all_continuous() ~ 1,
    type = list(employ2 ~ "categorical", cold_mother ~ "categorical", cold_father ~ "categorical"),
    # missing = "always",
    # missing_text = "(Missing)"
  ) %>%
  add_overall() %>% 
  add_p(
    test = list(all_continuous() ~ "t.test"),
    pvalue_fun = label_style_pvalue(digits = 3),
  )

# Check the number of missing values
# overlap_f %>% 
#   select(all_of(table_vars)) %>%
#   select(-agecat, -bmicat) %>% 
#   map(~ sum(is.na(.x))) %>% 
#   data.frame(n.miss = unlist(.)) %>% 
#   select(n.miss) %>% 
#   mutate(pct_miss = round(n.miss / nrow(overlap_f) * 100, 2))

# Distribution of continuous covariates -----------------------------------
# Using the first imputed dataset

imp1 %>% 
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


# Multicollinearity among exposure variables ------------------------------
# Using the first imputed data

# Correlation matrix
cm <- imp1 %>% 
  select(all_of(ind_vars)) %>% 
  mutate_all(as.numeric) %>% 
  cor(method = "spearman", use = "pairwise")

# Display coorrelation matrix: Lower triangle only
cm[upper.tri(cm, diag = TRUE)] <- NA
print(round(cm, 2), na.print = "")


# Logistic regression: Unadjusted ORs -------------------------------------

# Exposure variables of interest
ind_vars <- c(
  "parent_warm_rev",
  "parent_cold",
  "cold_mother",
  "cold_father",
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

# Function to run logistic reg on mids object
mice_logistic <- function(formula){
  model_fits <- with(imputed_processed, glm(as.formula(formula), family = "binomial"))
  pooled_results <- pool(model_fits)
  out <- summary(pooled_results, conf.int = TRUE, exponentiate = TRUE) %>% 
    slice(-1) %>% 
    select(term, estimate, conf.low, conf.high, p.value)
}

# Create models
model_formulas <- paste0("fibro_inc ~ ", ind_vars)

# Run models
unadjusted_results <- map(model_formulas, ~ mice_logistic(.x)) %>% 
  bind_rows() %>%
  remove_rownames() %>% 
  mutate(
    predictor = str_extract(as.character(term), paste0(ind_vars, collapse = "|")),
    term = gsub(paste0(ind_vars, collapse = "|"), "", term)
    ) %>% 
  select(predictor, everything())

# Trend p-values
model_formulas <- paste0("fibro_inc ~ as.numeric(", ind_vars, ")")
unadjusted_trendp <- map(model_formulas, ~ mice_logistic(.x)) %>% 
  bind_rows() %>%
  remove_rownames() %>% 
  mutate(term = gsub("as.numeric\\(|\\)", "", term)) %>% 
  rename(trend.p = p.value) %>% 
  filter(!(term %in% c("jobstress", "cold_mother", "cold_father"))) %>% 
  mutate(trend.p = format.pval(trend.p, digits = 2)) %>% 
  select(term, trend.p) 

unadjusted_results %>% 
  left_join(unadjusted_trendp, by = c("predictor" = "term")) %>% 
  rename(odds.ratio = estimate) %>% 
  mutate(across(odds.ratio:conf.high, round, 2)) %>%
  group_by(predictor) %>%
  mutate(trend.p = if_else(row_number() == 1, trend.p, NA_character_)) %>%
  ungroup() %>% 
  print(n = Inf)

# Logistic regression: Adjusted ORs ---------------------------------------

# Create models
model_formulas <- paste0("fibro_inc ~ ", ind_vars, " + agein + ahs1_bmi + educat3 + employ2 + marital3")

# Run models
adjusted_results <- map(model_formulas, ~ mice_logistic(.x)) %>% 
  bind_rows() %>%
  remove_rownames() %>% 
  mutate(
    predictor = str_extract(as.character(term), paste0(ind_vars, collapse = "|")),
    term = gsub(paste0(ind_vars, collapse = "|"), "", term)
    ) %>% 
  filter(!is.na(predictor)) %>% 
  select(predictor, everything())

# Trend p-values
model_formulas <- paste0("fibro_inc ~ as.numeric(", ind_vars, ")" ,  " + agein + ahs1_bmi + educat3 + employ2 + marital3")
adjusted_trendp <- map(model_formulas, ~ mice_logistic(.x)) %>% 
  bind_rows() %>%
  remove_rownames() %>% 
  mutate(
    predictor = str_extract(as.character(term), paste0(ind_vars, collapse = "|")),
    term = gsub("as.numeric\\(|\\)", "", term)
    ) %>% 
  rename(trend.p = p.value) %>% 
  filter(predictor %in% ind_vars) %>% 
  filter(!(term %in% c("jobstress", "cold_mother", "cold_father"))) %>% 
  mutate(trend.p = format.pval(trend.p, digits = 2)) %>% 
  select(predictor, trend.p) 

adjusted_results %>% 
  left_join(adjusted_trendp, by = "predictor") %>% 
  group_by(predictor) %>%
  mutate(trend.p = if_else(row_number() == 1, trend.p, NA_character_)) %>%
  ungroup() %>% 
  print(n = Inf)

# Checking non-linearity on BMI -------------------------------------------

# Using the first imputed data

# GAM model including BMI cubic splines
gam_bmi_nonlin <- mgcv::gam(
  fibro_inc ~ agein + s(ahs1_bmi, bs = "cr") + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
  )

# BMI not significant
# Effective df is very close to 1, suggesting the relationship is linear 
summary(gam_bmi_nonlin)

# LR test for non-linearity
# GAM model including BMI cubic splines, using unpenalized model
gam_bmi_nonlin_unpenal <- mgcv::gam(
  fibro_inc ~ agein + s(ahs1_bmi, bs = "cr", fx = TRUE) + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
)

summary(gam_bmi_nonlin_unpenal)

# Linear model
gam_bmi_lin <- mgcv::gam(
  fibro_inc ~ agein + ahs1_bmi + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
)

# Non-linearity not significant
anova(gam_bmi_nonlin_unpenal, gam_bmi_lin)

# Checking non-linearity on age -------------------------------------------

# GAM model including age cubic splines
gam_age_nonlin <- mgcv::gam(
  fibro_inc ~ s(agein, bs = "cr") + ahs1_bmi + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
  )

# Ages EFD is close to 1, suggesting the relationship is linear
summary(gam_age_nonlin)

# Using unpenalized model 
gam_age_nonlin_unpenal <- mgcv::gam(
  fibro_inc ~ s(agein, bs = "cr", fx = TRUE) + ahs1_bmi + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
  )

gam_age_lin <- mgcv::gam(
  fibro_inc ~ agein + ahs1_bmi + educat3 + employ2 + marital3,
  family = binomial, 
  data = overlap_f,
  method = "GCV.Cp"
)

anova(gam_age_nonlin_unpenal, gam_age_lin)
