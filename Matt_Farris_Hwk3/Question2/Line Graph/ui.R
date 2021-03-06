# Farris_Matt_Hwk3 
# Question One UI Script
#
library(shiny)
library(RCurl)
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
dat <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
dat <- read.csv(text=dat)
dataTotal <-data.frame(dat)
ICDNames <- unique(as.character(dataTotal$ICD.Chapter)) 
State <- unique(as.character(dataTotal$State)) 

# Define UI 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mortality Rates of States Per 100,000 People"),
  
  # Sidebar with Select Inputs from List 
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Select Diagnosis"), 
                  choices = ICDNames,
                  selected = 1),
      
      br(),

      #Select State Input
      selectizeInput("state", label = h3("Select State(s) - Max 5"), 
                  choices = State, multiple = TRUE,
                  options = list(maxItems = 5)),
      
      submitButton("Submit")
    ),
    
    
    # Tab Display 
    mainPanel(
      tabsetPanel(
        tabPanel("Line", htmlOutput("line")),
        tabPanel("Table", htmlOutput("table"))
      )
    )
  )
))
