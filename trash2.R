library(shiny)

ui <-
fluidRow(
  
  
 selectizeInput(
    inputId = "searchme",
    label = "Search Bar",
    multiple = FALSE,
    choices = c("Search Bar" = "", paste0(LETTERS,sample(LETTERS, 26))),
    options = list(
      create = FALSE,
      placeholder = "Search Me",
      maxItems = "1",
      onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
      onType = I("function (str) {if (str === '') {this.close();}}")
    )
  ))


server <- function(input, output) {

observe({
  print(input$searchme)
})

}

shinyApp(ui, server)










if (interactive()) {
  ui <- fluidPage(
    tags$h1("Search Input"),
    br(),
    searchInput(
      inputId = "search", label = "Enter your text",
      placeholder = "A placeholder",
      btnSearch = icon("search"),
      btnReset = icon("remove"),
      width = "450px"
    ),
    br(),
    verbatimTextOutput(outputId = "res")
  )
  
  server <- function(input, output, session) {
    output$res <- renderPrint({
      input$search
    })
  }
  
  shinyApp(ui = ui, server = server)
}