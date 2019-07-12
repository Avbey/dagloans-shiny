dist_no_dict <- read_tsv("data/convert/all_loans_dist.tsv")
row.names(dist_no_dict) <- dist_no_dict$Speaker
dist_no_dict <- dist_no_dict[,-which(grepl("D_",colnames(dist_no_dict)))]
row.names(dist_no_dict) <- dist_no_dict$Speaker
dist_no_dict <- dist_no_dict[-which(grepl("D_",row.names(dist_no_dict))),]
spkr <- dist_no_dict$Speaker
dist_no_dict$Speaker <- NULL
row.names(dist_no_dict) <- spkr

full_dist <- dist_no_dict
full_dist <- as.dist(full_dist)
result <- pvclust::pvclust(as.matrix(full_dist), method.hclust="average", nboot=100, quiet=TRUE)
d_no_dict_colors <- dist_no_dict
d_no_dict_colors$Speaker <- row.names(d_no_dict_colors)
d_no_dict_colors <- left_join(Districts, d_no_dict_colors, by= c("Speaker"))
d_no_dict_colors <- d_no_dict_colors[-which(d_no_dict_colors$Village == "Dictionary"),]
d_no_dict_colors$Turkic_total <- NULL
d_no_dict_colors$AvarAndic_total <- NULL
d_no_dict_colors %>% arrange(Speaker)
d_no_dict_colors <- d_no_dict_colors[order(d_no_dict_colors$Speaker),]
row.names(d_no_dict_colors) <- c(1:length(d_no_dict_colors$Speaker))
d_no_dict_colors <- cbind(row.names(dist_no_dict),d_no_dict_colors)
dend1 <- renderPlot({
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


clusterDendPage <- fluidPage(fluidRow(column(
  12,
  p("The dendrogram presented here show how the word lists collected from diffferent speakers group according to the sets of loanwords of different origin.
    This tree is built as follows. 0 distance is given only to two matching non-empty cells, otherwise the distance is 1. The The NA's are not counted."),
  div(dend1)
)))
