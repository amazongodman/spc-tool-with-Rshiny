library(shiny)

#define UI structure

fluidPage(
  titlePanel("hooray! YKK!"),

  # side bar ,input something
sidebarLayout(sidebarPanel(

        
              dateInput("start", 
                label = h3("start date"), 
                value = "2019-01-01"),

              dateInput("end", 
                label = h3("end date"), 
                value = "2019-08-31"),


textInput("odbc", label = h5("odbc"), value = "fas_cloud", width = NULL, placeholder = NULL),
textInput("user", label = h5("user"), value = "FSUSER", width = NULL, placeholder = NULL),
textInput("pass", label = h5("pass"), value = "YKK", width = NULL, placeholder = NULL),
textInput("country", label = h5("country lib"), value = "FC032LIB", width = NULL, placeholder = NULL),
checkboxGroupInput("non_use", label = h5("non use check"),  choices = list("all use" = 0,"CHNCA0" = 1, "CLSCA0" = 2, "TAPCA0" = 3,"statistic" = 4,"coler" = 5,"depo" = 6),selected = 5),
textInput("SIZCA0", label = h5("SIZCA0"), value = "45", width = NULL, placeholder = NULL),
textInput("CHNCA0", label = h5("CHNCA0"), value = "C", width = NULL, placeholder = NULL),
textInput("CLSCA0", label = h5("CLSCA0"), value = "CH", width = NULL, placeholder = NULL),
textInput("TAPCA0", label = h5("TAPCA0"), value = "P14S", width = NULL,placeholder = NULL),
textInput("statistic", label = h5("statistic code"), value = "1______", width = NULL,placeholder = NULL),
textInput("clrc", label = h5("CLRC"), value = "&&580", width = NULL,placeholder = NULL),
textInput("depot", label = h5("DEPO"), value = "01", width = NULL,placeholder = NULL),
numericInput("leadtime", label = h5("lead time [day]"), value=5, min = 1, max = 30, step = NA,width = NULL)
),
mainPanel(

      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot"))
      ),

        h5(textOutput("qy")), 
        h5(tableOutput("FA000")),

        h5(textOutput("che")), 
        h5(tableOutput("TDF00"))
        )

)
)


