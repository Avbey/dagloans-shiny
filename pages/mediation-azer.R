dict_turkic <-  as.data.frame(t(d[which(d$D_Azerbaijani>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA")),]))
dict_turkic$Speaker <- rownames(dict_turkic)
dict_turkic <- left_join(Districts, dict_turkic, by= c("Speaker"))
#head(all_turkic)

#all_turkic$District <- as.factor(all_turkic$District)
dict_turkic <- dict_turkic[dict_turkic$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
dict_turkic$District <- factor(dict_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))

all_turkic_wide <- dict_turkic
all_turkic_wide <- all_turkic_wide[all_turkic_wide$District %in% c("Rutul"),]
row.names(all_turkic_wide) <- all_turkic_wide$Speaker
all_turkic_wide <- all_turkic_wide[,-c(1:4)]
all_turkic_wide <- t(all_turkic_wide)
all_turkic_wide <- as.data.frame(all_turkic_wide)
#all_turkic_wide$Lexeme <- row.names(all_turkic_wide)

turkic=as.matrix(all_turkic_wide)
turkic[is.na(turkic)] <- 0
turkic=as.data.frame(turkic)


all_turkic_wide$Mikik <- turkic$Mikik1 + turkic$Mikik2
all_turkic_wide$Helmets <- turkic$Helmets1 + turkic$Helmets2 + turkic$Helmets3
all_turkic_wide$Kina <- turkic$Kina1 + turkic$Kina2 + turkic$Kina3
all_turkic_wide$Ikhrek <- turkic$Ikhrek1 + turkic$Ikhrek2 + turkic$Ikhrek3 + turkic$Ikhrek4
all_turkic_wide$Rutul <- turkic$Rutul1
all_turkic_wide$Kiche <- turkic$Kiche1 + turkic$Kiche2
all_turkic_wide$Khlut <- turkic$Khlut1 + turkic$Khlut2 + turkic$Khlut3 + turkic$Khlut4 + turkic$Khlut5
all_turkic_wide <- all_turkic_wide[,-c(1:21)]
all_turkic_wide <- ifelse(all_turkic_wide > 0, 1, 0)
all_turkic_wide <- as.data.frame(all_turkic_wide)

ups2 <- renderPlot({
upset(all_turkic_wide, 
      order.by="degree", sets = colnames(all_turkic_wide), matrix.color="blue", point.size=5)
})
  
all_turkic_lgs <- all_turkic_wide
all_turkic_lgs$Tsakhur <- all_turkic_wide$Mikik + all_turkic_wide$Helmets
all_turkic_lgs$Rutul <- all_turkic_wide$Rutul + all_turkic_wide$Kina + all_turkic_wide$Ikhrek + all_turkic_wide$Kiche
all_turkic_lgs$Lezgian <- all_turkic_wide$Khlut
all_turkic_lgs <- all_turkic_lgs[,-c(1:4,6,7)]
all_turkic_lgs <- ifelse(all_turkic_lgs > 0, 1, 0)
all_turkic_lgs <- as.data.frame(all_turkic_lgs)

ups3 <- renderPlot({
upset(all_turkic_lgs, 
      order.by="degree", sets = colnames(all_turkic_lgs), matrix.color="blue", point.size=5)
})

mediationAzerPage <- fluidPage(fluidRow(column(
  12,
  p("The plot presented here illustrates the intersections between the sets of loans from 
    Standard Azerbaijani between villages (plot 1) and regions (plot 2)."),
  div(ups2), div(ups3)
)))