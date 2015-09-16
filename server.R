library(shiny)
library(ggplot2)
library(MASS)

data(iris)

shinyServer(
    function(input, output){  
      
      # train the predictive model
      model <- lda(Species ~ ., data = iris)
      
      # scatterplot for visualistaions
      output$scatter <- renderPlot({
          ggplot(iris, aes_string(x = input$xInput, y = input$yInput,
                                  col = "Species", shape = "Species")) +
            geom_point(alpha = 0.6, size = 5) +
            scale_shape_manual(values = 16:18) +
            scale_colour_brewer(palette = "Set1") +
            theme_bw() +
            xlab(paste(gsub("[.]", " ",input$xInput), "(cm)")) + 
            ylab(paste(gsub("[.]", " ",input$yInput), "(cm)")) + 
            ggtitle("Pairwise plot of predictor variables")
          
        })
      
      # model inputs
      modelInputs <- eventReactive(input$goButton, {
        measures <- data.frame(
          Petal.Length =input$petalLength,
          Petal.Width  =input$petalWidth,
          Sepal.Length = input$sepalLength,
          Sepal.Width = input$sepalWidth)
        
        paste(c('Petal length: ', input$petalLength,
                '\nPetal width:', input$petalWidth,
                '\nSepal length:', input$sepalLength,
                '\nSepal width:', input$sepalWidth),
              sep = " ")         
      })
      
      # link to output
      output$inputs <- renderText({
        modelInputs()
      })
      
      # model prediction
      modelPrediction <- eventReactive(input$goButton, {
                 as.character(predict(model, newdata = data.frame(
                    Petal.Length = input$petalLength,
                    Petal.Width  = input$petalWidth,
                    Sepal.Length = input$sepalLength,
                    Sepal.Width = input$sepalWidth))$class)
      })
      
      # link to output
      output$model <- renderText({
        modelPrediction()
      })
})



    