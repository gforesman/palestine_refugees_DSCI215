library(tidyverse)

unrwaFull <- read_csv("unrwa_demo.csv")

unrwaClean <- unrwaFull %>%
  filter(!is.na(Year))

## Cleaning data
#creating vectors
female_minor_col <- c("female_0-4", "female_5-11", "female_12-17")
male_minor_col <- c("male_0-4", "male_5-11", "male_12-17")
pop_col <- c("female_0-4","female_5-11", "female_12-17","female_18-59", "female_60", "female_total","male_0-4", "male_5-11","male_12-17", "male_18-59","male_60","male_total", "total")
long_col <- c("female_0-4","female_5-11", "female_12-17","female_18-59", "female_60", "female_total","male_0-4", "male_5-11","male_12-17", "male_18-59","male_60","male_total", "total", "f_minor_all", "m_minor_all")


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
         "male_60" = "Male...14",
         "male_total"= "Male...15",
         "total" = "Total")

#taking out commas
unrwaClean <- unrwaClean %>%
  mutate_all(~sub("[,]{1,}" , "",.)) %>%
  mutate_all(~sub("[,]{1,}" , "",.))

unrwaClean[pop_col] <- sapply(unrwaClean[pop_col], as.numeric)

#adding new columns for total child

unrwaClean <- unrwaClean %>%
  mutate(f_minor_all = rowSums(across(female_minor_col)),
         m_minor_all = rowSums(across(male_minor_col)))

#converting column to same df structure as unhcr 
unrwaClean_long <- unrwaClean %>%
  pivot_longer(cols = long_col, 
               names_to = "population_type",
               values_to = "population"
)

#splitting age and gender for convenience depending on graph
unrwaClean_long[c('gender', 'age')] <- str_split_fixed(unrwaClean_long$population_type, "_", 2)


#saving csv
write.csv(unrwaClean_long, "unrwaDEMO_CleanLong.csv")

## Cleaning data for IDMC 

idmcFull <- read_csv("idmc_new_displacements.csv")

#taking out first row 
idmcClean <- idmcFull %>%
  filter(!is.na(new_displacement_rounded)) %>%
  mutate_at(c("year", "new_displacement", "new_displacement_rounded", "total_displacement", "total_displacement_rounded"), as.numeric)

#saving csv 
write.csv(idmcClean, "idmcClean.csv")

