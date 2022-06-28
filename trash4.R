library(bs4Dash)
library(tidyverse)

zones <- read_csv('zones.csv')

ui <- fluidPage(
  fluidRow(column(3),
           column(
             width = 5,
             selectizeInput(inputId = 'choixZone', 
                            label = NULL, 
                            choices = NULL, 
                            multiple = T, 
                            options = list(placeholder = "Choisir une zone...",
                                           maxItems = '1',
                                           optgroupField = 'Type_zone', 
                                           lockOptgroupOrder = T,
                                           searchField = 'Libelle_zone'
                            ),
                            width = '100%'
             )
           ),
           column(width = 3,
                  # actionBttn(
                  #   inputId = 'filtres',
                  #   label = 'Filtres', 
                  #   style = 'bordered',
                  #   color = 'primary',
                  #   size = 'sm',
                  #   icon = shiny::icon('sliders-h'),
                  # )
                  actionButton(
                    inputId = 'filtres', 
                    label = "Filtres", 
                    icon = shiny::icon('sliders-h'), 
                    width = NULL, 
                    dashboardBadge(2, color = 'danger')
                  )
           )
  ),
  verbatimTextOutput('affiche'),
)

server <- function(input, output, session) {
  #observe({
    # zones <- read_csv('zones.csv')
    updateSelectizeInput(session = session, 
                         inputId = 'choixZone', 
                         choices = zones, 
                         selected = zones %>% filter(Type_zone == ""),
                         server = TRUE)
 #  })
  output$affiche <- renderPrint({
    idZone <- as.character(zones[as.integer(input$choixZone), 1])
    typeZone <- as.character(zones[as.integer(input$choixZone), 2])
    libelleZone <- as.character(zones[as.integer(input$choixZone), 3])
    c(idZone, typeZone, libelleZone)
  })
  
}

shinyApp(ui, server)