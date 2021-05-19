ibrary(shiny)
library(ggplot2)

server <- function(input, output){
  dat <- reactive({
    r<-seq(0,(1/input$b_1)*(input$c_0-input$c_1*input$T+input$b_0+input$G),0.001)
    Y_IS_1<-(1/(1-input$c_1_base))*
            (input$c_0_base-input$c_1_base*input$T_base+input$b_0_base-
               input$b_1_base*r+input$G_base)
    Y_LM_1<-input$M_bar_base/(input$P_base*input$d_1_base)+(input$d_2_base/input$d_1_base)*r
    Y_star_1<-(input$d_2_base*(input$c_0_base-input$c_1_base*input$T_base+
                          input$b_0_base+input$G_base)+(input$b_1_base*input$M_bar_base)/
                 input$P_base)/(input$b_1_base*input$d_1_base+input$d_2_base*(1-input$c_1_base))
    r_star_1<-(input$d_1_base*(input$c_0_base-input$c_1_base*input$T_base+input$b_0_base+
                                 input$G_base)-(1-input$c_1_base)*input$M_bar_base/input$P_base)/
              ((1-input$c_1_base)*input$d_2_base+input$d_1_base*input$b_1_base)


    Y_IS_2<-(1/(1-input$c_1))*(input$c_0-input$c_1*input$T+input$b_0-input$b_1*r+input$G)
    Y_LM_2<-input$M_bar/(input$P*input$d_1)+(input$d_2/input$d_1)*r
    Y_star_2<-(input$d_2*(input$c_0-input$c_1*input$T+
                          input$b_0+input$G)+(input$b_1*input$M_bar)/input$P)/
                          (input$b_1*input$d_1+input$d_2*(1-input$c_1))
    r_star_2<-(input$d_1*(input$c_0-input$c_1*input$T+input$b_0+input$G)-
               (1-input$c_1)*input$M_bar/input$P)/((1-input$c_1)*input$d_2+input$d_1*input$b_1)

    data_table <- data.frame(r,Y_IS_1,Y_IS_2,Y_LM_1,Y_LM_2,Y_star_1,Y_star_2,r_star_1,r_star_2)
    data_table
  })
  output$graph <- renderPlot({
    ggplot(data = dat(), aes(x = Y, y=r)) +
      geom_line(aes(x = Y_IS_2, colour = "IS2"), size = 1)+
      geom_line(aes(x = Y_LM_2, colour = "LM2"), size = 1)+
      geom_line(aes(x = Y_IS_1, colour = "IS1"), size = 1)+
      geom_line(aes(x = Y_LM_1, colour = "LM1"), size = 1)+
      geom_segment(
        aes(x = Y_star_2, y = 0, xend = Y_star_2, yend = r_star_2),
        linetype = "dashed", colour = "black"
      ) +
      geom_segment(
        aes(x = 0, y = r_star_2, xend = Y_star_2, yend = r_star_2),
        linetype = "dashed", colour = "black"
      ) +
      geom_point(aes(x=Y_star_2, y=r_star_2), size=2)+
      geom_segment(
        aes(x = Y_star_1, y = 0, xend = Y_star_1, yend = r_star_1),
        linetype = "dashed", colour = "black"
      ) +
      geom_segment(
        aes(x = 0, y = r_star_1, xend = Y_star_1, yend = r_star_1),
        linetype = "dashed", colour = "black"
      ) +
      geom_point(aes(x=Y_star_1, y=r_star_1), size=2)
      })
  output$table <- renderTable({
    tmp <- dat()
    equil <- data.frame(
      "Y_star_1" = tmp$Y_star_1,
      "r_star_1" = tmp$r_star_1,
      "Y_star_2"=tmp$Y_star_2,
      "r_star_2"=tmp$r_star_2
    )[1, ]
  })
}
