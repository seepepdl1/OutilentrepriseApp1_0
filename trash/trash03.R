library(shiny)
# library(shinyBS)

ui<-fluidPage(
  actionButton("tabBut", "View Table"),
  #bsModal("modalExample", "Modal Example", "tabBut", size = "large",tags$div(class="modal-footer",tags$button(type="button",class="btn btn-primary mr-auto","data-dismiss"="modal","Done")))
)

server<-function(input, output){
  
  observeEvent(input$tabBut, {
    showModal(
      modalDialog(
        title = 'Modal Example',
        footer = tagList(
          actionButton("done", "Some button for Done"),
          modalButton('Close')
        )
      )
    )
  })
  
}


shinyApp(ui=ui,server=server)