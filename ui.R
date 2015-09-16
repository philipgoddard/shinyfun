library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Classifying Iris Type"),
  sidebarPanel(
    h3('Data Exploration'),
    p('To visualise pairwise relations in the training set, please navigate to the 
      Data Visualisation tab and select your x and y variables.'),
    selectInput("xInput", "x variable",
                c("Petal Length" = "Petal.Length",
                  "Petal Width" = "Petal.Width",
                  "Sepal Length" = "Sepal.Length",
                  "Sepal Width" = "Sepal.Width")),
    selectInput("yInput", "y variable",
                c("Petal Length" = "Petal.Length",
                  "Petal Width" = "Petal.Width",
                  "Sepal Length" = "Sepal.Length",
                  "Sepal Width" = "Sepal.Width")),
    h3('Data Input'),
    p('To make predictions, please navigate to the Making Predictions tab,
      enter your measurements, and then press Submit.'),
    numericInput('petalLength', 'Petal Length (cm)', 1.0, min = 1.0, max = 7, step = 0.1),
    numericInput('petalWidth', 'Petal Width (cm)', 1.0, min = 0.1, max = 2.5, step = 0.1),
    numericInput('sepalLength', 'Sepal Length (cm)', 1.0, min = 4.3, max = 7.9, step = 0.1),
    numericInput('sepalWidth', 'Sepal Width (cm)', 1.0, min = 2.0, max = 4.4, step = 0.1),
    actionButton('goButton', 'Submit')
    ),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview",
               h1('Overview'),
               p('This simple application fits a linear discriminant analysis model to the iris
                data set, allowing the species to be predicted for new samples based on the measurements
                of the petal length, petal width, sepal length, and sepal width.'),
               p("Please use the tabs above to navigate this application.")),
      tabPanel("Data Visualisation",
               h2('Predictor Pairwise Relationships'),
               p('Please feel free to investigate the pairwise relationships
                between predictor variables using the drop down boxes in the side bar.'),
               plotOutput('scatter')),
      tabPanel("Making Predictions",
               h2('Predictions'), 
               p('You can enter new measurements of petal length, petal width,
                sepal length, and sepal width and generate a prediction of the iris species.
                Please enter your measurements in the data input section of the sidebar'),
               h3("Input measurements:"),
               verbatimTextOutput("inputs"),
               h3("Predicted species is:"),
               verbatimTextOutput("model"))
    )
  )
))