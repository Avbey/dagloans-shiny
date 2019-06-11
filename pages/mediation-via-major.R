all_turkic_in_both_Lezgi <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian == 1  & d$Khlut_total > 0),]))
all_turkic_not_in_Lezgi_but_in_Khlut <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian  %in% c(0,NA,"NA") & d$Khlut_total > 0),]))
all_turkic_in_Lezgi_but_not_in_Khlut <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian == 1 & d$Khlut_total == 0),]))
all_turkic_not_in_Lezgi_and_not_in_Khlut <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian  %in% c(0,NA,"NA") & d$Khlut_total == 0),]))



all_turkic_in_both_Lezgi$Speaker <- rownames(all_turkic_in_both_Lezgi)
all_turkic_in_both_Lezgi <- left_join(Districts, all_turkic_in_both_Lezgi, by= c("Speaker"))

all_turkic_not_in_Lezgi_but_in_Khlut$Speaker <- rownames(all_turkic_not_in_Lezgi_but_in_Khlut)
all_turkic_not_in_Lezgi_but_in_Khlut <- left_join(Districts, all_turkic_not_in_Lezgi_but_in_Khlut, by= c("Speaker"))

all_turkic_in_Lezgi_but_not_in_Khlut$Speaker <- rownames(all_turkic_in_Lezgi_but_not_in_Khlut)
all_turkic_in_Lezgi_but_not_in_Khlut <- left_join(Districts, all_turkic_in_Lezgi_but_not_in_Khlut, by= c("Speaker"))

all_turkic_not_in_Lezgi_and_not_in_Khlut$Speaker <- rownames(all_turkic_not_in_Lezgi_and_not_in_Khlut)
all_turkic_not_in_Lezgi_and_not_in_Khlut <- left_join(Districts, all_turkic_not_in_Lezgi_and_not_in_Khlut, by= c("Speaker"))



#all_turkic$District <- as.factor(all_turkic$District)
#all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)
all_turkic_in_both_Lezgi <- gather(all_turkic_in_both_Lezgi,Lexeme,Present, the_beak_22:the_wolf_2,factor_key=TRUE)

all_turkic_not_in_Lezgi_but_in_Khlut <- gather(all_turkic_not_in_Lezgi_but_in_Khlut,Lexeme,Present, the_cattle_22:the_wine_3,factor_key=TRUE)

all_turkic_in_Lezgi_but_not_in_Khlut <- gather(all_turkic_in_Lezgi_but_not_in_Khlut,Lexeme,Present, the_blister_8:the_slave_1,factor_key=TRUE)

all_turkic_not_in_Lezgi_and_not_in_Khlut <- 
  gather(all_turkic_not_in_Lezgi_and_not_in_Khlut,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)

all_turkic_in_both_Lezgi$InLezgi <- rep("1",nrow(all_turkic_in_both_Lezgi))
all_turkic_not_in_Lezgi_but_in_Khlut$InLezgi <- rep("2",nrow(all_turkic_not_in_Lezgi_but_in_Khlut))
all_turkic_in_Lezgi_but_not_in_Khlut$InLezgi <- rep("3",nrow(all_turkic_in_Lezgi_but_not_in_Khlut))
all_turkic_not_in_Lezgi_and_not_in_Khlut$InLezgi <- rep("4",nrow(all_turkic_not_in_Lezgi_and_not_in_Khlut))

all_turkic_lezgi_mediation <- rbind(all_turkic_in_both_Lezgi, all_turkic_not_in_Lezgi_but_in_Khlut, all_turkic_in_Lezgi_but_not_in_Khlut, all_turkic_not_in_Lezgi_and_not_in_Khlut)

