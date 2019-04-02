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


# Task 6, comparison of Emission from motor vechile sources in Baltimore and Los Angles City

SCC_vechile <- SCC %>%
    filter(grepl("Motor", Short.Name)) %>%
    select(SCC) 

NEI_vechile <- NEI %>%
    filter(SCC %in% SCC_vechile$SCC & fips %in% c("24510", "06037")) %>%
    select(Emissions, year, fips) %>%
    group_by(year, fips) %>%
    summarise(Emission_sum = sum(Emissions, na.rm = T))
png("Plot6.png")
g <- ggplot(NEI_vechile, aes(x = factor(year), y = Emission_sum, group = factor(fips), color = factor(fips)))
g+ geom_line() + geom_point() + labs(title = "Motor Vechile-related Emissions", x ="Year", y= "Total Emission") +
    scale_color_discrete(name = "City", breaks = c("06037", "24510"), labels = c("Los Angeles", "Baltimore"))
dev.off()