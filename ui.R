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


# Define UI for application that draws a sankey
shinyUI(fluidPage(
  
 
  
  Network_df_NumberedNodes <- read.csv(file = "Network_df_NumberedNodes.csv"),
  female_prop_links <- read.csv(file = "female_prop_links.csv"),
  male_prop_links <- read.csv(file = "male_prop_links.csv"),
  male_links <- read.csv(file = "male_links.csv"),
  female_links <- read.csv(file = "female_links.csv"),
  
  
  
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
                                
                                # "Physics160_Top", #Comment out to exclude Physics160 students
                                # "Physics160_Middle",
                                # "Physics160_Bottom",
                                
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
                                        "5","5",'5')), #Source_group allows us to manually assign group to nodes.
  
  # Application title
  titlePanel("Sankey Network of Grade Progression Through Physics"),
  
  sidebarLayout(

    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("Raw Counts", "Female Counts", "Male Counts", "Female Percentage of Total", "Male Percentage of Total", "Female Percentage of Source", "Male Percentage of Source")),
      
      checkboxInput(inputId = "Physics160", 
                    label = "Include Physics 160 (Physics for Life Sciences)?")),
  
  mainPanel(
      sankeyNetworkOutput("sankeyNetwork")
    ))
  
))
