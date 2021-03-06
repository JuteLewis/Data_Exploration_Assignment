
# following function will take in a df then select the 'schname', 'monthorweek', 
# and 'index' numbers from the raw csv files and returning a tribble under the 
# wip_trend object ----

trend_prep <- function(df) {
  'schname' = select(df, schname)
  'week_of' = select(df, monthorweek)
  'index' = select(df, index)
  return(tibble(schname, week_of, index))
}
# a compact version 
trend_prep <- function(df) {
  'schname' = select(df, schname, monthorweek, index)
  return(tibble(schname))
}

# following function is for automating class conversion within data ----

class_conversion <- function(df, x, y){
  'str_prefix' = x
  'new_class' = y
  df %>% mutate(across(starts_with(str_prefix), new_class))
}