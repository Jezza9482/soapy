# Soapy
Shiny app code files and an *Excel* data workbook for a homemade soap recipe optimising app.

This *shiny* app takes slider inputs for masses (0-400g) of 6 oils used in homemade soap recipes:  

 - Coconut Oil  
 - Castor Oil  
 - Palm Oil  
 - Canola Oil  
 - Olive Oil  
 - Milk Fat  

It sets parameters for the superfat % and the water % and prompts for a target attribute and value from:  

 - Hardness  
 - Creamy  
 - Condition  
 - Cleansing  
 - Bubbly  
 
A bar plot of the resulting attributes is reactively created in real time and compared against community recommendations and the targeted attribute level. Oil masses can be adjusted until the optimum combination is found. When satisfied with the attributes of the recipe, a "Create Recipe" button can be pressed which calculates the requirements of water and NaOH for the given oil quantities and determines the total soap mass before coldprocess curing or hot process cooking. The app is available at: <http://jezza9482.shinyapps.io/soapy/>. A brief (5 slide) app pitch presentation is available at: <http://rpubs.com/Jezza9482/338152>