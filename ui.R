#
# 
#

library(shiny); library(shinythemes);

# Define UI for application
shinyUI(fluidPage(
  theme=shinytheme("cyborg"),
  # Application title
  titlePanel(span("Homemade Soap Recipe Optimiser",style="color:red; 
                  font-style:italic; font-weight:bold;")),
  
  # Sidebar with slider inputs for oil masses 
  fluidRow(
    column(2,
       h4(span("Oils:",style="color:orange")),
       sliderInput("oliv", "Olive Oil (g)", min=0, max=400, step=1, value=100),
       sliderInput("palm", "Palm Oil (g)", min=0, max=400, step=1, value=100),
       sliderInput("coco", "Coconut Oil (g)", min=0, max=400, step=1, value=0),
       sliderInput("cano", "Canola Oil (g)", min=0, max=400, step=1, value=0),
       sliderInput("cast", "Castor Oil (g)", min=0, max=400, step=1, value=0),
       sliderInput("milk", "Milk Fat (g)", min=0, max=400, step=1, value=0)
       ),
    # Siderbar with sliders for superfat and water%, a dropdown for attribute 
    # selection, a numeric input for target attribute level and an action 
    # button to create the recipe
    column(2,
           h4(span("Parameters:",style="color:orange")),
           sliderInput("sfat", "Superfat %:", min = 3, max = 10, value = 7),
           sliderInput("water", "Water as % of oils:", min=34, max=44, value=37),
           selectInput("optim", "Optimise for:", 
                       choices = c('Hardness'='1', 'Creamy'='5', 'Bubbly'='4', 
                                   'Cleansing'='2','Condition'='3')),
           numericInput("optval", "Value is:", min=10, max=70, value=25),
           actionButton("create", "Create Recipe")
    ),
    # 3 main panel tabs: 'About' gives a description of the app, 'Qualities' 
    # shows the reactive plot of the attributes of the recipe, and 'Recipe' 
    # shows the masses of the final recipe with the selected parameters.
    column(8,
           tabsetPanel(
        tabPanel(span("About",style="color:lightgreen"),
                 h5("Homemade soap makers create their soap recipes in order for
                   their final product to exhibit certain qualities. This app 
                   allows you to adjust quantities of common soap oils to 
                   determine in real time the qualities of the final recipe. 
                   Simply enter the parameters for the superfat and water 
                   percentages then select which quality you wish to optimise 
                   for. On the 'Outcomes' tab, a bar plot represents the 
                   qualities of the current recipe with a green line indicating
                   the desired attribute level and red lines indicating the 
                   recommended ranges for each attribute. Simply adjust the 
                   quantities of the oils you wish to use. When you are happy 
                   with the qualities, click the 'Create Recipe' button and the
                   'Recipe' tab will display the quantities of the components 
                   for your optimised recipe.")),
        tabPanel(span("Qualities",style="color:lightgreen"), 
                 h4(span("Your Soap Recipe:",style="color:orange")), 
                 plotOutput("plot1"),
                 p(span("Adjust the oil quantities to achieve the desired attribute 
                   levels then click 'Create Recipe' when happy.", style="color:white"))),
        tabPanel(span("Recipe",style="color:lightgreen"),
                 h4(span("Recipe Components:",style="color:orange")),
                 h5("Water component:"),
                 textOutput("water"),
                 h5("Caustic component (NaOH):"),
                 textOutput("NaOH"),
                 h5("Oil components in grams:"),
                 tableOutput("oil"),
                 h5("Soap mass before cold process cure or hot process cook:"),
                 textOutput("tot"))
    )
  )
)))
