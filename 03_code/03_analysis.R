# initial visualizations and descriptive
st(wip_institute_data)

ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_boxplot() + 
  xlab('Reported Earnings Standard Deviations') +
  geom_vline(xintercept = 1)

ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_density(fill = 'blue', alpha = .5) + 
  xlab('Reported Earnings Standard Deviations') +
  geom_vline(xintercept = 1)


base_pre_2015_earning_index %>% filter(sd_earnings > .786) %>% 
ggplot(aes(x = sd_earnings, y = monthly_std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('High Earning Institiutes Monthly Std Index, Prior to 2015')

base_pre_2015_earning_index %>% filter(sd_earnings < -.159) %>% 
  ggplot(aes(x = sd_earnings, y = monthly_std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('Low Earning Institiutes Monthly Std Index, Prior to 2015') 

pre_2015_high <- base_pre_2015_earning_index %>% filter(sd_earnings > .786)
pre_2015_high_lm <- lm(monthly_std_inst_index ~ sd_earnings + month, data= pre_2015_high)
pre_2015_low <- base_pre_2015_earning_index %>% filter(sd_earnings < -0.159)
pre_2015_low_lm <- lm(monthly_std_inst_index ~ sd_earnings + month, data= pre_2015_low)
export_summs(pre_2015_high_lm, pre_2015_low_lm)

effect_plot(pre_2015_low_lm, sd_earnings, plot.points = FALSE)

#######
ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_boxplot() + 
  xlab('Reported Earnings Standard Deviations') 

ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_density(fill = 'blue', alpha = .5) + 
  xlab('Reported Earnings Standard Deviations')

 
ggplot(pre_2015_high, aes(x = sd_earnings, y = std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('High Earning Institiutes Monthly Std Index, Prior to 2015')

base_pre_2015_earning_index %>% filter(sd_earnings < -.159) %>% 
  ggplot(aes(x = sd_earnings, y = monthly_std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('Low Earning Institiutes Monthly Std Index, Prior to 2015') 

pre_2015_high <- base_pre_2015_earning_index %>% filter(sd_earnings > .786)
pre_2015_high_lm <- lm(std_inst_index ~ sd_earnings + month, data= pre_2015_high)
export_summs(pre_2015_high_lm)

pre_2015_low <- base_pre_2015_earning_index %>% filter(sd_earnings < -0.159)
pre_2015_low_lm <- lm(monthly_std_inst_index ~ sd_earnings + month, data= pre_2015_low)
export_summs(pre_2015_high_lm, pre_2015_low_lm)

effect_plot(pre_2015_low_lm, sd_earnings, plot.points = FALSE)

####

ggplot(post_2015_high, aes(x = sd_earnings, y = monthly_std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('High Earning Institiutes Monthly Std Index, After 2015')

base_post_2015_earnings_index %>% filter(sd_earnings < -.159) %>% 
  ggplot(aes(x = sd_earnings, y = monthly_std_inst_index)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('Low Earning Institiutes Monthly Std Index, After 2015')

post_2015_high <- base_pre_2015_earning_index %>% filter(sd_earnings > .786)
post_2015_high_lm <- lm(std_inst_index ~ sd_earnings + month, data= pre_2015_high)
export_summs(pre_2015_high_lm, post_2015_high_lm)