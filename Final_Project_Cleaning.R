library(readr)
library(dplyr)
library(forcats)
library(stringr)
library(ggplot2)
library(forcats)
library(stargazer)
library(ggthemes)
library(knitr)

setwd("~/Documents/Fall 2016/Data Sc")

preferences_raw <- read_csv("~/Documents/Fall 2016/Data Sc/marriage_sample1.csv") %>% 
  tibble::rownames_to_column(var="id")

#Cleaning

preferences_raw <- preferences %>% 
  rename(
    Avg = `24h Average`, 
    Total_Volume = `Total Volume`
  )

# Caste Preferences

# Levels which mean don't care: string containing "Caste no bar", "n/a", "Any Caste"

preferences <- preferences_raw %>% 
  
  # Creating caste and sub caste binary variables
  mutate(partner_caste = ifelse(Caste == "\n Any Caste \n" |
                                  grepl("Caste no bar", Caste)==TRUE |
                                  Caste == "\n None \n" |
                                  Caste == "n/a", 0, 1)) %>% 
  mutate(partner_subcaste = ifelse(`Sub Caste` == "\n Any Sub Caste \n" |
                                     `Sub Caste` == "\n None \n" |
                                     `Sub Caste` == "n/a", 0, 1)) %>% 
  
  # Remove weird case (1 obs)
  filter(!(partner_caste==0 & partner_subcaste==1)) %>% 
  
  # must be hindu for caste/ subcaste to apply
  filter(Religion=="\n Hindu") %>%  
  
  # Cleaning income variable: only keeping income denoted in Rs
  filter(grepl("Rs", `Annual Income`)==TRUE) %>%
  mutate(mult_factor = ifelse(grepl("lakh", `Annual Income`)==TRUE, 100000, 
                              ifelse(grepl("crore", `Annual Income`)== TRUE, 10000000, 1))) %>% 
  mutate(income = str_sub(`Annual Income`, 8, 1000000)) %>% 
  mutate(income = str_replace_all(income, " lakhs", "")) %>% 
  mutate(income = str_replace_all(income, " crores", "")) %>% 
  mutate(income = str_replace_all(income, ",", "")) %>% 
  mutate(income = as.numeric(income)*mult_factor) %>% 
  mutate(income_dollar = income*0.015) %>% 
  
  # Cleaning education variable: Bachelor's, Masters, Professional, PhD
  mutate(education = fct_recode(Education, 
                                "Bachelor's" = "\n B.A.",
                                "Professional" = "\n Aeronautical Engineering",
                                "Professional" = "\n Aviation Degree",
                                "Bachelor's" = "\n B.A.M.S.",
                                "Bachelor's" = "\n B.Arch",
                                "Bachelor's" = "\n B.Com.",
                                "Bachelor's" = "\n B.Ed.",
                                "Bachelor's" = "\n B.L.",
                                "Bachelor's" = "\n B.M.M.",
                                "Bachelor's" = "\n B.Sc IT/ Computer Science",
                                "Bachelor's" = "\n B.Sc.",
                                "Bachelor's" = "\n B.Sc. Nursing",
                                "Bachelor's" = "\n B.Tech.",
                                "Bachelor's" = "\n BBA",
                                "Bachelor's" = "\n BCA",
                                "Bachelor's" = "\n BDS",
                                "Bachelor's" = "\n BE",
                                "Bachelor's" = "\n BFA",
                                "Bachelor's" = "\n BFM (Financial Management)",
                                "Bachelor's" = "\n BHM (Hotel Management)",
                                "Bachelor's" = "\n BHMS",
                                "Bachelor's" = "\n BPT",
                                "Bachelor's" = "\n BPharm",
                                "Bachelor's" = "\n Bachelor Degree in Arts / Science / Commerce",
                                "Bachelor's" = "\n Bachelor Degree in Engineering / Computers",
                                "Bachelor's" = "\n Bachelor Degree in Management",
                                "Professional" = "\n CA",
                                "Professional" = "\n CFA (Chartered Financial Analyst)",
                                "Professional" = "\n CS",
                                "Professional" = "\n ICWA",
                                "Professional" = "\n LL.B.",
                                "Professional" = "\n LL.M.",
                                "Masters" = "\n M.A.",
                                "Masters" = "\n M.Arch.",
                                "Masters" = "\n M.Pharm",
                                "Masters" = "\n M.Phil.",
                                "Professional" = "\n M.S.(Engg.)",
                                "Masters" = "\n M.Sc.",
                                "Masters" = "\n M.Sc. IT / Computer Science",
                                "Masters" = "\n M.Tech.",
                                "Masters" = "\n MBA",
                                "Professional" = "\n MBBS",
                                "Masters" = "\n MCA",
                                "Masters" = "\n MCom",
                                "Masters" = "\n MD / MS (Medical)",
                                "Masters" = "\n MDS",
                                "Masters" = "\n ME",
                                "Masters" = "\n MFM (Financial Management)",
                                "Masters" = "\n MHM  (Hotel Management)",
                                "Masters" = "\n MHRM (Human Resource Management)",
                                "Masters" = "\n MPT",
                                "Masters" = "\n Master Degree in Arts / Science / Commerce",
                                "Masters" = "\n Master Degree in Management",
                                "Masters" = "\n Master Degree in Medicine",
                                "Masters" = "\n Masters Degree in Engineering / Computers",
                                "Doctorate" = "\n PGDCA",
                                "Doctorate" = "\n PGDM",
                                "Doctorate" = "\n Ph.D."
                                )) %>% 
  # cleaning height
  mutate(height=as.numeric(str_sub(Height, str_length(Height)-5, str_length(Height)-2))) %>% 
  mutate(partner_height=as.numeric(str_sub(Height_1, str_length(Height_1)-5, str_length(Height_1)-2)))

