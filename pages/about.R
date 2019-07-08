content <- words_meta %>%
  group_by(`List ID`, Language, Word) %>%
  summarise(Words = n())

languages <- length(unique(content$Language))
target_words <- sum(content$Words)

aboutPage <- fluidPage(fluidRow(column(
  12,
  p(tags$i("Authors: Ilya Chechuro, Michael Daniel, and Samira Verhees.")),
  p("The DagLoans database contains results of elicitation of a list of 146 lexical meanings across languages of Daghestan. 
    Data collection was aimed at assessing the amount of lexical transfer between these languages. 
    The database includes lists elicited from 125 speakers of minority languages and 21 lists based on dictionaries 
    (15 of them of East Caucasian languages). In addition to the data from East Caucasian languages, 
    it also includes data from other languages relevant for the study of language contact in the area, including Persian, Arabic, Azerbaijani, 
    Georgian and Russian (6 dictionaries)."),
  p("The general objective of the DagLoans project is the study of lexical borrowing in the languages of Daghestan on the level 
    of granularity that is sensitive to the difference between village varieties. 
    For this purpose, we developed a method for obtaining comparable lexical data through eliciting a relatively short (146 concepts) wordlist 
    that serves as a litmus paper, a quick field probe for the amount of lexical transfer. 
    Using a fixed list allows discovering quantitative correlates of sociolinguistic differences between areas, 
    such as the spread of a certain lingua franca or the presence and degree of contact with particular languages. 
    In combination with the sociolinguistic data on multilingualism in Daghestan, our data shows that the conditions and the degree of 
    language contact for each village vary and correlate with bilingualism rates as reported in our another project, 
    Atlas of Multilingualism in Daghestan."),
  p("The table shows the concepts (lexical meanings) and their translations into target languages. 
    Translations are grouped into similarity sets, sets of words that look similarly and were used as translations of the same concept. 
    Whenever the similarity is shared by different language families or sufficiently distant branches, 
    we consider this as an indication that the lexical item night have been shared through language contact. 
    Metadata includes the name of the village where the word was recorded and its location, the language spoken in the village, 
    and the list ID. The ID corresponds to a particular speaker or, in some cases, to a written dictionary source. 
    All data are accessible", a(href="https://lingconlab.github.io/Dagloan_database/Github/LingConLab/DagloanDatabase", "here."), 
    "The dataset is also available ", a(href="https://github.com/LingConLab/Dagloan_database/blob/master/Convert/words_01042019_dummy.tsv", "here."), "in the one-hot format."),
  p("The DagLoans database has been compiled by Ilia Chechuro and Samira Verhees. 
    The field data was primarily collected by Ilya Chechuro, Michael Daniel, Nina Dobrushina, Samira Verhees 
    and the students supervised by them (see", a(href="#shiny-tab-acknowledgements", "Acknowledgements"),"). The data is copyrighted by", a(href="https://ilcl.hse.ru/en/", "Linguistic Convergence Laboratory"), 
    "HSE University, Moscow, and may be used in other academic projects (see", a(href="#shiny-tab-howto", "How to cite"),"). 
    The project was funded by the Basic Research Program at the National Research University Higher School of Economics (HSE) 
    and supported within the framework of a subsidy by the Russian Academic Excellence Project \"5-100\"."),

  box(
    title = "Contents", width = 4, solidHeader = TRUE,
    div(
      p(tags$b("Languages: "), languages),
      p(tags$b("Target words: "), target_words)
    )
  )
)))