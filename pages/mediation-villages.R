all_turkic_in_Lezgi <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian == 1),]))
all_turkic_not_in_Lezgi <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Lezgian  %in% c(0,NA,"NA")),]))

all_turkic_in_Lezgi$Speaker <- rownames(all_turkic_in_Lezgi)
all_turkic_in_Lezgi <- left_join(Districts, all_turkic_in_Lezgi, by= c("Speaker"))
#head(all_turkic)
all_turkic_not_in_Lezgi$Speaker <- rownames(all_turkic_not_in_Lezgi)
all_turkic_not_in_Lezgi <- left_join(Districts, all_turkic_not_in_Lezgi, by= c("Speaker"))
#all_turkic$District <- as.factor(all_turkic$District)
#all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)
all_turkic_in_Lezgi <- gather(all_turkic_in_Lezgi,Lexeme,Present, the_beak_22:the_wolf_2,factor_key=TRUE)
all_turkic_not_in_Lezgi <- gather(all_turkic_not_in_Lezgi,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)
all_turkic_in_Lezgi$InLezgi <- rep("1",nrow(all_turkic_in_Lezgi))
all_turkic_not_in_Lezgi$InLezgi <- rep("0",nrow(all_turkic_not_in_Lezgi))
all_turkic_lezgi_mediation <- rbind(all_turkic_in_Lezgi, all_turkic_not_in_Lezgi)

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

p2 <- renderPlotly({ 
  ggplot(data = all_turkic_lezgi_mediation_counts, aes(x = InLezgi, y = Percent, label1 = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Fig. 3. Lezgian Mediation of Turkic Influence", x = "", y = "% of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(District, levels = c("Rutul", "Tsunta", "Botlikh", "Akhvakh")), nrow = 1)+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("Not in Lezgian", "In Lezgian"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
})

all_turkic_in_avar <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar == 1),]))
all_turkic_not_in_avar <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$D_Avar  %in% c(0,NA,"NA")),]))

all_turkic_in_avar$Speaker <- rownames(all_turkic_in_avar)
all_turkic_in_avar <- left_join(Districts, all_turkic_in_avar, by= c("Speaker"))
#head(all_turkic)
all_turkic_not_in_avar$Speaker <- rownames(all_turkic_not_in_avar)
all_turkic_not_in_avar <- left_join(Districts, all_turkic_not_in_avar, by= c("Speaker"))
#all_turkic$District <- as.factor(all_turkic$District)
#all_turkic$District <- factor(all_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic$District <- as.factor(all_turkic$District)
all_turkic_in_avar <- gather(all_turkic_in_avar,Lexeme,Present, the_belt_15:the_worm_31,factor_key=TRUE)
all_turkic_not_in_avar <- gather(all_turkic_not_in_avar,Lexeme,Present, the_ant_5:the_year_2,factor_key=TRUE)
all_turkic_in_avar$InAvar <- rep("1",nrow(all_turkic_in_avar))
all_turkic_not_in_avar$InAvar <- rep("0",nrow(all_turkic_not_in_avar))
all_turkic_avar_mediation <- rbind(all_turkic_in_avar, all_turkic_not_in_avar)

all_turkic_avar_mediation <- all_turkic_avar_mediation[,-1]
all_turkic_avar_mediation <- distinct(all_turkic_avar_mediation)
all_turkic_avar_mediation_counts <- aggregate(all_turkic_avar_mediation$Present, by=list(all_turkic_avar_mediation$Village, all_turkic_avar_mediation$InAvar), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(all_turkic_avar_mediation_counts)
colnames(all_turkic_avar_mediation_counts) <- c("Village","InAvar","Loans")
all_turkic_avar_mediation_counts <- left_join(all_turkic_avar_mediation_counts, Districts, by= c("Village"))
all_turkic_avar_mediation_counts$Village <- droplevels(all_turkic_avar_mediation_counts$Village)
all_turkic_avar_mediation_counts$District <- factor(all_turkic_avar_mediation_counts$District, levels(all_turkic_avar_mediation$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_avar_mediation_counts <- all_turkic_avar_mediation_counts[-c(1:6),]
all_turkic_avar_mediation_counts$Loans <- as.numeric(all_turkic_avar_mediation_counts$Loans)

all_turkic_avar_mediation_counts <- all_turkic_avar_mediation_counts[all_turkic_avar_mediation_counts$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
all_turkic_avar_mediation_counts$District <- factor(all_turkic_avar_mediation_counts$District, levels(all_turkic_avar_mediation_counts$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))

all_turkic_avar_mediation_counts <- all_turkic_avar_mediation_counts[,-4]
all_turkic_avar_mediation_counts <- distinct(all_turkic_avar_mediation_counts)
Area <- factor(all_turkic_avar_mediation_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
all_turkic_avar_mediation_counts <- group_by(all_turkic_avar_mediation_counts, Village) %>% mutate(Percent = Loans/sum(Loans)*100)


p3 <- renderPlotly({ 
  ggplot(data = all_turkic_avar_mediation_counts, aes(x = InAvar, y = Percent, label1 = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Fig. 4. Avar Mediation of Turkic Influence", x = "", y = "% of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(District, levels = c("Rutul", "Tsunta", "Botlikh", "Akhvakh")), nrow = 1)+
  theme(legend.position = "bottom")+
  scale_x_discrete(labels=c("Not in Avar", "In Avar"))+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
})

mediationVillagesPage <- fluidPage(fluidRow(column(
  12,
  p("The four plots presented here show how lexical influence from Turkic is mediated by the local major languages (Lezgian and Avar) across Daghestan. The data are split by districts on X axis. 
    Y axis shows the percentage of the loans found in the elicited samples. Dots represent unions of all elicitations per village (color shows the village, too), with a horizontal line showing the median value per district. 
    The plot indicates that Avar mediation may be high in the north but not present in the south, while Lezgian mediation in not probable in both regions."),
  div(p2), div(p3)
)))