library(bs4Dash)
library(tidyverse)

# Constantes

zones <- read_csv('../zones.csv')

choixZone <- selectizeInput(
  inputId = 'choixZone', 
  label = NULL, 
  choices = NULL, 
  multiple = T, 
  options = list(placeholder = "Rechercher une zone...",
                 maxItems = '1',
                 optgroupField = 'Type_zone', 
                 lockOptgroupOrder = T,
                 searchField = 'Libelle_zone',
                 onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
                 onType = I("function (str) {if (str === \"\") {this.close();}}"),
                 onItemAdd = I("function() {this.close();}")
  ),
  width = '500px'
)

# UI

ui <- dashboardPage(
  dashboardHeader(),
  
  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem(
        text = "Tab 1",
        tabName = "tab1"
      ),
      menuItem(
        # condition = "input.show == true",
        condition = "input.choixZone.length !== 0",
        text = "Tab 2",
        tabName = "tab2"
      )
    )
  ),
  
  # Body
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "tab1",
        h1("Welcome!"),
        checkboxInput("show", "Show Tab 2", FALSE),
        selectInput(
          inputId = 'select',
          label = NULL,
          choices = c("hj", "hjkh"),
          selected = NULL,
          multiple = FALSE
        ),
        choixZone
      ),
      tabItem(
        tabName = "tab2",
        h1("Hey! You found me!")
      )
    )
  )
)

# SERVER

server <- function(input, output, session) {
  updateSelectizeInput(session = session, 
                       inputId = 'choixZone', 
                       choices = zones, 
                       selected = zones %>% filter(Type_zone == ""),
                       server = TRUE)
  output$affiche <- renderPrint({
    idZone <- as.character(zones[as.integer(input$choixZone), 1])
    typeZone <- as.character(zones[as.integer(input$choixZone), 2])
    libelleZone <- as.character(zones[as.integer(input$choixZone), 3])
    c(idZone, typeZone, libelleZone)
  })
  
}

shinyApp(ui = ui, server = server)

