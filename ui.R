library(shiny)
library(dplyr)
library(ggplot2)

shinyUI(
    navbarPage("NBA Team Statistics",
               tabPanel("Visualize Data",
                        sidebarPanel(
                            sliderInput("season",
                                        "Season(s)",
                                        min = 2012,
                                        max = 2016,
                                        value = c(2012,2016)),
                            checkboxGroupInput('teams', 'NBA Teams',
                                               sapply(teams,levels))
                            
                        ),
                        mainPanel(
                            h3("Visualizing NBA Offensive Efficiency", align = "Center"),
                            h4("Numbers above 100 are generally considered good.", align = "Center"),
                            plotOutput("offense"
                                       ),
                            h3("Visualizing NBA Defensive Efficiency", align = "center"),
                            h4("Number below 100 are generally considered good.", align = "Center"),
                            plotOutput("defence"
                                       ),
                            h3("Total Wins by Team per Season", align = "center"),
                            plotOutput("wins"
                                       )
                        )),
               tabPanel("Documentation",
                        mainPanel(
                            includeMarkdown("documentation.md")
                        ))
               )
)
