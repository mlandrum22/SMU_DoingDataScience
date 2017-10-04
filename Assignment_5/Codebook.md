# SMU_DoingDataScience 6306 Fall 2017

## Assignment 5 - CODEBOOK

### PURPOSE: The purpose of this CODEBOOK is short definition of each object you create as well as define the functions used and the package from which they derive.

##### Object list based upon the ```{code chunk}``` from which it appeas in the RMarkdown file:

  1) {setup}
    + Two libraries are loaded, which are:
      a) dplyr, which is select(), summarise(), etc
      b) magrittr, which access the %>% operator
  
  2) {r Q_1a}
    + STORE THE PATH TO FILE VARIABLE INTO THE PATH OBJECT
      a) path
    + MAKE THE PATH THE WORKING (ACTIVE) DIRECTORY
      b) setwd(path)
    + READ YOB2016 DATA INTO THE OBJECT DF
      c) df
  
  3) {r Q_1b}
    + PRODUCE A SUMMARY OF THE DF OBJECT
      a) summary(df)
    + PRODUCE A STRUCTURE (STR) OF THE DF OBJECT
      b) str(df)
    + DISPLAY THE NUMBER OF ROWS IN THE DF OBJECT
      c) pre_record_count<-nrow(df)
  
  4) {r Q_1c}
    + ISOLATE WHERE THE CONDITION ("yyy" OCCURS AT THE END OF A STRING) OCCURS IN THE DF OBJECT AND ASSIGN       TO AN OBJECT CALLED X
      a) x<-df[grep("yyy$",df$Name),]
  
  5) {r Q_1d}
    + FREQUENCY OF INSTANCES THAT END IN "YYY" AND ASSIGN IT TO THE OBJECT yyy_freq
      a) yyy_freq<- df[grep("yyy$",df$Name),]
    + SUBSET THE INSTANSTANCE WHERE THE NAME ENDS IN YYY OUT OF THE DATASET INTO AN OBJECT CALLED y2016
      b) y2016<-df[-grep("yyy$",df$Name),]
    + NUMBER OF ROWS IN THE y2016 OBJECT
      c) post_record_count<-nrow(y2016)
    + RECONCILIATION STEPS - PRINT ROW COUTNS
      d)sprintf("The total frequecy represented by the wildcard removal of names ending with 'yyy' was             %s.", prettyNum(yyy_freq$Freq, big.mark=","))
      e) sprintf("The total number of rows before the wildcard removal of names ending with 'yyy' was %s,          after the removal it is %s.", prettyNum(pre_record_count, big.mark=","),                                   prettyNum(post_record_count, big.mark=","))
  6) {r Q_2a}
    + READ YOB2015 DATA INTO THE OBJECT yob2015, DEFINE THE SEPERATOR AND ASSIGN COLUMN NAMES
      a) yob2015<-read.table("yob2015.txt", sep = ",", header = FALSE, col.names = c("Name","Gender",              "Freq"), stringsAsFactors = FALSE)
  
  7) {r Q_2b}
    + DISPAY THE LAST TEN ROWS OF THE yob2015 OBJECT
      a) tail(yob2015, n=10)
  
  8) {r Q_2_NOTREQUIRED}
    + DISPLAY - YOB2015 DATA - TOTAL COUNT BY GENDER - SUM THE FREQ VALUES
      a) yob2015 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq))
    + DISPLAY - Y2016 DATA - TOTAL COUNT BY GENDER - SUM THE FREQ VALUES
      b) y2016 %>% select(Gender, Freq) %>% group_by(Gender) %>% summarise(Count=sum(Freq))
      
  9) {r Q_2c}
    + MERGE THE TWO DATASETS INTO ONE, 'JOIN' WILL BE BASED UPON NAME AND GENDER FIELDS.
    + INCLUDING THE GENDER COLUMN IN THE MERGE WILL ENSURE THE MERGE WILL CONSIDER GENDER FOR NAMES             SPELLED THE SAME BETWEEN MALE AND FEMALE
      a) final_all<- merge(yob2015, y2016, by=c("Name","Gender"), all = TRUE)
          prettyNum(nrow(final_all), big.mark=",")
      b) final_na <- final_all[!complete.cases(final_all),]
          prettyNum(nrow(final_na), big.mark=",")
      c) final <- final_all[complete.cases(final_all),]
          prettyNum(nrow(final), big.mark=",")
  10) {r Q_3a}
    + CREATE A NEW COLUMN CALLED TOTAL, THE CONTENTS OF THE CELL IS THE ADDITION OF THE FREQ.X AND THE          FREQ.Y VALUES
      a) final["Total"]<-final$Freq.x + final$Freq.y

  11) {r Q_3b}
    + STORT THE FINAL DATAFRAME OBJECT BASED UPON THE VALUES IN THE TOTAL COLUMN, DESENDING ORDER
      a) final<- final[order(-final$Total),]
    + DISPAY THE FIRST TEN ROWS OF THE FINAL OBJECT
      b) head(final, n=10)
      
  12) {r Q_3c}
    + SUBSET THE DATAFRAME OBJECT FINAL WHERE GENDER == F (FEMALE) AND ASSIGN IT TO THE OBJECT FINAL
      a) girl <- final[ which(final$Gender =='F'), ]
    + STORT THE GIRL DATAFRAME OBJECT BASED UPON THE VALUES IN THE TOTAL COLUMN, DESENDING ORDER
      b) girl<- girl[order(-girl$Total),]
    + SLICE THE GIRL DATAFRAME OBJECT TAKING ROWS 1 THROUGH 10 AND ALL COLUMNS
      c) girl<- girl[1:10,]
    + DISPLAY THE DATAFRAME OBJECT GIRL
      girl
  
  13) {r Q_3d}
    + ASSIGN CHARACTER VECTOR TO myvars, WHICH REPRESENT THE COLUMN NAMES 
      a) myvars <- c("Name","Total")
    + EXTRACT/SUBSET COLUMNS INTO THE GIRL DATAFRAME OBJECT  
      b) girl <- girl[myvars]
    + DISPLAY THE DATAFRAME OBJECT GIRL
      c) girl
    + WRITE THE GIRL OBJECT TO A FILE, OMITTING THE ROW AND COLUMN NAMES
      d) write.table(girl, "itsagirl.csv", sep=",", row.names=F, col.names=F)


##### Package::Function used in this exercise:
  
  1) utils
    a) read.table()
    b) write.table()
    c) head()
    d) tail()
    
  2) base
    a) setwd()
    b) summary()
    c) grep()
    d) nrow()
    e) prettyNum()
    f) merge()
    g) names()
  
  3)  dplyr
    a) select()
    b) group_by()
    c) summarise()
    
  2) magrittr
    a) %>% (pipe-operator)






