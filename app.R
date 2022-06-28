#=====================================================================================================
# DESCRIPTION   : Application Web
#
# ENVIRONNEMENT : R 4.1.3hjkhk
#  
# TODO          : 
#=====================================================================================================

library(bs4Dash)
library(tidyverse)

# ----------------------------------------------------------------------------------------------------
# > FONCTIONS
# ----------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------
# > CONSTANTES
# ----------------------------------------------------------------------------------------------------

zones <- read_csv('zones.csv')

choixZone <- selectizeInput(
  inputId = 'choixZone', 
  label = NULL, 
  choices = NULL, 
  multiple = T, 
  options = list(placeholder = "Choisir une zone...",
                 maxItems = '1',
                 optgroupField = 'Type_zone', 
                 lockOptgroupOrder = T,
                 searchField = 'Libelle_zone'
  ),
  width = '500px'
)

filtres <- actionButton(
  inputId = 'filtres', 
  label = "Filtres", 
  icon = shiny::icon('sliders-h'), 
  width = NULL, 
  dashboardBadge(2, color = 'danger')
)

# ----------------------------------------------------------------------------------------------------
# > UI
# ----------------------------------------------------------------------------------------------------

# Body

body <- bs4DashBody(
  tags$head(
    tags$style(
      HTML(".navbar {
              justify-content: space-between;
            }
           .ml-auto {
             margin-left: initial!important
           }")
    )
  ),
  br(), br(), verbatimTextOutput('affiche')
  
)


# Header

header <- bs4DashNavbar(
  title = bs4DashBrand("Outil entreprise", color = NULL, href = NULL, image = "logo.png", opacity = 0.8),
  leftUi = NULL,
  rightUi = dropdownMenu(),
  skin = "light",
  status = "white",
  border = T,
  compact = F,
  sidebarIcon = shiny::icon("bars"),
  fixed = T,
  tags$style(HTML(".selectize-input {
                      height: 38px;
                      width: 500px;
                   }
                  .shiny-input-container {
                     margin-bottom: -15px;
                     margin-right: 15px;
                  }")),
  tags$ul(
    class = 'navbar-nav',
    tags$li(class = 'nav-item', choixZone),
    tags$li(class = 'nav-item', filtres)
  )
  
)


# Sidebar

sidebar <- bs4DashSidebar(
  bs4SidebarMenu(  
    bs4SidebarMenuItem("Tableau de bord", icon = icon("tachometer-alt"), tabName = "tabDashboard", selected = T),
    bs4SidebarMenuItem("Analyse", icon = icon("chart-pie"),
                       bs4SidebarMenuSubItem("Etablissements", tabName = "tabEtablissements"),
                       bs4SidebarMenuSubItem("Offres", tabName = "tabOffres"),
                       bs4SidebarMenuSubItem("DPAE", tabName = "tabDpae")),
    bs4SidebarMenuItem("Ciblage", icon = icon("bullseye"),
                       bs4SidebarMenuSubItem("Obligation d'Emploi", tabName = "tabBoe"))
  )
)


# Footer

footer <- bs4DashFooter("Hello")


# Ui

ui <- bs4DashPage(header = header, 
                  sidebar = sidebar, 
                  body = body, 
                  footer = footer, 
                  title = "Outil entreprise",
                  dark = NULL,
                  scrollToTop = TRUE)


# ----------------------------------------------------------------------------------------------------
# > SERVER
# ----------------------------------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------------------------------
# > APP
# ----------------------------------------------------------------------------------------------------

shinyApp(ui, server)