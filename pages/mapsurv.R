# Remove certain NA's for now

meta <- meta[complete.cases(meta$Glottocode),]


# Separate dictionaries from speakers

dict <- meta %>%
  filter(meta$Type == 'Dictionary')

speakers <- meta %>%
  filter(meta$Type == 'Speaker')


# Create a dataframe that shows the number of lists per village

lists <- speakers %>%
  group_by(Village, Language, Glottocode, Lat, Lon) %>%
  summarise(Lists = n())


# Convert the column with counts to a factor

lists$Lists <- as.factor(lists$Lists)


# Draw a map that shows each village and the number of lists collected

mapSurv <- map.feature(lang.gltc(lists$Glottocode),
            feature = lists$Lists,
            color = "magma",
            latitude = lists$Lat,
            longitude = lists$Lon,
            zoom.control = TRUE,
            legend = TRUE,
            title = "Lists",
            width = 7,
            label = lists$Language,
            popup = paste(aff.lang(lang.gltc(lists$Glottocode)), # Popup with genetic info on language + name of village
                          "<br>",
                          "<br>",
                          "<b> Village: </b>",
                          lists$Village),
            zoom.level = 7.5,) %>% # Put another map on top of it, showing dictionary data
  map.feature(lang.gltc(dict$Glottocode),
              latitude = dict$Lat,
              longitude = dict$Lon,
              feature = dict$Language,
              label = dict$Language,
              popup = paste(aff.lang(lang.gltc(dict$Glottocode)),
                            "<br>",
                            "<br>",
                            "<b>Source:</b>",
                            "[Insert reference to literature here]"),
              legend = FALSE,
              color = c("orange"),
              tile = c("Esri.WorldGrayCanvas"),
              pipe.data = .)

mapSurvPage <- fluidPage(fluidRow(column(
  12,
  p("Hover over and / or click on a dot on the map to know more. The color of the dots corresponds to the ",
    tags$b("number"), " of lists collected in a village. Orange = dictionary data."
    
  ),
 div(renderLeaflet(mapSurv))
)))