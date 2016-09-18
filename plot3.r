library(data.table)
library(ggplot2)
library(scales)

#Downloading and unzipping the archive
directory <- "Data"
if (!file.exists(directory)) {
  # Download the archive if it not exists
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  tmp_file <- "./temp.zip"
  download.file(url,tmp_file)
  # Unzip downloaded archive
  unzip(tmp_file, exdir="./Data")
  unlink(tmp_file)
}

# Loading datasets
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Subset data (Baltimore City, Maryland == fips)
MD <- subset(NEI,fips='24510')

# Generate the plot
png(filename='plot3.png')
g<-ggplot(MD,aes(year,Emissions,color=type))
g <- g + scale_y_continuous(labels = comma)
g <-g+geom_line(stat = "summary",fun.y="sum") + labs(y=expression(paste('Log', ' of PM'[2.5], ' Emissions')),x='Year') + ggtitle('Emissions in Baltimore City, MD')
print(g)
dev.off()
