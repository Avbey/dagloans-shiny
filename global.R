library(DT)
library(plyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(lingtypology)
library(dendextend)
library(pvclust)
library(UpSetR)
library(leaflet)
library(colourpicker)


#These functions count the necessary distances
div_count <- function(string1, string2){
  x <- unlist(string1, use.names = F)
  y <- unlist(string2, use.names = F)
  d <- data.frame(x, y)
  num <- sum(complete.cases(d))
  return(num)
}

# dissimilarity matrix -------------------------------------------------
dist_count <- function(data) {
  data2 <- data.frame()
  for (i in row.names(data)) {
    for (j in row.names(data)) {
      data2[i,j] = round(sum((data[i,]!=data[j,]), na.rm=TRUE)/div_count(data[i,],data[j,]), digits=2)
    }
  }
  return(data2)
}


# loading data - mind the date in the csv filename!
words <- read_tsv("data/words_standardized_01042019.tsv")

meta <- read_tsv("data/meta_01042019.tsv")


# select relevant parameters from metadata file

meta <- meta %>%  select(`List ID`, Type, Birthyear, Gender, Code, Language, Family, Group, Glottocode, Village, District, Lat, Lon)

# merge table with target words and the corresponding metadata

words_meta <- merge(words, meta, by = 'List ID')

words_meta$Set <- paste(words_meta$`Concept nr.`, "-", words_meta$Stem)

# select some variables for the datatable (= database interface)

database <- words_meta %>% select(`Concept nr.`, Concept, Word, `Standardized Transcription`, Set, Village, Language, Family, Group, District, `List ID`, Birthyear, Gender)

#dummy_dataset <- read.csv("words01032019_dummy.tsv", sep = "\t", header = TRUE)




