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
  bind_rows() %>% 
  na.omit()

# following code standardizes the index value for each school.

# mean and sd of trend index scores across all institutes; however, not required 
# because we are interested in the within variation of the changes in interest in 
# individual institutes.
index_sd <- wip_trend %>% pull(index) %>% na.omit %>% sd()
index_mean <- wip_trend %>% pull(index) %>% na.omit %>% mean()

# following code preps the trend data by first splitting the date 
# grouping data by schname, building average index, standard deviation variable and 
# standardized index variable per institute. It finally reordes the columns for 
# readability.

wip_trend<- wip_trend %>% mutate(week_start = as.Date(str_sub(monthorweek,1,10))) %>% 
  mutate(year = year(week_start), month = month(week_start)) %>% 
  select(-'monthorweek')

wip_trend <- wip_trend %>% group_by(schname) %>% 
  mutate(av_inst_index = mean(index), index_std_deviation = sd(index, na.rm = TRUE), 
         std_inst_index = (index - av_inst_index) / index_std_deviation) 

wip_trend <- wip_trend %>% group_by(schname, year, month) %>% 
  mutate(monthly_av_inst_index = mean(index), 
         monthly_std_inst_index = (monthly_av_inst_index - av_inst_index) / index_std_deviation)

wip_trend <- wip_trend[c(1,3,4,5,2,6,8,9,10,7)]

write_csv(wip_trend, path = '02_derived_data/wip_trend.csv')

# following code preps institute data ----
wip_institute_data <- base_institute_data

names(wip_institute_data)[121] <- 'md_earn_wne_p10'

# following coverts character columns to appropriate class
wip_institute_data$gt_25k_p6 <- as.numeric(wip_institute_data$gt_25k_p6) #float

wip_institute_data <- wip_institute_data %>% class_conversion("NPT", as.numeric) %>% 
  class_conversion("PCIP", as.numeric) %>% 
  #integer or float 
  class_conversion("md_", as.numeric) #integer or float 

wip_institute_data <- wip_institute_data %>% class_conversion(c('HBCU', 'PBI', 'ANNHI',
     'TRIBAL', 'AANAPII', 'HSI', 'NANTI', 'MENONLY', 'WOMENONLY'), as.factor)

# following code preps the data for analysis.  This includes standardizing the 
# variables/coefficients
earning_sd <- wip_institute_data %>% pull(md_earn_wne_p10) %>% na.omit() %>% sd()
mean_earning <- wip_institute_data %>% pull(md_earn_wne_p10) %>% na.omit() %>% mean()

wip_institute_data<- wip_institute_data %>% 
  mutate(sd_earnings = (md_earn_wne_p10 - mean_earning) / earning_sd)

write_csv(wip_institute_data, path = '02_derived_data/wip_institute_data.csv')

# following code joins the trend df with the institute data vi the base_name_id df ----

base_name_id <- read_csv('01_raw_data/id_name_link.csv')

wip_id_index <- base_name_id %>% left_join(wip_trend, 'schname') %>% 
  rename(OPEID = opeid)

wip_institute_data <- wip_institute_data %>% full_join(wip_id_index, 'OPEID')

wip_institute_data <- wip_institute_data %>% select(-'unitid', -'schname.y')


# following code filters high and low earning institutes ----

high_earning_index <- wip_institute_data %>% filter(sd_earnings > .786)
low_earning_index <- wip_institute_data %>% filter(sd_earnings < - 0.159)

base_earning_index <- high_earning_index %>% 
  bind_rows(low_earning_index)

base_pre_2015_earning_index <- base_earning_index %>% filter(year < 2015)
base_post_2015_earnings_index <- base_earning_index %>% filter(year > 2014)















