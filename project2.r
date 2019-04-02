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

# Task 1

NEI_year <- NEI %>% 
    group_by(year) %>%
    summarise(Emission_sum = sum(Emissions, na.rm = T)) %>%
    select(Emission_sum, year)

Emission_sum <- NEI_year$Emission_sum
names(Emission_sum) <- NEI_year$year
png("Plot1.png")
barplot(Emission_sum, main = "Total Emissions Across US", ylab = "Emission", xlab = "year")
dev.off()

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

# Task 3

NEI_type <- NEI %>% 
    group_by(year, type) %>%
    summarize(Emission_sum = sum(Emissions, na.rm = T)) %>%
    select(Emission_sum, year, type)
png("Plot3.png")
g <- ggplot(NEI_type, aes(x = factor(year), y = Emission_sum, group = type, color = type))
g+ geom_line() + geom_point() + labs(title = "Total Emission by Polution Type", x ="year", y= "Total Emission")
dev.off()

# Task 4

SCC_Coal <- SCC %>%
    select(SCC, Short.Name) %>%
    filter(grepl("Coal", SCC.Level.Four))
NEI_Coal <- NEI %>%
    filter(SCC %in% SCC_Coal$SCC) %>%
    select(Emissions, year) %>%
    group_by(year) %>%
    summarise(Emission_sum = sum(Emissions, na.rm = T))


png("Plot4.png")
g <- ggplot(NEI_Coal, aes(x = factor(year), y = Emission_sum, fill = factor(year)))
g+ geom_bar(position = "dodge", stat = "identity") + scale_fill_discrete(name = "Year")+ labs(title = "Coal Combustion-related Emissions Across US", x ="Year", y= "Total Emission")
dev.off()

# Task 5, Emission from motor vechile sources in Baltimore City

SCC_vechile <- SCC %>%
    filter(grepl("Motor", Short.Name)) %>%
    select(SCC) 
    
NEI_vechile <- NEI %>%
    filter(SCC %in% SCC_vechile$SCC & fips == "24510") %>%
    select(Emissions, year) %>%
    group_by(year) %>%
    summarise(Emission_sum = sum(Emissions, na.rm = T))
    
png("Plot5.png")
g <- ggplot(NEI_vechile, aes(x = factor(year), y = Emission_sum, fill = factor(year)))
g+ geom_bar(position = "dodge", stat = "identity") + scale_fill_discrete(name = "Year")+ labs(title = "Motor Vechile-related Emissions in Baltimore", x ="Year", y= "Total Emission")
dev.off()


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