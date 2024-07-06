library(rvest)

# URL of the webpage to scrape
url <- 'https://www.imdb.com/chart/top/'

# Read the webpage content
webpage <- read_html(url)

# Identify the CSS selector that contains the rank numbers
rank_data_html <- html_nodes(webpage, '.ipc-title--title .ipc-title__text')

# Convert the ranking data to text
rank_data <- html_text(rank_data_html)

rank_data <- sub("\\..*", "", rank_data)
rank_data

rank_data <- gsub("[^0-9]", "", rank_data)
rank_data

rank_data <- rank_data[rank_data != "" & rank_data != "250"]
rank_data



rank_data

# Convert to numeric
rank_data <- as.numeric(rank_data)

# Display the first few ranks
head(rank_data)
rank_data


#Using the css selector to scrap the title section 
title_data_html <-html_nodes(webpage,'.ipc-title--title .ipc-title__text')
title_data_html <-html_text(title_data_html)
title_data_html <- sub(".*\\.\\s*", "", title_data_html)
title_data_html <- title_data_html[title_data_html!="IMDb Charts" & title_data_html!="IMDb Top 250 Movies"]
title_data_html
tail(title_data_html)

#using the css selectors to scrape the rating

rating_data <-html_nodes(webpage, '.ipc-rating-star--base')
rating_data <- html_text(rating_data)
rating_data
#string <- "9.3 (2.9M)"
rating_data <- sub("\\s.*", "", rating_data)
rating_data

# First, install and load the stringr package if you haven't already
install.packages("stringr")
library(stringr)

#string <- "9.3 (2.9M)"
rating_data <- str_extract(rating_data, "^[0-9]+\\.[0-9]+")
rating_data

rating_data <-rating_data[!is.na(rating_data)]
rating_data <-as.numeric(rating_data)
rating_data


#Using css selector to scrape the movie runtime section 

runtime_data <-html_nodes(webpage,'.kLaxqf')
runtime_data <- html_text(runtime_data)
runtime_data <- runtime_data[seq(2, length(runtime_data),by = 3)]
runtime_data

year_data <- html_nodes(webpage,'.kLaxqf')
year_data <-html_text(year_data)
year_data <- year_data[seq(1,length(year_data), by =3)]
year_data



library(ggplot2)
movie_df <- data.frame(Runtime=runtime_data, Year=year_data)
movie_df
library(ggplot2)
qplot(data = movie_df, rating_data, fiT1 =year_data, bins= 30)
movie_rating <- data.frame(Rating = rating_data)
movie_rating
qplot(data = movie_rating, bins= 30)
