#
# This is the user-interface definition of a StockForecast web application. You can
# run the application by clicking 'Run App' above.


library(shiny)
library(quantmod)
library(forecast)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Stock Forecast web application"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
            
            selectInput("stock1", label = h3("Select company 1"), 
                        choices = list("Telenor ASA" = "TEL.OL", 
                                       "T-Mobile U.S." = "TMUS",
                                       "Telekom Austria" = "TKA.VI",
                                       "Deutsche Telekom" = "DTE.F",
                                       "Verizon Communications" = "VZ",
                                       "Vodafone Group" = "VOD.L",
                                       "Telefonica S.A." = "VIV",
                                       "Orange SA" = "ORAN"
                                       ), selected = "TEL.OL"),
            
            selectInput("stock2", label = h3("Select company 2"), 
                        choices = list("Telenor ASA" = "TEL.OL", 
                                       "T-Mobile U.S." = "TMUS",
                                       "Telekom Austria" = "TKA.VI",
                                       "Deutsche Telekom" = "DTE.F",
                                       "Verizon Communications" = "VZ",
                                       "Vodafone Group" = "VOD.L",
                                       "Telefonica S.A." = "VIV",
                                       "Orange SA" = "ORAN"
                        ), selected = "TKA.VI"),
            
            h4("This application:"),"- is using historical stock prices data from https://finance.yahoo.com for some of the major telecommunication companies and forecats their stock values using Forecasting time series method Exponential smoothing",
            
            h4("Black line:"),"- represents historical stock values from 2011. until 2014. (4 years data used as Training data)",
            h4("Red line:"),"- represents forecasted stock values from 2015. until 2017. (using Forecasting time series method Exponential smoothing)",
            h4("Blue line:"),"- represents historical stock values from 2015. until 2017. (2 years data used as Testing data)"
            
            

    ),
    

    # Show a plot
    mainPanel(
            h3("Forecasted stock value for Company 1:"),
            textOutput("print1"),
            plotOutput("plot1"),
            
            h3("Forecasted stock value for Company 2:"),
            textOutput("print2"),
            plotOutput("plot2"),
            
            "The application is using historical stock prices data from <https://finance.yahoo.com>"
            
    )
    
  )
  
  
))
