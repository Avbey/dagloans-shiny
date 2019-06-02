all_turkic_wide <- spread(all_turkic, Lexeme, Present)
all_turkic_wide <- all_turkic_wide[all_turkic_wide$District %in% c("Rutul"),]
row.names(all_turkic_wide) <- all_turkic_wide$Speaker
all_turkic_wide <- all_turkic_wide[,-c(1:4)]
all_turkic_wide <- t(all_turkic_wide)
all_turkic_wide <- as.data.frame(all_turkic_wide)

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

all_turkic_lgs <- all_turkic_wide
all_turkic_lgs$Tsakhur <- all_turkic_wide$Mikik + all_turkic_wide$Helmets
all_turkic_lgs$Rutul <- all_turkic_wide$Rutul + all_turkic_wide$Kina + all_turkic_wide$Ikhrek + all_turkic_wide$Kiche
all_turkic_lgs$Lezgian <- all_turkic_wide$Khlut
all_turkic_lgs <- all_turkic_lgs[,-c(1:4,6,7)]
all_turkic_lgs <- ifelse(all_turkic_lgs > 0, 1, 0)
all_turkic_lgs <- as.data.frame(all_turkic_lgs)

ups2 <- renderPlot({
  upset(all_turkic_lgs, 
      order.by="degree", sets = colnames(all_turkic_lgs), matrix.color="blue", point.size=5)
})