all_turkic_lezgi_mediation <- all_turkic_lezgi_mediation[,-1]
all_turkic_lezgi_mediation <- distinct(all_turkic_lezgi_mediation)
all_turkic_lezgi_mediation_counts <- aggregate(all_turkic_lezgi_mediation$Present, by=list(all_turkic_lezgi_mediation$Village, all_turkic_lezgi_mediation$InLezgi), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(all_turkic_lezgi_mediation_counts)
colnames(all_turkic_lezgi_mediation_counts) <- c("Village","InLezgi","Loans")
all_turkic_lezgi_mediation_counts <- left_join(all_turkic_lezgi_mediation_counts, Districts, by= c("Village"))
all_turkic_lezgi_mediation_counts$Village <- droplevels(all_turkic_lezgi_mediation_counts$Village)
all_turkic_lezgi_mediation_counts$District <- factor(all_turkic_lezgi_mediation_counts$District, levels(all_turkic_lezgi_mediation$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_lezgi_mediation_counts <- all_turkic_lezgi_mediation_counts[-c(1:6),]
all_turkic_lezgi_mediation_counts$Loans <- as.numeric(all_turkic_lezgi_mediation_counts$Loans)

all_turkic_lezgi_mediation_counts <- all_turkic_lezgi_mediation_counts[all_turkic_lezgi_mediation_counts$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
#all_turkic_lezgi_mediation_counts <- all_turkic_lezgi_mediation_counts[-which(all_turkic_lezgi_mediation_counts$Village == "Khlyut"),]
all_turkic_lezgi_mediation_counts$District <- factor(all_turkic_lezgi_mediation_counts$District, levels(all_turkic_lezgi_mediation_counts$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
all_turkic_lezgi_mediation_counts$Village <- factor(all_turkic_lezgi_mediation_counts$Village)

all_turkic_lezgi_mediation_counts <- all_turkic_lezgi_mediation_counts[,-4]
all_turkic_lezgi_mediation_counts <- distinct(all_turkic_lezgi_mediation_counts)
Area <- factor(all_turkic_lezgi_mediation_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
all_turkic_lezgi_mediation_counts <- group_by(all_turkic_lezgi_mediation_counts, Village) %>% mutate(Percent = Loans/sum(Loans)*100)
#all_turkic_lezgi_mediation_counts <- #all_turkic_lezgi_mediation_counts[-which(all_turkic_lezgi_mediation_counts$Village == "Khlyut"),]

p1 <- renderPlotly({ ggplot(data = all_turkic_lezgi_mediation_counts, aes(x = InLezgi, y = Percent)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Lezgian Mediation of Turkic Influence", x = "", y = "% of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(District, levels = c("Rutul", "Tsunta", "Botlikh", "Akhvakh")), nrow = 1)+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Khlut and Std. Lezgian", "In Khlut but not in Lezgian", "In Lezgian but not in Khlut", "Not in Khlut and not in Std. Lezgian"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
})

p_mediation_1 <- renderPlotly({ ggplot(data = all_turkic_lezgi_mediation_counts[which(all_turkic_lezgi_mediation_counts$District == "Rutul"),], aes(x = InLezgi, y = Percent, label1 = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Lezgian Mediation of Turkic Influence in the Rutul District", x = "", y = "% of Loanwords")+
  theme_bw()+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Khlut and Std. Lezgian", "In Khlut but not in Lezgian", "In Lezgian but not in Khlut", "Not in Khlut and not in Std. Lezgian"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30), plot.title = element_text(size=10), axis.text=element_text(size=6))+
  ylim(-5,105)
})

all_turkic_in_avar_and_in_chechen <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar == 1 & d$D_Chechen == 1),]))

all_turkic_not_in_avar_and_in_chechen <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar  %in% c(0,NA,"NA") & d$D_Chechen == 1),]))

all_turkic_in_avar_and_not_in_chechen <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar == 1 & d$D_Chechen  %in% c(0,NA,"NA")),]))

all_turkic_not_in_avar_and_not_in_chechen <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar  %in% c(0,NA,"NA") & d$D_Chechen  %in% c(0,NA,"NA")),]))



all_turkic_in_avar_and_in_chechen$Speaker <- rownames(all_turkic_in_avar_and_in_chechen)
all_turkic_in_avar_and_in_chechen <- left_join(Districts, all_turkic_in_avar_and_in_chechen, by= c("Speaker"))

all_turkic_not_in_avar_and_in_chechen$Speaker <- rownames(all_turkic_not_in_avar_and_in_chechen)
all_turkic_not_in_avar_and_in_chechen <- left_join(Districts, all_turkic_not_in_avar_and_in_chechen, by= c("Speaker"))

all_turkic_in_avar_and_not_in_chechen$Speaker <- rownames(all_turkic_in_avar_and_not_in_chechen)
all_turkic_in_avar_and_not_in_chechen <- left_join(Districts, all_turkic_in_avar_and_not_in_chechen, by= c("Speaker"))

