dist_no_dict2 <- read_tsv("data/convert/all_loans_dist_strict.tsv")
row.names(dist_no_dict2) <- dist_no_dict2$Speaker
dist_no_dict2 <- dist_no_dict2[,-which(grepl("D_",colnames(dist_no_dict2)))]
row.names(dist_no_dict2) <- dist_no_dict2$Speaker
dist_no_dict2 <- dist_no_dict2[-which(grepl("D_",row.names(dist_no_dict2))),]
spkr <- dist_no_dict2$Speaker
dist_no_dict2$Speaker <- NULL
row.names(dist_no_dict2) <- spkr

full_dist2 <- dist_no_dict2
full_dist2 <- as.dist(full_dist2)
result2 <- pvclust::pvclust(as.matrix(full_dist2), method.hclust="average", nboot=100, quiet=TRUE)
d_no_dict_colors2 <- dist_no_dict2
d_no_dict_colors2$Speaker <- row.names(d_no_dict_colors2)
d_no_dict_colors2 <- left_join(Districts, d_no_dict_colors2, by= c("Speaker"))
d_no_dict_colors2 <- d_no_dict_colors2[-which(d_no_dict_colors2$Village == "Dictionary"),]
d_no_dict_colors2$Turkic_total <- NULL
d_no_dict_colors2$AvarAndic_total <- NULL
d_no_dict_colors2 %>% arrange(Speaker)
d_no_dict_colors2 <- d_no_dict_colors2[order(d_no_dict_colors2$Speaker),]
row.names(d_no_dict_colors2) <- c(1:length(d_no_dict_colors2$Speaker))
d_no_dict_colors2 <- cbind(row.names(dist_no_dict2),d_no_dict_colors2)

dend2 <- renderPlot({
  dend <- as.dendrogram(result2)
  colors_to_use <- as.integer(as.factor(d_no_dict_colors2$District))
  colors_to_use <- colors_to_use[order.dendrogram(dend)]
  
  dend <- set(dend, "labels_colors", colors_to_use)
  dend <- set(dend, "labels_cex", .7)
  dend %>%
    pvclust_show_signif_gradient(result2) %>%
    pvclust_show_signif(result2) %>%
    plot(main = "Cluster Dendrogram of Foreign Influence")
  result2 %>% text (cex = 0.5) 
  result2 %>% pvrect(alpha=0.95)
})

clusterDendStrictPage <- fluidPage(fluidRow(column(
  12,
  p("The dendrogram presented here show how the word lists collected from diffferent speakers group according 
    to the sets of loanwords of different origin. This tree is built as follows. 0 distance is given only to two matching non-empty cells, 
    otherwise the distance is 1. This leads to the huge distances even if speakers are similar. The NA's are counted. 
    This dendrogram is different from the previous one in that the penalties for matches between speakers are higher."),
  div(dend2)
)))
