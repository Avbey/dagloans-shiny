#dummy_dataset <- read.csv("words01032019_dummy.tsv", sep = "\t", header = TRUE)


# library(tidyverse)
# library(DT)
# library(lingtypology)
# library(leaflet)
# 
# # loading data - mind the date in the csv filename!
# words <- read_tsv("data/words_20022019.csv")
# meta <- read_tsv("data/meta_07022019.csv")
# 
# # select relevant parameters from metadata file
# meta <- meta %>%
#   select(`List ID`, Type, Code, Language, Glottocode, Village, District, Lat, Lon)
# 
# # merge table with target words and the corresponding metadata
# words_meta <- merge(words, meta, by = 'List ID')
# 
# words_meta$Set <- paste(words_meta$`Concept nr.`, "-", words_meta$Stem)
# 
# # select some variables for the datatable (= database interface)
# database <- words_meta %>%
#   select(`Concept nr.`, Concept, Word, Set, Village, Language, District, `List ID`)
# 
# dummy_dataset <- read.csv("data/words20022019_dummy.csv", sep = "\t", header = TRUE)
# row.names(dummy_dataset) <- paste(dummy_dataset[,1], dummy_dataset[,2], sep = "_")
# dummy_dataset <- dummy_dataset[ , -which(names(dummy_dataset) %in% c("Darvag7"))]
# dummy_dataset <- dummy_dataset[ , -c(1:2)]
# 
# 
# content <- words_meta %>%
#   group_by(`List ID`, Language, Word) %>%
#   summarise(Words = n())
# 
# languages <- length(unique(content$Language))
# target_words <- sum(content$Words)
# 
# all <- rbind(target_words, languages)
# 
# # Remove certain NA's for now
# 
# meta <- meta[complete.cases(meta$Glottocode),]
# 
# 
# # Separate dictionaries from speakers
# dict <- meta %>%
#   filter(meta$Type == 'Dictionary')
# 
# speakers <- meta %>%
#   filter(meta$Type == 'Speaker')
# 
# 
# # Create a dataframe that shows the number of lists per village
# lists <- speakers %>%
#   group_by(Village, Language, Glottocode, Lat, Lon) %>%
#   summarise(Lists = n())
# 
# 
# # Convert the column with counts to a factor
# lists$Lists <- as.factor(lists$Lists) #don't need this
# # Popup with genetic info on language + name of village
# popup.content = paste(aff.lang(lang.gltc(lists$Glottocode)),
#                       "<br>",
#                       "<b> Village: </b>",
#                       lists$Village)
# 
# 
# # ui definitions
# function(input, output, session) {
#   output$samplemap <- renderLeaflet({
#     leaflet() %>%
#       addProviderTiles(providers$Stamen.TonerLite,
#                        options = providerTileOptions(noWrap = TRUE)
#       ) %>%
#       addMarkers(
#         data = cbind(lists$Lon, lists$Lat),
#         popup = popup.content,
#         label = lists$Language
#         )
#   })
#   
#   output$summary <- renderPrint({
#     all
#   })
#   
#   output$table <- DT::renderDataTable({
#     DT::datatable(database, class = 'cell-border stripe', filter = 'top', options = list(pageLength = 100))
#   })
# }