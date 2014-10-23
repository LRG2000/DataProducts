library(shiny); library(quantmod); library(datasets); library(HistData)
data(airquality); data(swiss); data(iris); library(ggplot2)
source("helpers.R")
## server for Developing Data Products Peer-reviewed project

shinyServer(function(input, output){
      
      fulldata <- reactive({
        switch(input$dataset,
                      "airquality" = airquality[complete.cases(airquality),],                    
                      "Swiss" = swiss[complete.cases(swiss),], 
               "iris" = iris[complete.cases(iris),])
      })
      
      explPage <- reactive({
        switch(input$dataset,
               "airquality" = "http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/airquality.html",
               "Swiss" = "http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/swiss.html",
               "iris" = "http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/iris.html")})
      getPage <- function(){return(includeHTML(explPage()))} 
      output$val <- renderUI({getPage()})
      
      output$yparams <- renderUI({
        selectInput("yparam", "plot...", names(fulldata()))
      })
      output$xparams <- renderUI({
        selectInput("xparam", "vs...", names(fulldata()))
         })
     xcol <- reactive({fulldata()[,which(names(fulldata()) == input$xparam)]})
     ycol <- reactive({fulldata()[, which(names(fulldata()) == input$yparam)]})
     xname <- reactive({input$xparam})
     yname <- reactive({input$yparam})
 
 output$myPlot <- renderPlot({
   
   

   if (input$line) {fit <- lm(ycol() ~ xcol())
                    m <- strtrim(as.character(coef(fit)[2]),5)
                    b <- strtrim(as.character(abs(coef(fit)[1])),5)
                    sign <- ifelse(coef(fit)[1] >= 0," + ", " - ")
                    tnm <- paste0("y = ",m,"x",sign,b)
                    plot(xcol(), ycol(), pch = 19, xlab = xname(), ylab = yname(), main = tnm)   
                    abline(fit[1], fit[2], col= "red") } else {
                      plot(xcol(), ycol(), pch = 19, xlab = xname(), ylab = yname())   
                    }
   
 })
 
   cols <- reactive({getcols(fulldata())})
    output$corrMatrix <- renderTable({
     cor(fulldata()[,cols()$nonfactors], use="na.or.complete") })

       output$factors <- renderText({cols()$factors}) 
 
})