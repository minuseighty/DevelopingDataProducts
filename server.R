library(shiny)
library(dplyr)
library(ggplot2)

## load and process data
source("data.R")
teams <- as.data.frame(sort(unique(nba$Team)))
names(teams) <- "TeamName"

shinyServer(
    function(input,output) {
        
        ## initialize reactive values
        values <- reactiveValues()
        values$teams <- sapply(teams,levels)
        
        
        ## offense plot
        output$offense <- renderPlot({
            filtered <- 
                nba %>%
                filter(Year >= input$season[1],
                       Year <= input$season[2],
                       Team %in% input$teams
                )
            
            ggplot(filtered,aes(Year, OEFF, colour = Team)) +
                geom_point() +
                geom_line() +
                theme(legend.position = "left") +
                ylab("Offensive Efficiency") +
                coord_cartesian(xlim = c(2012,2016)) +
                xlab("Year")
        })
           
        output$defence <- renderPlot({
            filtered <- 
                nba %>%
                filter(Year >= input$season[1],
                       Year <= input$season[2],
                       Team %in% input$teams
                )
            
            ggplot(filtered,aes(Year, DEFF, colour = Team)) +
                geom_point() +
                geom_line() +
                theme(legend.position = "left") +
                ylab("Defensive Efficiency") +
                coord_cartesian(xlim = c(2012,2016)) +
                xlab("Year")
        })        
                
        output$wins <- renderPlot({
            filtered <- 
                nba %>%
                filter(Year >= input$season[1],
                       Year <= input$season[2],
                       Team %in% input$teams
                )
            filtered2 <-
                filtered %>%
                group_by(Team)
                    summarise(filtered2, sum(WINS))
                    
             ggplot(filtered2, aes(Team,WINS, colour = Team)) +
                 geom_bar(stat = "identity") +
                 ylab("Total Wins") +
                 xlab("Teams")
                 
                    
        })
        
        
    })
