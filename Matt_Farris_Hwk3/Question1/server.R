# Farris_Matt_Hwk3 
# Question One Server Script
#

library(shiny)
library(googleVis)
#Taking Data Directly from Github page for simplicity.
library(RCurl)
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
dat <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
dat <- read.csv(text=dat)
dat <-data.frame(dat)

#Subsetting Data and Collect List
data2010 <- subset(dat, Year == 2010)
ICDNames <- unique(as.character(data2010$ICD.Chapter)) 


# Shiny Server functions for our Barchart, Map, and Table
shinyServer(function(input, output) {
  
  #Creating a Reactive dataset for our functions below
  dataSubset <-reactive({
      dataSubset <- subset(data2010, ICD.Chapter == input$select)
  })
  #Barchart
  output$chart<- renderGvis({
    dataSort <- dataSubset()
    dataSort <- dataSort[order(-dataSort$Crude.Rate),]
    gvisBarChart(dataSort, yvar = "Crude.Rate", xvar = "State", 
                 options=list(
                   title = "Mortality Rank by State", 
                   width=700, 
                   height=900))
  })
  #Mapping Mortality Rate
  output$map <- renderGvis({
    gvisGeoChart(dataSubset(), "State", "Crude.Rate",
                 options=list(
                   title= "Density Map of Mortality Rate",
                   region="US",
                   displayMode="regions", 
                   resolution="provinces",
                   colors="['blue','red']",
                   width=600, 
                   height=400))
  }) 
  
  #Sortable Table
  output$table<- renderGvis({
    gvisTable(dataSubset(), 
                 options=list(
                   title = "Sortable Table View of Mortality by Diagnosis",
                   width=1000, 
                   height=1000))
  })
  
})
