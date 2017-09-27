# DDS UNIT 5

#####################################################################################################
# SECTION 5.4 - IMPORTING DATA
#
#
#####################################################################################################
library(repmis)
library(RCurl)
site_file<-"http://www.users.miamioh.edu/hughesmr/stat333/baseballsalaries.txt"
Unit4_Directory<-"C:/Users/bgranger/Documents/SMU/DDS/Assignments/Assignment_4"
setwd(Unit4_Directory)
download.file(site_file, destfile = "./baseballsalaries.txt")

#####################################################################################################
# SECTION 5.7 - Cleaning Data for Merging 
#
#
#####################################################################################################
install.packages("tidyr")
install.packages("dplyr")
install.packages("countrycode")
install.packages("ggplot2")
install.packages("RCurl")
install.packages("jasonlite")
install.packages("WDI")
install.packages("RJSONIO")

library(tidyr)
library(dplyr)
library(countrycode)
library(ggplot2)
library(repmis)
library(RCurl)
library(RJSONIO)
library(WDI)

# GET DATA #######################################################################################
WDIsearch("fertilizer consumption")
FertConsumptionData<-WDI(indicator = "AG.CON.FERT.PT.ZS")
dim(FertConsumptionData)
str(FertConsumptionData)
head(FertConsumptionData)


# CREATE WIDE FORMAT DATA ###########################################################################
# SPREAD: TAKES DATA IN LONG FORMAT AND CONVERTS TO WIDE 
# YEAR GOES FROM A VARIABLE IN A ROW TO BEING IN A COLUMN
#####################################################################################################
SpreadFert<-spread(FertConsumptionData, year, AG.CON.FERT.PT.ZS)

# ARRANGING DATA ####################################################################################
# ARRAGE IS DEPENDENT UPON THE dplyr PACAGE
# THE DATA HAS BEEN ARRANGED BY COUNTRY ALPHABETICALLY (DESENDING - ASENDSENDING)
#####################################################################################################
SpreadFert<-arrange(SpreadFert, country)
str(SpreadFert)
dim(FertConsumptionData)
# GATHERING DATA ####################################################################################
# GATHER DOES THE OPPISITE OF SPREAD, TAKES WIDE AND MAKES IT LONG 
# IN THIS EXAMPLE, ONLY GATHERING COLUMNS 3 THROUGH 9, SINCE THESE YEARS WERE SPREAD OUT
# IN GATHER PROCESS, YEAR BECOMES A FACTOR (FACTOR = CATAGORY)
#
#####################################################################################################
GatheredFert<-gather(SpreadFert, Year, Fert, 3:9)
head(GatheredFert)
GatheredFert<-rename(GatheredFert, year=Year, FertilizerConsumption=Fert)
# RENAME COLUMN #####################################################################################
# TIDY DATA REQUIRES COLUMNS NAMES TO BE HUMAN READABLE
#
#####################################################################################################
GatheredFert<-rename(GatheredFert, year=Year, FertilizerConsumption=Fert)

# ORDER #############################################################################################
# REORDER BASED ON COUNTRY THEN YEAR, USING THE ORDER FUNCTION
#####################################################################################################
GatheredFert<-GatheredFert[order(GatheredFert$country, GatheredFert$year),]
# SUBSET DATA #######################################################################################
# TAKING PIECES OF THE DATASET
# A GOOD CASE OF SUBSETTING WHEN THERE IS AN EXTREEM, BUT THE BULK OF THE DATA IS NOT AND YOU WANT
# TO LOOK AT THE NON-EXTREEM, A SOLUTION IS TO SUBSET IT
#
# SUBSET OUT "ARAB WORLD" AND MISSING VALUES
#####################################################################################################
FertOutliers<-subset(x=GatheredFert, FertilizerConsumption > 1000)
GatheredFertSub<-subset(x=GatheredFert, FertilizerConsumption <= 1000)
ggplot(data=GatheredFert,aes(FertilizerConsumption) + geom_density() + xlab("\n Fertilizer Consumption") 
       + ylab("Denisty\n") + theme_bw() )
ggplot(data=GatheredFertSub,aes(FertilizerConsumption) + geom_density() + xlab("\n Fertilizer Consumption") 
       + ylab("Denisty\n") + theme_bw() )

GatheredFertSub<-subset(x=GatheredFertSub, country != "Arab World")
GatheredFertSub<-subset(x=GatheredFertSub, !is.na(FertilizerConsumption))

#####################################################################################################
# SECTION 5.8 - Recoding Variables 
#
#
#####################################################################################################

# MERGING DATA ######################################################################################
# MERGE TWO DATA SETS INTO ONE
# MERGE FertConsumpData and GatheredFertSub BY COUNTRY
#  MERGE:
#     IT IS OK THAT ONE DATASET HAS DIFFERENT VALUES, IN THIS CASE COUNTRY, WHAT DOES MATTER IS
#     WHERE THEY ARE THE SAME, THE SPELLING HAS TO BE IDENTICAL IN ORDER FOR THEM TO LINE UP
#
#   IF CHANGES ARE NEED, DO IT PRIOR TO THE MERGE
# 
#####################################################################################################
# COMPARE COUNTRY NAMES BETWEEN TWO DATASETS ########################################################
table(GatheredFertSub$country, FertConsumptionData$country)
# PRE PROCESSING CHANGES ############################################################################
GatheredFertSub$country[GatheredFertSub$country == "Korea, Rep."]<-"South Korea"
FertConsumpData$country[FertConsumpData$country == "Korea, Rep."]<-"South Korea"
# CREATE NEW VARIABLE ###############################################################################
#   TRANSFORM VARIABLES:
#     CREATE THE LOG OF FERTILIZER CONSUMPTION
#####################################################################################################
GatheredFertSub$logFertConsumption <- log(GatheredFertSub$FertilizerConsumption)
summary(GatheredFertSub)
# NEG INF ###########################################################################################
#   WHEN TAKING THE LOG OF ZERO CREATES NEG INFINITY
#   TO RESOLVE -INF, ADD A VERY SMALL VALUE
#   REPEAT THE LOG 
#####################################################################################################
GatheredFertSub$FertilizerConsumption[GatheredFertSub$FertilizerConsumption == 0] <- 0.0001
GatheredFertSub$logFertConsumption <- log(GatheredFertSub$FertilizerConsumption)