# Homework 3, Question 1

For this question, we selected a single input for the shiny app. We used the data source from github
(copied directly for simpliciity) and subsetted the data to look only at 2010 data. We created 3 
visuals for the data in 3 separate tab.  

### Barchart
The barchart displays the sorted data using gvisBarChart function. We sorted the data so the state with
the highest mortality rate is at the top of the list

### Map 
Using gvisGeoChart function, we created a visualization that displays the relative density of all the
states mortality rates. By superimposing the data onto the map of America, we have can better visualize
the date, and see exactly "where" higher mortality takes place.

### Table
The final tab is the summary page, and shows a sorted table with all the data we have available on hand.
This table was included for anyone who is interested in the break-down, to see the source of our charts. 

# Question 2

For question 2 we created 2 separate files. We did this as our first attempt though interesting, didn't 
really show what we wanted to. A description is shown below.  

## BarChart and Map

Our inputs here are again the Diagnosis, followed by a slider input showing the years. For the data here, 
we compared the mortality crude rate, and found the Variance against the weighted total per year. The 
variance here was calculated by taking the crude.rate of the state and subtracting the average. This way, 
we can see which states have the highest mortality rate based on the national average

### Barchart
Our barchart sorts the highest states to the lowest states (postive values imply higher than the national 
average, while negative values imply a lower mortality rate then the national average). Using the slider, 
we can show progress the data forward through the years, and see which states move in which direction, by 
pressing the play button (using animation), we can see the progression moving forward. 

### Map
Again we see a map with relatively variance of the data, going from dark purple to orange. By looking at the 
data we choose a range of colors that encorporated most of the data (from -50 to 50). Selecting a Diagnosis and pressing the 
play button we can see the changing density per year.  
