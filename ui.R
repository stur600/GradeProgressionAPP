#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RCurl)
library(networkD3)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  Network_df_NumberedNodes <- read.csv(file = "Network_df_NumberedNodes.csv"),
  links = Network_df_NumberedNodes,
  
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
                                        "5","5",'5')), #Source_group allows us to manually assign group to nodes.
  
  # Application title
  titlePanel("Sankey Network of Grade Progression Through Physics"),
  
 
  mainPanel(
      sankeyNetworkOutput("sankeyNetwork")
    )
  )
)
