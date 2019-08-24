###################################################################################################################

#########################  Master Thesis OK Computer: Job Applicants's Choice regarding Algorithmic Screening #####

###################################################################################################################



###########################################

## Part 0: Specifying the packages used within this paper. (if you don't have these packages already installed, 
## simply delete the "#" before the lines "install.packages below)

###########################################

## Specify packages needed 
library(tidyverse)
library(ggplot2)
library(xlsx)
library(Amelia)
library(compare)
library(ggpubr)
library(Hmisc)
library(psych)
library(sandwich)
library(pander)
library(broom)
library(xlsx)
library(RColorBrewer)
library(jtools)
library(stargazer)

## Install packages needed: (Needed for the code to run, if needed to install; remove the hashtags in front of it)

#install.packages("compare")
#install.packages("Amelia")
#install.packages("ggplot2")
#install.packages("xlsx")
#install.packages("tidyverse")
#install.packages("stargazer")
#install.packages("ggpubr")
#install.packages("Hmisc")
#install.packages("psych")
#install.packages("sandwich")
#install.packages("pander")
#install.packages("broom")
#install.packages("jtools")
install.packages("huxreg")



###########################################

## Part 1: Merging and cleaning the data:
## If you are interested in the analysis, please jump directly to the cleaned dataset in step 2

###########################################

## Read in the data

setwd("~/Utrecht/Master Thesis/After February/Data & Analysis/Final Data")

## Load first data set and take the 133 existing observations

df1 <- read.csv("all_apps_wide_2019-07-05.csv")
df1 <- df1[c(1:133), ]

## Load second data set and take the existing 71 observations, then merge

df2 <- read.csv("all_apps_wide_2019-07-06.csv")
df2 <- df2[c(1:71), ]

colnames(df2)[1] <- colnames(df1)[1]

## Change the ID for the new people, so they have one following number: 

df3 <- rbind(df1, df2)

# Select the needed columns/variables 

df3 <- df3 %>% 
  select(participant.code, participant.id_in_session, participant.payoff,
         participant.payoff_plus_participation_fee, 
         Demographic.1.player.age, Demographic.1.player.gender, Demographic.1.player.education,
         Demographic.1.player.ethnicity, Demographic.1.player.nationality,
         matrix_new.1.player.elapsed_time1, matrix_new.1.player.count1, 
         matrix_new.1.player.elapsed_time2, matrix_new.1.player.elapsed_time3,
         matrix_new.1.player.elapsed_time4, matrix_new.1.player.elapsed_time5,
         matrix_new.1.player.elapsed_time6, matrix_new.1.player.elapsed_time7,
         matrix_new.1.player.elapsed_time8, matrix_new.1.player.elapsed_time9,   
         matrix_new.1.player.elapsed_time10, matrix_new.1.player.count2,
         matrix_new.1.player.count3, matrix_new.1.player.count4, matrix_new.1.player.count5, 
         matrix_new.1.player.count6, matrix_new.1.player.count7, matrix_new.1.player.count8,
         matrix_new.1.player.count9,matrix_new.1.player.count10,
         discrete.1.player.accuracyalgorithm, discrete.1.player.accuracyhuman, 
         discrete.1.player.choice1, 
         discrete.1.player.predalg, discrete.1.player.predhum, 
         discrete.1.player.beliefalgorithm, discrete.1.player.beliefhuman, 
         discrete.1.player.payoff_belief_a, discrete.1.player.payoff_belief_h, 
         discrete.1.player.payoff_choice_a, discrete.1.player.payoff_choice_h, 
         discrete.1.player.rand_choice, discrete.1.player.treatment,
         openquestion.1.player.explanation, openquestion.1.player.explanation2, 
         openquestion.1.player.fair, openquestion.1.player.transparent, 
         openquestion.1.player.simpler, openquestion.1.player.discriminate, 
         openquestion.1.player.familiar, openquestion.1.player.characteristics, 
         openquestion.1.player.error, openquestion.1.player.previous_performance, 
         openquestion.1.player.quickly, openquestion.1.player.other,
         scl.1.player.lottery_choice, scl.1.player.payoff, 
         BFI_S.1.player.Worry,
         BFI_S.1.player.Nervous, BFI_S.1.player.Relax, BFI_S.1.player.Talkative,
         BFI_S.1.player.Sociable, BFI_S.1.player.Reserved, BFI_S.1.player.Original,
         BFI_S.1.player.Artistic, BFI_S.1.player.Active_imagination, BFI_S.1.player.Rude,
         BFI_S.1.player.Forgiving, BFI_S.1.player.Considerate, BFI_S.1.player.Thorough_job, 
         BFI_S.1.player.Thorough_job, BFI_S.1.player.Lazy, BFI_S.1.player.Efficient
  )
## Rename the data frame 
newnames <-  c("MTurk_code", "MTurk_ID", "Payoff", "Payoff_plus_participation", "Age", "Gender", 
                   "Education", "Ethnicity", "Nationality", "Time1", "Count1", "Time2", "Time3", "Time4", 
                   "Time5", "Time6", "Time7", "Time8", "Time9", "Time10", "Count2", "Count3", "Count4", "count5", "Count6", 
               "Count7", "Count8", "Count9", "Count10", "Confidence_alg", "Confidence_hum", "Choice1", "Pred_alg", "Pred_hum", 
               "Belief_algorithm", "Belief_human", "Payoff_belief_a", "Payoff_belief_h", "Payoff_choice_a", "Payoff_choice_h", "Rand_choice", 
               "Treatment", "Explanation1", "Explanation2", "B_Fair", "B_Transparent", "B_Simpler", "B_Discriminate",
               "B_Familiar", "B_Characteristics", "B_Error", "B_Performance", "B_Quickly", "B_Other", "Risk_choice", 
               "Payoff_Risk", "P_Worry", "P_Nervous", "P_Relax", "P_Talkative", "P_Sociable", "P_Reserved", "P_Original", 
               "P_Artistic", "P_Active_Imagination", "P_Rude", "P_Forgiving", "P_Considerate", "P_Thorough", "P_Lazy", "P_Efficient"
               )

colnames(df3) <- newnames

## Check for the class of variables
sapply(df3, class)

## Check if the treatment was balanced: 103 baseline; 101 transparency; imbalance due to the uneven final grou pnumbers (133 and 71)
summary(df3$Treatment)
df3 <- df3[df3$Treatment == "baseline", ]
df3 <- df3 %>% 
  filter(!is.na(df3$Gender))
df3 <- df3[complete.cases(df3), ]

# We take only observations who completed the entire experiment, deleting 35 observations from the baseline group


#############################################################

## Delete all Transp treatment and merge them with the data aquired on 02.08.2019

#############################################################


## Read in the new data and select only the observations who completed the entire experiment
df4 <- read.csv("all_apps_wide_2019-08-02.csv")
df4 <- df4 %>% 
  filter(!is.na(df4$Demographic.1.player.gender))
df4 <- df4[df4$participant._current_app_name == "payment_info", ]

## Now select the same variables as for the other dataframe, but include the attention check

df4 <- df4 %>% 
  select(participant.code, participant.id_in_session, participant.payoff,
         participant.payoff_plus_participation_fee, 
         Demographic.1.player.age, Demographic.1.player.gender, Demographic.1.player.education,
         Demographic.1.player.ethnicity, Demographic.1.player.nationality,
         matrix_new.1.player.elapsed_time1, matrix_new.1.player.count1, 
         matrix_new.1.player.elapsed_time2, matrix_new.1.player.elapsed_time3,
         matrix_new.1.player.elapsed_time4, matrix_new.1.player.elapsed_time5,
         matrix_new.1.player.elapsed_time6, matrix_new.1.player.elapsed_time7,
         matrix_new.1.player.elapsed_time8, matrix_new.1.player.elapsed_time9,   
         matrix_new.1.player.elapsed_time10, matrix_new.1.player.count2,
         matrix_new.1.player.count3, matrix_new.1.player.count4, matrix_new.1.player.count5, 
         matrix_new.1.player.count6, matrix_new.1.player.count7, matrix_new.1.player.count8,
         matrix_new.1.player.count9,matrix_new.1.player.count10,
         discreteT.1.player.test_intro1, discreteT.1.player.test_intro2, discreteT.1.player.test_intro3, 
         discreteT.1.player.test_belief1, discreteT.1.player.test_belief2, 
         discreteT.1.player.accuracyalgorithm, discreteT.1.player.accuracyhuman, 
         discreteT.1.player.choice1, 
         discreteT.1.player.predalg, discreteT.1.player.predhum, 
         discreteT.1.player.beliefalgorithm, discreteT.1.player.beliefhuman, 
         discreteT.1.player.payoff_belief_a, discreteT.1.player.payoff_belief_h, 
         discreteT.1.player.payoff_choice_a, discreteT.1.player.payoff_choice_h, 
         discreteT.1.player.rand_choice, discreteT.1.player.treatment, 
         openquestion.1.player.explanation, openquestion.1.player.explanation2, 
         openquestion.1.player.fair, openquestion.1.player.transparent, 
         openquestion.1.player.simpler, openquestion.1.player.discriminate, 
         openquestion.1.player.familiar, openquestion.1.player.characteristics, 
         openquestion.1.player.error, openquestion.1.player.previous_performance, 
         openquestion.1.player.quickly, openquestion.1.player.other,
         scl.1.player.lottery_choice, scl.1.player.payoff, 
         BFI_S.1.player.Worry,
         BFI_S.1.player.Nervous, BFI_S.1.player.Relax, BFI_S.1.player.Talkative,
         BFI_S.1.player.Sociable, BFI_S.1.player.Reserved, BFI_S.1.player.Original,
         BFI_S.1.player.Artistic, BFI_S.1.player.Active_imagination, BFI_S.1.player.Rude,
         BFI_S.1.player.Forgiving, BFI_S.1.player.Considerate, BFI_S.1.player.Thorough_job, 
         BFI_S.1.player.Thorough_job, BFI_S.1.player.Lazy, BFI_S.1.player.Efficient
  )
## Rename the data frame 
newnames_df4 <-  c("MTurk_code", "MTurk_ID", "Payoff", "Payoff_plus_participation", 
               "Age", "Gender", "Education", "Ethnicity", "Nationality", 
               "Time1", "Count1", "Time2", "Time3", "Time4", "Time5", "Time6", "Time7", "Time8", "Time9", "Time10",
               "Count2", "Count3", "Count4", "count5", "Count6", "Count7", "Count8", "Count9", "Count10", 
               "Check_Intro1", "Check_Intro2", "Check_Intro3", "Check_Belief1", "Check_Belief2",
               "Confidence_alg", "Confidence_hum", "Choice1", "Pred_alg", "Pred_hum", "Belief_algorithm", "Belief_human", 
               "Payoff_belief_a", "Payoff_belief_h", "Payoff_choice_a", "Payoff_choice_h", "Rand_choice", 
               "Treatment", "Explanation1", "Explanation2", 
               "B_Fair", "B_Transparent", "B_Simpler", "B_Discriminate", "B_Familiar", "B_Characteristics", "B_Error", 
               "B_Performance", "B_Quickly", "B_Other", 
               "Risk_choice", "Payoff_Risk", 
               "P_Worry", "P_Nervous", "P_Relax", "P_Talkative", "P_Sociable", "P_Reserved", "P_Original", "P_Artistic", 
               "P_Active_Imagination", "P_Rude", "P_Forgiving", "P_Considerate", "P_Thorough", "P_Lazy", "P_Efficient"
)

colnames(df4) <- newnames_df4

## Now, only take complete cases
df4 <- df4[complete.cases(df4), ]

## And merge the two data sets
## Pre-step: Create NA values for the test for the baseline
df3$Check_Intro1 <- NA
df3$Check_Intro2 <- NA
df3$Check_Intro3 <- NA
df3$Check_Belief1<- NA 
df3$Check_Belief2<- NA

df3 <- rbind(df4, df3)

test <- rbind(df4, df3)

#create the dummy for ethnicity 
df3$Nonwhite = 1
df3$Nonwhite[df3$Ethnicity == "White"] = 0

