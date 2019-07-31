avar_cognates <- read_tsv("data/Avar_Cognate_Test(Samira+Kusur).tsv")
avar_cognates <- avar_cognates[which(avar_cognates$Cognate_Samira == "y"),]
avar <-  as.data.frame(t(d[which(d$D_Avar>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$Turk_total == 0),]))
avar$Speaker <- rownames(avar)
avar <- left_join(Districts, avar, by= c("Speaker"))
#avar$District <- as.factor(avar$District)
avar <- avar[avar$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
avar$District <- factor(avar$District, levels(avar$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#avar$District <- as.factor(avar$District)
avar <- gather(avar,Lexeme,Present, the_ant_20:the_year_11,factor_key=TRUE)
#head(avar)
avar <- avar[-which(avar$Lexeme %in% avar_cognates$Lexeme.x),]

#avar_cognate_test <- as.data.frame(t(d[which(d$AvarAndic_total>1 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$Turk_total == 0),]))
#avar_cognate_test$Speaker <- rownames(avar_cognate_test)
#avar_cognate_test <- left_join(Districts, avar_cognate_test, by= c("Speaker"))
#avar_cognate_test <- gather(avar_cognate_test,Lexeme,Present, the_ant_20:the_year_12,factor_key=TRUE)
#avar_cognate_test <- avar_cognate_test[avar_cognate_test$District %in% c("Akhvakh", "Botlikh", "Tsunta") | avar_cognate_test$Speaker %in% c("D_Avar"),]
#avar_cognate_test <- avar_cognate_test[which(avar_cognate_test$Present == 1),]
#words_meta$Lexeme <- paste(gsub(" ", "_", words_meta$Concept, fixed = TRUE), words_meta$Stem, sep = "_")
#words_meta$SpkrLexeme <- paste(words_meta$Code, words_meta$Lexeme, sep = "_")
#avar_cognate_test$SpkrLexeme <- paste(avar_cognate_test$Speaker, avar_cognate_test$Lexeme, sep = "_")
#avar_cognate_test <- avar_cognate_test[which(avar_cognate_test$Present == 1),]
#avar_cognate_test <- merge(avar_cognate_test, words_meta, by= c("SpkrLexeme"))
#avar_cognate_test <- distinct (avar_cognate_test)
#avar_cognate_test <- avar_cognate_test %>%
#  select(`Speaker`, Language.x, Village.x, District.x, Lexeme.x, `List ID`, Concept, `Concept nr.`, Word, Stem, Set)
#write_tsv(avar_cognate_test, "Avar_Cognate_Test.tsv")

kusur_cognate_test <- as.data.frame(t(d[which(d$Kusur1 == 1 & d$D_Avar == 1 & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$Turk_total == 0),]))
kusur_cognate_test$Speaker <- rownames(kusur_cognate_test)
kusur_cognate_test <- left_join(Districts, kusur_cognate_test, by= c("Speaker"))
kusur_cognate_test <- gather(kusur_cognate_test,Lexeme,Present, the_ant_20:the_worm_16,factor_key=TRUE)
kusur_cognate_test <- kusur_cognate_test[kusur_cognate_test$Village %in% c("Kusur") | kusur_cognate_test$Speaker %in% c("D_Avar"),]
kusur_cognate_test <- kusur_cognate_test[which(kusur_cognate_test$Present == 1),]
words_meta$Lexeme <- paste(gsub(" ", "_", words_meta$Concept, fixed = TRUE), words_meta$Stem, sep = "_")
words_meta$SpkrLexeme <- paste(words_meta$Code, words_meta$Lexeme, sep = "_")
kusur_cognate_test$SpkrLexeme <- paste(kusur_cognate_test$Speaker, kusur_cognate_test$Lexeme, sep = "_")
kusur_cognate_test <- kusur_cognate_test[which(kusur_cognate_test$Present == 1),]
kusur_cognate_test <- merge(kusur_cognate_test, words_meta, by= c("SpkrLexeme"))
kusur_cognate_test <- distinct (kusur_cognate_test)
kusur_cognate_test <- kusur_cognate_test %>%
  select(`Speaker`, Language.x, Village.x, District.x, Lexeme.x, `List ID`, Concept, `Concept nr.`, Word, Stem, Set)
#write_tsv(kusur_cognate_test, "kusur_cognate_Test.tsv")




georgian <-  as.data.frame(t(d[which(d$D_Georgian>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$Turk_total == 0),]))
georgian$Speaker <- rownames(georgian)
georgian <- left_join(Districts, georgian, by= c("Speaker"))
#georgian$District <- as.factor(georgian$District)
georgian <- georgian[georgian$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
georgian$District <- factor(georgian$District, levels(georgian$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#georgian$District <- as.factor(georgian$District)
georgian <- gather(georgian,Lexeme,Present, the_ant_1:the_year_5,factor_key=TRUE)
#head(georgian)

chechen <-  as.data.frame(t(d[which(d$D_Chechen>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA") & d$Turk_total == 0),]))
chechen$Speaker <- rownames(chechen)
chechen <- left_join(Districts, chechen, by= c("Speaker"))
#chechen$District <- as.factor(chechen$District)
chechen <- chechen[chechen$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
chechen$District <- factor(chechen$District, levels(chechen$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#chechen$District <- as.factor(chechen$District)
chechen <- gather(chechen,Lexeme,Present, the_ant_9:the_worm_28,factor_key=TRUE)
#head(chechen)

all_turkic_counts <- aggregate(all_turkic$Present, by=list(all_turkic$Speaker), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(all_turkic_counts)
colnames(all_turkic_counts) <- c("Speaker","Loans")
all_turkic_counts <- left_join(all_turkic_counts, Districts, by= c("Speaker"))
all_turkic_counts$Village <- droplevels(all_turkic_counts$Village)
all_turkic_counts$District <- factor(all_turkic_counts$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#all_turkic_counts <- all_turkic_counts[-c(1:6),]
all_turkic_counts$Loans <- as.numeric(all_turkic_counts$Loans)

avar_counts <- aggregate(avar$Present, by=list(avar$Speaker), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(avar_counts)
colnames(avar_counts) <- c("Speaker","Loans")
avar_counts <- left_join(avar_counts, Districts, by= c("Speaker"))
avar_counts$Village <- droplevels(avar_counts$Village)
avar_counts$District <- factor(avar_counts$District, levels(avar$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#avar_counts <- avar_counts[-c(1:6),]
avar_counts$Loans <- as.numeric(avar_counts$Loans)

georgian_counts <- aggregate(georgian$Present, by=list(georgian$Speaker), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(georgian_counts)
colnames(georgian_counts) <- c("Speaker","Loans")
georgian_counts <- left_join(georgian_counts, Districts, by= c("Speaker"))
georgian_counts$Village <- droplevels(georgian_counts$Village)
georgian_counts$District <- factor(georgian_counts$District, levels(georgian$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#georgian_counts <- georgian_counts[-c(1:6),]
georgian_counts$Loans <- as.numeric(georgian_counts$Loans)

chechen_counts <- aggregate(chechen$Present, by=list(chechen$Speaker), FUN=sum, na.rm=TRUE, na.action=NULL)
#head(chechen_counts)
colnames(chechen_counts) <- c("Speaker","Loans")
chechen_counts <- left_join(chechen_counts, Districts, by= c("Speaker"))
chechen_counts$Village <- droplevels(chechen_counts$Village)
chechen_counts$District <- factor(chechen_counts$District, levels(chechen$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))
#chechen_counts <- chechen_counts[-c(1:6),]
chechen_counts$Loans <- as.numeric(chechen_counts$Loans)

all_turkic_counts$Source <- rep("Turkic",nrow(all_turkic_counts))
avar_counts$Source <- rep("Avar",nrow(avar_counts))
georgian_counts$Source <- rep("Georgian",nrow(georgian_counts))
chechen_counts$Source <- rep("Chechen",nrow(chechen_counts))
loan_counts <- rbind(all_turkic_counts, avar_counts, georgian_counts, chechen_counts)

Area <- factor(loan_counts$District, levels  = c("Rutul","Tsunta","Botlikh","Akhvakh"))
p1 <- ggplot(data = loan_counts, aes(x = Area, y = Loans)) + 
  geom_jitter(aes(color = Village), position = position_jitter(width = 0.3, height = 0.1)) +
  stat_summary(fun.y = "median", geom = "point", pch = 3, group = 1, size = 5)+
  labs(title = "Fig. 2. Percentages of borrowings across the four districts", x = "", y = "Number of Loanwords")+
  theme_bw()+
  facet_wrap(. ~ factor(Source, levels = c("Turkic", "Avar", "Georgian", "Chechen")), nrow = 1, scales = "free")+
  theme(legend.position = "bottom", axis.text.x = element_text(angle = -30))
#p5
#par(mfcol=c(1,4))
#library(gridExtra)
soursesLexPlot <-
ggplotly(p1) %>%
  layout(legend = list(
    size = 30
  )
  )

#subplot(p1,p2,p3,p4)

#grid.arrange(ggplotly(p1), ggplotly(p2), ggplotly(p3), ggplotly(p4), nrow = 1)
#lemon::grid_arrange_shared_legend(ggplotly(p1), ggplotly(p2), ggplotly(p3), ggplotly(p4), nrow = 1)
#subplot(p1, p2, p3, p4) %>%
#  layout(showlegend = FALSE)


sourcesLexPage <- fluidPage(fluidRow(column(
  12,
  p("The four plots presented here show lexical influence from Turkic, Avar, 
    Georgian and Chechen. The data are split by districts on X axis. Y axis shows the percentage of the loans found in the elicited samples. 
    Dots represent elicitations (color shows the village), with a horizontal line showing the median value per district."),
  div(renderPlotly(soursesLexPlot))
)))