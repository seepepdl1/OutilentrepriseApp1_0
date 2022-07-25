#===================================================================================================
# DESCRIPTION   : Formulaire de filtre des zones
#
# ENVIRONNEMENT : R 4.1.3
#  
# TODO          : 
#===================================================================================================


# --------------------------------------------------------------------------------------------------
# > CONSTANTES
# --------------------------------------------------------------------------------------------------

zoneInput <- selectizeInput(
  inputId = 'zoneInput', 
  label = NULL, 
  choices = NULL, 
  multiple = TRUE, 
  options = list(
    placeholder = "Rechercher une zone...",
    maxItems = '1',
    optgroupField = 'Type_zone', 
    lockOptgroupOrder = TRUE,
    searchField = 'Libelle_zone',
    onDropdownOpen = I("function($dropdown) {
                          if (!this.lastQuery.length) {
                            this.close(); 
                            this.settings.openOnFocus = false;
                          }
                        }"),
    onType = I("function(str) {
                  if (str === \"\") {
                    this.close();
                  }
                }"),
    onItemAdd = I("function() {
                     this.close();
                   }")
  ),
  width = '500px'
)

filtres <-   conditionalPanel(
  condition = I("input.zoneInput.length !== 0"),
  actionButton(
    inputId = 'filtresButton',
    label = "Filtres", 
    icon = shiny::icon('sliders-h'), 
    width = NULL, 
    dashboardBadge(2, color = 'danger')
  )
)


# --------------------------------------------------------------------------------------------------
# > UI
# --------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------
# > SERVER
# --------------------------------------------------------------------------------------------------



# --------------------------------------------------------------------------------------------------
# > APP TEST
# --------------------------------------------------------------------------------------------------



if (interactive()) {
  
  library(shiny)
  
  # Contantes
  zones <- read_csv('zones.csv')
  
  # UI
  ui <- fluidPage(
    
    tags$ul(
      class = 'navbar-nav',
      tags$li(class = 'nav-item', zoneInput),
      tags$li(class = 'nav-item', filtres)
    )
    
  )
  
  # Server
  server <- function(input, output, session) {
    
    
    # Update de la box zoneInput
    updateSelectizeInput(
      session = session, 
      inputId = 'zoneInput', 
      choices = zones, 
      selected = zones %>% filter(Type_zone == ""),
      server = TRUE)
    
    
  }
  
  # App
  
  shinyApp(ui, server)
  
}

