library(tidyverse)

unrwaFull <- read_csv("unrwa_demo.csv")

unrwaClean <- unrwaFull %>%
  filter(!is.na(Year))

## Cleaning data
#creating vectors
female_minor_col <- c("female_0-4", "female_5-11", "female_12-17")
male_minor_col <- c("male_0-4", "male_5-11", "male_12-17")

#renaming columns
unrwaClean <- unrwaClean %>%
  rename("year" = "Year",
         "origin" = "Country of...2",
         "asylum" = "Country of...3",
         "female_0-4" = "Female...4",
         "female_5-11" = "Female...5",
         "female_12-17" = "Female...6",
         "female_18-59" = "Female...7",
         "female_60" = "Female...8",
         "female_total"= "Female...9",
         "male_0-4" = "Male...10",
         "male_5-11" = "Male...11",
         "male_12-17" = "Male...12",
         "male_18-59" = "Male...13",
         "male_60" = "Male...15",
         "male_total"= "Male...15",
         "total" = "Total")


  mutate(f_minor_total = rowSums(across(female_minor_col)),
         m_minor_total = rowSums(across(male_minor_col)))