# Clean parent contact
preferences <- preferences %>% 
  mutate(parent_contact = ifelse(`Parent Contact`=="\n\t\t\t\t\t\tAvailable\n\t\t\t\t\t\t", 1, 0))

# Relevel education
preferences <- preferences %>% 
  mutate(education=fct_relevel(education, "Bachelor's")) %>% 
# Relevel job
  mutate(job=fct_relevel(`Employed in`, "\n Private Sector"))

# Clean age
preferences <- preferences %>% 
  mutate(age = as.numeric(str_match_all(Age, "[0-9]+")))

# Baseline partner caste prefs

baseline_caste <- as.numeric(table(preferences$partner_caste)[2]/
  (table(preferences$partner_caste)[1]+table(preferences$partner_caste)[2]))

## INCOME DECILES ##

# Create income deciles
preferences$income_deciles <- preferences$income_dollar %>% 
  cut(.,
      breaks=quantile(., probs=seq(0,1, by=0.10), na.rm=TRUE), 
      include.lowest=TRUE) %>% 
  as.numeric()


####################################################################################################
#EXPLORING VARIABLES################################################################################
####################################################################################################

pander(summary(preferences$income_dollar))



kable(preferences$`Drinking Habits`)
table(preferences$`Drinking Habits_1`)
table(preferences$Zodiac)
table(preferences$`Eating Habits`) #
table(preferences$`Eating Habits_1`)
table(preferences$`Body Type`)
table(preferences$`Marital Status`)
table(preferences$`Marital Status_1`)
table(preferences$Complexion)
table(preferences$height) #
table(preferences$partner_height)
table(preferences$Citizenship)
table(preferences$Citizenship_1)
table(preferences$parent_contact) #




# Understand deciles: table()

# Icnome EDA Graph
preferences %>% 
  group_by(income_deciles) %>% 
  summarize(prop_caste=mean(partner_caste)) %>% 
  ggplot(aes(x=income_deciles, y=prop_caste)) + 
  geom_point() +
  geom_smooth(method="lm") +
  theme(text = element_text(family="Verdana"), 
             axis.text.x = element_text(angle=45, hjust = 1, face = "bold"), 
             axis.text.y = element_text(face = "bold"), 
             plot.title = element_text(size=20)) +
  labs(y = "Proportion of people who stated caste prefs", x = "Income Deciles")

## TYPE OF JOB EDA ##

preferences %>% 
  group_by(`Employed in`) %>% 
  summarize(prop_caste=mean(partner_caste),
            count = n()) %>% 
  mutate(job_lab=paste(`Employed in`, " (n = ", count, ")", sep="")) %>% 
  ggplot(aes(x=fct_reorder(job_lab,prop_caste), y=prop_caste)) +
  geom_bar(stat="identity", colour="black", fill = "cadetblue2") +
  geom_hline(yintercept = baseline_caste, color = "blue") +
  theme(text = element_text(family="Verdana"), 
        axis.text.x = element_text(angle=45, hjust = 1, face = "bold"), 
        axis.text.y = element_text(face = "bold"), 
        plot.title = element_text(size=20)) +
  labs(y = "Proportion of people who stated caste prefs", x = "Type of Job")

## EDUCATION EDA ##

preferences %>% 
  group_by(education) %>% 
  summarize(prop_caste=mean(partner_caste),
            count = n()) %>% 
  mutate(edu_lab=paste(education, " (n = ", count, ")", sep="")) %>% 
  ggplot(aes(x=fct_reorder(edu_lab,prop_caste), y=prop_caste)) +
  geom_bar(stat="identity", colour="black", fill = "cadetblue2") +
  geom_hline(yintercept = baseline_caste, color = "blue") +
  theme(text = element_text(family="Verdana"), 
        axis.text.x = element_text(angle=45, hjust = 1, face = "bold"), 
        axis.text.y = element_text(face = "bold"), 
        plot.title = element_text(size=20)) +
  labs(y = "Proportion of people who stated caste prefs", x = "Education Level")


  





