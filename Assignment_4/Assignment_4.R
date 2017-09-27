# ASSIGNMENT 4 - FIVETHIRTYEIGHT
install.packages("fivethirtyeight")
library(fivethirtyeight)

###########################################################################################
# RESOURCES:
# http://www.storybench.org/how-to-explore-a-dataset-from-the-fivethirtyeight-package-in-r/
# https://cran.r-project.org/web/packages/fivethirtyeight/fivethirtyeight.pdf
#   - PAGE 18
# https://www.rdocumentation.org/packages/utils/versions/3.4.1/topics/data
# https://github.com/rudeboybert/fivethirtyeight
#
# https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
###########################################################################################

# To see a list of all data sets (AS A SEPERATE TAB IN RSTUDIO):
data(package = "fivethirtyeight")


# To see a more detailed list of all data sets, see the package vignette:
# PULLS UP IN THE 'HELP' TAB
vignette("fivethirtyeight", package = "fivethirtyeight")


#PRODUCES A TABLE CALLED college_recent_grads WITH 173 OBSERVATIONS AND 21 VARIABLES
data(college_recent_grads, package = "fivethirtyeight")


#PRODUCES SEPERATE TABLE
View(college_recent_grads)

Recent_College_Grads<-data.frame(college_recent_grads)

#DIMENSIONS OF THE Recent_College_Grads DATAFRAME
dim(Recent_College_Grads) # ROW AND COLUMN COUNT
str(Recent_College_Grads) # DETAILED UNDERSTANDING OF DATAFRAME


# COUNT UNIQUE OCCURANCES
#https://www.miskatonic.org/2012/09/24/counting-and-aggregating-r/
Occurances <- unique(Recent_College_Grads$major_category)
Occurances
library(plyr)
#help(plyr)
#sub<-c(Recent_College_Grads$major_category, Recent_College_Grads$major_category)
#str(sub)
#OCCUR<-aggregate(Recent_College_Grads$major_category ~ Recent_College_Grads$major_category, data = sub, sum)
#OCCUR
class(Recent_College_Grads)
#GRAND TOTAL 
major_count<-count(Recent_College_Grads, "Recent_College_Grads$major_category")

#THIS COUNTS EACH CATEGORY COUNT
major_count<-count(Recent_College_Grads,major_category)




class(X)
x
X

# POLTS ###############################################################################################
# http://www.r-graph-gallery.com/portfolio/barplot
#######################################################################################################
