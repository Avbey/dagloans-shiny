library(tidyverse)
library(DT)
library(lingtypology)
library(webshot)

options(max.print="75")
opts_chunk$set(echo=FALSE,
               cache=TRUE,
               prompt=FALSE,
               tidy=TRUE,
               comment=NA,
               message=FALSE,
               warning=FALSE)
opts_knit$set(width=75)
knitr::opts_knit$set(global.device = TRUE)

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


