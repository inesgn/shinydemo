library(shiny)
library(ggplot2)

data <- get(load('data.Rda'))
varEsp <- names(data)[3:18]

shinyServer(function(input, output) {
        
        #creates reactive formula for the input variable
        reactiveFormula <- reactive({
                formula <- as.formula(paste0("weigths ~ LFS +", input$x))
        })
        
        #renders table for the reactive formula
        output$table1 <- renderTable({
                formula <- reactiveFormula()
                if( input$val == "absolute" ){
                        addmargins(xtabs(formula, data = data))                        
                }
                else if ( input$val == "row-percents" ){
                        prop.table(xtabs(formula, data = data),1)*100                      
                }
                else if ( input$val == "column-percents" ){
                        prop.table(xtabs(formula, data = data),2)*100                      
                }
        })
        
        #the table is transformed to data frame and a plot is rendered
        output$plot1 <- renderPlot({
                df <- as.data.frame(prop.table(xtabs(reactiveFormula(), data = data),1))
                names(df) <- c("LFS","Freq","Var")               
                  p <- ggplot(df, aes(x=LFS, y=Freq)) + geom_point(aes(size=Var), shape=21, colour="black", fill="cornsilk")+
                        scale_size(range=c(0,60), guide=FALSE) +
                        geom_text(aes(y=as.numeric(Freq)-sqrt(Var)/30, label=round(Var*100,0)), vjust=1, colour="grey60", size=4)                
                print(p)
        })
})