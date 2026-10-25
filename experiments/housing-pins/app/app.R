# Runnable Shiny shell. We will add controls and data logic together later.
# From the ds_lab root:
# shiny::runApp("experiments/housing-pins/app")

library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Northeast Ohio Home Value Explorer"),
  p("Compare home-value trends in familiar communities."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "communities",
        label = "Compare communities",
        choices = NULL,
        multiple = TRUE
      ),
      selectInput(
        inputId = "start_year",
        label = "Starting year",
        choices = NULL
      ),
      radioButtons(
        inputId = "view",
        label = "Show",
        choices = c(
          "Home value ($)" = "dollars",
          "Growth since baseline (%)" = "growth"
        ),
        selected = "dollars"
      )
    ),
    mainPanel(
      h3("Compare local housing trends"),
      textOutput("data_status"),
      plotOutput("value_plot"),
      tags$small(
        "Source: Zillow Home Value Index (ZHVI), ",
        tags$a(
          "Zillow Research",
          href = "https://www.zillow.com/research/data/"
        ),
        ". These are estimated typical home values, not individual sale prices."
      )
    )
  )
)

server <- function(input, output, session) {
  # Putting the pin read inside server() means each new visitor session reads
  # the published snapshot.
  web_board <- pins::board_url(
    "https://mpfoley73.github.io/ds_lab/experiments/housing-pins/board/"
  )
  housing <- pins::pin_read(web_board, "home-values")

  updateSelectInput(
    session,
    inputId = "communities",
    choices = sort(unique(housing$community)),
    selected = c("Cleveland", "Lakewood", "Shaker Heights")
  )

  updateSelectInput(
    session,
    inputId = "start_year",
    choices = sort(unique(format(housing$date, "%Y"))),
    selected = "2015"
  )

  output$data_status <- renderText({
    paste(
      "Loaded",
      nrow(housing),
      "observations; data through",
      max(housing$date)
    )
  })

  output$value_plot <- renderPlot({
    validate(
      need(length(input$communities) > 0, "Select at least one community."),
      need(length(input$communities) <= 4, "Select up to four communities.")
    )

    # req() pauses plotting until the year control has a value
    req(input$start_year)
    start_date <- as.Date(paste0(input$start_year, "-01-01"))

    selected_data <- housing |>
      filter(community %in% input$communities, date >= start_date)

    plot_data <- selected_data
    y_label <- "Typical home value ($)"
    subtitle <- NULL

    if (input$view == "growth") {
      # Baseline date is when all selected communities have nonmissing values.
      common_dates <- selected_data |>
        filter(!is.na(value)) |>
        count(date) |>
        filter(n == length(input$communities))
      validate(
        need(nrow(common_dates) > 0, "No shared month with available values.")
      )
      baseline_date <- min(common_dates$date)

      y_label <- "Change since baseline (%)"
      subtitle <- paste("Baseline month:", baseline_date)
      plot_data <- selected_data |>
        filter(date >= baseline_date) |>
        arrange(community, date) |>
        mutate(.by = community, value = (value / first(value) - 1) * 100)
    }

    ggplot(plot_data, aes(date, value, color = community)) +
      geom_line() +
      labs(x = NULL, y = y_label, color = NULL, subtitle = subtitle) +
      theme_minimal()
  })
}

shinyApp(ui, server)
