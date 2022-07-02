library(shiny)

ui <- fluidPage(
  
  selectInput(inputId = "var", label = "Select a variable:", choices = c("A", "B", "C"), selected = NULL, multiple = T),
  
  textOutput("selected_var")
  
)

server <- function(input, output) {
  
  observeEvent(input$var, {
    
    if (is.null(input$var)) {    
      
      showNotification("var changed to null")    
      
    }
    
  }, ignoreInit = TRUE, ignoreNULL = FALSE)
  
}
shinyApp(ui = ui, server = server)