
# Farris_Matt_Hwk3 
# Question Two Server Script
# This is for the table and Line Graph with multiple state inputs

library(shiny)
library(googleVis)
#Taking Data Directly from Github page for simplicity.
library(RCurl)
library(dplyr)
library(magrittr)
library(reshape2)

url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
dat <- getURL(url, ssl.verifypeer=0L, followlocation=1L)
dat <- read.csv(text=dat)
dataTotal <-data.frame(dat)


# Shiny Server functions for our Barchart, Map, and Table
shinyServer(function(input, output) {
  
  #Creating a Reactive dataset for our functions below
  dataDiag <-reactive({
    subset(dataTotal, ICD.Chapter == input$select)
  })
  dataState <-reactive({
    subset(dataTotal, State %in% input$state & ICD.Chapter == input$select)
  })


  #Plot of Diagnosis over Time Compared to National Average. 
  output$line<- renderGvis({
    
    dataSubset <- dataState()  %>% 
      select(State,Year, Crude.Rate)
    
    dataYear<- dataDiag() %>%
      select(Year, Deaths, Population) %>%
      group_by(Year) %>%
      summarize(Deaths=sum(Deaths), Population=sum(as.numeric(Population)))
    dataYear$Crude.Rate <- (as.numeric(dataYear$Deaths)/as.numeric(dataYear$Population))*100000 
    dataYear <- dataDiag() %>%
      select(Year,Crude.Rate)
    dataYear$State <- "National"
    dataSubset <-rbind(dataSubset,dataYear)
    dataSubset<- dcast(dataSubset, Year~State, mean)
    
    
    gvisLineChart(dataSubset, xvar = "Year",
                  options=list(
                   title = "Mortality Rank by State",
                   hAxis="{title:'Year'}",
                   vAxis="{title:'Mortality Rate per 100,000'}",
                   width=700, 
                   height=900))
  })
  #Sortable Table
  output$table<- renderGvis({
    
    dataSubset <- dataState()  %>% 
      select(State,Year, Crude.Rate)
    
    dataYear<- dataDiag() %>%
      select(Year, Deaths, Population) %>%
      group_by(Year) %>%
      summarize(Deaths=sum(Deaths), Population=sum(as.numeric(Population)))
    dataYear$Crude.Rate <- (as.numeric(dataYear$Deaths)/as.numeric(dataYear$Population))*100000 
    dataYear <- dataDiag() %>%
      select(Year,Crude.Rate)
    dataYear$State <- "National"
    dataSubset <-rbind(dataSubset,dataYear)
    dataSubset<- dcast(dataSubset, Year~State, mean)
   
     gvisTable(dataSubset, 
              options=list(
                title = "Sortable Table View of Mortality by Diagnosis",
                width=1000, 
                height=1000))
  })
 
})
