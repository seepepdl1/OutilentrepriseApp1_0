library(shiny)
library(tidyverse)

zones <- read_csv('zones.csv')

liste <- zones %>% 
           mutate(Zone = paste(Type_zone, Libelle_zone, sep = " - ")) %>%
           select(Type_zone, Zone)

ui <- fluidPage(title = "Search Bar",
                
        fluidRow(tags$style(HTML(".selectize-input.items.not-full.has-options:before {
                                    content: '\\e062';
                                    font-family: \"Glyphicons Halflings\";
                                    color: grey;
                                    line-height: 2;
                                    display: block;
                                    position: absolute;
                                    top: 0;
                                    left: 0;
                                    padding: 0 4px;
                                    font-weight:200;
                                  }
                                   
                                   .selectize-input.items.not-full.has-options {
                                     padding-left: 24px;
                                  }
                                  
                                  .selectize-input.items.not-full.has-options.has-items {
                                     padding-left: 0px;
                                  }
                                  
                                   .selectize-input.items.not-full.has-options .item:first-child {
                                       margin-left: 20px;
                                  }")),
                                 
          selectizeInput(inputId = "searchZone", 
                         label = NULL,
                         multiple = T,
                         choices = list(`Placeholder` = "",
                                        `Région` = list("Région - Pays de la Loire"),
                                        `Département` = list("Département - Loire-Atlantique", "Département - Maine-et-Loire", "Département - Mayenne", "Département - Sarthe", "Département - Vendée"),
                                        `Agence` = list('Agence - Ancenis', 'Agence - Angers Balzac', 'Agence - Angers Capucins', 'Agence - Angers Europe', 'Agence - Angers La Roseraie', 'Agence - Beaufort en Vallée', 'Agence - Beaupreau')),
                         options = list(create = FALSE,
                                        maxItems = "1",
                                        placeholder = "Rechercher une zone...",
                                        onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
                                        onType = I("function (str) {if (str === \"\") {this.close();}}"),
                                        onItemAdd = I("function() {this.close();}")))
        )
      )


server <- function(input, output, session) {
  
  # Show Selected Value in Console
  observe({print(input$searchZone)})
  
}

shinyApp(ui, server)