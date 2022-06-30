library(shiny)

choice_list <- c('hghg', 'hhjkhkj', 'jhhjkhjk', 'elise')

shinyApp(
  ui = shinyUI(
    fluidPage(
      
      selectizeInput("ckbox",
                     label = "Letters",
                     choices = choice_list,
                     selected = 1,
                     multiple = T),
      

        conditionalPanel(
          # condition = "input.ckbox != null",
          #  condition = "input.ckbox != null && input.ckbox.indexOf('elise') != -1",
          condition = "input.ckbox.length !== 0",
          numericInput('gg', "Elise !", 1)
        ),
      
      checkboxInput("test", label = "TEST", value = F),
      conditionalPanel(
        condition = "input.test",
        h3("TEST")                
      )
    )
  ), server = shinyServer(
    function(input, output, session) {  
    })
)