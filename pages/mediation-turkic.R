sum_sibcls <- function(df, name_str) {
  df1 <- data.frame(df[ , grepl( name_str , names( df ))])
  return (rowSums(df1[sapply(df1, is.numeric)], na.rm = FALSE))
}

aggregate_df <- function(df, unique_names) {
  result <- setNames(data.frame(matrix(ncol = length(unique_names), nrow = nrow(df))), c(unique_names))
  for(village_name in unique_names) {
    result[village_name] <- sum_sibcls(df, village_name)
  }
  return(as.data.frame(ifelse(result > 0, 1, 0)))
}

all_turkic_wide <- spread(all_turkic, Lexeme, Present)
row.names(all_turkic_wide) <- all_turkic_wide$Speaker
all_turkic_wide <- all_turkic_wide[,-c(1:4)]
all_turkic_wide <- t(all_turkic_wide)
turkic=as.matrix(all_turkic_wide)
turkic[is.na(turkic)] <- 0
all_turkic_wide=as.data.frame(turkic)
unique_names <- c(unique(gsub('[[:digit:]]+', '', names(all_turkic_wide))))
all_turkic_wide_mod <- aggregate_df(all_turkic_wide, unique_names)

# all_turkic_lgs <- all_turkic_wide
# all_turkic_lgs$Tsakhur <- all_turkic_wide$Mikik + all_turkic_wide$Helmets
# all_turkic_lgs$Rutul <- all_turkic_wide$Rutul + all_turkic_wide$Kina + all_turkic_wide$Ikhrek + all_turkic_wide$Kiche
# all_turkic_lgs$Lezgian <- all_turkic_wide$Khlut
# all_turkic_lgs <- all_turkic_lgs[,-c(1:4,6,7)]
# all_turkic_lgs <- ifelse(all_turkic_lgs > 0, 1, 0)
# all_turkic_lgs <- as.data.frame(all_turkic_lgs)
