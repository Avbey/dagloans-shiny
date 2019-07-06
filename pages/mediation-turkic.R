all_turkic_wide <- spread(all_turkic, Lexeme, Present)
all_turkic_wide <- ddply(all_turkic_wide,"Village",numcolwise(sum))
all_turkic_wide[is.na(all_turkic_wide)] <- 0
all_turkic_wide[,-1] <- ifelse(all_turkic_wide[,-1] > 0, 1, 0)
# transpose DF
villages <- all_turkic_wide$Village
all_turkic_wide <- as.data.frame(t(all_turkic_wide[,-1]))
colnames(all_turkic_wide) <- villages
