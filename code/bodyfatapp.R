#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Calculate your BodyFat!"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("ABDOMEN",
                        "Please input your abdomen(cm):",
                        value = 90, step = 0.1),
            numericInput("WEIGHT", "Please input your weight(lbs):", value = 170,
                     step = 0.25)
        ),


        mainPanel(
           textOutput("BodyFat")
        )
    )
)



server <- function(input, output) {

    BodyFat = reactive({
        BodyFat = -42.95790+0.90152*input$ABDOMEN-0.11994*input$WEIGHT
        return(BodyFat)
    })
    
    output$BodyFat <- renderText({
        if( BodyFat()>0){
            paste("Your body fat is ",round(BodyFat(),2),".",sep="")
        }else{
            print("Ops! There might be something wrong with your data. Please try again.")
        }
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)



