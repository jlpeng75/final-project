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


# Task 3

NEI_type <- NEI %>% 
    group_by(year, type) %>%
    summarize(Emission_sum = sum(Emissions, na.rm = T)) %>%
    select(Emission_sum, year, type)
png("Plot3.png")
g <- ggplot(NEI_type, aes(x = factor(year), y = Emission_sum, group = type, color = type))
g+ geom_line() + geom_point() + labs(title = "Total Emission by Polution Type", x ="year", y= "Total Emission")
dev.off()
