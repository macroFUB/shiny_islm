library(shiny)
library(mathjaxr)

ui <- fluidPage(
  titlePanel("IS-LM-Modell"),
  withMathJax(helpText(
    "$$C=c_0+c_1(Y-T),\\quad I=b_0-b_1r, \\quad G=\\bar{G}, \\quad T=\\bar{T},\\quad
    \\frac{M^d}{P}=d_1Y-d_2r, \\quad \\frac{M^s}{P}=\\frac{\\bar{M}}{P}$$"
  )),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId="c_0", label="c_0", value = 100, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "c_1", label = "c_1", value = 0.8, min = 0.01, max = 0.99
      ),
      sliderInput(
        inputId = "T", label = "T", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "b_0", label = "b_0", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "b_1", label = "b_1", value = 200, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "G", label = "G", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "M_bar", label = "M_bar", value = 250, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "d_1", label = "d_1", value = 0.4, min = 0.01, max = 10
      ),
      sliderInput(
        inputId = "d_2", label = "d_2", value = 500, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "P", label = "P", value = 1, min = 0.01, max = 10
      ),
      sliderInput(
        inputId="c_0_base", label="c_0_base", value = 100, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "c_1_base", label = "c_1_base", value = 0.8, min = 0.01, max = 0.99
      ),
      sliderInput(
        inputId = "T_base", label = "T_base", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "b_0_base", label = "b_0_base", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "b_1_base", label = "b_1_base", value = 200, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "G_base", label = "G_base", value = 150, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "M_bar_base", label = "M_bar_base", value = 250, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "d_1_base", label = "d_1_base", value = 0.4, min = 0.01, max = 10
      ),
      sliderInput(
        inputId = "d_2_base", label = "d_2_base", value = 500, min = 0.01, max = 1000
      ),
      sliderInput(
        inputId = "P_base", label = "P_base", value = 1, min = 0.01, max = 10
      ),
      tags$head(tags$style(
        type = 'text/css',
        'form.well { max-height: 600px; overflow-y: auto; }'
      ))
    ),
    mainPanel(
      plotOutput('graph', click = "plot_click"),
      fluidRow(
        column(width = 6,h4("Gleichgewichtswerte"), tableOutput('table'))
      ),
      tableOutput("info")
    )
  )
)
