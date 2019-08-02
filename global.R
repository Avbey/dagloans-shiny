library(shiny)
library(shinydashboard)
library(DT)
library(plyr)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(lingtypology)
library(dendextend)
library(pvclust)
library(leaflet)
library(colourpicker)
library(rlang)
library(RSQLite)
library(DBI)
library(openssl)
library(devtools)
devtools::install_github('jbryer/DTedit')
library(DTedit)


# Authentication
DB_NAME <- "data.sqlite"
TBL_USER_DATA <- "users"

# These functions count the necessary distances
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

database <- words_meta %>% select(`Concept nr.`, Concept, Word, `Standardized Transcription`, 
                                  Set, Village, Language, Family, Group, District, `List ID`, 
                                  Birthyear, Gender)

#dummy_dataset <- read.csv("words01032019_dummy.tsv", sep = "\t", header = TRUE)

# df for lexical map
maplex_words <- words_meta[complete.cases(words_meta$Word),]
maplex_words <- maplex_words[complete.cases(maplex_words$Glottocode),]
maplex_words$StdTran <- sapply(strsplit(maplex_words$`Standardized Transcription`, ';'),  '[', 1)

#####################################################################################

d <- read.csv("data/convert/words_01042019_dummy.tsv", header = TRUE, sep = "\t", na.strings = "NA", row.names = NULL)
#head(d)
row.names(d) <- d[,1]
#d_long <- gather(d, Lexeme, Present, the_ant_1:the_year_12, factor_key=TRUE)
d$District <- as.character(d$District)
Districts <- d[,c(1:4)]
#d$District <- factor(d$District, levels = c("Tabasaran", "Khiv", "Rutul", "Tsakhur", "Tabasaran_Azeri", "Qax_Azeri"))
#head(as.data.frame(t(d)))
d <- d[,-c(1:4)]
d <- as.data.frame(t(d))

turkic=as.matrix(d)
turkic[is.na(turkic)] <- 0
turkic=as.data.frame(turkic)

d$Turk_total <- turkic$D_Azerbaijani+turkic$D_Kumyk+turkic$Darvag1+turkic$Darvag2+turkic$Darvag3+turkic$Darvag4+turkic$Darvag5+turkic$Darvag6+turkic$Ilisu1+turkic$Yersi1+turkic$Yersi2+turkic$Yersi3+turkic$Yersi4+turkic$Qax1+turkic$Qax2+turkic$Qax3+turkic$Qax7+turkic$Qax8+turkic$Qax9

d$AvarAndic_total <- turkic$D_Avar+turkic$D_Gagatli+turkic$Karata1+turkic$Karata2+turkic$Karata3+turkic$Karata4+turkic$Rikvani1+turkic$`Tad-Magitl1`+turkic$`Tad-Magitl2`+turkic$Tukita1+turkic$Zilo1+turkic$Zilo2+turkic$Tlibisho1+turkic$Tlibisho2+turkic$Tlibisho3+turkic$Tlibisho4+turkic$D_Bagvalal+turkic$Kusur1+turkic$Bezhta1+turkic$D_Bezhta1+turkic$D_Botlikh+turkic$D_Hinuq+turkic$D_Karata+turkic$D_Tsez+turkic$Kidero1+turkic$Kidero2+turkic$Kidero3+turkic$D_Bezhta2

d$Khlut_total <- turkic$Khlut1 + turkic$Khlut2 + turkic$Khlut3 + turkic$Khlut4 + turkic$Khlut5

#d <- as.data.frame(t(d))
#head(d)

#Preparing datasets for plotting
all_turkic <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA")),]))
all_turkic$Speaker <- rownames(all_turkic)
all_turkic <- left_join(Districts, all_turkic, by= c("Speaker"))
#head(all_turkic)

#all_turkic$District <- as.factor(all_turkic$District)
all_turkic <- all_turkic[all_turkic$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)
all_turkic <- gather(all_turkic,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)

################################################################################
##                Mediation of Total Turkic Influence                         ##
################################################################################

all_turkic_wide_total <- spread(all_turkic, Lexeme, Present)

# By Villages
all_turkic_wide_total_village <- ddply(all_turkic_wide_total, "Village", numcolwise(sum)) # sum all rows by Village
all_turkic_wide_total_village[is.na(all_turkic_wide_total_village)] <- 0 
all_turkic_wide_total_village[,-1] <- ifelse(all_turkic_wide_total_village[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
villages <- all_turkic_wide_total_village$Village
all_turkic_wide_total_village <- as.data.frame(t(all_turkic_wide_total_village[,-1]))
colnames(all_turkic_wide_total_village) <- villages

# By Languages
all_turkic_wide_total_language <- ddply(all_turkic_wide_total, "Language", numcolwise(sum)) # sum all rows by Language
all_turkic_wide_total_language[is.na(all_turkic_wide_total_language)] <- 0 
all_turkic_wide_total_language[,-1] <- ifelse(all_turkic_wide_total_language[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
languages <- all_turkic_wide_total_language$Language
all_turkic_wide_total_language <- as.data.frame(t(all_turkic_wide_total_language[,-1]))
colnames(all_turkic_wide_total_language) <- languages


################################################################################
##                Mediation of Standard Azerbaijani Influence                 ##
################################################################################

dict_turkic <-  as.data.frame(t(d[which(d$D_Azerbaijani>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA")),]))
dict_turkic$Speaker <- rownames(dict_turkic)
dict_turkic <- left_join(Districts, dict_turkic, by= c("Speaker"))

# By Villages
all_turkic_wide_az_village <- ddply(dict_turkic, "Village", numcolwise(sum)) # sum all rows by Village
all_turkic_wide_az_village[is.na(all_turkic_wide_az_village)] <- 0 
all_turkic_wide_az_village[,-1] <- ifelse(all_turkic_wide_az_village[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
villages <- all_turkic_wide_az_village$Village
all_turkic_wide_az_village <- as.data.frame(t(all_turkic_wide_az_village[,-1]))
colnames(all_turkic_wide_az_village) <- villages

# By Languages
all_turkic_wide_az_language <- ddply(dict_turkic, "Language", numcolwise(sum)) # sum all rows by Language
all_turkic_wide_az_language[is.na(all_turkic_wide_az_language)] <- 0 
all_turkic_wide_az_language[,-1] <- ifelse(all_turkic_wide_az_language[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
languages <- all_turkic_wide_az_language$Language
all_turkic_wide_az_language <- as.data.frame(t(all_turkic_wide_az_language[,-1]))
colnames(all_turkic_wide_az_language) <- languages

