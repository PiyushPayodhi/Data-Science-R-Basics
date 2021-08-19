#installing the dslabs package.
install.packages("dslabs")

#loading the dslabs package into the R session.
library(dslabs)

#check all installed packages.
installed.packages()

#defining variables
a <- 1
b <- 2
c <- -1

#print a
a

#print all variables in work space.
ls()

#show function logic.
ls

#exponential of 1
exp(1)

#log of 2.718282
log(2.718282)

#nested function are computed from inside out.
log(exp(1))

#get help with functions
help(log)
?exp

#get help with function arguments
args(log)

#change base of log
log(8,base = 2)

#use arguments name
log(x = 8, base = 2)


#all available data sets in R
data()

co2
