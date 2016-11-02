# Farris_Matt_Hwk3 
# Question One UI Script
#
library(shiny)
library(RCurl)
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
dat <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
dat <- read.csv(text=dat)
dat <-data.frame(dat)
data2010 <- subset(dat, Year == 2010)
ICDNames <- unique(as.character(data2010$ICD.Chapter)) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mortality Rate Per 100,000 for 2010"),
  
  # Sidebar with Select Inputs from List 
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Select Diagnosis"), 
                  choices = ICDNames,
                  selected = 1)
    ),
    
    # Tab Display 
    mainPanel(
      tabsetPanel(
        tabPanel("BarChart", htmlOutput("chart")), 
        tabPanel("Map", htmlOutput("map")), 
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
))
