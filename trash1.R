library(shiny)
library(tidyverse)


zones <- read_csv('Zones.csv')

liste <- zones %>% 
          mutate(Zone = paste(Type_zone, Libelle_zone, sep = " - ")) %>%
          select(Type_zone, Zone)


ui <- fluidPage(
  title = "Search Bar",
  fluidRow(
    tags$style(HTML("    
.selectize-input.items.not-full.has-options:before {
 content: '\\e003';
 font-family: \"Glyphicons Halflings\";
 line-height: 2;
 display: block;
 position: absolute;
 top: 0;
 left: 0;
 padding: 0 4px;
 font-weight:900;
 }
  
  .selectize-input.items.not-full.has-options {
    padding-left: 24px;
  }
 
 .selectize-input.items.not-full.has-options.has-items {
    padding-left: 0px;
 }
 
  .selectize-input.items.not-full.has-options .item:first-child {
      margin-left: 20px;
 }
 
")),
    selectizeInput(
      inputId = "searchme", 
      label = "Search Bar",
      multiple = T,
      choices = c("Search Bar" = "", paste0(LETTERS,sample(LETTERS, 26))),
      options = list(
        create = FALSE,
        placeholder = "Search Me",
        onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
        onType = I("function (str) {if (str === \"\") {this.close();}}"),
        onItemAdd = I("function() {this.close();}")
      )
    ))
)

server <- function(input, output, session) {
  
  # Show Selected Value in Console
  observe({
    print(input$searchme)
  })
  
}

shinyApp(ui, server)