# installing the dslabs package
install.packages("dslabs")

# loading the dslabs package into the R session
library(dslabs)

#check all installed packages.
installed.packages()

install.packages("tidyverse")

library(dslabs)
library(tidyverse)
library(ggplot2)
data(murders)
murders %>%
  ggplot(aes(population, total, label = abb, color = region))+
  geom_label()
