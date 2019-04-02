# Exploratory Data Analysis - Course Project 2

library(dplyr); library(ggplot2); 

setwd("C:/Users/jpeng11/coursera/Exploratory Data Analysis/final project")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "EmissionData.zip", mode = "wb")

master <- as.character(unzip("EmissionData.zip", list = T)$Name)
length(master); master
unzip("EmissionData.zip")

SCC <- readRDS(master[1])
NEI <- readRDS(master[2])

str(NEI); str(SCC)
summary(NEI); summary(SCC)
head(NEI); head(SCC)



png("Plot5.png")
g <- ggplot(NEI_vechile, aes(x = factor(year), y = Emission_sum, fill = factor(year)))
g+ geom_bar(position = "dodge", stat = "identity") + scale_fill_discrete(name = "Year")+ labs(title = "Motor Vechile-related Emissions in Baltimore", x ="Year", y= "Total Emission")
dev.off()