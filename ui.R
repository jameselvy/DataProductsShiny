
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Decomposition of trimodal distributions"),
  tabsetPanel(
    tabPanel("Plot",
  fluidRow(
    column(4,
           h4("Component 1 (red)"),
           wellPanel(
             sliderInput("size.a", "size", min = 200, max = 5000, value = 500, ticks = FALSE),
             sliderInput("mean.a", "mean", min = 0, max = 100, value = 2, ticks = FALSE),
             sliderInput("sd.a", "standard deviation", min = 1, max = 10, value = 2, ticks = FALSE)#,
#             submitButton(text = "Update Model", icon = NULL, width = NULL)
           )),
    column(4,
           h4("Component 2 (blue)"),
           wellPanel(
             sliderInput("size.b", "size", min = 200, max = 5000, value = 400, ticks = FALSE),
             sliderInput("mean.b", "mean", min = 0, max = 100, value = 3, ticks = FALSE),
             sliderInput("sd.b", "standard deviation", min = 1, max = 10, value = 2, ticks = FALSE)#,
#             submitButton(text = "Update Model", icon = NULL, width = NULL)
           )),
    column(4,
           h4("Component 3 (green)"),
           wellPanel(
             sliderInput("size.c", "size", min = 200, max = 5000, value = 100, ticks = FALSE),
             sliderInput("mean.c", "mean", min = 0, max = 100, value = 8, ticks = FALSE),
             sliderInput("sd.c", "standard deviation", min = 1, max = 10, value = 4, ticks = FALSE)#,
#             submitButton(text = "Update Model", icon = NULL, width = NULL)
           ))),
  fluidRow(column(4, offset = 0, submitButton(text = "Click to regenerate model", icon = NULL, width = NULL))),
  fluidRow(column(12, plotOutput("distPlot", height = "400px")   #,
#  fluidRow(column(4, offset = 0, submitButton(text = "Submit Changes", icon = NULL, width = NULL)))
))),
tabPanel("Summary", fluidRow(column(12, 
                                    h4("Trimodal distribution"), 
                                    p("The trimodal distribution incoporates the following three user defined normal distributions"),
                                    br(),
                                    tableOutput("table"),
                                    tags$hr(),
                                    h4("Decomposition of trimodal distribution"),
                                    p("The following table shows estimated parameters of each of the three user chosen 'component' distributions usimg the mixtools package. This package assumes of each the three component distributions are normal distributions"),
                                    tableOutput("Mixtable"),
                                    tags$hr()  #,
#                                    h4("Statistical test for multimodal distributions"),
#                                    verbatimTextOutput('dip')
                                    ))),
tabPanel("Instructions", fluidRow(column(12, 
                                         h3("Overview"),
                                         p("The application shows how the normalmixEM function in the mixtoolsols package can be used to decompose distributions with greater than one distribution. This example app demonstrates the decomposition of a user defined trimodal distribution"),
                                         br(),
                                         h3("Instructions"),
                                         p("On the calculation tab, Choose the parameters for three component distributions. The parameters to choose are: a) number of data points; b) mean value; c) and standard deviation."),
                                         p("Once you have done this for all three component distributions, click on the GENERATE button at the bottom of the calculation page"),
                                         p("The user defined trimodal distribution histogram will be updated with the user defined values. Also, the individual components distribution are shown as density plots in red, blue and green."),
                                         p("In addition, when the GENERATE button is clcked, the user defined trimodal distribution is feed into the normalmixEM function of the mixtools package. The function iterates through possible trimodal solutions and converges on the best fit"),
                                         p("The best fit mixtools model is plotted showing the three best-fit normal componets determined by the function"),
                                         br(),
                                         h3("Data Summaries"),
                                         p("A table of the user defined component parameters and parameters determined by the mixmode model are presented on the summary tab page"),
                                         br(),
                                         h3("Source Code"),
                                         p("You can find the source code for ui.r and server.r here:"),
                                         helpText(   a("https://github.com/jameselvy/DataProductsShiny",     href="https://github.com/jameselvy/DataProductsShiny")),
                                         p("A table of the user defined component parameters and parameters determined by the mixmode model are presented on the summary tab page"),
                                         br(),
                                         h3("Slidify Presentation"),
                                         p("You can find the Slidify Presentation here:"),
                                         helpText(   a("https://jameselvy.github.com/DataProductsSlidify",     href="https://jameselvy.github.com/DataProductsSlidify"))
                                         )))

)))
