# UNIT 5 - LECTURE ASSIGNMENT 2

# INSTALL DOWNLOADER #############################################################
install.packages("downloader")
library(downloader)

# LOAD DATA FILES ################################################################
URL<- "https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/appleorange.csv"
downloader::download(URL, destfile="appleorange.csv")
list.files()

# READ APPLE ORANGE FILE ########################################################
# STINGSASFACTORS = FALSE WILL READ STRINGS AS CHARACTERS, NOT FACTORS
ao<- read.csv("appleorange.csv", stringsAsFactors = FALSE, header = FALSE)
str(ao)
aoraw<-ao

# EXAMINE DATA ##################################################################
head(aoraw, n=10)
tail(aoraw, n=10)

# WHY IS DATA NOT TIDY #########################################################
# 1) CHARACTER VECTORS AS QUATATION MARKS, NA

# TIDY THE DATA ################################################################
# DROP THE FIRST THREE AND THE LAST SEVEN FROM THE aoraw AND ASSIGN TO A NEW 
#   OBJECT CALLED AODATA AND INCLUDE ALL COLUMNS
aodata<-aoraw[3:700,]
# ASSIGN MEANINGFUL COLUMN HEADERS
names(aodata)<- c("country","countrynumber","products","productnumber","tonnes","year")
str(aodata)
# COERICE COUNTRYNUMBER FROM CHRACTER TO INTEGER ##############################
aodata$countrynumber<-as.integer(aodata$countrynumber)
# FIND LINES IN THE COUNTRY COLUMN THAT EQUAL A VALUE, USING WHICH ############
fslines<-which(aodata$country == "Food supply quantity (tonnes) (tonnes)")
fslines
# REMOVE THE LINES THAT ARE IN FSLINES VECTOR #################################
aodata<-aodata[(-1 * fslines),]
str(aodata)
# SUBSTITUTE: GSUB ############################################################
aodata$tonnes<-gsub("\xca", "", aodata$tonnes)
aodata$tonnes<-gsub(", tonnes \\(\\)", "", aodata$tonnes)
aodata$tonnes<-as.numeric(aodata$tonnes)
str(aodata)
# YEAR COLUMN - WE KNOW THAT IT IS ALL 2009 DATA ##############################
aodata$year<- 2009
# EXTRACT OUT APPLES AND ORANGES ##############################################
# PRODUCT NUMBER FOR APPLES IS 2617 AND PULL OUT 1,2, and 5th COLUMN
apples<-aodata[aodata$productnumber == 2617, c(1,2,5)]
names(apples)[3]<- "apples"
# PRODUCT NUMBER FOR ORANGES IS 2611 AND PULL OUT 2, and 5th COLUMN
oranges<-aodata[aodata$productnumber == 2611, c(2,5)]
names(oranges)[2]<- "oranges"
str(oranges)
# TEST DELETE LAST SEVEN ROWS ################################################
test<-aoraw
str(test)
tail(test, n=10)
test<-test[1:700,]
# MISSING ORANGES FROM EXPORT DATA ###########################################
oranges<-aodata[aodata$productnumber == 2611, c(1,2,5)]
names(oranges)[3]<- "oranges"
country_list<-data.frame(c("Myanmar", "Suriname", "Turkministan", "Chad"))
which(oranges$country == "Myanmar") # 0
which(oranges$country == "Suriname") # 147
which(oranges$country == "Turkministan") # 0
which(oranges$country == "Chad") # 31


# MERGE DATA #################################################################
oranges<-aodata[aodata$productnumber == 2611, c(2,5)]
names(oranges)[2]<- "oranges"
cleanao2<-merge(apples, oranges, by="countrynumber", all = TRUE)
library(reshape2)
cleanao3<-dcast(aodata[,c(1:3,5)],formula = country+countrynumber~products,value.var = "tonnes")
str(cleanao3)
names(cleanao3)[3:4]<-c("apples","oranges")
# COMPLETE CASES #############################################################
cleanao2[!(complete.cases(cleanao2)),]
cleanao3[!(complete.cases(cleanao3)),]

table(aodata$country)[table(aodata$country)==1]

# IN CLASS ##################################################################
getwd()
WD<-"C:/Users/bgranger/Documents/SMU/DDS/Assignments/Assignment_5"
setwd(WD)
getwd()
df<-read.csv("Breakout_Unit5.csv", header = TRUE, sep = ",")
df
library("reshape2")
df<-cbind(colsplit(df$Name,";", names=c("LastName","FirstName")),df)
df

