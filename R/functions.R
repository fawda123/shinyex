# plotting function
plotcatch <- function(name, szrng, gearsel, datin){
  
  subdat <- datin %>% 
    filter(Commonname %in% name) %>% 
    filter(avg_size > szrng[1] & avg_size < szrng[2]) %>% 
    filter(Gear %in% gearsel) %>% 
    mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))
  
  p <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
    geom_point() + 
    scale_y_log10() + 
    geom_smooth(method = 'lm') + 
    labs(
      x = NULL,
      y = 'Total catch', 
      title = paste0(name, " catch in gear ", gearsel), 
      subtitle = paste0("Data subset to average size between ", szrng[1], '-', szrng[2], " mm")
    )
  
  p 
  
}
