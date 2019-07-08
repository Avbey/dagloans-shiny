all_turkic_wide_total <- spread(all_turkic, Lexeme, Present)

# By Villages
all_turkic_wide_total_village <- ddply(all_turkic_wide_total, "Village", numcolwise(sum)) # sum all rows by Village
all_turkic_wide_total_village[is.na(all_turkic_wide_total_village)] <- 0 
all_turkic_wide_total_village[,-1] <- ifelse(all_turkic_wide_total_village[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
villages <- all_turkic_wide_total_village$Village
all_turkic_wide_total_village <- as.data.frame(t(all_turkic_wide_total_village[,-1]))
colnames(all_turkic_wide_total_village) <- villages

# By Languages
all_turkic_wide_total_language <- ddply(all_turkic_wide_total, "Language", numcolwise(sum)) # sum all rows by District
all_turkic_wide_total_language[is.na(all_turkic_wide_total_language)] <- 0 
all_turkic_wide_total_language[,-1] <- ifelse(all_turkic_wide_total_language[,-1] > 0, 1, 0) # normalize DF
# transpose DF to satisfy UpsetR plotting function
languages <- all_turkic_wide_total_language$Language
all_turkic_wide_total_language <- as.data.frame(t(all_turkic_wide_total_language[,-1]))
colnames(all_turkic_wide_total_language) <- languages
