dist_no_dict2 <- read_tsv("data/convert/all_loans_dist_strict.tsv")
row.names(dist_no_dict2) <- dist_no_dict2$Speaker
dist_no_dict2 <- dist_no_dict2[,-which(grepl("D_",colnames(dist_no_dict2)))]
row.names(dist_no_dict2) <- dist_no_dict2$Speaker
dist_no_dict2 <- dist_no_dict2[-which(grepl("D_",row.names(dist_no_dict2))),]
spkr <- dist_no_dict2$Speaker
dist_no_dict2$Speaker <- NULL
row.names(dist_no_dict2) <- spkr


#d_no_dict <- d
#d_no_dict$Turkic_total <- NULL
#d_no_dict$AvarAndic_total <- NULL
#d_no_dict <- as.data.frame(t(d_no_dict))
#d_no_dict$Speaker <- row.names(d_no_dict)
#d_no_dict <- left_join(Districts, d_no_dict, by= c("Speaker"))
#d_no_dict <- d_no_dict[-which(d_no_dict$Village == "Dictionary"),]
#row.names(d_no_dict) <- d_no_dict$Speaker
#d_no_dict <- d_no_dict[,-c(1:4)]
#d_no_dict <- as.matrix(d_no_dict)

#full_dist <- dist_count(d_no_dict)
full_dist <- dist_no_dict2
full_dist <- as.dist(full_dist)
result <- pvclust::pvclust(as.matrix(full_dist), method.hclust="average", nboot=100, quiet=TRUE)
d_no_dict_colors <- dist_no_dict2
d_no_dict_colors$Speaker <- row.names(d_no_dict_colors)
d_no_dict_colors <- left_join(Districts, d_no_dict_colors, by= c("Speaker"))
d_no_dict_colors <- d_no_dict_colors[-which(d_no_dict_colors$Village == "Dictionary"),]
d_no_dict_colors$Turkic_total <- NULL
d_no_dict_colors$AvarAndic_total <- NULL
d_no_dict_colors %>% arrange(Speaker)
d_no_dict_colors <- d_no_dict_colors[order(d_no_dict_colors$Speaker),]
row.names(d_no_dict_colors) <- c(1:length(d_no_dict_colors$Speaker))
d_no_dict_colors <- cbind(row.names(dist_no_dict2),d_no_dict_colors)

dend2 <- renderPlot({
  dend <- as.dendrogram(result)
  colors_to_use <- as.integer(as.factor(d_no_dict_colors$District))
  colors_to_use <- colors_to_use[order.dendrogram(dend)]
  
  dend <- set(dend, "labels_colors", colors_to_use)
  dend <- set(dend, "labels_cex", .7)
  dend %>%
    pvclust_show_signif_gradient(result) %>%
    pvclust_show_signif(result) %>%
    plot(main = "Cluster Dendrogram of Foreign Influence")
  result %>% text (cex = 0.5) 
  result %>% pvrect(alpha=0.95)
})

clusterDendStrictPage <- fluidPage(fluidRow(column(
  12,
  p("The dendrogram presented here show how the word lists collected from diffferent speakers group according 
    to the sets of loanwords of different origin. This tree is built as follows. 0 distance is given only to two matching non-empty cells, 
    otherwise the distance is 1. This leads to the huge distances even if speakers are similar. The NA's are counted. 
    This dendrogram is different from the previous one in that the penalties for matches between speakers are higher."),
  div(dend2)
)))
