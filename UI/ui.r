#ui.r
#require("devtools")

#library(shiny)
#library(plotly)
#require("dplyr")

if(require("dplyr")==T){print("exist")}else{
  install.packages("dplyr")
  require("dplyr")}
if(require("plotly")==T){print("exist")}else{
  install.packages("plotly")
  require("plotly")}
if(require("shiny")==T){print("exist")}else{
  install.packages("shiny")
  require("shiny")}


# 目的のパッケージをインストール
#devtools::install_github('andrewsali/shinycssloaders')
#library(shinycssloaders)

#define UI structure
shinyUI(navbarPage("表示するタイトル",theme = "Solar.css",

#headerPanel("New Application"),

tabPanel("1ページ目のタイトル",





#tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "mystyles.css")),

  sidebarLayout(
    sidebarPanel(

      submitButton("Submit"),
      br(),
      br(),

#selectInput("uni_item","ITEM_COL",uni_each),
#uni_lis <- read.csv("uni_each.csv")

      numericInput("num", 
                    h3("Numeric input"), 
                    value = 1),

      textInput("text", h3("Text input"), 
                  value = "Enter text"),

      radioButtons("radio", h3("Radio buttons"),
                    choices = list("Choice 1" = 1, "Choice 2" = 2,
                    "Choice 3" = 3),selected = 1),

      dateRangeInput("dates", h3("Date range"),start = "2018-01-01", end = "2019-01-01"),

      dateInput("date", 
                  h3("Date input"), 
                  value = "2014-01-01"),

      checkboxGroupInput("boxinput", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")

      ),  #sidebarPanelの終わり　カンマが必要
    mainPanel(
          #    textOutput("text1"),
          #    tableOutput("table1"), #テーブルを表示させたい。各項目にカンマ必要
          #    tags$head(tags$style("#table1 table {background-color: #996600; }", media="screen", type="text/css")),

tableOutput("table1")
            #  plotlyOutput("plot2") #ページに表示させたいものがplotである。　最後なのでカンマ不要

            ) #mainpanelの終わりカンマ不要
  )#sidebarLayoutの終わり
),  #1タブページの終わり。2タブページ目を作りたいのでコンマが必要

tabPanel("2ページ目のタイトル",
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("boxinput3", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")  #最後のinput項目　カンマ不要
      ),  #sidebarPanelの終わり　カンマが必要
    mainPanel(
            plotlyOutput("plot4")
            ) #mainpanelの終わりカンマ不要
  )#sidebarLayoutの終わり
),
#2タブページ目の終わり。　3ページ目は無いのでコンマ不要

tabPanel("3ページ目のタイトル",
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("boxinput3", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")  #最後のinput項目　カンマ不要
      ),  #sidebarPanelの終わり　カンマが必要
    mainPanel(
            plotlyOutput("plot5")
            ) #mainpanelの終わりカンマ不要
  )#sidebarLayoutの終わり
),


tabPanel("4ページ目のタイトル",
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("boxinput3", 
                          label = h3("ラベル"), 
                          choices = list("1", "2", "3"),
                          selected = "1")  #最後のinput項目　カンマ不要
      ),  #sidebarPanelの終わり　カンマが必要
    mainPanel(
            plotlyOutput("plot6")
            ) #mainpanelの終わりカンマ不要
  )#sidebarLayoutの終わり
)

)#タイトルからのひとまとまりの末端
)#ページ自体の末端



