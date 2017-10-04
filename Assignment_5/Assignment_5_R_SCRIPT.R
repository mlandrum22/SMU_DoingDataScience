# ASSIGNMENT 5 R SCRIPT
library(dplyr)
library(magrittr)

path<-"/Users/bgranger/Documents/SMU/DDS/SMU_DoingDataScience/Assignment_5"
setwd(path)

# READ YOB2016 DATA
df<-read.table("yob2016.txt", sep = ";", header = FALSE, col.names = c("Name","Gender", "Freq"), stringsAsFactors = FALSE)

pre_record_count<-nrow(df)

# ISOLATE WHERE CONDITION OCCURS
x<-df[grep("yyy$",df$Name),]
x

# FREQUENCY OF THE INSTANCES THAT END IN YYY
yyy_freq<- df[grep("yyy$",df$Name),]

# SUBSET THE INSTANSTANCE WHERE THE NAME ENDS IN YYY OUT OF THE DATASET
y2016<-df[-grep("yyy$",df$Name),]

post_record_count<-nrow(y2016)

# ADD DATASOURCE COLUMN TO Y2016 DF
#y2016["Datasource"]<-2016


# READ YOB2015 DATA
yob2015<-read.table("yob2015.txt", sep = ",", header = FALSE, col.names = c("Name","Gender", "Freq"), stringsAsFactors = FALSE)

# ADD DATASOURCE COLUMN TO Y2015 DF
#yob2015["Datasource"]<-2015

# NOT REQUIRED BY THE ASSIGNMENT

# YOB2015 DATA - TOTAL COUNT BY GENDER
yob2015 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq))

F_Count_2015<-(yob2015 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq)))
F_Count_2015<-F_Count_2015[1,2]

# YOB2015 DATA - TOTAL COUNT BY GENDER
y2016 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq))

F_Count_2016<-(y2016 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq)))
F_Count_2016<-F_Count_2016[1,2]

#RECONCILIATION STEP
sprintf("The total number of female names in 2015 and 2016 are %s and %s; respectively.", prettyNum(F_Count_2015, big.mark=","), prettyNum(F_Count_2016,big.mark=","))

sprintf("The total number of female names for both years (post 'yyy' removal from 2016) is %s.", prettyNum((F_Count_2015 + F_Count_2016), big.mark=","))


final_all<- merge(yob2015, y2016, by=c("Name","Gender"), all = TRUE)
prettyNum(nrow(final_all), big.mark=",")

final_na <- final_all[!complete.cases(final_all),]
prettyNum(nrow(final_na), big.mark=",")

final <- final_all[complete.cases(final_all),]
prettyNum(nrow(final), big.mark=",")

final["Total"]<-final$Freq.x + final$Freq.y

final<- final[order(-final$Total),]

final_all<- merge(yob2015, y2016, by=c("Name","Gender"), all = TRUE)
final_not_all <- final_all[!complete.cases(final_all),]

write.table(final_all, "final_all.txt", sep="\t") 
write.table(final_not_all, "final_not_all.txt", sep="\t")

# SUBSET THE DATAFRAME WHERE GENDER == F
final_all_f <- final_all[ which(final_all$Gender =='F'), ]
final_not_all_f <- final_not_all[ which(final_not_all$Gender =='F'), ]

write.table(final_all_f, "final_all_f.txt", sep="\t")


# FOR THE INCOMPLETE CASES, INJECT ZEROS INTO CELL POSITION WHERE VALUE IS.NA()== "TRUE"
final_not_all_f$Freq.x[is.na(final_not_all_f$Freq.x)==TRUE]<-0
final_not_all_f$Freq.y[is.na(final_not_all_f$Freq.y)==TRUE]<-0

write.table(final_not_all_f, "final_not_all_f.txt", sep="\t")

# MERGE THE COUNTS BY YEAR INTO A SINGLE COLUMN
final_all_f_sum<-(final_all_f %>% select(Name, Freq.x, Freq.y) %>% group_by(Name) %>% summarise(Count=sum(Freq.x + Freq.y)))
final_not_all_f_sum<-(final_not_all_f %>% select(Name, Freq.x, Freq.y) %>% group_by(Name) %>% summarise(Count=sum(Freq.x + Freq.y)))

write.table(final_all_f_sum, "final_all_f_sum.txt", sep="\t")
write.table(final_not_all_f_sum, "final_not_all_f_sum.txt", sep="\t")


# BRING TOGETHER THE COMPLETE AND INCOMPLETE CASES
# 1) REMOVE NAs FROM final_all_f_sum TABLE 22,544 - 7,277 = 15,267
# 2) MERGE THE final_not_all_f_sum INTO the final_all_f_sum TABLE
# 1) ###########################################################
final_all_f_sum_not_complete<- final_all_f_sum[!complete.cases(final_all_f_sum),] 
final_all_f_sum<- final_all_f_sum[complete.cases(final_all_f_sum),]
# 2) ############################################################
final<- rbind(final_all_f_sum, final_not_all_f_sum) 

# 3,533,185
final_count_sum<-colSums(final[,2]) 

sprintf("After merging the female names for both years, the total number of names is %s.", prettyNum(sum(final_f_sum$Count), big.mark=","))


final_all_f <- final[ which(final$Gender =='F'), ]