all_turkic_not_in_avar_and_not_in_chechen$Speaker <- rownames(all_turkic_not_in_avar_and_not_in_chechen)
all_turkic_not_in_avar_and_not_in_chechen <- left_join(Districts, all_turkic_not_in_avar_and_not_in_chechen, by= c("Speaker"))



#all_turkic$District <- as.factor(all_turkic$District)
#all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)
all_turkic_in_avar_and_in_chechen <- gather(all_turkic_in_avar_and_in_chechen,Lexeme,Present, the_bottle_5:the_wine_3,factor_key=TRUE)

all_turkic_not_in_avar_and_in_chechen <- gather(all_turkic_not_in_avar_and_in_chechen,Lexeme,Present, the_beeswax_9:the_voice_8,factor_key=TRUE)
#head(all_turkic_not_in_avar_and_in_chechen)

all_turkic_in_avar_and_not_in_chechen <- gather(all_turkic_in_avar_and_not_in_chechen,Lexeme,Present, the_belt_15:the_worm_31,factor_key=TRUE)

all_turkic_not_in_avar_and_not_in_chechen <- 
  gather(all_turkic_not_in_avar_and_not_in_chechen,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)


all_turkic_in_avar_and_in_chechen$InAC <- rep("1",nrow(all_turkic_in_avar_and_in_chechen))
all_turkic_not_in_avar_and_in_chechen$InAC <- rep("2",nrow(all_turkic_not_in_avar_and_in_chechen))
all_turkic_in_avar_and_not_in_chechen$InAC <- rep("3",nrow(all_turkic_in_avar_and_not_in_chechen))
all_turkic_not_in_avar_and_not_in_chechen$InAC <- rep("4",nrow(all_turkic_not_in_avar_and_not_in_chechen))

all_turkic_AC_mediation <- rbind(all_turkic_in_avar_and_in_chechen, all_turkic_not_in_avar_and_in_chechen, all_turkic_in_avar_and_not_in_chechen, all_turkic_not_in_avar_and_not_in_chechen)

all_turkic_AC_mediation <- all_turkic_AC_mediation[,-1]
all_turkic_AC_mediation <- distinct(all_turkic_AC_mediation)
all_turkic_AC_mediation_counts <- aggregate(all_turkic_AC_mediation$Present, by=list(all_turkic_AC_mediation$Village, all_turkic_AC_mediation$InAC), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(all_turkic_AC_mediation_counts)
colnames(all_turkic_AC_mediation_counts) <- c("Village","InAC","Loans")
all_turkic_AC_mediation_counts <- left_join(all_turkic_AC_mediation_counts, Districts, by= c("Village"))
all_turkic_AC_mediation_counts$Village <- droplevels(all_turkic_AC_mediation_counts$Village)
all_turkic_AC_mediation_counts$District <- factor(all_turkic_AC_mediation_counts$District, levels(all_turkic_AC_mediation$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_AC_mediation_counts <- all_turkic_AC_mediation_counts[-c(1:6),]
all_turkic_AC_mediation_counts$Loans <- as.numeric(all_turkic_AC_mediation_counts$Loans)

all_turkic_AC_mediation_counts <- all_turkic_AC_mediation_counts[all_turkic_AC_mediation_counts$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
#all_turkic_AC_mediation_counts <- all_turkic_AC_mediation_counts[-which(all_turkic_AC_mediation_counts$Village == "Khlyut"),]
all_turkic_AC_mediation_counts$District <- factor(all_turkic_AC_mediation_counts$District, levels(all_turkic_AC_mediation_counts$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
all_turkic_AC_mediation_counts$Village <- factor(all_turkic_AC_mediation_counts$Village)

all_turkic_AC_mediation_counts <- all_turkic_AC_mediation_counts[,-4]
all_turkic_AC_mediation_counts <- distinct(all_turkic_AC_mediation_counts)
Area <- factor(all_turkic_AC_mediation_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
all_turkic_AC_mediation_counts <- group_by(all_turkic_AC_mediation_counts, Village) %>% mutate(Percent = Loans/sum(Loans)*100)

p2 <- renderPlotly({ ggplot(data = all_turkic_AC_mediation_counts, aes(x = InAC, y = Percent)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Avar and Chechen  Mediation of Turkic Influence", x = "", y = "% of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(District, levels = c("Rutul", "Tsunta", "Botlikh", "Akhvakh")), nrow = 1)+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Avar and Chechen", "In Chechen but not in Avar", "In Avar but not in Chechen", "Not in Avar and not in Chechen"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
})

p_mediation_2 <- renderPlotly({ ggplot(data = all_turkic_AC_mediation_counts[which(all_turkic_AC_mediation_counts$District == "Botlikh"),], aes(x = InAC, y = Percent, label1 = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Avar and Chechen Mediation of Turkic Influence in the Botlikh District", x = "", y = "% of Loanwords")+
  theme_bw()+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Avar and Chechen", "In Chechen but not in Avar", "In Avar but not in Chechen", "Not in Avar and not in Chechen"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30), plot.title = element_text(size=10), axis.text=element_text(size=6))+
  ylim(-5,105)
})

all_turkic_in_avar_and_in_georgian <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar == 1 & d$D_Georgian == 1),]))

all_turkic_not_in_avar_and_in_georgian <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar  %in% c(0,NA,"NA") & d$D_Georgian == 1),]))

all_turkic_in_avar_and_not_in_georgian <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar == 1 & d$D_Georgian %in% c(0,NA,"NA")),]))

