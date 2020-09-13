library(readr)
library(stringr)
library(ggplot2)
library(ggimage)
library(here)
data <- read.csv("Attendee information - Introduction to RNA-seq.csv",sep=";")
names(data)[14] <- "event"
data$event <- str_replace(data$event,"posted on r-ladies slack workspace","Slack")
data$event <- str_replace(data$event,"Group R-ladies Tunis","Facebook")
data$event <- str_replace(data$event,"someone from work","A friend")


dt <- data.frame(img = list.files(here::here('icon_social_media'), full.names = TRUE),
                 media = as.data.frame(table(data$event))[,1],
                 freq= as.data.frame(table(data$event))[,2]
)

ggplot(dt, aes(x = reorder(media,-freq), y=freq, fill=media)) + geom_bar(stat = 'identity', fill = "#8856a7" ) +
  geom_image(y = -1, aes(image = img), by = "width",size = rep(0.035, 7))  +
  labs(x = "", y = "Number", title = 'How did you find out about our event ?') + 
  geom_text(aes(media, freq + 1, label = freq, fill = NULL), data = dt) +
  theme(plot.title = element_text(color="#003366", size=14)) +
  theme_bw()
