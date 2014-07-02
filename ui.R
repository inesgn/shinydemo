library(shiny)
library(ggplot2)

data <- get(load('data.Rda'))
varEsp <- names(data)[3:18]

shinyUI(fluidPage(
        sidebarLayout(position = "right",
                        sidebarPanel( "Choose living condition variable",
                                selectInput('x', '', names(data[,varEsp])),
                                selectInput(inputId='val',label='Table values: ',choices = c("absolute", "row-percents", "column-percents"))
                        ),
                        mainPanel(
                                h2("Living Conditions by Labour Force Segment Explorator"),  
                                plotOutput('plot1'),
                                tableOutput('table1'),
                                h3("Explanation"),  
                                p("This app has been designed to explore a bunch of questionnaire items collected by means of the 'Living Conditions Survey' for the population in the Basque Country during the last quarter of 2009."),
                                p("Living condition items are explored as a function of the labour market segmentation, according to which people are classified as:"),
                                p("-- Occupied"),
                                p("-- Umployed, of which thre are two sub-types: strictly unemployed, and unemployed who whish to have a job but are occupied in unpaid works"), 
                                p("-- Inactive, those doing unpaid work such as studying or housekeeping, and"),
                                p("-- Retired."),
                                p("By using the drop down menu, you should choose one living condition item -such as the one you'll see first: having health problems 'yes' or 'no'- to check if interesting patterns emerge."),
                                p("Numbers inside balloons add up to 100 in each labour force segment."),
                                p("You can check numbers in the table below choosing the type of cell values: absolute values, row percents or column percents.")
                        )
        )
))
