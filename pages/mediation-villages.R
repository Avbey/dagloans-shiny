all_turkic_in_avar <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian != 1 & d$D_Arabic != 1 & d$D_Persian != 1 & d$D_Avar == 1),]))
all_turkic_not_in_avar <-  as.data.frame(t(d[which(d$Turk_total>0 & d$D_Russian != 1 & d$D_Arabic != 1 & d$D_Persian != 1 & d$D_Avar != 1),]))

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

all_turkic_avar_mediation_counts <- aggregate(all_turkic_avar_mediation$Present, by=list(all_turkic_avar_mediation$Speaker, all_turkic_avar_mediation$InAvar), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(all_turkic_avar_mediation_counts)
colnames(all_turkic_avar_mediation_counts) <- c("Speaker","InAvar","Loans")
all_turkic_avar_mediation_counts <- left_join(all_turkic_avar_mediation_counts, Districts, by= c("Speaker"))
all_turkic_avar_mediation_counts$Village <- droplevels(all_turkic_avar_mediation_counts$Village)
all_turkic_avar_mediation_counts$District <- factor(all_turkic_avar_mediation_counts$District, levels(all_turkic_avar_mediation$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_avar_mediation_counts <- all_turkic_avar_mediation_counts[-c(1:6),]
all_turkic_avar_mediation_counts$Loans <- as.numeric(all_turkic_avar_mediation_counts$Loans)

all_turkic_avar_mediation_counts <- all_turkic_avar_mediation_counts[all_turkic_avar_mediation_counts$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
all_turkic_avar_mediation_counts$District <- factor(all_turkic_avar_mediation_counts$District, levels(all_turkic_avar_mediation_counts$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))

Area <- factor(all_turkic_avar_mediation_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
all_turkic_avar_mediation_counts <- group_by(all_turkic_avar_mediation_counts, Village) %>% mutate(Percent = Loans/sum(Loans)*100)
p3 <- renderPlotly({ ggplot(data = all_turkic_avar_mediation_counts, aes(x = InAvar, y = Percent)) +
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
  div(p3)
)))