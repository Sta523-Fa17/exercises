library(shiny)

options(shiny.reactlog=TRUE)

colors = c("red","green","blue")

shinyApp(
  ui =  fluidPage(
    titlePanel("Shiny Example - Reactivity"),
    mainPanel(
      sliderInput("number","Pick a number:", min = 0, max = 10, value = 5),
      textOutput("text")
    )
  ),
  server = function(input, output, session)
  {
    output$text = renderText({
      input$number
    })
  }
)