all_turkic_not_in_avar_and_not_in_georgian <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar  %in% c(0,NA,"NA") & d$D_Georgian  %in% c(0,NA,"NA")),]))



all_turkic_in_avar_and_in_georgian$Speaker <- rownames(all_turkic_in_avar_and_in_georgian)
all_turkic_in_avar_and_in_georgian <- left_join(Districts, all_turkic_in_avar_and_in_georgian, by= c("Speaker"))

all_turkic_not_in_avar_and_in_georgian$Speaker <- rownames(all_turkic_not_in_avar_and_in_georgian)
all_turkic_not_in_avar_and_in_georgian <- left_join(Districts, all_turkic_not_in_avar_and_in_georgian, by= c("Speaker"))

all_turkic_in_avar_and_not_in_georgian$Speaker <- rownames(all_turkic_in_avar_and_not_in_georgian)
all_turkic_in_avar_and_not_in_georgian <- left_join(Districts, all_turkic_in_avar_and_not_in_georgian, by= c("Speaker"))

all_turkic_not_in_avar_and_not_in_georgian$Speaker <- rownames(all_turkic_not_in_avar_and_not_in_georgian)
all_turkic_not_in_avar_and_not_in_georgian <- left_join(Districts, all_turkic_not_in_avar_and_not_in_georgian, by= c("Speaker"))



#all_turkic$District <- as.factor(all_turkic$District)
#all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)

all_turkic_not_in_avar_and_in_georgian <- gather(all_turkic_not_in_avar_and_in_georgian,Lexeme,Present, the_frog_2:the_thread_1,factor_key=TRUE)

all_turkic_in_avar_and_not_in_georgian <- gather(all_turkic_in_avar_and_not_in_georgian,Lexeme,Present, the_belt_15:the_worm_31,factor_key=TRUE)

all_turkic_not_in_avar_and_not_in_georgian <- 
  gather(all_turkic_not_in_avar_and_not_in_georgian,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)


#all_turkic_in_avar_and_in_georgian$InAG <- rep("1",nrow(all_turkic_in_avar_and_in_georgian))
all_turkic_not_in_avar_and_in_georgian$InAG <- rep("2",nrow(all_turkic_not_in_avar_and_in_georgian))
all_turkic_in_avar_and_not_in_georgian$InAG <- rep("3",nrow(all_turkic_in_avar_and_not_in_georgian))
all_turkic_not_in_avar_and_not_in_georgian$InAG <- rep("4",nrow(all_turkic_not_in_avar_and_not_in_georgian))

all_turkic_AG_mediation <- rbind(all_turkic_not_in_avar_and_in_georgian, all_turkic_in_avar_and_not_in_georgian, all_turkic_not_in_avar_and_not_in_georgian)

