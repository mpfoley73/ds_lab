# Runnable Shiny shell. We will add controls and data logic together later.
# From the ds_lab root:
# shiny::runApp("experiments/housing-pins/app")

library(shiny)

ui <- fluidPage(
  titlePanel("Northeast Ohio Home Value Explorer"),
  p("Compare home-value trends in familiar communities."),
  sidebarLayout(
    sidebarPanel(
      h4("Our next Shiny step"),
      p("Add community, starting-year, and chart-view controls.")
    ),
    mainPanel(
      h3("The data comes first"),
      p("This learning scaffold is not connected to a pin yet."),
      p("We will first prepare a small dataset and verify its local pin."),
      tags$small(
        "Planned source: Zillow Home Value Index (ZHVI), ",
        tags$a("Zillow Research", href = "https://www.zillow.com/research/data/"),
        ". These are estimated typical home values, not individual sale prices."
      )
    )
  )
)

server <- function(input, output, session) {
  # Later: create board_url() and pin_read() HERE, once per visitor session.
  # Keep the pin read outside reactive chart calculations.
  # Add selection validation, a common baseline, and renderPlot() in small steps.
}

shinyApp(ui, server)
