# UNIT 5 - LECTURE ASSIGNMENT
# 1) Download a data file from a website using one of the "direct from Internet" 
#   tools in R.
#
# Find the following (and give the code):
#   2)  Date of file download
#   3)  Dimensions of the file
#   4)  Variable names for the file
#   5)  Variable types for the variables in the file
#
# Put the code into a text document and upload below.

# REQUIREMENT 1 ##################################################################
URL<-"http://bit.ly/1jXJgDh"
temp<-tempfile()
download.file(URL,temp)
UDSData<-read.csv(gzfile(temp,"uds_summary.csv"))

# REQUIREMENT 2 ##################################################################
file.info(temp)
# REQUIREMENT 3 ##################################################################
dim(UDSData)
# REQUIREMENT 4 ##################################################################
colnames(UDSData)
# REQUIREMENT 5 ##################################################################
str(UDSData)
# CLOSE CONNECTION ###############################################################
unlink(temp)
