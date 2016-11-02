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
      
      
      #State Selection With multiple allowed data

      sliderInput("year", label = "Select Year",
                  min=1999, max=2010, value=1999,
                  sep = "", animate=TRUE)
    ),
    
    
    # Tab Display 
    mainPanel(
      tabsetPanel(
        tabPanel("BarChart", htmlOutput("chart")), 
        tabPanel("Map", htmlOutput("map"))
      )
    )
  )
))
