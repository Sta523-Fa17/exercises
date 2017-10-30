library(shiny)

options(shiny.reactlog=TRUE)

shinyApp(
  ui =  fluidPage(
    titlePanel("Shiny Example - Reactivity"),
    mainPanel(
      sliderInput("number","Pick a number:", min = 0, max = 10, value = 5),
      actionButton("button","Click me!"),
      textOutput("text")
    )
  ),
  server = function(input, output, session)
  {
    observeEvent(
      input$button,
      {
        updateSliderInput(session, "number", value = input$number+1)
      }
    )
    
    output$text = renderText({
      input$number
    })
  }
)