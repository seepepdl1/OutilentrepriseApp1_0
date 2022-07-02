  library(shiny)
  library(bs4Dash)
  
  shinyApp(
    ui = dashboardPage(
      header = dashboardHeader(actionButton(inputId = "sidebarToggle", label = "Toggle Sidebar")),
      sidebar = dashboardSidebar(id = "sidebar"),
      body = dashboardBody(
        
      )
    ),
    
    server = function(input, output, session) {
      observeEvent(
        input$sidebarToggle, 
        {updateSidebar(id = "sidebar", session = session)})
    }
  )
