library(readr)
library(ggplot2)
library(ggimage)
library(here)
data <- read.csv("https://raw.githubusercontent.com/rladiestunis/R4Bioinfo-series-workshop-Introduction-to-RNA-seq/master/dist/data.csv", sep = ",")
names(data)[9] <- "Country"
dt <- data.frame(img = list.files(here::here('Flags'), full.names = TRUE),
                 country = as.data.frame(table(data$Country))[,1],
                 freq= as.data.frame(table(data$Country))[,2]
)
ggplot(dt, aes(x=reorder(country,-freq), y=freq)) +
  theme(axis.text.x=element_text(angle=80,vjust = 1, hjust=1,size=12)) +
  geom_bar(stat='identity',fill = "#8856a7") +
  geom_image(y = -1, aes(image = img), by = "width",size = rep(0.035, 28)) + 
  labs(x = "", y="Number", title = 'Where are you from?') + 
  geom_text(aes(country, freq + 1, label = freq, fill = NULL), data = dt) +
  theme(text = element_text(color="#2b8cbe", size=14)) +
  theme_bw()
