#These functions count the necessary distances
div_count <- function(string1, string2){
  x <- unlist(string1, use.names = F)
  y <- unlist(string2, use.names = F)
  d <- data.frame(x, y)
  #print(d)
  num <- sum(complete.cases(d))
  return(num)
}

# dissimilarity matrix -------------------------------------------------
dist_count <- function(data) {
  data2 <- data.frame()
  for (i in row.names(data)) {
    for (j in row.names(data)) {
      #print(data[i,])
      #print(data[j,])
      data2[i,j] = round(sum((data[i,]!=data[j,]), na.rm=TRUE)/div_count(data[i,],data[j,]), digits=2)
      #print (round(sum((data[i,]!=data[j,]), na.rm=TRUE)/div_count(data[i,],data[j,]), digits=2))
    }
  }
  return(data2)
}

d_no_dict <- d
d_no_dict$Turkic_total <- NULL
d_no_dict$AvarAndic_total <- NULL
d_no_dict <- as.data.frame(t(d_no_dict))
d_no_dict$Speaker <- row.names(d_no_dict)
d_no_dict <- left_join(Districts, d_no_dict, by= c("Speaker"))
d_no_dict <- d_no_dict[-which(d_no_dict$Village == "Dictionary"),]
row.names(d_no_dict) <- d_no_dict$Speaker
d_no_dict <- d_no_dict[,-c(1:4)]
d_no_dict <- as.matrix(d_no_dict)
full_dist <- dist_count(d_no_dict)
result <- pvclust::pvclust(as.matrix(full_dist), method.hclust="average", nboot=1000, quiet=TRUE)
print(result)
d_no_dict_colors <-  full_dist
d_no_dict_colors$Speaker <- row.names(d_no_dict_colors)
d_no_dict_colors <- left_join(Districts, d_no_dict_colors, by= c("Speaker"))
d_no_dict_colors <- d_no_dict_colors[-which(d_no_dict_colors$Village == "Dictionary"),]
d_no_dict_colors$Turkic_total <- NULL
d_no_dict_colors$AvarAndic_total <- NULL
d_no_dict_colors %>% arrange(Speaker)
row.names(d_no_dict_colors) <- c(1:length(d_no_dict_colors$Speaker))
lbl <- cbind(result$hclust$label, result$hclust$order)
colnames(lbl) <- c("Speaker", "Number")
lbl <- as.data.frame(lbl)
dstrct <- c()
for (number in lbl$Number){
  dstrct <- c(dstrct, d_no_dict_colors$District[as.integer(number)])
}

lbl$District <- dstrct

dend <- as.dendrogram(result)
dend <- set(dend, "labels_colors", as.integer(as.factor(lbl$District))) 
dend <- set(dend, "labels_cex", .7)
dend %>%
  pvclust_show_signif_gradient(result) %>%
  pvclust_show_signif(result) %>%
  plot(main = "Cluster Dendrogram of Foreign Influence")
result %>% text (cex = 0.5) 
result %>% pvrect(alpha=0.95)
print(result)

clusterDendPage <- fluidPage(fluidRow(column(
  12,
  div("clusterDend")
)))
