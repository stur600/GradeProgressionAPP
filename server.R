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
    
    #if we don't want to include physics 160 students...
    if(input$Physics160 == FALSE){ 
    #Manually create nodes dataframe 
    nodes = data.frame("name" = c("GPE_Top", 
                                  "GPE_Middle", 
                                  "GPE_Bottom", 
                                  
                                  "Physics120_Top", 
                                  "Physics120_Middle", 
                                  "Physics120_Bottom",
                                  
                                  "Physics150_Top",
                                  "Physics150_Middle",
                                  "Physics150_Bottom", 
                                 
                                  "S2GPA_Top",
                                  "S2GPA_Middle",
                                  "S2GPA_Bottom", 
                                  
                                  "S3GPA_Top",
                                  "S3GPA_Middle",
                                  "S3GPA_Bottom"),
                       
                       "Source_Group" = c("1","1","1",
                                          "2",'2',"2",
                                          '3',"3","3",
                                          "4","4",'4',
                                          "5","5",'5')) #Source_group allows us to manually assign group to nodes.
    
    #Load data for network links (These files do not include physics160 students)
    Network_df_NumberedNodes <- read.csv(file = "Network_df_NumberedNodes.csv")
    female_prop_links <- read.csv(file = "female_prop_links.csv")
    male_prop_links <- read.csv(file = "male_prop_links.csv")
    male_links <- read.csv(file = "male_links.csv")
    female_links <- read.csv(file = "female_links.csv")
    prop_by_gender_F <- read.csv(file = "prop_by_gender_F.csv")
    prop_by_gender_M <- read.csv(file = "prop_by_gender_M.csv")
    
    #make sankey network using dataset specified by user. 
    if(input$dataset == "Raw Counts"){
      links = Network_df_NumberedNodes
      sankeyNetwork(Links = links, Nodes = nodes,
                  Source = "Source", Target = "Target",
                  Value = "n", NodeID = "name",
                  NodeGroup = "Source_Group",
                  LinkGroup = "gender", 
                  units = "students",
                  nodePadding = 75,
                  fontSize= 12, nodeWidth = 20,
                  colourScale = "d3.scaleOrdinal().range(['#ef8a62','#67a9cf','#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}   #First two colours are the links, last 5 are the nodes.
    
      else if(input$dataset == "Female Counts"){
        links = female_links
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "students",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
    
        else if(input$dataset == "Male Counts"){
          links = male_links
          sankeyNetwork(Links = links, Nodes = nodes,
                        Source = "Source", Target = "Target",
                        Value = "n", NodeID = "name",
                        NodeGroup = "Source_Group",
                        units = "students",
                        nodePadding = 75,
                        fontSize= 12, nodeWidth = 20,
                        colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
    
          else if(input$dataset == "Female Percentage"){
            links= female_prop_links
            sankeyNetwork(Links = links, Nodes = nodes,
                          Source = "Source", Target = "Target",
                          Value = "n", NodeID = "name",
                          NodeGroup = "Source_Group",
                          units = "percent female",
                          nodePadding = 75,
                          fontSize= 12, nodeWidth = 20,
                          colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
    
            else if(input$dataset == "Male Percentage"){
              links = male_prop_links
              sankeyNetwork(Links = links, Nodes = nodes,
                            Source = "Source", Target = "Target",
                            Value = "n", NodeID = "name",
                            NodeGroup = "Source_Group",
                            units = "percent male",
                            nodePadding = 75,
                            fontSize= 12, nodeWidth = 20,
                            colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
    
              else if(input$dataset == "Female Percentage of Source"){
                links = prop_by_gender_F
                sankeyNetwork(Links = links, Nodes = nodes,
                              Source = "Source", Target = "Target",
                              Value = "n", NodeID = "name",
                              NodeGroup = "Source_Group",
                              units = "percent",
                              nodePadding = 75,
                              fontSize= 12, nodeWidth = 20,
                              colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
    
                else if(input$dataset == "Male Percentage of Source"){
                  links = prop_by_gender_M
                  sankeyNetwork(Links = links, Nodes = nodes,
                                Source = "Source", Target = "Target",
                                Value = "n", NodeID = "name",
                                NodeGroup = "Source_Group",
                                units = "percent",
                                nodePadding = 75,
                                fontSize= 12, nodeWidth = 20,
                                colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
                          
    #if we want to include physics for life science students... 
    } else { 
      nodes = data.frame("name" = c("GPE_Top", 
                                    "GPE_Middle", 
                                    "GPE_Bottom", 
                                    
                                    "Physics160_Top", #include Physics160 tertiles in our nodes
                                    "Physics160_Middle",
                                    "Physics160_Bottom",
                                    
                                    "Physics120_Top", 
                                    "Physics120_Middle", 
                                    "Physics120_Bottom",
                                    
                                    "Physics150_Top",
                                    "Physics150_Middle",
                                    "Physics150_Bottom", 
                                    
                                    
                                    "S2GPA_Top",
                                    "S2GPA_Middle",
                                    "S2GPA_Bottom", 
                                    
                                    "S3GPA_Top",
                                    "S3GPA_Middle",
                                    "S3GPA_Bottom"),
                         
                         "Source_Group" = c("1","1","1",
                                            "2",'2',"2",
                                            '3',"3","3",
                                            "4","4",'4',
                                            "5","5",'5',
                                            "6", "6", "6")) #Source_group allows us to manually assign group to nodes.
      
      #Load data for network links (these files include physics 160 students)
      Network_df_NumberedNodes <- read.csv(file = "Network_df_NumberedNodes_160.csv")
      female_prop_links <- read.csv(file = "female_prop_links_160.csv")
      male_prop_links <- read.csv(file = "male_prop_links_160.csv")
      male_links <- read.csv(file = "male_links_160.csv")
      female_links <- read.csv(file = "female_links_160.csv")
      prop_by_gender_F <- read.csv(file = "prop_by_gender_F_160.csv")
      prop_by_gender_M <- read.csv(file = "prop_by_gender_M_160.csv")
      
      # create sankey network based on input specified by user.
      if(input$dataset == "Raw Counts"){
        links = Network_df_NumberedNodes
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      LinkGroup = "gender", 
                      units = "students",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#ef8a62','#67a9cf','#f7f7f7', '#a1dab4','#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}   #First two colours are the links, last 5 are the nodes.
      
      else if(input$dataset == "Female Counts"){
        links = female_links
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "students",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
      else if(input$dataset == "Male Counts"){
        links = male_links
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "students",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
      else if(input$dataset == "Female Percentage"){
        links= female_prop_links
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "percent female",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
      else if(input$dataset == "Male Percentage"){
        links = male_prop_links
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "percent male",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
      else if(input$dataset == "Female Percentage of Source"){
        links = prop_by_gender_F
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "percent",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
      else if(input$dataset == "Male Percentage of Source"){
        links = prop_by_gender_M
        sankeyNetwork(Links = links, Nodes = nodes,
                      Source = "Source", Target = "Target",
                      Value = "n", NodeID = "name",
                      NodeGroup = "Source_Group",
                      units = "percent",
                      nodePadding = 75,
                      fontSize= 12, nodeWidth = 20,
                      colourScale = "d3.scaleOrdinal().range(['#f7f7f7', '#a1dab4', '#a1dab4', '#31a354', '#006d2c'])")}
      
    }
    })
})
    

