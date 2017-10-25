library(shiny)
library(dplyr)
library(ggplot2)
library(forcats)

colors = c("red","green","blue")

shinyApp(
  ui =  fluidPage(
    titlePanel("Shiny Example - Beta-Binomial"),
    sidebarLayout(
      sidebarPanel(
        h4("Data:"),
        sliderInput("n", "Number of trials (n)", 1, 100, 10),
        sliderInput("x", "Number of successes (x)", 1, 100, 5),
        h4("Prior:"),
        numericInput("alpha",HTML("&alpha;"), value=1, min=0, max=100),
        numericInput("beta",HTML("&beta;"), value=1, min=0, max=100),
        h4("Plotting:"),
        checkboxInput("facet","Separate densities?", value = FALSE),
        checkboxInput("customize","Customize plot output?", value = FALSE),
        conditionalPanel(
          "input.customize == true",
          selectInput("prior","Prior color", choices = colors, selected = colors[1]),
          selectInput("likelihood","Likelihood color", choices = colors, selected = colors[2]),
          selectInput("posterior","Posterior color", choices = colors, selected = colors[3])
        )
      ),
      mainPanel(
        plotOutput("dists"),
        tableOutput("summary")
      )
    )
  ),
  server = function(input, output, session)
  {
    observe({
      updateSliderInput(session, "x", max = input$n)
    })
    
    observeEvent(input$prior, {
      if (input$prior == input$likelihood)
        updateSelectInput(session, "likelihood", selected = setdiff(colors, c(input$prior, input$posterior)))
      if (input$prior == input$posterior)
        updateSelectInput(session, "posterior", selected = setdiff(colors, c(input$prior, input$likelihood)))
    })
    
    observeEvent(input$likelihood, {
      if (input$likelihood == input$prior)
        updateSelectInput(session, "prior", selected = setdiff(colors, c(input$likelihood, input$posterior)))
      if (input$likelihood == input$posterior)
        updateSelectInput(session, "posterior", selected = setdiff(colors, c(input$prior, input$likelihood)))
    })
    
    observeEvent(input$posterior, {
      if (input$posterior == input$prior)
        updateSelectInput(session, "prior", selected = setdiff(colors, c(input$posterior, input$likelihood)))
      if (input$posterior == input$likelihood)
        updateSelectInput(session, "likelihood", selected = setdiff(colors, c(input$prior, input$posterior)))
    })
    
    output$dists = renderPlot({
      d = bind_rows(
        data_frame(
          dist = "prior",
          color = input$prior,
          p = seq(0, 1, length.out=100)
        ) %>%
          mutate(d = dbeta(p, shape1=input$alpha, shape2=input$beta)),
        data_frame(
          dist = "likelihood",
          color = input$likelihood,
          p = seq(0, 1, length.out=100)
        ) %>%
          mutate(d = dbinom(input$x, input$n, p)) %>%
          mutate(d = d / (sum(d) / n())),
        data_frame(
          dist = "posterior",
          color = input$posterior,
          p = seq(0, 1, length.out=100)
        ) %>%
          mutate(d = dbeta(p, shape1=input$alpha+input$x, shape2=input$beta+input$n-input$x))
      ) %>%
        mutate(dist = as_factor(dist))
      
      colors = c(input$prior, input$likelihood, input$posterior)
      
      g = ggplot(d, aes(x=p, y=d, ymax=d, fill=dist)) +
        geom_ribbon(ymin=0, alpha=0.25) +
        geom_line() +
        labs(y="Density", fill="") +
        scale_fill_manual(values = colors)
      
      if (input$facet)
        g = g + facet_wrap(~dist)
      
      g
    })
  }
)