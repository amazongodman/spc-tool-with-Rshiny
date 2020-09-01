
library(shiny)
library(plotly)


ui<-

navbarPage("表示するタイトル",

tabPanel("1ページ目のタイトル",
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("boxinput", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1"),

                checkboxGroupInput("boxinput2", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")
                
      ),
    mainPanel(
              textOutput("text1"),
              tableOutput("table1"),
              plotOutput("plot1"),
              plotOutput("plot2")
            ) 
  )
),
tabPanel("2ページ目のタイトル",
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("boxinput3", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")
), 
    mainPanel(
              plotlyOutput("plot3") 
            ) 
  ))
)






x <- c(1:100)
random_y <- rnorm(100, 156, 15)
data <- data.frame(x, random_y)


server <-function(input, output) {

                                output$text1 <- renderText({
　　　　　　　　　　　　　　　　　　print(input$boxinput)
                                })

                                output$table1 <- renderTable({
                              　head(iris)
                                })

                                output$plot1 <- renderPlot({
                              　plot(iris)
                                })

                                output$plot2 <- renderPlot({
                                    plot(cars)
                                })

output$plot3 <- renderPlotly(
fig <- plot_ly(data, x = ~x, y = ~random_y, type = 'scatter', mode = 'lines')
)

}


shinyApp(ui,server)
