library(shiny); library(quantmod)
## ui for Developing Data Products Peer-reviewed project
shinyUI(navbarPage(
      titlePanel("Welcome to my awesome Shiny app!"),
      sidebarLayout(
            sidebarPanel(
                  selectInput("dataset", "Choose a dataset", choices = 
                        c("airquality", "Swiss", "iris")),
            
            uiOutput("yparams"),
            uiOutput("xparams"),
            checkboxInput("line", label = "Add trendline")

      ),        
     mainPanel(
           tabsetPanel(type = "tabs",
                tabPanel("Explanation", htmlOutput("val")),
                tabPanel("Correlation Matrix", tableOutput("corrMatrix"), 
                         p("factor variables: "),verbatimTextOutput("factors")),  
                tabPanel("Plot", plotOutput("myPlot")),
                navbarMenu("Help",
                           tabPanel("About the app",
                                    h3("About this app"), 
                                    p("This app allows users to choose from one of two
                                      data sets (airquality, iris, or Swiss), 
                                      see the correlations
                                      between parameters in those data sets, and plot
                                      parameters against other paramters, both with and
                                      without a trend line.")
                                    ),
                           tabPanel("The tabs",
                                    h3("Explanation"),
                                    p("Explains what that column names in the data frames mean."),
                                    br(),
                                    h3("Correlation matrix"),
                                    p("A correlation matrix of the chosen data set with NAs
                                      removed. Factor variables are not considered, and are
                                      listed separately under the correlation table."),
                                    h3("Plot"),
                                    p("Shows the graph of the selected parameters. This 
                                      should be pretty self-explanatory.")),
                           tabPanel("data sets",
                                    h3("Data sets"),
                                    p("This app allows users to examine either the Swiss 
                                      Fertility data set, iris dataset, or the airquality data set, both
                                      of which are built into R.")),
                           tabPanel("what to plot",
                                    h3("Plotting"),
                                    p("The user chooses a data set. The next two pull-down 
                                      menus automatically update with the columns in the
                                      chosen data set. The user chooses whether or not to 
                                      include a trendline. If included, the equation of the
                                      trendline will display as the title of the plot.")
                                    ))
      
         ))
      
      
      ))) 