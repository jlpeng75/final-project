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


# Task 2

Baltimore_NEI <- NEI %>%
    filter(fips=="24510") %>%
    group_by(year) %>%
    summarise(Emission_sum = sum(Emissions, na.rm = T)) %>%
    select(Emission_sum, year)
png("Plot2.png")
barplot(Baltimore_NEI$Emission_sum, names.arg = unique(Baltimore_NEI$year),
        xlab = "year", ylab = "Emission", main = "Total Emissions in Baltimore")
dev.off()
