#
# 
#
# Access the shiny and xlsx packages.
library(shiny); library(xlsx);

# Define server logic required 
shinyServer(function(input, output) {
# Read the qualitative data for the oils in from the Excel spreadsheet then 
# separate into attributes data and saponification values.
    quals <- read.xlsx("quals.xlsx", sheetIndex = 1)
    att <- as.matrix(quals[, 2:6])
    SAPS <- as.matrix(quals[, 7])
# Define the oil weights as a vector of the inputs    
    weights <- reactive({
               c(input$coco, input$cast, input$cano, input$oliv, input$palm, 
                 input$milk)
    })
# Calculate the total oil mass    
    coeftot <- reactive({sum(weights())})
# Use matrix multiplication to determine the attributes of the oil mix    
    soap <- reactive({t(att) %*% weights() /coeftot()})
# Define x0, y0, x1, and y1 values for lines representing the upper and
# lower recommended bounds for the five attributes and format.     
    recoms <- c(0.1,29,1.3,29, 0.1,54,1.3,54, 1.3,12,2.5,12, 
                1.3,22,2.5,22, 2.5,44,3.7,44, 2.5,69,3.7,69,
                3.7,14,4.9,14, 3.7,46,4.9,46, 4.9,16,6.1,16,
                4.9,48,6.1,48)
    dim(recoms) <- c(4,10)
    recoms <- t(recoms)
# Create the barplot output of the attribute levels.
    output$plot1<- renderPlot({
    barplot(t(as.matrix(soap())), col = 'blue', ylim=c(0,90), 
            main="Soap attribute levels")
# Draw the attribute recommendation lines in red       
    segments(recoms[,1],recoms[,2],recoms[,3],recoms[,4], col='red', lwd=3)  
# Draw the targeted optimising attribute level in green    
    segments((as.numeric(input$optim))*1.2-1.1,input$optval,
             (as.numeric(input$optim))*1.2+0.1, 
             input$optval, col='green',lwd=4)
    text(c(0.7,1.9,3.1,4.3,5.5),soap(),labels=floor(soap()),pos=3)
    par(xpd=TRUE)
    legend(1.1,-13,legend=c("Recommended Values", "Targeted Value"), 
           col=c('red','green'), lwd=3, horiz=TRUE)
  })
# Calculate the mass in grams of water required based on oil mass.    
    w1 <- reactive({ 
        coeftot() * input$water / 100
    })
# Calculate the mass in grams of NaOH required using matrix multiplication and
# discount for the superfat value (% of fat to remain unsaponified).    
    caustic <- reactive({
        t(SAPS) %*% weights() * (100-input$sfat)/10000
    })
# Define the data frame of the oil types and their masses.    
    oils <- reactive({
        cbind(Oil=c("Coconut Oil:", "Castor Oil:", "Canola Oil:", 
                    "Olive Oil:", "Palm Oil:", "Milk Fat:"), Mass=weights())
    })
# Define a function to remove entries from the oils dataframe that have no mass.    
    clean <- function(x){
        for(i in 6:1){
        if(x[i,2]==0){x <- x[-i,]}
        }
        x
    }
# Define the text output for the water component of the final recipe.    
    output$water <- renderText({
        input$create
        isolate({sprintf("%3.2f grams", w1())})
    })
# Define the text output for the NaOH component of the final recipe.    
    output$NaOH <- renderText({
        input$create
        isolate({
            sprintf("%3.2f grams", caustic())
            })
    })
# Define the table output for the oil components of the final recipe.    
    output$oil <-renderTable({
        input$create
        isolate({
            clean(oils())
    })
    })
# Define the text output for the total final recipe mass.    
    output$tot <- renderText({
        input$create
        isolate({sprintf("%4.2f grams", caustic()+w1()+coeftot())})
    })
})
