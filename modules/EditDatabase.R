DB_test_connect <- function(){
  db <- dbConnect(RSQLite::SQLite(), DB_NAME)
  
  print("#######################")
  print("- Connected to Database")
  
  # If a user data table doesn't already exist, create one
  if(!(TBL_USER_DATA %in% dbListTables(db))){
    print("- Warning: No 'users' table found. Creating table...")
    df <- data.frame(ID = as.numeric(character()),
                     USER = character(),
                     HASH = character(),
                     stringsAsFactors = FALSE)
    dbWriteTable(db, TBL_USER_DATA, df)
  } 
  
  print("- Table exists.")
  print("#######################")
  
  dbDisconnect(db)
}

DB_get_user <- function(user){
  db <- dbConnect(RSQLite::SQLite(), DB_NAME)
  
  users_data <- dbReadTable(db, TBL_USER_DATA)
  
  hashusers_data <- filter(users_data, USER == user)
  
  dbDisconnect(db)
  
  return(users_data)
}

DB_add_user <- function(usr, pass){
  db <- dbConnect(RSQLite::SQLite(), DB_NAME)
  
  df <- dbReadTable(db, TBL_USER_DATA)
  
  q <- paste("INSERT INTO", TBL_USER_DATA, "(ID, USER, HASH) VALUEs (", paste("", nrow(df), ",", usr, ",", sha256(pass), "", sep="'"), ")")
  
  dbSendQuery(db, q)
  
  suppressWarnings({dbDisconnect(db)})
  
}


DB_test_connect()

# Server ------------------------------------------------------------------

EditDatabase <- function(input, output, session) {
  ns <- session$ns
  loggedIn <- reactiveVal(value = FALSE)
  user <- reactiveVal(value = NULL)
  
  # For test purposes
  admin <- DB_get_user("admin")
  if(nrow(admin) == 0) {
    DB_add_user("admin", "admin")
  }
  
  login <- eventReactive(input$login, {
    
    user_data <- DB_get_user(input$username)
    
    if(nrow(user_data) > 0){ # If the active user is in the DB then logged in
      if(sha256(input$password) == user_data[1, "HASH"]){
        
        user(input$username)
        loggedIn(TRUE)
        
        print(paste("- User:", user(), "logged in"))
        
        return(TRUE)
      }
    }
    
    return(FALSE)
    
  })

  output$login_status <- renderUI({
    if(input$login == 0){
      return(NULL)
    } else {
      if(!login()){
        return(span("The Username or Password is Incorrect", style = "color:red"))
      }
    }
  })
  
  observeEvent(input$logout, {
    user(NULL)
    loggedIn(FALSE)
    print("- User: logged out")
  })
  
  observe({
    if(loggedIn()){
      output$page <- renderUI({
        fluidPage(
          fluidRow(
            strong(paste("logged in as", user(), "|")), actionLink(ns("logout"), "Logout"), align = "right",
            hr()
          ),
          fluidRow(
            uiOutput('datatable')
          )
        )
        
      })
    } else {
      output$page <- renderUI({
        fluidPage(fluidRow(column(4, offset = 4,
          div(class = "auth-box",
            wellPanel(
              h3("Authentication Required", align = "center"),
              textInput(ns("username"), label = "Username"),
              passwordInput(ns("password"), label = "Password"),
              fluidRow(
                column(6, offset = 4, actionButton(ns("login"), label = "Login")),
                column(8, offset = 3, uiOutput(ns("login_status")))
              )
            )
          )
        )))
      })
    }
  })
  
  
}
