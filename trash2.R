library(shiny)
# library(shinythemes)

css <- ".shiny-input-container > label {margin-bottom: -15px;}"

ui <- fluidPage(
  # theme = shinytheme("sandstone"),
  tags$head(
    tags$style(HTML(css))
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "select1", 
        label = h5("Selection 1"),
        choices = c("a", "b", "c"), 
        selectize = TRUE
      ),
      
      div(style = "margin-top:-15px"),
      
      selectInput(
        "select2", 
        label = h5("Selection 2"),
        choices = c("a", "b", "c"), 
        selectize = TRUE
      )
    ),
    mainPanel(
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)