all_turkic_AG_mediation <- all_turkic_AG_mediation[,-1]
all_turkic_AG_mediation <- distinct(all_turkic_AG_mediation)
all_turkic_AG_mediation_counts <- aggregate(all_turkic_AG_mediation$Present, by=list(all_turkic_AG_mediation$Village, all_turkic_AG_mediation$InAG), FUN=sum, na.rm=TRUE, na.AGtion=NULL)
#head(all_turkic_AG_mediation_counts)
colnames(all_turkic_AG_mediation_counts) <- c("Village","InAG","Loans")
all_turkic_AG_mediation_counts <- left_join(all_turkic_AG_mediation_counts, Districts, by= c("Village"))
all_turkic_AG_mediation_counts$Village <- droplevels(all_turkic_AG_mediation_counts$Village)
all_turkic_AG_mediation_counts$District <- factor(all_turkic_AG_mediation_counts$District, levels(all_turkic_AG_mediation$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_AG_mediation_counts <- all_turkic_AG_mediation_counts[-c(1:6),]
all_turkic_AG_mediation_counts$Loans <- as.numeric(all_turkic_AG_mediation_counts$Loans)

all_turkic_AG_mediation_counts <- all_turkic_AG_mediation_counts[all_turkic_AG_mediation_counts$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
#all_turkic_AG_mediation_counts <- all_turkic_AG_mediation_counts[-which(all_turkic_AG_mediation_counts$Village == "Khlyut"),]
all_turkic_AG_mediation_counts$District <- factor(all_turkic_AG_mediation_counts$District, levels(all_turkic_AG_mediation_counts$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
all_turkic_AG_mediation_counts$Village <- factor(all_turkic_AG_mediation_counts$Village)

all_turkic_AG_mediation_counts <- all_turkic_AG_mediation_counts[,-4]
all_turkic_AG_mediation_counts <- distinct(all_turkic_AG_mediation_counts)
Area <- factor(all_turkic_AG_mediation_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
all_turkic_AG_mediation_counts <- group_by(all_turkic_AG_mediation_counts, Village) %>% mutate(Percent = Loans/sum(Loans)*100)
all_turkic_AG_mediation_counts <- all_turkic_AG_mediation_counts[-which(all_turkic_AG_mediation_counts$Village == "Khlyut"),]


p3 <- renderPlotly({ ggplot(data = all_turkic_AG_mediation_counts, aes(x = InAG, y = Percent)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Avar and Georgian Mediation of Turkic Influence", x = "", y = "% of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(District, levels = c("Rutul", "Tsunta", "Botlikh", "Akhvakh")), nrow = 1)+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Avar and Georgian", "In Georgian but not in Avar", "In Avar but not in Georgian",  "Not in Avar and not in Georgian"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
})

dat <- all_turkic_AG_mediation_counts[which(all_turkic_AG_mediation_counts$District == "Tsunta"),]


dat <- rbind(dat[c(1:2),], dat)
dat[1,2] <- 1
dat[2,2] <- 1
p_mediation_3 <- renderPlotly({  ggplot(data = dat, aes(x = InAG, y = Percent, label1 = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Avar and Georgian Mediation of Turkic Influence in the Tsunta District", x = "", y = "% of Loanwords")+
  theme_bw()+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("In Both Georgian and Avar", "In Georgian but not in Avar", "In Avar but not in Georgian", "Not in Avar and not in Georgian"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30), plot.title = element_text(size=10), axis.text=element_text(size=6))+
  ylim(-5,105)
})

####################################

mediationAzerMajorPage <- fluidPage(fluidRow(column(
  12,
  p("The first two plots (the first set) presented here in the show how lexical influence from Turkic is mediated by the Lezgian 
    and the Khlut (Akhty) dialect of Lezgian across Daghestan. The data presented here are mostly relevant for the Rutul region, 
    but are still comparable across Daghestan. The data are split by districts on X axis. 
    Y axis shows the percentage of the loans found in the elicited samples. Dots represent elicitations (color shows the village, too), 
    with a horizontal line showing the median value per district. 
    The plot indicates that Avar mediation may be high in the north but not present in the south, 
    while Lezgian mediation in not probable in both regions."),
  p("The second set of plots represent the same data for the Chechen and Avar mediation. These data are relevant for the Botlikh region, 
    but are still comparable across Daghestan."),
  p("The third set of plots represent the same data for the Georgian and Avar mediation. These data are relevant for the Tsunta region, but are still comparable across Daghestan."),
  p("The last plot set is a combination of the first three made for convenience."),
  div(p1), div(p2), div(p3), 
  div(class = "myclass", 
      tags$div(p_mediation_1),
      tags$div(p_mediation_2),
      tags$div(p_mediation_3)
      )
)))
