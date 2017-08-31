#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RCurl)
library(networkD3)
# Define server logic required to draw a sankey network
shinyServer(function(input, output) {
   
  output$sankeyNetwork <- renderSankeyNetwork({
    
    # Load data for network links
    Network_df_NumberedNodes <- read.csv(file = "C:/Users/stur600/Documents/Network_df_NumberedNodes.csv")
    links = Network_df_NumberedNodes
        
    #Manually create nodes dataframe 
    nodes = data.frame("name" = c("GPE_Bottom", 
                                  "GPE_Middle", 
                                  "GPE_Top", 
                                  
                                  "Physics120_Bottom", 
                                  "Physics120_Middle", 
                                  "Physics120_Top",
                              
                                  "Physics150_Bottom",
                                  "Physics150_Middle",
                                  "Physics150_Top", 
                                  
                                  # "Physics160_Bottom", #Comment out to exclude Physics160 students
                                  # "Physics160_Middle",
                                  # "Physics160_Top",
                                  
                                  "S2GPA_Bottom",
                                  "S2GPA_Middle",
                                  "S2GPA_Top", 
                                      
                                  "S3GPA_Bottom",
                                  "S3GPA_Middle",
                                  "S3GPA_Top"),
                           
                       "Source_Group" = c("1","1","1",
                                          "2",'2',"2",
                                          '3',"3","3",
                                          "4","4",'4',
                                          "5","5",'5')) #Source_group allows us to manually assign group to nodes.
        
        
        
      sankeyNetwork(Links = links, Nodes = nodes,
                    Source = "Source", Target = "Target",
                    Value = "n", NodeID = "name",
                    NodeGroup = "Source_Group",
                    LinkGroup = "gender", 
                    fontSize= 12, nodeWidth = 20,
                    units = "students",
                    colourScale = "d3.scaleOrdinal().range(['#ef8a62','#67a9cf','#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])") #First two colours are the links, last 5 are the nodes.
      })
    })
    

