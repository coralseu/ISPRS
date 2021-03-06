library(shiny)
library(shinydashboard)
library(leaflet)
library(plotly)
library(ggplot2)
library(data.table)
library(ggmap)

ui <- dashboardPage(
    dashboardHeader(
        title = "Transit Analyst"
    ),
    
    dashboardSidebar(
        sidebarMenu(
            menuItem("Bus line profile", tabName = "line", icon = icon("check")),
            menuItem("Bus station profile", tabName = "station", icon = icon("circle")),
            menuItem("Transit OD", tabName = "transit", icon = icon("bus")),
            menuItem("Transit accessibility", tabName = "playground", icon = icon("exchange"))
        ),
        div(style = "padding-left: 15px; padding-top: 40px;",
            p(class = "small", "Made with ",
              a("R", href = "http://www.r-project.org/"),
              ", ",
              a("Shiny", href = "http://shiny.rstudio.com/"),
              ", ",
              a("shinydashboard", href = "http://rstudio.github.io/shinydashboard/"),
              ", ",
              a("leaflet", href = "http://rstudio.github.io/leaflet/"),
              ", ",
              a("plotly", href = "https://plot.ly/"),
              ", ",
              a("ggplot2", href = "http://ggplot2.org/")
            ),
            p(class = "small", "Data from", 
              a("ISPRS (深圳)", href = "http://citysensing.cn/opencup/home.html")
            ),
            p(class = "small", "View", 
              a("Source code", href = "https://github.com/coralseu/ISPRS")
            ),
            p(class = "small", "Author", 
              a("Yiling Deng (邓一凌)", href = "http://coralseu.github.io")
            )
        )
    ),
    
    dashboardBody(
        tabItems(
            # bus line profile ------------------------------------------------------
            tabItem(tabName = "line",
                    fluidRow(
                        box(selectInput("selectLine", "选择公交线路名称", routeIndex$name))
                    ),
                    fluidRow(
                        infoBoxOutput("stationCount"),
                        infoBoxOutput("passengerVolumn"),
                        infoBoxOutput("routeLength"),
                        infoBoxOutput("routeIndirect"), 
                        infoBoxOutput("headway"), 
                        infoBoxOutput("vehicle"),
                        infoBoxOutput("volumnByLength"),
                        infoBoxOutput("avgHaulDistance"),
                        infoBoxOutput("turnoverTime"),
                        infoBoxOutput("peakHourRatio"),
                        infoBoxOutput("operationTime"),
                        infoBoxOutput("operationCompany")
                    ),
                    fluidRow(
                        box(width = 12, title = "公交线路示意图", leafletOutput("line_map"))
                    ),
                    fluidRow(
                        box(width = 12, title = "客流站点分布图", plotlyOutput("total_volumn"))
                    ),
                    fluidRow(
                        box(width = 12, title = "客流时间分布图", plotlyOutput("time_volumn"))
                    ),
                    fluidRow(
                        box(width = 12, title = "公交车辆运行图", plotlyOutput("travel_diagram"))
                    )
            ),
            # bus station profile ---------------------------------------------------
            tabItem(tabName = "station",
                    fluidRow(
                        box(width = 12, title = "站点空间分布图", leafletOutput("station_map"))
                    ),
                    fluidRow(
                        box(width = 12, title = "站点客流分布图", leafletOutput("station_volumn"))
                    )
            ),
            # transit OD ------------------------------------------------------------
            tabItem(tabName = "transit", 
                    fluidRow(
                        box(width = 12, title = "公交出行起点聚类图", leafletOutput("transit_O"))
                    ),
                    fluidRow(
                        box(width = 12, title = "公交出行讫点聚类图", leafletOutput("transit_D"))
                    ),
                    fluidRow(
                        box(sliderInput("range", "选择OD客流量", min = 3000, max = 9000, value = c(7000, 9000)))
                    ),
                    fluidRow(
                        box(width = 12, title = "公交出行OD图", leafletOutput("transit_OD"))
                    )

            ),
            # transit play ------------------------------------------------------------            
            tabItem(tabName = "playground", 
                    fluidRow(
                        box(sliderInput("radius", "选择缓冲区半径", min = 100, max = 1000, value = 500, step = 50))
                    ),
                    fluidRow(
                        box(width = 12, title = "单击选择位置", leafletOutput("get_location"))
                    ),
                    fluidRow(
                        box(width = 12, title = "途径公交线路", leafletOutput("dis_transit"))
                    )
            )
        )
    )
)