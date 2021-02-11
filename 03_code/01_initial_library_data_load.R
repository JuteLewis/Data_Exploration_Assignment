# Loads primary libraries for use.
library(tidyverse)
library(jtools)
library(vtable)
library(purrr)
library(readxl)


# Loads most recent scorecard data into a base dataframe then selects out potential
# control variables.  Renames 'INSTINM' to 'schname' to match the trend dataframes to 
# simplify the code for joins
base_institute_data <- read_csv('01_raw_data/Most+Recent+Cohorts+(Scorecard+Elements).csv') %>% 
  select('INSTNM','HBCU', 'PBI', 'ANNHI', 'TRIBAL', 'AANAPII', 'HSI','NANTI', 
         'MENONLY','WOMENONLY','md_earn_wne_p10-REPORTED-EARNINGS') %>% 
  rename( schname = INSTNM)

view(base_institute_data)
