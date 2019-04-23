content <- words_meta %>%
  group_by(`List ID`, Language, Word) %>%
  summarise(Words = n())


languages <- length(unique(content$Language))
target_words <- sum(content$Words)

aboutPage <- fluidPage(fluidRow(column(
  12,
  h4("Authors: Ilya Chechuro, Michael Daniel, and Samira Verhees."),
  p(
    "This database contains wordlists collected as part of the",
    a(href = "https://ilcl.hse.ru/en/projects", "Daghestanian loans"),
    "project by the",
    a(href = "https://ilcl.hse.ru/en/", "Linguistic Convergence Laboratory"),
    "at NRU HSE. The aim of the 160-item shortlist, which is based on the",
    a(href = "https://wold.clld.org/", "World Loanword Database questionnaire"),
    "is to measure lexical contact on a micro-level. In other words, to quantify lexical convergence among the speech communities of minority languages on a village-level, and to detect fine-grained areal patterns beyond general observations on the spheres of influence of certain languages."
  ),
  h5("Contents:"),
  div(
    p(tags$b("Languages:"), languages),
    p(tags$b("Target words:"), target_words)
  )
)))