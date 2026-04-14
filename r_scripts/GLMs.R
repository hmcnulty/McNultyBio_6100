# GLMs, GLMMs, and Choosing a Distribution
# Hannah Grace McNulty
# # 4/14/2026

##########################################################################

library(tidyverse)
library(lubridate)
library(lme4)
library(car)

bee_dat <- read_csv("data/Burnham_field_data_pathogens_wide.csv")


bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)




# filtered for only positive 
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]


# continous y & continous x
# linear regression
m_cont_cont <- lm(data = df_filtered, log10_DWV_load ~ log10_BQCV_load) # not significant

summary(m_cont_cont)

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)

# distributions just to look at
hist(df_filtered$log10_DWV_load)
hist(df_filtered$log10_BQCV_load)

# continous y & categorical x
# anova design

m_cont_cat <- lm(data = df_filtered, log10_BQCV_load ~ bombus_spp)
summary(m_cont_cat)

# categorical y & continous x
# actual requiring a glm
m_cat_cont <- glm(data = bee_dat, DWV_pathogen_binary ~ log10_BQCV_load, family = binomial(link = "logit"))
summary(m_cat_cont)


# categotical y & categorical x
m_cat_cat <- glm(data = bee_dat, DWV_pathogen_binary ~ bee_caste, family = binomial(link = "logit"))
summary(m_cat_cat)



# testing for significance
# using the car(companion of applied regression) package

# build some models
bin_mod <- glm(data = bee_dat, DWV_pathogen_binary ~ bombus_spp * sampling_event + host_plant, family = binomial(link =))

gaus_mod <- lm(data = bee_dat, log10_Nosema_load ~ sampling_event * host_plant)

summary(bin_mod)
summary(gaus_mod)


# using the car package for significance
Anova(bin_mod)
Anova(gaus_mod)

#liklihood ratio test
m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1) # null model
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant) # model of interest

anova(m_dwv_null, m_dwv_full, test = "LRT") # run an anova between the models comparing them

# Likelihood ratio test: full vs reduced model
m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event) #take out host plant
#comparing full model to reduced model = host plant plays a significant role in the model)

anova(m_dwv_reduced, m_dwv_full, test = "LRT")



# random effects and nesting
# ranom effects
g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code),
  data = df_filtered)

Anova(g_bqcv_site)

# nested random effects
g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + (1 | site_code/sampling_event),
  data = df_filtered)

Anova(g_bqcv_site)


# gamma mixed model effects

# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma
nos_gamma <- glmer(
  Nosema_pathogen_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos, family = Gamma)
Anova(nos_gamma)

# log
nos_log <- lmer(
  log10_Nosema_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos)
Anova(nos_log)
