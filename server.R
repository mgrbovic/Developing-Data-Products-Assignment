#
# This is the server logic of a StockForecast web application. You can run the 
# application by clicking 'Run App' above.

library(shiny)
library(quantmod)
library(forecast)

# Define server logic required
shinyServer(function(input, output) {

        
        # Determine fromDate (1st Jan 6 years before yestersday)
        today <- as.POSIXlt(as.Date(Sys.Date()), format="%Y-%m-%d")
        yesterday <- as.POSIXlt(as.Date(Sys.Date()) - 1, format="%Y-%m-%d")
        sixYearsAgo <- as.integer(substr(as.character(yesterday),1,4))-6
        fromDate <- as.Date(paste(as.character(sixYearsAgo), "-01-01", sep = ""))
        yesterdayMonth <- yesterday$mon + 1
        
        
        ################
        #Stock 1
        ################
        
        stock1Info <- reactive({
                index1 <- input$stock1

                if(index1 == "TEL.OL"){
                        print("TEL.OL: Telenor ASA stock index on Oslo stock exchange, Currency in NOK")
                } else if(index1 == "TMUS"){
                        print("TMUS: T-Mobile U.S. stock index on NASDAQ stock exchange, Currency in USD")
                } else if(index1 == "TKA.VI"){
                        print("TKA.VI: Telekom Austria stock index on Vienna stock exchange, Currency in EUR")
                } else if(index1 == "DTE.F"){
                        print("DTE.F: Deutsche Telekom stock index on Frankfurt stock exchange, Currency in EUR")
                } else if(index1 == "VZ"){
                        print("VZ: Verizon Communications stock index on New York stock exchange, Currency in USD")
                } else if(index1 == "VOD.L"){
                        print("VOD.L: Vodafone Group stock index on London stock exchange, Currency in GBP")
                } else if(index1 == "VIV"){
                        print("VIV: Telefonica S.A. stock index on New York stock exchange, Currency in USD")
                } else if(index1 == "ORAN"){
                        print("ORAN: Orange SA stock index on New York stock exchange, Currency in USD")
                } 
         
        })
        

        
        
        
        output$print1 <- renderText({
                stock1Info()
        })
        
        
        

        output$plot1 <- renderPlot({

                index1 <- input$stock1

                #Fetching historical stock data
                stockData1 <- getSymbols(index1, src = 'yahoo', from = fromDate,to = Sys.Date(), auto.assign=FALSE)
                monthlyValues1 <- to.monthly(stockData1)
                closeValues1 <- Cl(monthlyValues1)
                
                #Creating Time Series
                ts1 <- ts(closeValues1,frequency=12)
                
                #Creating Training and Testing data sets
                ts1Train <- window(ts1, start= 1, end = 5 - 1/12) #Training data set contains 4 years data
                ts1Test <- window(ts1, start= 5, end = 5+(dim(ts1)[1] - dim(ts1Train)[1])/12 - 1/12) #Testing data set contains remaining data
                
                #Forecasting Method - Exponential Smoothing
                ets1 <- ets(ts1Train, model="MMM")
                fcast1 <- forecast(ets1, h=dim(ts1Test)[1])
                
                plot(fcast1, type="o", pch= 20, col = "black", fcol= "red", shadecols = c("gray", "darkgray"),
                     main= "Company 1 - Stock closing value",
                     xlab= "Years", 
                     ylab= "Stock closing value")
                
                lines(ts1Test, type="o", pch= 20, col = "blue")

        })
        
        
 
        ################
        #Stock 2
        ################
        
        
        stock2Info <- reactive({
                index2 <- input$stock2
                
                if(index2 == "TEL.OL"){
                        print("TEL.OL: Telenor ASA stock index on Oslo stock exchange, Currency in NOK")
                } else if(index2 == "TMUS"){
                        print("TMUS: T-Mobile U.S. stock index on NASDAQ stock exchange, Currency in USD")
                } else if(index2 == "TKA.VI"){
                        print("TKA.VI: Telekom Austria stock index on Vienna stock exchange, Currency in EUR")
                } else if(index2 == "DTE.F"){
                        print("DTE.F: Deutsche Telekom stock index on Frankfurt stock exchange, Currency in EUR")
                } else if(index2 == "VZ"){
                        print("VZ: Verizon Communications stock index on New York stock exchange, Currency in USD")
                } else if(index2 == "VOD.L"){
                        print("VOD.L: Vodafone Group stock index on London stock exchange, Currency in GBP")
                } else if(index2 == "VIV"){
                        print("VIV: Telefonica S.A. stock index on New York stock exchange, Currency in USD")
                } else if(index2 == "ORAN"){
                        print("ORAN: Orange SA stock index on New York stock exchange, Currency in USD")
                } 
                
                
 
                
        })
        
        
        
        
        
        output$print2 <- renderText({
                stock2Info()
        })
        
        
        
        
        output$plot2 <- renderPlot({
                
                index2 <- input$stock2
                
                #Fetching historical stock data
                stockData2 <- getSymbols(index2, src = 'yahoo', from = fromDate,to = Sys.Date(), auto.assign=FALSE)
                monthlyValues2 <- to.monthly(stockData2)
                closeValues2 <- Cl(monthlyValues2)
                
                #Creating Time Serie2
                ts2 <- ts(closeValues2,frequency=12)
                
                #Creating Training and Testing data sets
                ts2Train <- window(ts2, start= 1, end = 5 - 1/12) #Training data set contains 4 years data
                ts2Test <- window(ts2, start= 5, end = 5+(dim(ts2)[1] - dim(ts2Train)[1])/12 - 1/12) #Testing data set contains remaining data
                
                #Forecasting Method - Exponential Smoothing
                ets2 <- ets(ts2Train, model="MMM")
                fcast2 <- forecast(ets2, h=dim(ts2Test)[1])
                
                plot(fcast2, type="o", pch= 20, col = "black", fcol= "red", shadecols = c("gray", "darkgray"),
                     main= "Company 2 - Stock closing value",
                     xlab= "Years", 
                     ylab= "Stock closing value")
                
                lines(ts2Test, type="o", pch= 20, col = "blue")
                
        })       

        
  
})
