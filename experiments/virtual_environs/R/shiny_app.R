# R/shiny_app.R
# Simple Shiny app for deployment demonstration

library(shiny)
library(ggplot2)

# UI
ui <- fluidPage(
    titlePanel("Virtual Environment Demo App"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "n",
                "Number of points:",
                min = 10,
                max = 1000,
                value = 100
            ),
            selectInput("color", "Color:", choices = c("blue", "red", "green"))
        ),
        mainPanel(
            plotOutput("plot")
        )
    )
)

# Server
server <- function(input, output) {
    output$plot <- renderPlot({
        set.seed(123)
        df <- data.frame(
            x = rnorm(input$n),
            y = rnorm(input$n)
        )
        ggplot(df, aes(x = x, y = y)) +
            geom_point(color = input$color) +
            labs(title = paste("Random Points:", input$n), x = "X", y = "Y") +
            theme_minimal()
    })
}

# Run the app
shinyApp(ui = ui, server = server)
