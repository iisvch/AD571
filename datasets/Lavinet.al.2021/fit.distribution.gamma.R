
data = final_survey; boot = 999; range = seq(25,80, by = 0.1)

fit.distribution.gamma = function(data, boot, range) {
  set.seed(123)
  density_function = "gamma"
  #Fit distribution
  #Calculate parameters by MLE
  fit.dist <- suppressWarnings(fitdistr(data, densfun= density_function, lower = c(0,0)))

  #plot1 = qqPlot(data, distribution= density_function, shape=fit.dist$estimate[[1]], rate=fit.dist$estimate[[2]], las=1, pch=19)
  dat.dgamma <- dgamma(range, shape=as.numeric(fit.dist[[1]][1]), rate=as.numeric(fit.dist[[1]][2]))
  
  rw.small <- rgamma(data, shape = fit.dist$estimate[[1]], rate = fit.dist$estimate[[2]])

  #Bootstrap the pointwise confidence intervals
  boot.pdf <- matrix(nrow = length(range), ncol = boot)

  for(i in 1:boot){
    xi <- sample(rw.small, size=length(rw.small), replace=TRUE)
    MLE.est <- suppressWarnings(fitdistr(xi, densfun= density_function))  
    boot.pdf[,i] <- dgamma(range, shape=as.numeric(MLE.est[[1]][1]), rate=as.numeric(MLE.est[[1]][2]))
  }
  
  #Plot the data
  plot.dat = as_tibble(boot.pdf) %>% mutate(range = range) %>% gather(key = key, value = value, -range)
  
  quants <- as.data.frame(apply(boot.pdf, 1, quantile, c(0.025, 0.5, 0.975))) %>%  rownames_to_column(var = "quantile") %>% 
    gather(key = key, value = value, -quantile) %>%
    mutate(key = as.numeric(gsub("V", "", as.character(key)))) %>%
    spread(key = quantile, value = value) %>%
    mutate(range = range) %>%
    left_join(data.frame(distribution = dat.dgamma, range = range), by = "range") %>%
    gather(key = quantile, value = value, -key, -range) 
  
  #plot2 = ggplot() +
  #  geom_line(data= plot.dat, aes(y = value, x = range, group = key), col = "grey", alpha = .1, lty = "solid") +
  #  geom_line(data= quants, aes(y = value, x = range, linetype = quantile), col = "red") +
  #  scale_linetype_manual(values=c("dashed", "solid", "dashed"))
  
  myplot.1 = ggplot(quants %>% spread(key = quantile, value = value), 
                    aes(y = `50%`, x = range)) +
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = "grey") +
    geom_line(col = "black") +
    geom_line(data = quants %>% spread(key = quantile, value = value), 
              aes(y = distribution, x = range), col = "red", lty = "dashed") +
    scale_y_continuous(expand = c(0,0)) +
    scale_x_continuous(breaks = seq(0,80,10), limits = c(min(range),max(range)), expand = c(0,0)) +
    labs(y=expression(Probability~density %+-% `95%CI`), x="Total length (cm)") + 
    theme_classic() + theme(plot.margin = unit(c(1,1,1,2), "lines"))
  
  myplot.2 = ggplot(quants %>% spread(key = quantile, value = value), 
                    aes(y = `50%`, x = range)) +
    geom_histogram(data = data.frame(x = data), aes(x = x, y=..density..), 
                   binwidth=5, boundary=5, colour="grey40", fill="white") + 
    geom_ribbon(aes(ymin = `2.5%`, ymax = `97.5%`), fill = "grey", alpha = .5) +
    geom_line(col = "black") +
    scale_y_continuous(expand = c(0,0)) +
    scale_x_continuous(breaks = seq(0,80,10), limits = c(min(range),max(range)), expand = c(0,0)) +
    labs(y=expression(Probability~density %+-% `95%CI`), x="Total length (cm)") + 
    theme_classic() + theme(plot.margin = unit(c(1,1,1,2), "lines"))
  
  
  my.distribution = list(quants, myplot.1, myplot.2, fit.dist)
  return(my.distribution)
  
}

