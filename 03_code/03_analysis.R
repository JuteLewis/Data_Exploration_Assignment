# initial visualizations and descriptive
st(wip_institute_data)

ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_boxplot() + 
  xlab('Reported Earnings Standard Deviations')


ggplot(wip_institute_data, aes(x = sd_earnings)) + 
  geom_density(fill = 'blue', alpha = .5) + 
  xlab('Reported Earnings Standard Deviations') +
  geom_vline(xintercept = 1)

ggplot(pre_2015_hi, aes(x = sd_earnings, y = monthly_av_stdzed_index_score)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('High Earning Institiutes Monthly Std Index, Prior to 2015')

ggplot(pre_2015_low, aes(x = sd_earnings, y = monthly_av_stdzed_index_score)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('Low Earning Institiutes Monthly Std Index, Prior to 2015') 

st_pre_2015_hi_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + month, data = pre_2015_hi)
poly_pre_2015_hi_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + I(sd_earnings^2) + month, data = pre_2015_hi)
pre_2015_low_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + month, data = pre_2015_low)
export_summs(st_pre_2015_hi_lm, poly_pre_2015_hi_lm, pre_2015_low_lm, model.names = c('pre_2015_hi_lm', 'poly_pre_2015_hi_lm', 'pre_2015_low_lm'))
effect_plot(st_pre_2015_hi_lm, sd_earnings, plot.points = TRUE, x.label = 'Standardized Earnings', y.label =  'Monthly Standardized Index Scores', point.color = 'blue2', main.title = "Straight pre 2015 Model")
effect_plot(poly_pre_2015_hi_lm, sd_earnings, plot.points = TRUE, x.label = 'Standardized Earnings', y.label =  'Monthly Standardized Index Scores', point.color = 'blue2', main.title = "Polynomial pre 2015 Model")

ggplot(post_2015_hi, aes(x = sd_earnings, y = monthly_av_stdzed_index_score)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('High Earning Institiutes Monthly Std Index, Post 2015')
ggplot(post_2015_low, aes(x = sd_earnings, y =monthly_av_stdzed_index_score)) + 
  geom_point() +
  xlab('Standardized Earnings') +
  ylab('Monthly Standardized Index Score') +
  ggtitle('Low Earning Institiutes Monthly Std Index, Post 2015') 

poly_post_2015_hi_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + I(sd_earnings^2) +  month, data = post_2015_hi)
post_2015_low_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + month, data = post_2015_low)
export_summs(poly_post_2015_hi_lm, post_2015_low_lm, model.names = c('poly_post_2015_hi_lm', 'post_2015_low_lm'))
effect_plot(poly_post_2015_hi_lm, sd_earnings, plot.points = TRUE, x.label = 'Standardized Earnings', y.label =  'Monthly Standardized Index Scores', point.color = 'blue2', main.title = "Polynomial post 2015 Model")

poly_post_2015_hi_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + I(sd_earnings^2) +  month, data = post_2015_hi)
post_2015_low_lm <- lm(monthly_av_stdzed_index_score ~ sd_earnings + month, data = post_2015_low)
export_summs(poly_post_2015_hi_lm, post_2015_low_lm, model.names = c('poly_post_2015_hi_lm', 'post_2015_low_lm'))
effect_plot(poly_post_2015_hi_lm, sd_earnings, plot.points = TRUE, x.label = 'Standardized Earnings', y.label =  'Monthly Standardized Index Scores', point.color = 'blue2', main.title = "Polynomial post 2015 Model")