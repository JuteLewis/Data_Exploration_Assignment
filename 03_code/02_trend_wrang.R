# following code will list the csv file names in to a variable. 
trend_filenames <- list.files('01_raw_data', 'trend', full.name = TRUE)

# following function will take in a df then select the 'schname', 'monthorweek', 
# and 'index' numbers from the raw csv files and returning a tribble. 
trend_prep <- function(df) {
  'schname' = select(df, schname, monthorweek, index)
  return(tibble(schname))
}

# following code iterates over the filenames, reading the cvs, feeding them
# through the trend_prep function which will binding together the rows
# in the wip_trend object.  
wip_trend <- trend_filenames %>% 
  map(read_csv) %>% 
  map(trend_prep) %>% 
  bind_rows()

wip_trend <- wip_trend %>% separate(monthorweek, c('week_of', 'week_end'), 
  sep = 11, convert = TRUE) %>% 
  select(- 'week_end')













