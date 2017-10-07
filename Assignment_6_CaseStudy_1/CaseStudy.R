#library(UScensus2010)
# UScensus2010: https://cran.r-project.org/web/packages/UScensus2010/UScensus2010.pdf
#detach("package:UScensus2010", unload=TRUE)


# https://www.computerworld.com/article/3120415/data-analytics/how-to-download-new-census-data-with-r.html

#library(acs)
# https://cran.r-project.org/web/packages/acs/acs.pdf
#rm(kansas09)
#detach("package:acs", unload=TRUE)

path<-"/Users/bgranger/Documents/SMU/DDS/SMU_DoingDataScience/Assignment_6_CaseStudy"
setwd(path)

#READ BREWERIES DATA
Breweries<-read.csv("Breweries.csv", sep = ",", header = TRUE, stringsAsFactors = TRUE, col.names =c("Brewery_id","Name","City","State"))
Breweries$Name<-as.character(Breweries$Name)

#READ BEER DATA
Beers<-read.csv("Beers.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
Beers$Style<-as.factor(Beers$Style)

# MERGE BREWERIES AND BEER                       
Breweries_Beers<- merge(Breweries, Beers, by=c("Brewery_id"), all = TRUE)

# Q1: How many breweries are present in each state?
library(magrittr)
library(dplyr)
#library(doBy)
rm(doBy)

Breweries_Per_State<-Breweries %>% group_by(State) %>% summarise(Count_By_State = length(State))


# CORRELATION/COVARIANCE
#http://www.statmethods.net/stats/correlations.html
# Complete Cases

#IS THERE A CORRELATION BETWEEN BEER AND ABV --- 4.3% ... NO
Corr_Beer_ID_ABV<-cor(Breweries_Beers$Beer_ID, Breweries_Beers$ABV, use = "pairwise.complete.obs", method="pearson")

#IS THERE A CORRELATION BETWEEN BEER AND CITY
# CREATE UNIQUE CITY, STATE
unique_city<-data.frame(seq(1,length(unique(Breweries$City))), unique(Breweries$City))
colnames(unique_city)<- c("city_id", "city")


# INSERT NEW COLUMN 
unique_city$city_id<-

Corr_Beer_ID_City<-cor(Breweries_Beers$City , Breweries_Beers$Beer_ID , use = "pairwise.complete.obs", method="pearson")


#library(Hmisc)
#detach("package:Hmisc", unload=TRUE)
#Corr_Beer_ID_ABV<-rcorr(Breweries_Beers, type ="pearson")
