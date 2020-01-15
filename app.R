#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(rsconnect)
library(shiny)
library(ggplot2)
# rsconnect::deployApp('C:/Users/usewr/Documents/RProject/Plotbox/Plotboxapp')

# Load in the diamond.csv data
dm = read.csv("diamond.csv",header = TRUE)
#View(dm)

# Define UI for application that plot scatter plot or boxplot
ui <- fluidPage(
    
    # Application title
    titlePanel("PLOTBOX"),
    
    # Sidebar with a select input and text input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "y",label = "Y-Axis",names(dm)),
            selectInput(inputId = "x",label = "X-Axis",names(dm)),
            #selectInput(inputId = "x",label = "X-Axis",names(dm)[2:4]),
            selectInput("col","Select Point colour (or Boxplot outside Line Color)",choices=c("red","yellow","green","black","purple","orange","magenta","violet","white","pink")),
            selectInput("colfill","Select Box Fill Colour (Not needed for Scatter Plot)",choices=c("red","yellow","green","black","purple","orange","magenta","violet","white","pink")),
            textInput(inputId = "title",label = "Enter Plot Title"),
            textInput(inputId = "xlab",label = "Enter X-Label"),
            textInput(inputId = "ylab",label = "Enter Y-Label"),
            selectInput("plottype","Select Plot Type",choices =c("Scatter","Boxplot"))
            
        ),
        
        # Show the plot selected by the user
        mainPanel(
            # creating ID for the output
            plotOutput("boxPlot"),
            plotOutput("scatterplot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    # Building output object
    output$boxPlot <- renderPlot(
        if (input$plottype=="Boxplot")
        {ggplot(dm, aes_string(input$x,input$y))+geom_boxplot(colour=input$col, fill=input$colfill)+ggtitle(input$title)+xlab(input$xlab)+ylab(input$ylab)
        }
        else{ggplot(dm, aes_string(input$x,input$y))+geom_point(colour=input$col, fill=input$colfill)+ggtitle(input$title)+xlab(input$xlab)+ylab(input$ylab)
            
        }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
