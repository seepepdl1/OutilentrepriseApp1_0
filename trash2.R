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