## What is the mean payoff across participants? 
mean(as.numeric(df3$Payoff_plus_participation))

# Now delete the unneccesary observations: how many NA's are in the discrete choice? 
summary(df3$Choice1)

# Further exclusion of participants: Delete observations who have non-sense answers for both open-ended questions or the same value 
# for all likert-scale questions: 

df3 <- subset(df3, df3$Explanation1 != "na")

# Calculate the deviance between believed and actual prediction for both recruitment methods
df3$Deviance_Algorithm  = df3$Belief_algorithm - df3$Pred_alg
df3$Deviance_Human      = df3$Belief_human - df3$Pred_hum


## Calculate the BIg 5 Personality traits: Some need to be reversed; calculation according to 
## Lang, F. R., John, D., Lüdtke, O., Schupp, J., & Wagner, G. G. (2011)

df3$Openness <- (df3$P_Original + df3$P_Artistic + df3$P_Active_Imagination)/3

df3$Conscientiousness <- (df3$P_Thorough + (6-df3$P_Lazy) + df3$P_Efficient)/3

df3$Extroversion <- (df3$P_Talkative + df3$P_Sociable + (6-df3$P_Reserved))/3

df3$Agreeableness <- ((6-df3$P_Rude) + df3$P_Forgiving + df3$P_Considerate)/3

df3$Neuroticism <- (df3$P_Worry + df3$P_Nervous + (6-df3$P_Relax))/3

## What was the average speed of participants? 
df3$TimeAverage <- (df3$Time1 + df3$Time2 + df3$Time3 + df3$Time4 + df3$Time5 + df3$Time6 + df3$Time7 + df3$Time8 + 
                      df3$Time9 + df3$Time10)/10

# Check the coefficients of a regression on the personal covariates for both treatment and control 
# Split the data across the treatment 
df4 <- df3[df3$Treatment == "baseline", ]
df5 <- df3[df3$Treatment == "transp", ]


#### Create new variables needed for the later analysis: 

df3$Belief_diff     <- df3$Belief_algorithm - df3$Belief_human
df3$Confidence_diff <- df3$Confidence_alg - df3$Confidence_hum
df3$Belief_dummy <- 0 
df3$Belief_dummy[df3$Belief_algorithm < df3$Pred_hum] <- 1
df3$diff_pred <- df3$Pred_alg - df3$Pred_hum

df3$rational <- 0 
df3$rational[df3$Choice1 == 1 & df3$Belief_dummy == 1] <- 1
df3$rational[df3$Choice1 == 0 & df3$Belief_dummy == 0] <- 1

df3$rational2 <- 0
df3$rational2[df3$diff_pred < 0 & df3$Choice1 == 1] <- 1
df3$rational2[df3$diff_pred > 0 & df3$Choice1 == 0] <- 1
table(df3$rational2)

#### Now create scaled psychological variables and beliefs: 
df3$sc_extro <- scale(df3$Extroversion)
df3$sc_agree <- scale(df3$Agreeableness)
df3$sc_consc <- scale(df3$Conscientiousness)
df3$sc_neuro <- scale(df3$Neuroticism)
df3$sc_open <-  scale(df3$Openness)

df3$sc_discriminate <- scale(df3$B_Discriminate)
df3$sc_fair         <- scale(df3$B_Fair)
df3$sc_transp       <- scale(df3$B_Transparent)
df3$sc_simple       <- scale(df3$B_Simpler)
df3$sc_familiar     <- scale(df3$B_Familiar)
df3$sc_charact      <- scale(df3$B_Characteristics)
df3$sc_error        <- scale(df3$B_Error)
df3$sc_perf         <- scale(df3$B_Performance)
df3$sc_quick        <- scale(df3$B_Quickly)
df3$sc_other        <- scale(df3$B_Other)


## Now export the merged dataset 
write.csv(df3, "merged_data_03082019.csv")
setwd("~/Utrecht/Master Thesis/After February/Data & Analysis/Final Data")


########################################################################
########################################################################

## Part 2: Data analysis: Main treatment effects and analysis of beliefs

########################################################################
########################################################################


library(xtable)
library(stargazer)
library(ggplot2)

setwd("~/Utrecht/Master Thesis/After February/Data & Analysis/Final Data")
df1 <- read.csv("merged_data_03082019.csv")

## Create two seperate data files for treatment and control

df2 <- df1[df1$Treatment == "baseline", ]
df3 <- df1[df1$Treatment == "transp", ]

#PART 0: Descriptive statistics: 


## Exclusion critera: check how well participants did on the attention checks
table(df3$Check_Intro1)
table(df3$Check_Intro2)
table(df3$Check_Intro3)
table(df3$Check_Belief1)
table(df3$Check_Belief2)

##  Is there somebody who failed all attention checks? 

fail_check <- 
  df3 %>% 
  subset(df3$Check_Intro1 == 0 & Check_Intro2 == 0 & Check_Intro3 == 0)

fail_check2 <- 
  df3 %>% 
  subset(df3$Check_Belief1 == 1 & Check_Belief2 == 0) 


## AVerage payoff and speed: 
summary(df1$Payoff_plus_participation)
summary(df2$Payoff_plus_participation)
summary(df3$Payoff_plus_participation)

pay_hist <- 
  ggplot(data = df1, aes(df1$Payoff_plus_participation)) + 
  geom_histogram( breaks = seq(0,6, by = 0.1), col = "grey", 
                  alpha = 0.8) + 
  labs(x = "Payoff", y = "Count")  + 
  xlim(c(0, 6))

pay_hist

summary(df1$Time9)
summary(df2$Time9)
summary(df3$Time9)

hist(df1$Time9, breaks = 20)
hist(df2$Time9, breaks = 20)
hist(df3$Time9, breaks = 20)

# These results are quite similar to the training round. 

# Look at the treatment: Is it balanced? 
summary(df1$Treatment)  ### Due to the exclusion; and multiple runs of the experiment; 66 baseline, 84 treatment

# Look at the discrete choice: Overall 62.84 % chose the algorithm, across treatment and baseline
summary(df1$Choice1)

# Now split this up for the treatment: In the baseline, 58.9% percent chose the algorithm, in the treatment only 45.98 %
summary(df2$Choice1)
summary(df3$Choice1)


summary(df1$TimeAverage)
summary(df2$TimeAverage)
summary(df3$TimeAverage)
hist(df1$TimeAverage, breaks = 20)

## Descriptives: comparig the two samples. 

df_comp <- cbind(
  c(mean(df1$Gender), 
    mean(df1$Age), 
    mean(df1$Education), 
    mean(df1$Nonwhite), 
    mean(df1$Time9), 
    mean(df1$TimeAverage), 
    mean(df1$Risk_choice), 
    mean(df1$Openness),
    mean(df1$Conscientiousness),
    mean(df1$Extroversion),
    mean(df1$Agreeableness),
    mean(df1$Neuroticism)
  ),
  c(mean(df2$Gender), 
    mean(df2$Age), 
    mean(df2$Education), 
    mean(df2$Nonwhite), 
    mean(df2$Time9), 
    mean(df2$TimeAverage), 
    mean(df2$Risk_choice), 
    mean(df2$Openness),
    mean(df2$Conscientiousness), 
    mean(df2$Extroversion), 
    mean(df2$Agreeableness), 
    mean(df2$Neuroticism)), 
  c(mean(df3$Gender), 
    mean(df3$Age), 
    mean(df3$Education), 
    mean(df3$Nonwhite), 
    mean(df3$Time9), 
    mean(df3$TimeAverage), 
    mean(df3$Risk_choice), 
    mean(df3$Openness), 
    mean(df3$Conscientiousness), 
    mean(df3$Extroversion), 
    mean(df3$Agreeableness), 
    mean(df3$Neuroticism)), 
  c(t.test(df2$Gender, df3$Gender)$statistic, 
    t.test(df2$Age, df3$Age)$statistic,
    t.test(df2$Education, df3$Education)$statistic,
    t.test(df2$Nonwhite, df3$Nonwhite)$statistic,
    t.test(df2$Time9, df3$Time9)$statistic,
    t.test(df2$TimeAverage, df3$TimeAverage)$statistic,
    t.test(df2$Risk_choice, df3$Risk_choice)$statistic,
    t.test(df2$Openness, df3$Openness)$statistic,
    t.test(df2$Conscientiousness, df3$Conscientiousness)$statistic,
    t.test(df2$Extroversion, df3$Extroversion)$statistic,
    t.test(df2$Agreeableness, df3$Agreeableness)$statistic,
    t.test(df2$Neuroticism, df3$Neuroticism)$statistic)
)

### p-values
round(c(t.test(df2$Gender, df3$Gender)$p.value, 
  t.test(df2$Age, df3$Age)$p.value,
  t.test(df2$Education, df3$Education)$p.value,
  t.test(df2$Nonwhite, df3$Nonwhite)$p.value,
  t.test(df2$Time9, df3$Time9)$p.value,
  t.test(df2$TimeAverage, df3$TimeAverage)$p.value,
  t.test(df2$Risk_choice, df3$Risk_choice)$p.value,
  t.test(df2$Openness, df3$Openness)$p.value,
  t.test(df2$Conscientiousness, df3$Conscientiousness)$p.value,
  t.test(df2$Extroversion, df3$Extroversion)$p.value,
  t.test(df2$Agreeableness, df3$Agreeableness)$p.value,
  t.test(df2$Neuroticism, df3$Neuroticism)$p.value), 2)


#### Calculating the standard deviations

df_sd <- df3 %>%
  select(Gender, Age, Education, Nonwhite, Time9, TimeAverage, Risk_choice, Openness, Conscientiousness, Extroversion, 
         Agreeableness, Neuroticism)

round(sapply(df_sd, sd), 2)

colnames(df_comp) <- c("Whole Sample", "Baseline", "Treatment", "t-statistic")
rownames(df_comp) <- c("Gender", "Age", "Education", "Nonwhite", "Time9", "Average Time", "Risk Aversion", 
                       "Openness", "Conscientiousness", "Extroversion", "Agreeableness", "Neuroticism")
df_comp <- round(df_comp, 3)

xtable(df_comp)
############### comparing the two sexes in both treatment groups
df6 <- df2 %>% 
  filter(Gender == 0)

df7 <- df2%>% 
  filter(Gender == 1)

df_comp2 <- cbind(
  c(
    mean(df6$Age), 
    mean(df6$Education), 
    mean(df6$Nonwhite), 
    mean(df6$Time9), 
    mean(df6$TimeAverage), 
    mean(df6$Risk_choice), 
    mean(df6$Openness),
    mean(df6$Conscientiousness), 
    mean(df6$Extroversion), 
    mean(df6$Agreeableness), 
    mean(df6$Neuroticism)), 
  c( 
    mean(df7$Age), 
    mean(df7$Education), 
    mean(df7$Nonwhite), 
    mean(df7$Time9), 
    mean(df7$TimeAverage), 
    mean(df7$Risk_choice), 
    mean(df7$Openness), 
    mean(df7$Conscientiousness), 
    mean(df7$Extroversion), 
    mean(df7$Agreeableness), 
    mean(df7$Neuroticism)), 
  c(
    t.test(df6$Age, df7$Age)$statistic,
    t.test(df6$Education, df7$Education)$statistic,
    t.test(df6$Nonwhite, df7$Nonwhite)$statistic,
    t.test(df6$Time9, df7$Time9)$statistic,
    t.test(df6$TimeAverage, df7$TimeAverage)$statistic,
    t.test(df6$Risk_choice, df7$Risk_choice)$statistic,
    t.test(df6$Openness, df7$Openness)$statistic,
    t.test(df6$Conscientiousness, df7$Conscientiousness)$statistic,
    t.test(df6$Extroversion, df7$Extroversion)$statistic,
    t.test(df6$Agreeableness, df7$Agreeableness)$statistic,
    t.test(df6$Neuroticism, df7$Neuroticism)$statistic)
)


