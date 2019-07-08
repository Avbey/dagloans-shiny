dict_turkic <-  as.data.frame(t(d[which(d$D_Azerbaijani>0 & d$D_Russian  %in% c(0,NA,"NA") & d$D_Arabic  %in% c(0,NA,"NA") & d$D_Persian  %in% c(0,NA,"NA")),]))
dict_turkic$Speaker <- rownames(dict_turkic)
dict_turkic <- left_join(Districts, dict_turkic, by= c("Speaker"))
#head(all_turkic)

#all_turkic$District <- as.factor(all_turkic$District)
# dict_turkic <- dict_turkic[dict_turkic$District %in% c("Akhvakh", "Botlikh", "Rutul", "Tsunta"),]
# dict_turkic$District <- factor(dict_turkic$District, levels(all_turkic$District) <- c("Akhvakh", "Botlikh", "Rutul", "Tsunta"))

#all_turkic_wide <- all_turkic_wide[all_turkic_wide$District %in% c("Rutul"),]

# By Villages
all_turkic_wide_az_village <- ddply(dict_turkic, "Village", numcolwise(sum)) # sum all rows by Village
all_turkic_wide_az_village[is.na(all_turkic_wide_az_village)] <- 0 
all_turkic_wide_az_village[,-1] <- ifelse(all_turkic_wide_az_village[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
villages <- all_turkic_wide_az_village$Village
all_turkic_wide_az_village <- as.data.frame(t(all_turkic_wide_az_village[,-1]))
colnames(all_turkic_wide_az_village) <- villages

# By Languages
all_turkic_wide_az_language <- ddply(dict_turkic, "Language", numcolwise(sum)) # sum all rows by Language
all_turkic_wide_az_language[is.na(all_turkic_wide_az_language)] <- 0 
all_turkic_wide_az_language[,-1] <- ifelse(all_turkic_wide_az_language[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
languages <- all_turkic_wide_az_language$Language
all_turkic_wide_az_language <- as.data.frame(t(all_turkic_wide_az_language[,-1]))
colnames(all_turkic_wide_az_language) <- languages