# I want to extract the integer from the first digit, then multiply by the correct power of 10 depending on lakhs, crores, thousand while taking into account the rest of the number.

table(preferences$partner_caste)
table(preferences$partner_subcaste)
summary(preferences$income)

table(preferences$education)

# Clean income : how to extract integer value of salary
# "\n None" or "n/a"
# 19 onwards
substring(x, 5)

# Create education categorical vars: Bachelor's, Masters, PhD

# Sector employed in, run LPM regression or logit



table(preferences$"Drinking Habits")
# All say never drink

table(preferences$"Zodiac")
# Aries, Pisces, Scorpio

table(preferences$"Annual Income")
table(preferences_unique$"Annual Income")

table(preferences$"Height")
table(preferences_unique$"Height")

preferences_unique <- preferences %>% 
  filter(!duplicated(.))

prefs_unique <- preferences %>% 
  filter(!duplicated(.$Name))

#############
#REGRESSIONS#
#############

model_1 <- glm(partner_caste ~ I(income_dollar/1000), data=preferences, family="binomial")
predict(model_1, type="response") %>% summary()
broom::tidy(model_1)
stargazer(model_1, model_2, model_3, title="Results", align=TRUE)

kable(summary(model_1)$coef, digits=2)

model_2 <- glm(partner_caste ~ education, data=preferences, family="binomial")
predict(model_2, type="response") %>% summary()
broom::tidy(model_2)

model_3 <- glm(partner_caste ~ `Employed in`, data=preferences, family="binomial")
predict(model_3, type="response") %>% summary()
broom::tidy(model_3)


model_3 <- lm(partner_caste ~ I(income/100000), data=preferences)
model_4 <- lm(partner_caste ~ `Employed in`, data=preferences)
model_5 <- glm(partner_caste ~ `Employed in`, data=preferences, family="binomial")

model_6 <- lm(partner_caste ~ education, data=preferences)
broom::tidy(model_6)

# Quadratic income model
model_7 <- lm(partner_caste ~ I(income/100000), data=preferences)
broom::tidy(model_7)
predict(model_7, type="response") %>% summary()

# Regress on income deciles
model_8 <- lm(partner_caste ~ income_quantiles, data=preferences)
predict(model_8, type="response") %>% summary()
broom::tidy(model_8)

confint(model_7)

predict(model_1, type="response") %>% hist()
predict(model_3, type="response") %>% hist()

broom::tidy(model_1)
broom::tidy(model_2)

broom::tidy(model_3)
broom:: tidy(model_4)
broom:: tidy(model_5)


breaks <- quantile(preferences$income, probs=seq(from=0, to=1, by=0.1))

preferences$income_bucket <- preferences$income %>% cut_number(5)



preferences$income_quantiles %>% table()

preferences$income_bucket %>% table()


## EDA ##

# Income distribution
summary(preferences$income_dollar)

preferences %>% 
  group_by(income_bucket) %>% 
  summarize(prop_caste=mean(partner_caste)) %>% 
  ggplot(aes(x=income_bucket, y=prop_caste)) + 
  geom_bar(stat="identity") 

# Caste by income deciles

  

preferences %>% 
  group_by(income_bucket) %>% 
  summarize(prop_subcaste=mean(partner_subcaste)) %>% 
  ggplot(aes(x=income_bucket, y=prop_subcaste)) + 
  geom_point()

# 'Sub caste by income deciles
preferences %>% 
  group_by(income_deciles) %>% 
  summarize(prop_subcaste=mean(partner_subcaste)) %>% 
  ggplot(aes(x=income_deciles, y=prop_subcaste)) + 
  geom_point() +
  geom_smooth(method="lm", formula = y ~ x + I(x^2))


# Confidence Interval Plots

y <- confint(model_2)
y1 <- y[2:4, 1:2]
y1 <- as.data.frame(y1)
y1$Degree <- "Professional"
y1$Degree[2] <- "Masters"
y1$Degree[3] <- "Doctorate"
names(y1)[3] <- "Degree"
names(y1)[1] <- "Lower_Bound"
names(y1)[2] <- "Upper_Bound"
ggplot(y1,aes(factor(Degree), y = (Lower_Bound+Upper_Bound)/2, ymin=Lower_Bound,ymax=Upper_Bound)) + 
  geom_pointrange() + 
  geom_hline(yintercept = 0, color = "violetred4") +
  coord_flip() +
  labs(x = "Highest Degree", 
       y = "95% Confidence Range of Probability of Having Caste Preferences") +
  theme_few()



