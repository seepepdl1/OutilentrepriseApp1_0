
# --------------------------------------------------------------------------------------------------
# > UI
# --------------------------------------------------------------------------------------------------

radioExtraUI <- function(id, label, choices, selected = NULL, placeholder = "Other") {
  other <- textInput(NS(id, "other"), label = NULL, placeholder = placeholder)
  names <- if (is.null(names(choices))) choices else names(choices)
  values <- unname(choices)
  radioButtons(NS(id, "primary"), 
               label = label,
               choiceValues = c(names, "other"),
               choiceNames = c(as.list(values), list(other)),
               selected = selected
  )
}


# --------------------------------------------------------------------------------------------------
# > SERVER
# --------------------------------------------------------------------------------------------------

radioExtraServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$other, ignoreInit = TRUE, {
      updateRadioButtons(session, "primary", selected = "other")
    })
    
    reactive({
      if (input$primary == "other") {
        input$other
      } else {
        input$primary
      }
    })
  })
}


# --------------------------------------------------------------------------------------------------
# > APP TEST
# --------------------------------------------------------------------------------------------------

# App
radioExtraApp <- function(...) {
  ui <- fluidPage(
    radioExtraUI("extra", ...),
    textOutput("value")
  )
  server <- function(input, output, server) {
    extra <- radioExtraServer("extra")
    output$value <- renderText(paste0("Selected: ", extra()))
  }
  shinyApp(ui, server)
}

# Test
radioExtraApp(label = 'gh', 
              choices = c("Fraise", "Chocolat", "Vanille", "Pistache"),
              placeholder = "Autre parfum !"
)

