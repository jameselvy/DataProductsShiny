
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    library(mixtools)    # install.packages("mixtools")
    
    # http://stackoverflow.com/questions/25313578/any-suggestions-for-how-i-can-plot-mixem-type-data-using-ggplot2
    proportions <- c(input$size.a, input$size.b, input$size.c)
    means <- c(input$mean.a, input$mean.b, input$mean.c)
    sds <- c(input$sd.a, input$sd.b, input$sd.c)
    
    a <- data.frame(matrix(rnorm(100000, mean=means[1], sd=sds[1]))); samp.a <- a[sample(nrow(a), proportions[1]), ]; den.a <- density(samp.a)
    b <- data.frame(matrix(rnorm(100000, mean=means[2], sd=sds[2]))); samp.b <- b[sample(nrow(b), proportions[2]), ]; den.b <- density(samp.b)
    c <- data.frame(matrix(rnorm(100000, mean=means[3], sd=sds[3]))); samp.c <- c[sample(nrow(c), proportions[3]), ]; den.c <- density(samp.c)
    
    ### build up mix sample
    mix <- c(samp.a, samp.b, samp.c)
    
    ### Build up mix model
    mixModel <- normalmixEM(mix, lambda=NULL, mu=NULL, sigma=NULL, k=3)   # k=3 as we expect three populations are sampled  
  
    ### plots
    par(mfrow=c(1,2))                    # 1 figures arranged in 2 rows and 1 column
    hist(mix, freq = F, main = "User defined trimodal distribution", xlab = "Data")          # 'mixed' distribution
    lines(den.a$x, den.a$y * (proportions[1] / sum(proportions)), col = "blue", lwd = 2)
    lines(den.b$x, den.b$y * (proportions[2] / sum(proportions)), col = "red", lwd = 2)
    lines(den.c$x, den.c$y * (proportions[3] / sum(proportions)), col = "green", lwd = 2)
    plot(mixModel, which = 2, main2 = "Decomposition of mix sample using 'mixtools'")      # mixtools decomposition
    summary(mixModel)
  
    # make dataframe of comparisons
    comparisonTable <- data.frame(proportions, round((proportions / sum(proportions)) * 100, 0), means, sds, row.names = c("Component1", "Component2", "Component3")) 
    names(comparisonTable) <- c("count", "percent of total count", "mean", "standard deviation")
    comparisonTable
    output$table <- renderTable(comparisonTable)
    
    # make dataframe of comparisons
    comparisonMixTable <- data.frame(round(mixModel$lambda * 100, 0), round(mixModel$mu, 2), round(mixModel$sigma, 2), row.names = c("MixComponent1", "MixComponent2", "MixComponent3")) 
    names(comparisonMixTable) <- c("Estimated count percent", "mean", "standard deviation")
    comparisonMixTable
    output$Mixtable <- renderTable(comparisonMixTable)
    
    # http://dsp.stackexchange.com/questions/26358/how-to-detect-whether-a-signal-is-unimodal-or-bimodal
    # library(diptest)   # install.packages("diptest")
    # output$dip <- dip.test(mix)
  })
})
