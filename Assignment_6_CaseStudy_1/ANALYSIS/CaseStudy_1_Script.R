#library(UScensus2010)
# UScensus2010: https://cran.r-project.org/web/packages/UScensus2010/UScensus2010.pdf
#detach("package:UScensus2010", unload=TRUE)


# https://www.computerworld.com/article/3120415/data-analytics/how-to-download-new-census-data-with-r.html

#library(acs)
# https://cran.r-project.org/web/packages/acs/acs.pdf
#rm(kansas09)
#detach("package:acs", unload=TRUE)

# SETUP ######################################################################################################
# DEFINE WORKING DIRECTORY
path<-"/Users/bgranger/Documents/SMU/DDS/SMU_DoingDataScience/Assignment_6_CaseStudy_1/DATA"
setwd(path)

# READ DATA ##################################################################################################
#READ BREWERIES DATA
Breweries<-read.csv("Breweries.csv", sep = ",", header = TRUE, stringsAsFactors = TRUE, col.names =c("Brewery_id","Name","City","State"))
Breweries$Name<-as.character(Breweries$Name)

#READ BEER DATA
Beers<-read.csv("Beers.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
Beers$Style<-as.factor(Beers$Style)


# Q1: How many breweries are present in each state? ###########################################################
## LOAD magrittr PACKAGE TO ACCESS THE PIPE "%>%" OPERATOR, WHICH ALLOWS FOR VALUES TO FORWARD
## INTO AN EXPRESSION OR FUNCTIONAL CALL
## LOAD THE dplyr PACKAGE TO ACCESS THE "group_by"
library(magrittr)
library(dplyr)
Breweries_Per_State<-Breweries %>% group_by(State) %>% summarise(Count_By_State = length(State))

# Q2: MERGE DATA #############################################################################################
# MERGE BREWERIES AND BEER                       
# Q2 Merge beer data with the breweries data.... 
#    b) Print the ???rst 6 observations and the last six observations to check the merged ???le
Breweries_Beers<- merge(Breweries, Beers, by=c("Brewery_id"), all = TRUE)
names(Breweries_Beers)[c(2,5)] <- c("Brewery Name","Beer Name")   # Changed the names of the columns
head(Breweries_Beers,6)
tail(Breweries_Beers,6)

# Q3: NA's ###################################################################################################
# Report the number of NA's in each column.

emptyObservations <- c( sum(is.na(Breweries_Beers$Brewery_id)),     # Sums NAs for Brewery IDs
                        sum(is.na(Breweries_Beers$City)),           # Sums NAs for Cities
                        sum(is.na(Breweries_Beers$State)),          # Sums NAs for States
                        sum(is.na(Breweries_Beers$`Beer Name`)),    # Sums NAs for Beer Names
                        sum(is.na(Breweries_Beers$Beer_ID)),        # Sums NAs for Beer IDs
                        sum(is.na(Breweries_Beers$ABV)),            # Sums NAs for ABV
                        sum(is.na(Breweries_Beers$IBU))             # Sums NAs for IBU
  )
emptyObservations   # Only NAs are in ABV and IBU columns. 62 ABV, 1005 IBU

# Q4 MEDIAN ALCHOL CONTENT AND BITTERNESS ####################################################################
# a) Compute the median alcohol content and international bitterness unit for each state. 
# b) Plot a bar chart to compare.

# Q5: BY STATE: MAX ALCOHOLIC BEER, BITTER BEER ############################################################## 
# a) Which state has the maximum alcoholic (ABV) beer? 
# b) Which state has the most bitter (IBU) beer?
sortedByABV <- Breweries_Beers[ order(Breweries_Beers$ABV, decreasing=TRUE), ]    # Sorts the DF by ABV
sortedByABV[1,"State"]   #Colorado
sortedByIBU <- Breweries_Beers[ order(Breweries_Beers$IBU, decreasing=TRUE), ]    # Sorts the DF by IBU
sortedByIBU[1,"State"]   #Oregon

# Q6: SUMMARY STATS FOR ABV ##################################################################################
#  Summary statistics for the ABV variable.
summary(Breweries_Beers$ABV)   # Min 0.001   1Q 0.05   Median 0.056   3Q 0.067   Max 0.128    62 NA

# Q7: CORRELATION: BITTERNESS AND ALCOHOLIC CONTENT ##########################################################
# Is there an apparent relationship between the bitterness of the beer and its alcoholic content? 
# Draw a scatter plot. You are welcome to use the ggplot2 library for graphs. 
# Please ignore missing values in your analysis. 
# Make your best judgment of a relationship and EXPLAIN your answer.


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
