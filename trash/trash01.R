library(shiny)

ui <- fluidPage(
  
  actionLink(inputId = 'truc', label = "Cliquer")
  
)

server <- function(input, output, session) {
  
  observeEvent(input$truc, {
    showModal(modalDialog(
      title = "Important message",
      "This is an important message!"
    ))
  })
  
}

shinyApp(ui, server)