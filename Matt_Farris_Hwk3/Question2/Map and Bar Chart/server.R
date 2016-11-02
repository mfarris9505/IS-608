
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
dataTotal <-data.frame(dat)


# Shiny Server functions for our Barchart, Map, and Table
shinyServer(function(input, output) {
  
  #Creating a Reactive dataset for our functions below
  dataSubset <-reactive({
      subset(dataTotal, ICD.Chapter == input$select & Year == input$year)
  })
  #Plot of Diagnosis over Time Compared to National Average. 
  output$chart<- renderGvis({
    dataVar <- dataSubset()
    dataVar$Variance <- dataVar$Crude.Rate - (sum(as.numeric(dataVar$Deaths))/sum(as.numeric(dataVar$Population))*100000)
    dataSort <- dataVar[order(-dataVar$Variance),]
    gvisBarChart(dataSort, yvar = "Variance", xvar = "State", 
                 options=list(
                   title = "Mortality Rank by State",
                   width=700, 
                   height=900))
  })
  #Mapping Mortality Rate
  output$map <- renderGvis({
    dataVar <- dataSubset()
    dataVar$Variance <- dataVar$Crude.Rate- (sum(as.numeric(dataVar$Deaths))/sum(as.numeric(dataVar$Population))*100000) 
    gvisGeoChart(dataVar, "State", "Variance",
                 options=list(
                   title= "Density Map of Mortality Rate",
                   region="US",
                   sep = "", 
                   displayMode="regions",
                   colorAxis="{values:[-50,-25,0,25,50],
                   colors:['blue','purple','red','orange','yellow']}",
                   resolution="provinces",
                   width=600, 
                   height=400))
  }) 
})
