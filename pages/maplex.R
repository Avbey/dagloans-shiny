pepper <- words_meta[(words_meta$Concept == 'the pepper'),]

pepper <- pepper[complete.cases(pepper$Word),]
pepper <- pepper[complete.cases(pepper$Glottocode),]

mapLex <- map.feature(lang.gltc(pepper$Glottocode),
            latitude = pepper$Lat,
            longitude = pepper$Lon,
            features = pepper$Set,
            zoom.control = T,
            zoom.level = 7.5,
            label = pepper$Language,
            popup = pepper$Word)

mapLexPage <- fluidPage(fluidRow(column(
  12,
  p("The map below shows the distribution of different stems for the concept 'pepper'."),
  div(renderLeaflet(mapLex))
)))