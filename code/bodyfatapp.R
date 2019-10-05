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
                        "Please input your abdomen:",
                        value = 90, step = 0.1),
            numericInput("WEIGHT", "Please input your height:", value = 170,
                     step = 0.25),
            numericInput("WRIST","Please input your wrist:",value = 18,
                         step = 0.1)
        ),


        mainPanel(
           textOutput("BodyFat")
        )
    )
)





server <- function(input, output) {

    # ABDOMEN = reactive({return(input$ABDOMEN)})
    # WEIGHT = reactive({return(input$WEIGHT)})
    # WRIST = reactive({return(input$WRIST)})
    # BodyFat = -24.97026+0.88700*ABDOMEN()-0.08541*WEIGHT()-1.25212*WRIST()
    # output$BodyFat <- renderText({
    #     return(as.character(round(BodyFat,2)))
    # })
    
    BodyFat = reactive({
        BodyFat = -24.97026+0.88700*input$ABDOMEN-0.08541*input$WEIGHT-1.25212*input$WRIST
        return(BodyFat)
    })
    
    output$BodyFat <- renderText({
        paste("Your body fat is ",round(BodyFat(),2),".",sep="")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)



