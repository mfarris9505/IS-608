# -*- coding: utf-8 -*-
"""
Data Extraction for the 
@author: Matts42
"""

import pandas as pd
import numpy as np 

#Data Upload
url = "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture4/data/riverkeeper_data_2013.csv"
dat_raw = pd.read_csv(url, index_col = 0)

# Data Cleaning (removine Greater than and Lss then values)
rep_val = [">2420", ">24196","<1","<10"]
new_val = [2500,25000,1,10]
dat_raw["EnteroCount"] = dat_raw["EnteroCount"].replace(rep_val,new_val)
dat_raw["EnteroCount"] = dat_raw["EnteroCount"].astype(int)
dat_raw['Date'] = pd.to_datetime(dat_raw['Date'])

dat_avg = dat_raw.drop(['FourDayRainTotal','SampleCount'], 1)


from bokeh.charts import *

p = Bar(dat_yearly_top, values='EnteroCount', label='Year',
         title="Entero Count by Year")
output_notebook()
show(p)