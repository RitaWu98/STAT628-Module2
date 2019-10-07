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
                        value = 90, step = 0.1,min=0),
            numericInput("WEIGHT", "Please input your weight(lbs):", value = 170,
                     step = 0.25,min=0),
            helpText("Note: Our result is based on the data of males from age 22-81.
                     If you are female and the age is out of the range, 
                     the result might not be accurate"),
            actionButton("calculate", "Let's calculate!"),
            actionButton("mail","Any problem? Contact us!")
        ),


        mainPanel(
           h4("Your body fat is:"),
           textOutput("BodyFat"),
           textOutput("email")
        )
    )
)



server <- function(input, output) {

    BodyFat = eventReactive(input$calculate,{
        BodyFat = -42.95790+0.90152*input$ABDOMEN-0.11994*input$WEIGHT
        return(BodyFat)
    })
    
    output$BodyFat <- renderText({
        if( BodyFat()>0 & BodyFat()<100){
            paste(round(BodyFat(),2),"%",sep="")
        }else{
            paste("Ops! There might be something wrong with your data. Please try again.")
        }
    })
    
    contact = eventReactive(input$mail,{
        return (1)
    })
    
    output$email <- renderText({
        if (contact()==1){
            paste("Please email your problem to our email address: hpan55@wisc.edu")
        }
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)