colnames(df_comp2) <- c("Female", "Male", "t-statistic")
rownames(df_comp2) <- c("Age", "Education", "Nonwhite", "Time9", "Average Time", "Risk Aversion", 
                       "Openness", "Conscientiousness", "Extroversion", "Agreeableness", "Neuroticism")
df_comp <- round(df_comp2, 3)



stargazer(df_comp)
df_comp

as.table(df_comp)


## First: Histogram of the average speed of the exercises 
speed <- ggplot(data = df1, aes(df1$TimeAverage)) + 
  geom_histogram( breaks = seq(0,60, by = 1), col = "grey", 
                  alpha = 0.8) + 
  labs(x = "Average time of solving the exercises in seconds", y = "Count")  + 
  xlim(c(0, 60))

speed


############### 2.1. Regression Analysis #############################################
library(sandwich)
### Question 1: What is the effect of the treatment on the discrete choice? 
reg1 <- lm(df1$Choice1 ~ df1$Treatment)
summary(reg1) 
reg1.se <- vcovHC(reg1, type = "HC")
reg1.se <- sqrt(diag(reg1.se))

reg11 <- lm(Choice1 ~ Treatment + Gender + Treatment * Gender, data = df1)
summary(reg11)

reg12 <- lm(Choice1 ~ Treatment + Gender+ Education + Nonwhite +  Age + Nonwhite + Time9, data = df1)
summary(reg12)


summary(lm(Choice1 ~ Gender, data = df3))


### Now do one large regression with all interaction effects: 
reg13 <- lm(Choice1 ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
              Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
summary(reg13)
reg13.se <- vcovHC(reg13, type = "HC")
reg13.se <- sqrt(diag(reg13.se))

stargazer(reg1, reg13, se=list(reg1.se, reg13.se))



### Question 2: How do the extra elicited variables affect the choice in both treatments? 
## Using all three datasets (Combined, baseline only, treatment only)
reg_extra11 <- lm(Choice1 ~ Risk_choice + Openness + Conscientiousness + Extroversion + Agreeableness + Neuroticism, data = df1)
summary(reg_extra11)

reg_extra1 <- lm(Choice1 ~ Risk_choice + Openness + Conscientiousness + Extroversion + Agreeableness + Neuroticism + Treatment + 
                   Risk_choice*Treatment + Openness * Treatment + Conscientiousness*Treatment + Extroversion * Treatment + Agreeableness*Treatment + 
                   Neuroticism * Treatment 
                   , data = df1)
summary(reg_extra1)



## Now with ALL covariates
reg_extra2 <- lm(Choice1 ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                   Nonwhite * Treatment + Time9*Treatment + Risk_choice + Openness + Conscientiousness + Extroversion + Agreeableness + Neuroticism + Treatment + 
                   Risk_choice*Treatment + Openness * Treatment + Conscientiousness*Treatment + Extroversion * Treatment + Agreeableness*Treatment + 
                   Neuroticism * Treatment 
                 , data = df1)

summary(reg_extra2)
reg_extra2.se <- vcovHC(reg_extra2, type = "HC")
reg_extra2.se <- sqrt(diag(reg_extra2.se))

stargazer(reg_extra2, se = list(reg_extra2.se))

#### Do the same for a logit regression 

reg_extra_log<- glm(Choice1 ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                      Nonwhite * Treatment + Time9*Treatment + Risk_choice + Openness + Conscientiousness + Extroversion + Agreeableness + Neuroticism + Treatment + 
                      Risk_choice*Treatment + Openness * Treatment + Conscientiousness*Treatment + Extroversion * Treatment + Agreeableness*Treatment + 
                      Neuroticism * Treatment  , 
                   data = df1, 
                   family = binomial
                 )

summ(reg_extra_log)
summ(reg_extra_log, exp = T, digits = 4)

### looking at conscientiousness and gender 
df_conscn <- df1 %>% 
  group_by(Gender, Treatment) %>% 
  summarise(Consc = mean(Conscientiousness))
### Contingency/percentage tables

proptable_base  <- prop.table(table(df2$Choice1, df2$Gender), margin = 1)
proptable_treat <- prop.table(table(df3$Choice1, df3$Gender), margin = 1)

prop.table(table(df2$Choice1, df2$Time9), margin = 1)
median(df2$Time9)
median(df3$Time9)
summary(df2$Time9)
summary(df3$Time9)

stargazer(proptable_base)
stargazer(proptable_treat)




### Question 3: How do personal characteristics (self-selection) affect the discrete choice? 

## Run the two regressions for both the control and the treatment
reg2 = lm(Choice1 ~ Gender + Age + Education + Nonwhite + Time9, data = df2)
reg3 = lm(Choice1 ~ Gender + Age + Education + Nonwhite + Time9, data = df3)

summary(reg2)
summary(reg3)

stargazer(reg2, reg3)

## What is the difference in coefficients? 

diffcoff <- coefficients(reg2) - coefficients(reg3)

## So through the increased transparency and knowing the weights, the coefficients changed; the algorithm is less likely to be selected
## the older you are, ,higher educated, non-white and for people who have a higher average in the ninth round. Only for males, the likelihood of choosing 
## the algorithm increased following the treatment. 

## Now do the same analysis for a logit regression: 


## Logistic regression for the baseline: 

log1 <- glm(Choice1 ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
              Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
            data = df1, 
           family = binomial)

summ(log1)
summ(log1, exp = T)

## Change the logit coefficients to odds-ratios to be able to interpret them: 
res_log1 <- exp(cbind(OR = coef(log1), confint(log1)))
res_log1 


## Logistic regression for the treatment: 
log2 <- glm(Choice1 ~ Age + Gender + Education + Nonwhite + Time9, 
            data = df3,
            family = binomial)

summ(log2)
## Change the logit coefficients to odds-ratios to be able to interpret them: 
res_log2 <- exp(cbind(OR = coef(log2), confint(log2)))
res_log2 

summary(res_log1)
##

## Get the latex code: 
# For the logistic regression: 

stargazer(log1)


############ Now do the same for a probit regression

prob1 <- glm(Choice1 ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
               Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
             data = df1, 
             family = binomial(link = "probit"))

summary(prob1)
stargazer(prob1)


#For the tables
xtable(res_log1)
xtable(res_log2)

df1_plot <- df1 %>% 
  mutate(Treatment = recode(Treatment, "transp" = "Treatment", 
                            "baseline" = "Baseline")) %>%
  mutate(Gender = recode(Gender, '0' = "Female",
                         "1" = "Male"))

test <- df1 %>% 
  group_by(Gender, Treatment) %>%
  summarise(mean = mean(Choice1))


p1 <- ggplot(df1_plot, aes(x = Treatment, y= Choice1, fill = as.factor(Gender))) + 
  geom_bar(position = position_dodge(width=0.85), stat = "summary", fun.y = "mean", width = 0.8, color = "black")  + 
  scale_fill_manual(values = c("#0000CC", "#990000", "#0000CC", "#990000")) + 
  geom_errorbar(stat="summary", fun.data="mean_se", position = position_dodge(0.85), width = .2) + 
  theme_bw() + xlab("") + ylab("Chosen Algorithmic Recruiter") + 
  ylim(c(0, 1)) + 
  theme(legend.position = "top",
        legend.background = element_rect(fill = "#EEEEEE", color = "black"),
        legend.title = element_text(),axis.title = element_text(size = 16, face="bold")) +
  theme(axis.text.x  = element_text(size = 14)) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), size = 20)) + 
  guides(fill=guide_legend(title="Gender: "))
p1


setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
jpeg("AlgChoice.jpg")
p1
dev.off()
## What changes from the Odds-ratio? With the treatment, higher age makes it more likely to select the algorithm, especially for gender, 
## being male raises has nearly three times the rates of choosing the algorithmic recruiter


##### Frequency tables 
choice_gender_all <- 
  df1 %>%
  count(Treatment, Gender, Choice1) %>%
  group_by(Gender) %>%          # now required with changes to dplyr::count()
  mutate(prop = prop.table(n))

choice_gender_base <- 
  df2 %>% 
  count(Choice1, Gender) %>%
  group_by(Gender) %>%
  mutate(prop = prop.table(n))

choice_gender_treat <- 
  df3 %>% 
  count(Choice1, Gender) %>%
  group_by(Gender) %>%
  mutate(prop = prop.table(n))

xtable(choice_gender_all)
choice_gender_all

xtable(choice_gender_base)
xtable(choice_gender_treat)

# Frequency tables for the distribution of choice of algorithm and gender for the baseline and treatment

#test1 <- xtabs( ~ Choice1 + Gender, data = df4)
#test1
#test2 <- xtabs( ~ Choice1 + Gender, data = df5)
#test2 


# For the latex output: 

#xtable(test1)
#xtable(test2)

## Or use the once generated by tidyverse: 

xtable(choice_gender_base)
xtable(choice_gender_treat)
### So before the treatment 54.29% of women and 68.75 % of men chose the algorithm 
### With the treatment; 23/42 = 54.76 % of women and 16/42 = 38.1 % of men chose the algorithm. 


########################################################################################

############ Part 3: Looking at the beliefs and accuracy      ##########################

########################################################################################


## How did people generally believed both recruiters to judge?


## First create the collapsed dataset 

## Did the treatment change how well participants perceived the algorithm? 
test <- df2 %>% 
  mutate(Gender, recode(Gender, "0" = "Female", "1" = "Male"))
df1$Treatment2 <- NULL
df1$Treatment2[df1$Treatment == "baseline"]   <- "Baseline"
df1$Treatment2[df1$Treatment == "transp"]     <- "Information-rich"

belief_distalg <- 
  ggpar(ggdensity(df1, x = "Belief_algorithm", 
          add = "mean", rug = TRUE, 
          color = "Treatment2", fill = "Treatment2", 
          palette = c("#00AFBB", "#E7B800"), 
          xlab = "Believed average speed in seconds", 
          xlim = c(0,90)), legend.title ="Treatment Group")

belief_disthum <- 
  ggpar(ggdensity(df1, x = "Belief_human", 
          add = "mean", rug = TRUE, 
          color = "Treatment2", fill = "Treatment2", 
          palette = c("#00AFBB", "#E7B800"), 
          xlab = "Believed average speed in seconds", 
          xlim = c(0,90)), legend.title = "Treatment Group")


## Exporting the file 

setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")

jpeg("Dist-Believe-Alg.jpg")
plot(belief_distalg)
dev.off()
jpeg("Dist-Believe-Hum.jpg")
plot(belief_disthum)
dev.off()


#################################################################################################

# Question 1: Did the treatment have an effect on the beliefs? 

reg_belief1 <-  lm(Belief_human ~ Treatment, data = df1)
reg_belief2 <-  lm(Belief_algorithm ~ Treatment, data = df1)


## Check if the beliefs differ for gender? 
df2$Gender2[df2$Gender == 1] <- "Male"
df2$Gender2[df2$Gender == 0] <- "Female"
df3$Gender2[df3$Gender == 1] <- "Male"
df3$Gender2[df3$Gender == 0] <- "Female"



setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
jpeg("Dist-Beliefs-Genderalg1.jpg")
print(ggdensity(df2, x = "Belief_algorithm", 
          add = "mean", rug = TRUE, 
          color = "Gender2", fill = "Gender2", 
          palette = c("#00AFBB", "#E7B800"), 
          xlab = "Believed average speed in seconds", 
          xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-Genderalg2.jpg")
plot(ggdensity(df3, x = "Belief_algorithm", 
               add = "mean", rug = TRUE, 
               color = "Gender2", fill = "Gender2", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-Genderhum1.jpg")
plot(ggdensity(df2, x = "Belief_human", 
          add = "mean", rug = TRUE, 
          color = "Gender2", fill = "Gender2", 
          palette = c("#00AFBB", "#E7B800"), 
          xlab = "Believed average speed in seconds", 
          xlim = c(0,90)))
dev.off()


jpeg("Dist-Beliefs-Genderhum2.jpg")
plot(ggdensity(df3, x = "Belief_human", 
               add = "mean", rug = TRUE, 
               color = "Gender2", fill = "Gender2", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-MaleAlg")
plot(gghistogram(df1[df1$Gender == 1, ], x = "Belief_algorithm", 
               add = "mean", rug = TRUE, 
               color = "Treatment", fill = "Treatment", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-FemaleAlg")
plot(ggdensity(df1[df1$Gender == 0, ], x = "Belief_algorithm", 
               add = "mean", rug = TRUE, 
               color = "Treatment", fill = "Treatment", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-MaleHum")
plot(ggdensity(df1[df1$Gender == 1, ], x = "Belief_diff", 
               add = "mean", rug = TRUE, 
               color = "Treatment", fill = "Treatment", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()


jpeg("Dist-Beliefs-FemaleHum")
plot(ggdensity(df1[df1$Gender == 0, ], x = "Belief_diff", 
               add = "mean", rug = TRUE, 
               color = "Treatment", fill = "Treatment", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()

jpeg("Dist-Beliefs-FemaleHum")
plot(ggdensity(df1[df1$Gender == 0, ], x = "Belief_human", 
               add = "mean", rug = TRUE, 
               color = "Treatment", fill = "Treatment", 
               palette = c("#00AFBB", "#E7B800"), 
               xlab = "Believed average speed in seconds", 
               xlim = c(0,90)))
dev.off()


### Test for differences in beliefs
ggdensity(df1, x = "Belief_diff", 
          add = "mean", rug = TRUE, 
          color = "Treatment", fill = "Treatment", 
          palette = c("#00AFBB", "#E7B800"), 
          xlab = "Believed average speed in seconds", 
          xlim = c(0,90))

#### Kolomogorov Smirnov test to see if both distributions come from the same distribution or not
df2 <- df1 %>% filter(Treatment == "baseline")
df3 <- df1 %>% filter(Treatment == "transp")

ks.belief_alg <- ks.test(df2$Belief_algorithm, df3$Belief_algorithm)
ks.belief_alg

ks.belief_hum <- ks.test(df2$Belief_human, df3$Belief_human)
ks.belief_hum

k.s.belief_diff <- ks.test(df2$Belief_diff, df3$Belief_diff)
k.s.belief_diff

##Test out some stuff

summary(lm(Belief_algorithm ~ Treatment + Gender + Age + Education + Nonwhite  + 
     Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment,
   data = df1))

## Now with all available personal characteristics 

reg_belief11 <- lm(Belief_human ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + 
                Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
                data = df1 )

reg_belief21 <- lm(Belief_algorithm ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + 
                Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
                data = df1 )

summary(reg_belief21)


#### Defined as: Belief about the algorithmic recruiter minus belief about the human recruiter

## Define the two variables
df1$Belief_diff     <- df1$Belief_algorithm - df1$Belief_human
df1$Confidence_diff <- df1$Confidence_alg - df1$Confidence_hum

graph_belief_diff <-
  ggdensity(df1, x = "Belief_diff", 
            add = "mean", rug = TRUE, 
            color = "Treatment", fill = "Treatment", 
            palette = c("#00AFBB", "#E7B800"), 
            xlab = "Believed average speed in seconds", 
            xlim = c(-60, 60))


## Show the easy regression
reg_beliefdiff1 <- lm(Belief_diff ~ Treatment, data = df1)
summary(reg_beliefdiff1)


reg_beliefdiff2 <- lm(Belief_diff ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + Treatment * Gender + Age * Treatment + 
                        Education * Treatment + Nonwhite * Treatment + Time9*Treatment , data = df1)
summary(reg_beliefdiff2)


reg_beliefdiff3 <- lm(Belief_diff ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                    Nonwhite * Treatment + Time9*Treatment + Risk_choice + Openness + Conscientiousness + Extroversion + Agreeableness + Neuroticism + Treatment + 
                    Risk_choice*Treatment + Openness * Treatment + Conscientiousness*Treatment + Extroversion * Treatment + Agreeableness*Treatment + 
                    Neuroticism * Treatment , data = df1)


### Print out the regressions 
## Calculate robust standard error
## Make function for standard errors

reg1.se <- vcovHC(reg1, type = "HC")
reg1.se <- sqrt(diag(reg1.se))

robust <- function(x){
  x.se <- vcovHC(x, type = "HC2")
  x.se <- sqrt(diag(x.se)) 
  print(x.se)
}

reg_belief1.se <- robust(reg_belief1)
reg_belief2.se <- robust(reg_belief2)
reg_beliefdiff1.se <- robust(reg_beliefdiff1)

stargazer(reg_belief1, reg_belief2, reg_beliefdiff1, se = list(reg_belief1.se, reg_belief2.se, reg_beliefdiff1.se))

reg_belief11.se <- robust(reg_belief11)
reg_belief21.se <- robust(reg_belief21)
reg_beliefdiff2.se  <- robust(reg_beliefdiff2)
reg_beliefdiff3.se <- robust(reg_beliefdiff3)

stargazer(reg_belief11, reg_belief21, reg_beliefdiff2, se = list(reg_belief11.se, reg_belief21.se, reg_beliefdiff2.se))
stargazer(reg_extra2, reg_beliefdiff3, se = list(reg_extra2.se, reg_beliefdiff3.se))


reg_beliefdiff3.se <- robust(reg_beliefdiff3)
stargazer(reg_beliefdiff3, se = reg_beliefdiff3.se)


#################################################################################################

# Question 2: How did the believed accuracy change? 
df1$Confidence_diff <- df1$Confidence_alg - df1$Confidence_hum

reg_confidence1 <- lm(Confidence_alg ~ Treatment, data = df1)
reg_confidence2 <- lm(Confidence_hum ~ Treatment, data = df1)
reg_confidence21 <- lm(Confidence_diff ~ Treatment, data = df1)


reg_confidence3 <- (lm(Confidence_alg ~ Treatment + Gender + Age + Education + Time9 + Nonwhite + Gender * Treatment + Age * Treatment + 
             Education * Treatment + Time9 * Treatment + Nonwhite * Treatment, data = df1))

reg_confidence4 <- lm(Confidence_hum ~ Treatment + Gender + Age + Education + Time9 + Nonwhite + Gender * Treatment + Age * Treatment + 
             Education * Treatment + Time9 * Treatment + Nonwhite * Treatment, data = df1)

reg_confidence1.se <- robust(reg_confidence1)
reg_confidence2.se <- robust(reg_confidence2)
reg_confidence21.se <- robust(reg_confidence21)

stargazer(reg_confidence1, reg_confidence2, reg_confidence21, se = list(reg_confidence1.se, reg_confidence2.se, reg_confidence21.se))

summary(reg_confidence4)

## Look at the confidence change for both recruitment methods
reg_confidence5 <- lm(Confidence_diff ~ Treatment + Gender + Age + Education + Time9 + Nonwhite + Gender * Treatment + Age * Treatment + 
             Education * Treatment + Time9 * Treatment + Nonwhite * Treatment, data = df1)

## Calculate robust standard error
reg_confidence3.se <- robust(reg_confidence3)
reg_confidence4.se <- robust(reg_confidence4)
reg_confidence5.se <- robust(reg_confidence5)


stargazer(reg_confidence3, reg_confidence4, reg_confidence5, se = list(reg_confidence3.se, reg_confidence4.se, reg_confidence5.se))

#################################################################################################
## Question 3: How good were participants actually in guessing their score? 
# Calculating the deviance for both 

graph_deviance1 <- 
  ggpar(ggdensity(df1, x = "Deviance_Algorithm", 
            add = "mean", rug = TRUE, 
            color = "Treatment2", fill = "Treatment2", 
            palette = c("#00AFBB", "#E7B800"), 
            xlab = "Believed average speed in seconds", 
            xlim = c(-60, 60)), legend.title = "Treatment Group")


graph_deviance2 <-
  ggpar(ggdensity(df1, x = "Deviance_Human", 
            add = "mean", rug = TRUE, 
            color = "Treatment2", fill = "Treatment2", 
            palette = c("#00AFBB", "#E7B800"), 
            xlab = "Believed average speed in seconds", 
            xlim = c(-60, 60)), legend.title = "Treatment Group")


setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
jpeg("Hist-Deviance-Alg.jpg")
plot(graph_deviance1)
dev.off()
jpeg("Hist-Deviance-Hum.jpg")
plot(graph_deviance2)
dev.off()

## KS test to show if distributions are different from each other: 
ks.deviance_alg <- ks.test(df2$Deviance_Algorithm, df3$Deviance_Algorithm)
ks.deviance_alg

ks.deviance_hum <- ks.test(df2$Deviance_Human, df3$Deviance_Human)
ks.deviance_hum

## Output it to latex 
stargazer(tidy(ks.deviance_alg))



## What are their means? 
summary(df1$Deviance_Algorithm)
summary(df1$Deviance_Human)

summary(df2$Deviance_Algorithm)
summary(df2$Deviance_Human)

summary(df3$Deviance_Algorithm)
summary(df3$Deviance_Human)


## The long regression, using all available characteristics and treatment interaction: 
reg_deviance11 <- lm(Deviance_Human ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + 
                       Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
                     data = df1 )

reg_deviance21 <- lm(Deviance_Algorithm ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + 
                       Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
                     data = df1 )

stargazer(reg_deviance11, reg_deviance21)


#### Construct a new measure: The difference in beliefs and confidence: 
df1$Deviance_Diff <- df1$Deviance_Algorithm - df1$Deviance_Human
df1$Deviance_Diff2 <- df1$Deviance_Diff*df1$Deviance_Diff

hist(df1$Deviance_Diff, breaks = 50)
summary(df1$Deviance_Diff)

reg_deviancediff <- lm(Deviance_Diff ~ Treatment + Gender + Age + Education + Nonwhite + Time9 + 
                         Gender * Treatment  +  Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment,
                       data = df1)

summary(lm(Deviance_Diff ~ Treatment + Gender + Treatment * Gender, data = df1))

reg_deviance21.se <- robust(reg_deviance21)
reg_deviance11.se <- robust(reg_deviance11)
reg_deviancediff.se <- robust(reg_deviancediff)

stargazer(reg_deviance21, reg_deviance11, reg_deviancediff, se = list(reg_deviance21.se, reg_deviance11.se, reg_deviancediff.se))
#################################################################################################

### Question 4: Do the believes predict the choice of the underlying method? 

## Create dummy indicating if algorithm belief is higher than human belief
df1$Belief_dummy <- 0 
df1$Belief_dummy[df1$Belief_algorithm < df1$Pred_hum] <- 1

summary(lm(Choice1 ~ Belief_dummy * Treatment, data = df1))


reg_belief31 <- lm(Choice1 ~ Belief_dummy+ Gender + Age + Nonwhite + Education + Time9  + Treatment*Belief_dummy + Treatment * Gender + 
                          Treatment * Age + Treatment*Education + Treatment * Nonwhite + Treatment * Time9 , data = df1)
summary(reg_belief31)



reg_belief41 <- lm(Choice1 ~ Belief_dummy + Belief_dummy * Treatment, data = df1)

reg_belief51 <- lm(Choice1 ~ Belief_dummy + Belief_human + Belief_algorithm + Treatment * Belief_dummy + 
                     Treatment * Belief_algorithm + Treatment * Belief_human, data = df1)

summary(reg_belief51)
reg_belief_51.se <- robust(reg_belief51)
stargazer(reg_belief51, se = reg_belief_51.se)

summary(lm(Choice1 ~ Belief_dummy + Belief_human + Belief_algorithm + Treatment * Belief_dummy + 
             Treatment * Belief_algorithm + Treatment * Belief_human + 
             Gender + Gender * Treatment  + Gender * Belief_dummy, data = df1))


reg_belief51log <- glm(Choice1 ~ Belief_dummy + Belief_human + Belief_algorithm + Treatment * Belief_dummy + 
                        Treatment * Belief_algorithm + Treatment * Belief_human, 
                       data = df1, 
                       family = binomial)


summ(reg_belief51log)
summ(reg_belief51log, exp = T)




### Robustness check: Weighted Beliefs
df1$weights_confidence <- (df1$Confidence_alg + df1$Confidence_hum)/sum(df1$Confidence_alg+ df1$Confidence_hum)



###################################################################################################
####  Do the people decide rational for themselves? 

df1$diff_pred <- df1$Pred_alg - df1$Pred_hum

### Define a rational dummy, which is 1 if the chosen method is the one which is believed to be higher.

df1$rational <- 0 
df1$rational[df1$Choice1 == 1 & df1$Belief_dummy == 1] <- 1
df1$rational[df1$Choice1 == 0 & df1$Belief_dummy == 0] <- 1

table(df1$rational)
summary(df1$rational)

## Second: Construct the payoff that participants received: 
df1$Payoff_choice[df1$Choice1 == 0] <- round((90-df1$Pred_hum)/60,3)
df1$Payoff_choice[df1$Choice1 == 1] <- round((90-df1$Pred_alg)/60,3)


## Develop a second outcome variable: To select the right recruiter: 
df1$rational2 <- 0
df1$rational2[df1$diff_pred < 0 & df1$Choice1 == 1] <- 1
df1$rational2[df1$diff_pred > 0 & df1$Choice1 == 0] <- 1
table(df1$rational2)


### Plot this across groups
### Create data frame for plots

df1_plot2 <- df1 %>%
  mutate(Treatment = recode(Treatment, "transp" = "Treatment", 
                            "baseline" = "Baseline")) %>%
  mutate(Gender = recode(Gender, '0' = "Female",
                         "1" = "Male")) %>%
  group_by(Treatment, Gender) %>% # Group the data by manufacturer
  summarise(rational2_mean= mean(rational2), # Create variable with mean of cty per group
            sd_rational= sd(rational2), # Create variable with sd of cty per group
            n_rational=n(), # Create new variable N of cty per group
            se=sd_rational/sqrt(n_rational), # Create variable with se of cty per group
            upper_limit=rational2_mean+se, # Upper limit
            lower_limit=rational2_mean-se # Lower limit
  )
  
df1_plot$Gender <- as.factor(df1_plot$Gender)


  


p2 <- ggplot(df1_plot2, aes(x = Treatment, y= rational2_mean, fill = as.factor(Gender))) + 
  geom_bar(position = position_dodge(width=0.85), stat = "summary", fun.y = "mean", width = 0.8, color = "black")  + 
  scale_fill_manual(values = c("#0000CC", "#990000", "#0000CC", "#990000")) + 
  geom_errorbar(stat="summary", fun.data="mean_se", position = position_dodge(0.85), width = .2) + 
  theme_bw() + xlab("") + ylab("Payoff-maximizing recruiter") + 
  ylim(c(0, 1)) + 
  theme(legend.position = "top",
        legend.background = element_rect(fill = "#EEEEEE", color = "black"),
        legend.title = element_text(),axis.title = element_text(size = 16, face="bold")) +
  theme(axis.text.x  = element_text(size = 14)) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), size = 20)) + 
  guides(fill=guide_legend(title="Gender: "))

setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
jpeg("Payoffmax.jpg")
print(p2)
dev.off()


df1_plot3 <- df1 %>%
  mutate(Treatment = recode(Treatment, "transp" = "Treatment", 
                            "baseline" = "Baseline")) %>%
  mutate(Gender = recode(Gender, '0' = "Female",
                         "1" = "Male")) %>%
  group_by(Treatment, Gender) %>% # Group the data by manufacturer
  summarise(rational_mean= mean(rational), # Create variable with mean of cty per group
            sd_rational= sd(rational), # Create variable with sd of cty per group
            n_rational=n(), # Create new variable N of cty per group
            se=sd_rational/sqrt(n_rational), # Create variable with se of cty per group
            upper_limit=rational_mean+se, # Upper limit
            lower_limit=rational_mean-se # Lower limit
  )


p3 <- ggplot(df1_plot3, aes(x = Treatment, y= rational_mean, fill = as.factor(Gender))) + 
  geom_bar(position = position_dodge(width=0.85), stat = "summary", fun.y = "mean", width = 0.8, color = "black")  + 
  scale_fill_manual(values = c("#0000CC", "#990000", "#0000CC", "#990000")) + 
  geom_errorbar(stat="summary", fun.data="mean_se", position = position_dodge(0.85), width = .2) + 
  theme_bw() + xlab("") + ylab("Choosing consistent with belief") + 
  ylim(c(0, 1)) + 
  theme(legend.position = "top",
        legend.background = element_rect(fill = "#EEEEEE", color = "black"),
        legend.title = element_text(),axis.title = element_text(size = 16, face="bold")) +
  theme(axis.text.x  = element_text(size = 14)) + 
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), size = 20)) + 
  guides(fill=guide_legend(title="Gender: "))

p3 <- p3 + geom_errorbar(aes(ymin = lower_limit, ymax = upper_limit), position = position_dodge(0.85), width = 0.2)

setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
jpeg("Beliefconsistent.jpg")
print(p3)
dev.off()

p3

## Cross-check why the coefficient of rational 2 is negative (Choosing the better-paying option should be payoff-enhancing, right?)
### Construct a new rational variable: 
df1$AdvAlg <- 0
df1$AdvAlg[df1$Pred_alg < df1$Pred_hum] <- 1
summary(lm(df1$Choice1 ~ df1$AdvAlg + df1$AdvAlg * df1$Treatment + df1$Treatment))

#New varaible: 
table(df1$AdvAlg)

df1$rational3 <- 0
df1$rational3[df1$AdvAlg == 1 & df1$Choice1== 1] <- 1
df1$rational3[df1$AdvAlg == 0 & df1$Choice1 == 0] <- 1

summary(lm(rational2 ~ Gender + Age + Education + Nonwhite + Treatment + Time9 + 
          Gender * Treatment + Age * Treatment + Education * Treatment + Nonwhite * Treatment, data = df1))


summary(lm(rational ~ Gender + Age + Education + Nonwhite + Treatment + Time9 + 
             Gender * Treatment + Age * Treatment + Education * Treatment + Nonwhite * Treatment + Time9* Treatment, data = df1))

reg_rational5 <- lm(rational2 ~ Treatment + Gender * Treatment , data = df1)
reg_rational6 <- lm(rational ~ Treatment + Gender * Treatment, data = df1)

reg_rational5.se <- robust(reg_rational5)
reg_rational6.se <- robust(reg_rational6)
summary(reg_rational5)
summary(reg_rational6)


## Rational2 means payoff maximization, rational is the consistent with the higher beliefed score. 
stargazer(reg_rational5, reg_rational6, se = list(reg_rational5.se, reg_rational6.se))
cor(df1$rational, df1$rational2)

reg_rational4 <- lm(rational2 ~ Gender + Age + Education + Nonwhite + Time9 + Treatment*Gender +  Treatment*Age + Treatment*Education + 
                      Treatment*Nonwhite + Treatment*Time9,
                    data = df1)

reg_rational3 <- lm(rational ~ Gender + Age + Education + Nonwhite + Time9 + Treatment*Gender +  Treatment*Age + Treatment*Education + 
                      Treatment*Nonwhite + Treatment*Time9, 
                    data = df1)

reg_rational4.se <- robust(reg_rational4)
reg_rational3.se <- robust(reg_rational3)

stargazer(reg_rational5, reg_rational6, reg_rational4, reg_rational3, se = list(reg_rational5.se, reg_rational4.se, reg_rational3.se))


reg_rational7 <- lm(rational2 ~ Treatment, data = df1)
reg_rational8 <- lm(rational ~ Treatment, data = df1)

summ(reg_rational7, robust= "HC3", digits = 3)
summ(reg_rational8, robust = "HC3", digits = 3)
summ(reg_rational3, robust = "HC3", digits = 3)
########################################################################################################

############### Part 4.1. Looking within genders          ##############################################

########################################################################################################

df6 <- df1 %>%
  filter(Gender == 0)

df7 <- df1 %>% 
  filter(Gender == 1)


## Check belief forming 


reg_belief7 <- (lm(Belief_algorithm ~ Age + Education + Nonwhite + Time9 + Treatment + 
             Age * Treatment + Education * Treatment + Nonwhite * Treatment + Time9*Treatment, data = df6))

reg_belief8 <- (lm(Belief_algorithm ~ Age + Education + Nonwhite + Time9 + Treatment + 
             Age * Treatment + Education * Treatment + Nonwhite * Treatment + Time9*Treatment, data = df7))


summary(reg_belief7)
summary(reg_belief8)


summary(lm(Choice1 ~ Age + Education + Nonwhite + Time9 + Treatment + 
             Age * Treatment + Education * Treatment + Nonwhite * Treatment + Time9*Treatment, data = df6))

summary(lm(Choice1 ~ Age + Education + Nonwhite + Time9 + Treatment + 
             Age * Treatment + Education * Treatment + Nonwhite * Treatment + Time9*Treatment, data = df7))

  
  
  
  #########################################################################################################
  
  ############ Part 5: Looking at how well the algorithm performed    ##################
  
  #########################################################################################################
  
  
  
  df1$Algorithm_Predicted <- 6.43 + 0.75*df1$Age - 4.1 * df1$Gender + 0.53*df1$Time9 + 0.71 * df31Education - 1.03 * df31Nonwhite
  df3$Algorithm_deviation <- df31TimeAverage - df31Algorithm_Predicted
  
  hist(df3$Algorithm_deviation, breaks = 20)
  summary(df3$Algorithm_deviation)
  
  
  plot(df3$Algorithm_Predicted, df3$TimeAverage)
   summary(lm(df3$Pred_alg ~ df3$TimeAverage))
  
  
  summary(lm(df3$TimeAverage ~ df3$Age + df3$Gender + df3$Education + df3$Nonwhite + df3$Time9))
  
  
  summary(df3$Payoff_belief_a)
  summary(df3$Payoff_belief_h)
  


  ##logit?
  
  
  #########################################################################################################
  
  ############ Part 6: Looking at the attrition of participants    ##################
  
  #########################################################################################################
  setwd("~/Utrecht/Master Thesis/After February/Data & Analysis/Final Data")
  
  df_at <- read.csv("TimeSpent (accessed 2019-08-02) (1).csv")

  dropout1 = NULL 
  
  for (i in 1:33){
    x <- sum(df_at$page_index == i)
    dropout1[i] <- x
  }
  
  
  ## Calculating the average time participants needed for the experiment 
  summary(33 * (df_at$seconds_on_page) /60)
  summary(df_at$seconds_on_page)
  

  longtakers <- (df_at %>% 
    filter(seconds_on_page > 600))
  length(unique(longtakers$participant__id_in_session))
  
  df_at1 <- df_at[df_at$participant__code %in% df1$MTurk_code, ]
  df_at1$Treatment = "transp"
  

  # Now read in the baseline times
  
  df_at2 <- rbind(read.csv("TimeSpent (accessed 2019-07-05).csv"), read.csv("TimeSpent (accessed 2019-07-06).csv"))
  df_at2 <- df_at2[df_at2$participant__code%in% df1$MTurk_code, ]
  df_at2$Treatment = "baseline"
  
  sum(df_at1$seconds_on_page < 3)
  sum(df_at2$seconds_on_page < 3)
  
  unique(df_at1$participant__code[df_at1$seconds_on_page < 3])
  unique(df_at2$participant__code[df_at2$seconds_on_page <3])
  
  unique(df_at1$participant__code[df_at1$seconds_on_page > 1200])
  unique(df_at2$participant__code[df_at2$seconds_on_page > 1200])
  
  
  df_timespent <- rbind(df_at1 %>% 
          group_by(participant__code) %>% 
          summarise(Avg_Time = mean(seconds_on_page)) %>% 
          add_column(Treatment = "transp"), 
        df_at2 %>% 
          group_by(participant__code) %>% 
          summarise(Avg_Time = mean(seconds_on_page)) %>% 
          add_column(Treatment = "baseline")
        )
  
  
  setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
  
  jpeg("TimeSpent.jpg")
  ggdensity(df_timespent, x = "Avg_Time",
              add = "mean", rug = TRUE,
              fill = "Treatment", palette = c("#00AFBB", "#E7B800"),
              add_density = TRUE, 
            xlab = "Average Time spent per Page", 
            xlim = c(0,120))
  dev.off()
  
  df_timepage = rbind(df_at1, df_at2) %>% 
    group_by(page_index, Treatment) %>% 
    summarise(Avg_Time = mean(seconds_on_page)) %>% 
    spread(Treatment, Avg_Time) %>% 
    add_column(Page_Name = df_at1$page_name[1:33])
    
    #Reorder
  df_timepage$page_index = NULL
  df_timepage <- df_timepage[, c(3,1,2)]
  
  ## Output in latex
  print(xtable(df_timepage),  include.rownames = FALSE)
  test <- pairwise.t.test(df_timepage$baseline, df_timepage$transp, pool.sd = F)
  test$p.value
  
  #### Robustness Check excluding people who needed 
  
  reg13 <- lm(Choice1 ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  summary(reg13)
  reg13.se <- vcovHC(reg13, type = "HC")
  reg13.se <- sqrt(diag(reg13.se))
  
  stargazer(reg1, reg13, se=list(reg1.se, reg13.se))
  
  
  ### Now look at the 

  #########################################################################################################
  
        ############    Part 7: Results of the two Auxiliary experiments    ##################
  
  #########################################################################################################
  
  
  
  
  # define working directory
  setwd("~/Utrecht/Master Thesis/After February/Data & Analysis")
  
  library(xlsx)
  # Define data set
  df_aux1 <- read.xlsx("all_apps_wide_2019-04-17.xlsx", 1)
  
  #change df2 to tibble 
  df_aux1 <- as_tibble(df_aux1)
  
  
  # subsetting the data for the variables of interest, that are: 
  # id and code, all characteristics, risk choice, big 5, scores for each task 
  # and all answeres for the post survey and payoff
  
  df_aux1 <- df_aux1 %>% 
    select(participant.code, participant.id_in_session, participant.payoff,
           participant.payoff_plus_participation_fee, 
           Demographic.1.player.age, Demographic.1.player.gender, Demographic.1.player.education,
           Demographic.1.player.ethnicity, Demographic.1.player.nationality,
           matrix_new.1.player.elapsed_time1, matrix_new.1.player.count1, 
           matrix_new.1.player.elapsed_time2, matrix_new.1.player.elapsed_time3,
           matrix_new.1.player.elapsed_time4, matrix_new.1.player.elapsed_time5,
           matrix_new.1.player.elapsed_time6, matrix_new.1.player.elapsed_time7,
           matrix_new.1.player.elapsed_time8, matrix_new.1.player.elapsed_time9,   
           matrix_new.1.player.elapsed_time10, matrix_new.1.player.count2,
           matrix_new.1.player.count3, matrix_new.1.player.count4, matrix_new.1.player.count5, 
           matrix_new.1.player.count6, matrix_new.1.player.count7, matrix_new.1.player.count8,
           matrix_new.1.player.count9,matrix_new.1.player.count10,
           post_exp_survey.1.player.test_intro,  post_exp_survey.1.player.choice1,
           post_exp_survey.1.player.explanation, post_exp_survey.1.player.choice2,
           post_exp_survey.1.player.fair, post_exp_survey.1.player.transparent,
           post_exp_survey.1.player.simpler, post_exp_survey.1.player.familiar,
           post_exp_survey.1.player.characteristics, post_exp_survey.1.player.previous_performance,
           post_exp_survey.1.player.discriminate, post_exp_survey.1.player.quickly,
           post_exp_survey.1.player.error, post_exp_survey.1.player.other,
           post_exp_survey.1.player.x1,
           mpl.1.player.inconsistent, mpl.1.player.switching_row, BFI_S.1.player.Worry,
           BFI_S.1.player.Nervous, BFI_S.1.player.Relax, BFI_S.1.player.Talkative,
           BFI_S.1.player.Sociable, BFI_S.1.player.Reserved, BFI_S.1.player.Original,
           BFI_S.1.player.Artistic, BFI_S.1.player.Active_imagination, BFI_S.1.player.Rude,
           BFI_S.1.player.Forgiving, BFI_S.1.player.Considerate, BFI_S.1.player.Thorough_job, 
           BFI_S.1.player.Thorough_job, BFI_S.1.player.Lazy, BFI_S.1.player.Efficient
    )
  
  
  #create the average
  df_aux1$matrix_new.1.player.average = (df_aux1$matrix_new.1.player.elapsed_time1 + 
                                       df_aux1$matrix_new.1.player.elapsed_time2 + 
                                       df_aux1$matrix_new.1.player.elapsed_time3 +
                                       df_aux1$matrix_new.1.player.elapsed_time4 + 
                                       df_aux1$matrix_new.1.player.elapsed_time5 + 
                                       df_aux1$matrix_new.1.player.elapsed_time6 +
                                       df_aux1$matrix_new.1.player.elapsed_time7 + 
                                       df_aux1$matrix_new.1.player.elapsed_time8 + 
                                       df_aux1$matrix_new.1.player.elapsed_time9 + 
                                       df_aux1$matrix_new.1.player.elapsed_time10 )/10
  
  # First create dummy for ethnicity: If not white
  df_aux1$Demographic.1.player.dummyeth = 1
  df_aux1$Demographic.1.player.dummyeth[df_aux1$Demographic.1.player.ethnicity == "White"] = 0
  
  
  #Now run the regression 
  reg1 <- (lm(df_aux1$matrix_new.1.player.average ~ df_aux1$Demographic.1.player.age + df_aux1$Demographic.1.player.gender + df_aux1$Demographic.1.player.education + df_aux1$Demographic.1.player.dummyeth + df_aux1$matrix_new.1.player.elapsed_time9))

  stargazer(reg1)
  
  
  ### Unincentivized section: Discrete choice and belief
  
  table(df_aux1$post_exp_survey.1.player.choice1)
  
  # Create barplots to show the distribution  
  df_choice1 <- 
    cbind.data.frame(
      c("Aux1", "Baseline", "Transp"), 
      c(round(mean(df_aux1$post_exp_survey.1.player.choice1-1), 3), round(mean(df2$Choice1),3),  
        round(mean(df3$Choice1), 3)), 
      c(1- round(mean(df_aux1$post_exp_survey.1.player.choice1-1), 3), 1- round(mean(df2$Choice1),3),  
        1- round(mean(df3$Choice1), 3))
    )
  colnames(df_choice1) <- c("Experiment", "Algorithmic Recruiter", "Human Recruiter")
  
  ## Create a simple barplot to show how many participants chose human-algorithm in the auxiliary experiment
  
  xtable(table(df_aux1$post_exp_survey.1.player.choice1))
  xtable(table(df_aux1$post_exp_survey.1.player.choice2))
  
  #Create the correlation matrix 
  stargazer(cor(df_aux1[, c("post_exp_survey.1.player.choice1", "post_exp_survey.1.player.choice2", 
                            "matrix_new.1.player.elapsed_time9")]))
  
  
  #constructing a vector with the classifications
  classification <- c("nonsense", "avoiding bias", "avoiding bias", "avoiding bias", "nonsense", 
                      "avoiding bias", "general-human", "general-human", "general-human", "avoiding bias", 
                      "avoiding bias", "nonsense", "avoiding bias", "general-human", "general-human", "general-human", 
                      "avoiding bias", "fair", "performance", "miscalleneous", "general-algorithm", "general-algorithm", 
                      "general-human", "general-human", "avoiding bias", "avoiding bias", "general-human", "general-human", 
                      "general-human", "general-algorithm", "general-algorithm", "avoiding bias", "avoiding bias", 
                      "general-algorithm", "general-human", "avoiding bias", "avoiding bias", "general-human",
                      "avoiding bias", "performance", "trust", "general-algorithm", "general-human", "trust", 
                      "avoiding bias", "general-human", "general-algorithm", "fair", "general-algorithm", "avoiding bias", 
                      "general-human", "avoiding bias", "avoiding bias", "task", "general-human", "task", "general-human", 
                      "general-human", "general-human", "miscalleneous", "avoiding bias", "trust", "general-human",
                      "general-human", "general-human", "general-algorithm", "avoiding bias", "general-human", 
                      "performance", "avoiding bias", "general-human", "miscalleneous", "avoiding bias", "fair", 
                      "avoiding bias", "fair", "avoiding bias", "performance", "miscalleneous", "fair", "general-human", 
                      "general-human", "general-algorithm")
  
  #add the classification to the data
  df_aux1$classification = classification
  
  #show the frequencies of the classification
  table(df_aux1$classification)
  
  #Plot the frequencies of the type of answers
  g <- ggplot(df_aux1, aes(x = classification))
  
  setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
  jpeg("classification.jpg")
  g + geom_bar() + theme(axis.text.x = element_text(face = "bold", 
                                                    size = 10, angle = 45, hjust = 1))  + xlab("")
  dev.off()
  
  ## Looking at the relationship between the categorized explanations and the choosing behavior of participants
  
  df_aux1$post_exp_survey.1.player.dummybias = 0
  df_aux1$post_exp_survey.1.player.dummybias[df_aux1$classification == "avoiding bias"] = 1
  
  df_aux1$post_exp_survey.1.player.dummyhuman = 0
  df_aux1$post_exp_survey.1.player.dummyhuman[df_aux1$classification == "general-human"] = 1
  
  cor(df_aux1[, c("post_exp_survey.1.player.choice1" , "post_exp_survey.1.player.dummybias",  
  "post_exp_survey.1.player.dummyhuman")])
  
  

  #Do some quick regressions on the discrete choice with both dummy variables
  reg_aux1 <- lm((df_aux1$post_exp_survey.1.player.choice1-1) ~ df_aux1$post_exp_survey.1.player.dummybias + 
               df_aux1$post_exp_survey.1.player.dummyhuman)

  reg_aux2 <- lm((df_aux1$post_exp_survey.1.player.choice2-1) ~ df_aux1$post_exp_survey.1.player.dummybias + 
               df_aux1$post_exp_survey.1.player.dummyhuman)
  
  stargazer(reg_aux1, reg_aux2)
  
  
  
  #########################################################################################################
  
  ############    Part 8: Results from the human recruiter    ##################
  
  #########################################################################################################
  
  setwd("~/Utrecht/Master Thesis/After February/Human Evaluator/Datasheets/Results")
  
  df_aux2 <- read.csv("df1.csv")
  df_aux2 <- df_aux2[, 1:16]
  
  #Creating non-white dummy
  df_aux2$dummyeth = 0
  df_aux2$dummyeth[df_aux2$Ethnicity != "White"] = 1
  
  #Create average score 
  df_aux2$Avg_Pred <- (df_aux2$P1 + df_aux2$P2 + df_aux2$P3 + df_aux2$P4 + df_aux2$P5 + df_aux2$P7 + df_aux2$P8 + 
                         df_aux2$P9)/9
  
  ## Now use OLS to see how they decided on average
  
  reg_aux3 <- lm(Avg_Pred ~ Gender + Age + Education + dummyeth + Round9, data = df_aux2)
  
  stargazer(reg1, reg_aux3)
  
  
 ######################################################################################## 
  
  ####    Part 9: Looking at the qualitative answers                              ######
  
  ########################################################################################
  
  
  ## Vector with answers from people who chose the algorithm in the treatment
  
  
## Print the explanations
  
  print(xtable(df1 %>% 
                 select(Explanation1, Explanation2)), include.rownames = FALSE)

  
  expl1 <- df1 %>%
    filter(Treatment == "transp" & Choice1 == 1) %>% 
    select(Explanation1)
  
  expl2 <- df1%>% 
    filter(Treatment == "transp" & Choice1 == 0 & Gender == 0) %>%
  select(Explanation1)
  
  ######## Code the free-text explanations 
  
  ## Check if it can be true that all were presented in the order algorithm - human
  
  test <- ggplot(df1, aes(x = Treatment, y = B_Fair)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    facet_wrap(~Gender,nrow=3)
  
  test <- df1 %>% 
    select(B_Fair, B_Transparent, B_Simpler, B_Simpler, B_Discriminate, B_Familiar, B_Characteristics, B_Error, 
           B_Performance, B_Quickly, B_Other, Treatment, Gender) %>%
    group_by(Treatment, Gender)
    
  ggplot(df6, aes(x = B_Fair)) + 
    geom_histogram() + 
    facet_grid( ~ c(Treatment))
  
  ggplot(df7, aes(x = B_Fair)) + 
    geom_histogram() + 
    facet_grid( Treatment ~ .)
  
  ### Now do a t-test means table for the beliefs 
  
  df_beliefs <- cbind(c( mean(df2$B_Fair),
                         mean(df2$B_Transparent), 
                         mean(df2$B_Simpler), 
                         mean(df2$B_Discriminate), 
                         mean(df2$B_Familiar), 
                         mean(df2$B_Characteristics), 
                         mean(df2$B_Error), 
                         mean(df2$B_Performance), 
                         mean(df2$B_Quickly), 
                         mean(df2$B_Other)), 
                      c( mean(df3$B_Fair),
                         mean(df3$B_Transparent), 
                         mean(df3$B_Simpler), 
                         mean(df3$B_Discriminate), 
                         mean(df3$B_Familiar), 
                         mean(df3$B_Characteristics), 
                         mean(df3$B_Error), 
                         mean(df3$B_Performance), 
                         mean(df3$B_Quickly), 
                         mean(df3$B_Other)),
                      c( t.test(df2$B_Fair, df3$B_Fair)$statistic, 
                         t.test(df2$B_Transparent, df3$B_Transparent)$statistic,
                         t.test(df2$B_Simpler, df3$B_Simpler)$statistic,
                         t.test(df2$B_Discriminate, df3$B_Discriminate)$statistic,
                         t.test(df2$B_Familiar, df3$B_Familiar)$statistic,
                         t.test(df2$B_Characteristics, df3$Characteristics)$statistic,
                         t.test(df2$B_Error, df3$Error)$statistic,
                         t.test(df2$B_Performance, df3$B_Performance)$statistic,
                         t.test(df2$B_Quickly, df3$B_Quickly)$statistic,
                         t.test(df2$B_Other, df3$B_Other)$statistic)
  )
  
  ## P-values
  
  round(c( t.test(df2$B_Fair, df3$B_Fair)$p.value,
     t.test(df2$B_Transparent, df3$B_Transparent)$p.value,
     t.test(df2$B_Simpler, df3$B_Simpler)$sp.value,
     t.test(df2$B_Discriminate, df3$B_Discriminate)$p.value,
     t.test(df2$B_Familiar, df3$B_Familiar)$p.value,
     t.test(df2$B_Characteristics, df3$Characteristics)$p.value,
     t.test(df2$B_Error, df3$Error)$p.value,
     t.test(df2$B_Performance, df3$B_Performance)$p.value,
     t.test(df2$B_Quickly, df3$B_Quickly)$p.value,
     t.test(df2$B_Other, df3$B_Other)$p.value), 2)
  
  colnames(df_beliefs) <- c("Baseline", "Treatment", "T-statistic") 
  rownames(df_beliefs) <- c("Fairness", "Transparent", "Simpler", "Discriminate", "Familiar", "Care about Characteristics", 
                            "Prone to Error", "Performance", "Quickly", "Other")
  
  xtable(df_beliefs)
  
  ##### Now do the same for the treatment only, comparing Genders
  df8 <- df1 %>% filter(Gender == 0, Treatment == "transp")
  df9 <- df1 %>% filter(Gender == 1, Treatment == "transp")
  
  
  df_beliefsgender <- cbind(c( mean(df8$B_Fair),
                         mean(df8$B_Transparent), 
                         mean(df8$B_Simpler), 
                         mean(df8$B_Discriminate), 
                         mean(df8$B_Familiar), 
                         mean(df8$B_Characteristics), 
                         mean(df8$B_Error), 
                         mean(df8$B_Performance), 
                         mean(df8$B_Quickly), 
                         mean(df8$B_Other)), 
                      c( mean(df9$B_Fair),
                         mean(df9$B_Transparent), 
                         mean(df9$B_Simpler), 
                         mean(df9$B_Discriminate), 
                         mean(df9$B_Familiar), 
                         mean(df9$B_Characteristics), 
                         mean(df9$B_Error), 
                         mean(df9$B_Performance), 
                         mean(df9$B_Quickly), 
                         mean(df9$B_Other)),
                      c( t.test(df8$B_Fair, df9$B_Fair)$statistic, 
                         t.test(df8$B_Transparent, df9$B_Transparent)$statistic,
                         t.test(df8$B_Simpler, df9$B_Simpler)$statistic,
                         t.test(df8$B_Discriminate, df9$B_Discriminate)$statistic,
                         t.test(df8$B_Familiar, df9$B_Familiar)$statistic,
                         t.test(df8$B_Characteristics, df9$B_Characteristics)$statistic,
                         t.test(df8$B_Error, df9$B_Error)$statistic,
                         t.test(df8$B_Performance, df9$B_Performance)$statistic,
                         t.test(df8$B_Quickly, df9$B_Quickly)$statistic,
                         t.test(df8$B_Other, df9$B_Other)$statistic)
  )
  
  colnames(df_beliefsgender) <- c("Baseline", "Treatment", "T-statistic") 
  rownames(df_beliefsgender) <- c("Fairness", "Transparent", "Simpler", "Discriminate", "Familiar", "Care about Characteristics", 
                            "Prone to Error", "Performance", "Quickly", "Other")
  
  xtable(df_beliefsgender)
  
  round(c( t.test(df8$B_Fair, df9$B_Fair)$p.value, 
     t.test(df8$B_Transparent, df9$B_Transparent)$p.value,
     t.test(df8$B_Simpler, df9$B_Simpler)$p.value,
     t.test(df8$B_Discriminate, df9$B_Discriminate)$p.value,
     t.test(df8$B_Familiar, df9$B_Familiar)$p.value,
     t.test(df8$B_Characteristics, df9$B_Characteristics)$p.value,
     t.test(df8$B_Error, df9$B_Error)$p.value,
     t.test(df8$B_Performance, df9$B_Performance)$p.value,
     t.test(df8$B_Quickly, df9$B_Quickly)$p.value,
     t.test(df8$B_Other, df9$B_Other)$p.value), 2)
  
  ### Now do the same for the baseline
  df8 <- df1 %>% 
    filter(Treatment == "baseline", Gender == 1)
  
  df9 <- df1 %>% 
    filter(Treatment == "transp", Gender == 1)
  
  df_beliefsgenderbase <- cbind(c( mean(df8$B_Fair),
                               mean(df8$B_Transparent), 
                               mean(df8$B_Simpler), 
                               mean(df8$B_Discriminate), 
                               mean(df8$B_Familiar), 
                               mean(df8$B_Characteristics), 
                               mean(df8$B_Error), 
                               mean(df8$B_Performance), 
                               mean(df8$B_Quickly), 
                               mean(df8$B_Other)), 
                            c( mean(df9$B_Fair),
                               mean(df9$B_Transparent), 
                               mean(df9$B_Simpler), 
                               mean(df9$B_Discriminate), 
                               mean(df9$B_Familiar), 
                               mean(df9$B_Characteristics), 
                               mean(df9$B_Error), 
                               mean(df9$B_Performance), 
                               mean(df9$B_Quickly), 
                               mean(df9$B_Other)),
                            c( t.test(df8$B_Fair, df9$B_Fair)$statistic, 
                               t.test(df8$B_Transparent, df9$B_Transparent)$statistic,
                               t.test(df8$B_Simpler, df9$B_Simpler)$statistic,
                               t.test(df8$B_Discriminate, df9$B_Discriminate)$statistic,
                               t.test(df8$B_Familiar, df9$B_Familiar)$statistic,
                               t.test(df8$B_Characteristics, df9$B_Characteristics)$statistic,
                               t.test(df8$B_Error, df9$B_Error)$statistic,
                               t.test(df8$B_Performance, df9$B_Performance)$statistic,
                               t.test(df8$B_Quickly, df9$B_Quickly)$statistic,
                               t.test(df8$B_Other, df9$B_Other)$statistic)
  )
  
  colnames(df_beliefsgenderbase) <- c("Female", "Male", "T-statistic") 
  rownames(df_beliefsgenderbase) <- c("Fairness", "Transparent", "Simpler", "Discriminate", "Familiar", "Care about Characteristics", 
                                  "Prone to Error", "Performance", "Quickly", "Other")
  xtable(df_beliefsgenderbase)
  
  
  ### Regressin choice and qualitative beliefs: 
  
  reg_test <- lm(Choice1 ~ B_Discriminate * Treatment, data = df1)
  summary(reg_test)
  ### Regressions for all Beliefs
  
  reg_belief1 <- lm(B_Fair ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                    Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  reg_belief2 <- lm(B_Transparent ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                    Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  reg_belief3 <- lm(B_Simpler ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                    Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  reg_belief4 <- lm(B_Discriminate ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  reg_belief5 <- lm(B_Familiar ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1) 
  reg_belief6 <- lm(B_Characteristics ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1)
  reg_belief7 <- lm(B_Error ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1 )
  reg_belief8 <- lm(B_Performance ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1 )
  reg_belief9 <- lm(B_Quickly ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1 )
  reg_belief10 <- lm(B_Other ~ Treatment + Gender + Education + Nonwhite + Age  + Time9 + Gender * Treatment  +  
                      Education * Treatment + Age * Treatment + Nonwhite * Treatment + Time9 * Treatment, data = df1 )
  
  summary(reg_belief1)
  
  reg_belief1.se  <- robust(reg_belief1)
  reg_belief2.se  <- robust(reg_belief2)
  reg_belief3.se  <- robust(reg_belief3)
  reg_belief4.se  <- robust(reg_belief4)
  reg_beleif5.se  <- robust(reg_belief5)
  reg_belief6.se  <- robust(reg_belief6)
  reg_belief7.se  <- robust(reg_belief7)
  reg_belief8.se  <- robust(reg_belief8)
  reg_belief9.se  <- robust(reg_belief9)
  reg_belief10.se <- robust(reg_belief10)
  
  summary(reg_belief10, se = reg_belief10.se)

  ## Do a regression Table that will get put into the main paper
  stargazer(reg_belief1, reg_belief2, reg_belief4, se = list(reg_belief1.se, reg_belief2.se, reg_belief4.se))
  
  
  
  ### Comparing the models fit 
  
  reg_qual0  <- (lm(Choice1 ~ Belief_algorithm+ Belief_human + Belief_dummy + Treatment + 
               Belief_algorithm * Treatment + Belief_human * Treatment + Belief_dummy * Treatment, data = df1))
  
  reg_qual1 <- (lm(Choice1 ~ B_Fair  + B_Performance  + B_Discriminate + B_Familiar  + B_Error + Treatment + 
               B_Fair * Treatment + B_Performance * Treatment + B_Discriminate * Treatment + B_Familiar * Treatment * B_Error * Treatment, data = df1  ))
  
  reg_qual2 <- (lm(Choice1 ~ B_Fair  + B_Performance  + B_Discriminate   + Treatment + 
            B_Fair * Treatment + B_Performance * Treatment + B_Discriminate * Treatment , data = df1))
  
  ## Now both: 
  reg_qual3 <- (lm(Choice1 ~ Belief_algorithm+ Belief_human + Belief_dummy + Treatment + 
               Belief_algorithm * Treatment + Belief_human * Treatment + Belief_dummy * Treatment + 
               B_Fair  + B_Fair * Treatment, data = df1 ))
  
  reg_qual4 <- (lm(Choice1 ~ Belief_algorithm+ Belief_human + Belief_dummy + Treatment + 
                     Belief_algorithm * Treatment + Belief_human * Treatment + Belief_dummy * Treatment + 
                     B_Fair  + B_Fair * Treatment + B_Discriminate + B_Discriminate * Treatment, data = df1 ))
    
    
  reg_qual5 <- (lm(Choice1 ~ Belief_algorithm+ Belief_human + Belief_dummy + Treatment + 
                     Belief_algorithm * Treatment + Belief_human * Treatment + Belief_dummy * Treatment + 
                     B_Fair  + B_Performance  + B_Discriminate   + Treatment + 
                     B_Fair * Treatment + B_Performance * Treatment + B_Discriminate * Treatment, data = df1 ))
  
  
  reg_qual6 <- lm(Choice1~ Belief_algorithm+ Belief_human + Belief_dummy + Treatment + 
                    Belief_algorithm * Treatment + Belief_human * Treatment + Belief_dummy * Treatment + 
                    B_Fair  + B_Performance  + B_Discriminate + B_Familiar  + B_Error + Treatment + 
                    B_Fair * Treatment + B_Performance * Treatment + B_Discriminate * Treatment + B_Familiar * Treatment * B_Error * Treatment + 
                    B_Transparent  + B_Transparent * Treatment, 
                  data = df1)
  
  reg_qual00 <- lm(Choice1 ~ 0, data = df1)
  ### Anova to see if the inclusion of qualitative beliefs significantly increased the explanatory power: 
  anova0 <- anova(reg_qual00, reg_qual0)
  anova1 <- anova(reg_qual0, reg_qual3)
  anova2 <- anova(reg_qual3, reg_qual4)
  anova3 <- anova(reg_qual4, reg_qual5)
  anova4 <- anova(reg_qual5, reg_qual6)
  
  ## Regression on algorithmic belief OR the dummy and the qual. beliefs
  reg_qual7 <- lm(Belief_algorithm ~ B_Fair + B_Discriminate + B_Performance + B_Transparent + 
                    B_Fair * Treatment + B_Discriminate * Treatment + B_Performance * Treatment + B_Transparent * Treatment , 
                  data = df1)
  reg_qual7.se <- robust(reg_qual7)
  
  reg_qual8 <- lm(Belief_diff ~ B_Fair + B_Discriminate + B_Performance + B_Transparent + 
                    B_Fair * Treatment + B_Discriminate * Treatment + B_Performance * Treatment + B_Transparent * Treatment , 
                  data = df1)
  reg_qual8.se <- robust(reg_qual8)
  
  reg_qual9 <- lm(Confidence_alg ~ B_Fair + B_Discriminate + B_Performance + B_Transparent + 
                    B_Fair * Treatment + B_Discriminate * Treatment + B_Performance * Treatment + B_Transparent * Treatment , 
                  data = df1)  

  
  stargazer(reg_qual7, reg_qual8, se = list(reg_qual7.se, reg_qual8.se))
  
  
  
  p3 <- ggplot(df1_plot, aes(x = Treatment, y= B_Discriminate, fill = as.factor(Gender))) + 
    geom_bar(position = position_dodge(width=0.85), stat = "summary", fun.y = "mean", width = 0.8, color = "black")  + 
    scale_fill_manual(values = c("#0000CC", "#990000", "#0000CC", "#990000")) + 
    geom_errorbar(stat="summary", fun.data="mean_se", position = position_dodge(0.85), width = .2) + 
    theme_bw() + xlab("") + ylab("Perceived Discriminatioon ") + 
    ylim(c(0, 4)) + 
    theme(legend.position = "top",
          legend.background = element_rect(fill = "#EEEEEE", color = "black"),
          legend.title = element_text(),axis.title = element_text(size = 16, face="bold")) +
    theme(axis.text.x  = element_text(size = 14)) + 
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), size = 20)) + 
    guides(fill=guide_legend(title="Gender: "))
  p3
  
  
  p4 <- ggplot(df1_plot, aes(x = Treatment, y= B_Fair, fill = as.factor(Gender))) + 
    geom_bar(position = position_dodge(width=0.85), stat = "summary", fun.y = "mean", width = 0.8, color = "black")  + 
    scale_fill_manual(values = c("#0000CC", "#990000", "#0000CC", "#990000")) + 
    geom_errorbar(stat="summary", fun.data="mean_se", position = position_dodge(0.85), width = .2) + 
    theme_bw() + xlab("") + ylab("Perceived Discriminatioon ") + 
    ylim(c(0, 4)) + 
    theme(legend.position = "top",
          legend.background = element_rect(fill = "#EEEEEE", color = "black"),
          legend.title = element_text(),axis.title = element_text(size = 16, face="bold")) +
    theme(axis.text.x  = element_text(size = 14)) + 
    theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), size = 20)) + 
    guides(fill=guide_legend(title="Gender: "))
  p4
  
  test <- df1%>% 
    group_by(Gender, Treatment) %>% 
    summarise(mean_fair = mean(B_Fair)) %>% 

    
  test2 <- reshape(test, time = Gender, direction = "wide")
  
  ####################################################################
  
  ### Part 9: Did men and women get more money out of their self sections
  
 df1$payoff_choice_r[df1$Choice1 == 1] <- (max(90-8*df1$Pred_alg, 0))
 df1$payoff_choice_r[df1$Choice1 == 0] <- max(90-8*df1$Pred_hum, 0)
  
  summary(lm(payoff_choice_r ~ Treatment , data = df1 %>% filter(Gender == 1)))
  
##################################################################################################################
  ##################################################################################################################
  
  ## Miscalleneous
  
  ##################################################################################################################
  ##################################################################################################################
  
  ##### The average payoment of the human recruiter experimet (Experiment B) 
  
  
  payment_ExperimnetB <- c(11, 6.5, 11, 10, 10.5, 11, 11, 11, 11, 11, 11, 11, 10.5, 7.5, 9, 11, 11, 11, 10, 11)
  mean(payment_ExperimnetB)


  test <- df1 %>%
    filter(Treatment == "transp" & Gender == 0 & Choice1 == 0)
  
  summary(test$B_Discriminate)
  
  test <- df1 %>% 
    group_by(Treatment, Gender) %>% 
    summarise(mean_diff = mean(Belief_diff))
  
  test <- df1 %>% 
    group_by(Treatment, Gender) %>% 
    summarise(mean_alg = mean(Belief_algorithm), 
              mean_hum = mean(Belief_human))
  
  
  #############################################################################################################
  
  ###### Part 10: Scaling the psychological predictors and qualitative beliefs
  
  
  ### Step 1: Checking the distributions: 
  class(df1$Extroversion)
  
  hist(df1$Extroversion, breaks = 20 )
  hist(df1$Neuroticism, breaks = 20)
  hist(df1$Openness, breaks = 20)
  hist(df1$Conscientiousness, breaks = 20)
  hist(df1$Agreeableness, breaks = 20)
  
  
  hist_extro <- ggplot(df1) + geom_histogram(aes(Extroversion), binwidth = 0.15) + ylab("Count") + xlab("Extroversion") + 
    theme(axis.title.x = element_text(face = "bold"))  + theme_bw()
  hist_extro
  hist_neuro <- ggplot(df1) + geom_histogram(aes(Neuroticism), binwidth = 0.15) + theme_bw()
  hist_open <- ggplot(df1) + geom_histogram(aes(Openness), binwidth = 0.15) + theme_bw()
  hist_consc <- ggplot(df1) + geom_histogram(aes(Conscientiousness), binwidth = 0.15) + theme_bw()
  hist_agree <- ggplot(df1) + geom_histogram(aes(Agreeableness), binwidth = 0.15) + theme_bw()
  
  
  ks.test(df1$sc_open, "pnorm")
  
  setwd("~/Utrecht/Master Thesis/After February/Writing the thesis/Document/Graphs")
  jpeg("Hist_big5.jpg")
  ggarrange(hist_extro, hist_neuro, hist_open, hist_consc, hist_agree, 
            ncol = 2, nrow = 3)
  dev.off()
  
  #### Now start the scaling regressions: Which one's do I have to do? 
  #### - 4 including the Big 5 - and the qualitative beliefs
  
  ###### Regression Part 1: Run the full regression specification for the discrete choice and the difference in beliefs: 
  
  reg_scale1 <- lm(Choice1 ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                                   Nonwhite * Treatment + Time9*Treatment + Risk_choice + sc_open + sc_consc + sc_extro + sc_agree + sc_neuro  + 
                                   Risk_choice*Treatment + sc_open * Treatment + sc_consc*Treatment + sc_extro * Treatment + sc_agree*Treatment + 
                                   sc_neuro * Treatment 
                                   , data = df1)
  
  summary(reg_scale1)
  reg_scale1.se <- robust(reg_scale1)
  
  reg_scale2 <- lm(Belief_diff ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment + Risk_choice + sc_open + sc_consc + sc_extro + sc_agree + sc_neuro  + 
                     Risk_choice*Treatment + sc_open * Treatment + sc_consc*Treatment + sc_extro * Treatment + sc_agree*Treatment + 
                     sc_neuro * Treatment 
                   , data = df1)
  
  reg_scale2.se <- robust(reg_scale2)
  summary(reg_scale2)
  
  stargazer(reg_scale1, reg_scale2, se = list(reg_scale1.se, reg_scale2.se))
  
  
  ##### Regression Part 2: Run the full regression specification for payoff-maximizing recruiters and belief consistency
  
  reg_scale3 <- lm(rational2 ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment + Risk_choice + sc_open + sc_consc + sc_extro + sc_agree + sc_neuro  + 
                     Risk_choice*Treatment + sc_open * Treatment + sc_consc*Treatment + sc_extro * Treatment + sc_agree*Treatment + 
                     sc_neuro * Treatment 
                   , data = df1)
  
  summary(reg_scale3)
  reg_scale3.se <- robust(reg_scale3)
  
  reg_scale4 <- lm(rational ~ Gender + Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment + Risk_choice + sc_open + sc_consc + sc_extro + sc_agree + sc_neuro  + 
                     Risk_choice*Treatment + sc_open * Treatment + sc_consc*Treatment + sc_extro * Treatment + sc_agree*Treatment + 
                     sc_neuro * Treatment 
                   , data = df1)
  
  reg_scale4.se <- robust(reg_scale4)
  summary(reg_scale4)
  
  stargazer(reg_scale3, reg_scale4, se = list(reg_scale3.se, reg_scale4.se))
  
  #### Regression Part 3: Test the influence of personal characteristics on the beliefs: 
  
  
  reg_scale5 <- lm(df1$sc_discriminate ~ Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment, data = df1)
  
  summary(reg_scale5)
  reg_scale5.se <- robust(reg_scale5)
  
  reg_scale6 <- lm(df1$sc_fair ~ Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment, data = df1)
  summary(reg_scale6)
  reg_scale6.se <- robust(reg_scale6)
  
  stargazer(reg_scale6, se = reg_scale6.se)
  
  reg_scale7 <- lm(df1$sc_transp ~ Age + Education + Nonwhite + Time9 + Gender * Treatment + Age * Treatment + Education * Treatment + 
                     Nonwhite * Treatment + Time9*Treatment, data = df1)
  summary(reg_scale7)
  reg_scale7.se <- robust(reg_scale7)
  
  stargazer(reg_scale5, reg_scale6, reg_scale7, se = list(reg_scale5.se, reg_scale6.se, reg_scale7.se))
  
  
  #### Regression Part 4: Do the regression where beliefs are regressed on qualitative beliefs
  
  reg_scale8 <- lm(Belief_algorithm ~ sc_fair + sc_discriminate + sc_perf + sc_transp + 
                    sc_fair * Treatment + sc_discriminate * Treatment + sc_perf * Treatment + sc_transp * Treatment , 
                  data = df1)
  reg_scale8.se <- robust(reg_scale8)
  
  reg_scale9<- lm(Belief_diff ~ sc_fair + sc_discriminate + sc_perf + sc_transp + 
                    sc_fair * Treatment + sc_discriminate * Treatment + sc_perf * Treatment + sc_transp * Treatment , 
                  data = df1)
  reg_scale9.se <- robust(reg_scale9)
  
  
  
  stargazer(reg_scale8, reg_scale9, se = list(reg_scale8.se, reg_scale9.se))
  
  

  