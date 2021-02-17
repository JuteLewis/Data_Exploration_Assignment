# following code preps the trend data ----

# following code will list the csv file names in to a variable. 
trend_filenames <- list.files('01_raw_data', 'trend', full.name = TRUE)

# following code iterates over the filenames, reading the cvs, feeding them
# through the trend_prep function which will extracts the desired columns
# then binding together the rows of data
# into the wip_trend object.  
wip_trend <- trend_filenames %>% 
  map(read_csv) %>% 
  map(trend_prep) %>% 
  bind_rows()

wip_trend <- wip_trend %>% separate(monthorweek, c('week_of', 'week_end'), 
  sep = 11, convert = TRUE) %>% 
  select(- 'week_end')

# following code convert the week_of col from character to date class
wip_trend$week_of <- ymd(wip_trend$week_of)


# following code brings together and preps institute and trend data ----

# following code joins the 2 separate data sets into a single df
wip_institute_data <- full_join(base_institute_data, wip_trend, 'schname')

# following coverts character columns to appropriate class
wip_institute_data$gt_25k_p6 <- as.numeric(wip_institute_data$gt_25k_p6) #float

wip_institute_data <- wip_institute_data %>% class_conversion("NPT", as.numeric) %>% 
  class_conversion("PCIP", as.numeric) %>% 
  #integer or float 
  class_conversion("md_", as.numeric) #integer or float 
  
wip_institute_data <- wip_institute_data %>% class_conversion(c('HBCU', 'PBI', 'ANNHI',
      'TRIBAL', 'AANAPII', 'HSI', 'NANTI', 'MENONLY', 'WOMENONLY'), as.factor)

write_csv(wip_institute_data, path = '02_derived_data/wip_institute_data.csv')

vt(wip_institute_data)


# following code # following code preps the data for analysis.  This includes standardizing the 
# variables/coefficients ----

# Standardizing the coefficients: 
# mean and sd of earning
mean_earning_sd <- pull(wip_institute_data[,121]) %>% na.omit() %>% sd()
mean_earning <- pull(wip_institute_data[,121]) %>% na.omit() %>% mean()

# mean and sd of trend index scores
index_sd <- pull(wip_institute_data[,124]) %>% na.omit %>% sd()
index_mean <- pull(wip_institute_data[,124]) %>% na.omit %>% mean()

# groups by school name to then adds a variable 'av_index' for the school over time 
wip_institute_data <- wip_institute_data %>% group_by(schname) %>% 
  mutate(av_index = mean(index))








