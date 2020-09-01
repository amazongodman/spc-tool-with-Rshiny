#server.r
#library(shiny)
#library(tidyverse)
#library(lubridate)
#library(plotly)
#library(data.table)

if(require("data.table")==T){print("data.table")}else{
  install.packages("data.table")
  require("dplyr")}
if(require("plotly")==T){print("exist")}else{
  install.packages("plotly")
  require("plotly")}
if(require("shiny")==T){print("exist")}else{
  install.packages("shiny")
  require("shiny")}

if(require("tidyverse")==T){print("exist")}else{
  install.packages("tidyverse")
  require("tidyverse")}

if(require("lubridate")==T){print("exist")}else{
  install.packages("lubridate")
  require("lubridate")}












tdfpath<-"data/tdf2017.csv"
tdppath<-"data/TDP.csv"


shinyServer(function(input, output) {

#                                output$text1 <- renderText({
#                                })
                                output$table1 <- renderTable({ 　
                                  head(iris)
                                })


















tdf <- read.csv(tdfpath,stringsAsFactors = F)
tdp <- read.csv(tdppath,stringsAsFactors = F)


#unique(tdf$CLRCDF)
tdf_col<-unique(tdf$CLRCDF)
colers=1
#tdf_col[colers]

tdf$ITMCDF <- gsub(" ","",tdf$ITMCDF)
tdp$ITMCDP <- gsub(" ","",tdp$ITMCDP)

tdf$SHSCDF <- as.numeric(tdf$SHSCDF)

unis<-unique(tdp$ITMCDP)#20200604[1:20]

#length(unis)
items=1
#unis[items]

tdf$SIOUDF<-ymd(tdf$SIOUDF)
tdp$YMD<-ymd(paste0(tdp$YMTGDP,"28"))

tdf_item10<- tdf[which(tdf$ITMCDF%in%unis),]%>% 
  filter(SIOUDF>=ymd("2017-01-01"))%>% 
  filter(CLRCDF>=tdf_col[colers])

tdp_item10<- tdp[which(tdp$ITMCDP%in%unis),]%>% 
  filter(YMD>=ymd("2017-01-01"))%>% 
  filter(CLRCDP>=tdf_col[colers])

tdf_item1<-tdf_item10[tdf_item10$ITMCDF==unis[items],]
tdp_item1<-tdp_item10[tdp_item10$ITMCDP==unis[items],]


upfac<-c(5,4,7,8,10)
downfac<-c(55,54,57,58,60)

increase<-tdf_item1[which(tdf_item1$SHSCDF%in%upfac),]
increase<-increase%>%group_by(SIOUDF,SHSCDF)%>%summarise(SIOQDF=sum(SIOQDF))

decrease<-tdf_item1[which(tdf_item1$SHSCDF%in%downfac),]
decrease<-decrease%>%group_by(SIOUDF,SHSCDF)%>%summarise(SIOQDF=sum(SIOQDF))

'%notin%' <- Negate('%in%')
other<-tdf_item1[which(tdf_item1$SHSCDF %notin% c(upfac,6,downfac,56)),]

#unique(tdf_item1$SHSCDF)
##########################################

in_other<-other[50>other$SHSCDF,]
in_other<-in_other%>%
  group_by(SIOUDF,SHSCDF)%>%
  summarise(SIOQDF=sum(SIOQDF))

dw_other<-other[other$SHSCDF>49,]
dw_other<-dw_other%>%
  group_by(SIOUDF,SHSCDF)%>%
  summarise(SIOQDF=sum(SIOQDF))

###############################################

increase <- data.frame(
           SIOUDF=increase$SIOUDF,
           SIOQDF=increase$SIOQDF,
           SHSCDF=increase$SHSCDF)

decrease <- data.frame(
  SIOUDF=decrease$SIOUDF,
  SIOQDF=decrease$SIOQDF,
  SHSCDF=decrease$SHSCDF)

#max(ymd(tdf$SIOUDF))

dt <- data.table(date.hour = seq(ymd("20170101"), ymd("20200430"), by='day'))

d_10 <- increase[increase$SHSCDF==10,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code10<-d_10

###########

d_10 <- increase[increase$SHSCDF==4,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code4<-d_10


d_10 <- increase[increase$SHSCDF==5,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code5<-d_10


d_10 <- increase[increase$SHSCDF==7,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code7<-d_10






d_10 <- increase[increase$SHSCDF==8,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code8<-d_10
####################################################################

d_10 <- decrease[decrease$SHSCDF==60,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 

code60<-d_10


d_10 <- decrease[decrease$SHSCDF==54,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 
code54<-d_10



d_10 <- decrease[decrease$SHSCDF==55,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 
code55<-d_10


d_10 <- decrease[decrease$SHSCDF==57,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 
code57<-d_10


d_10 <- decrease[decrease$SHSCDF==58,]
setkey(setDT(d_10), SIOUDF)
d_10<-d_10[dt]
d_10<-data.frame(d_10)
d_10$SIOQDF <- tidyr::replace_na(d_10$SIOQDF, 0) 
code58<-d_10


######################################################################

upper<-data.frame(dth=data.frame(dt),
                  code4=code4$SIOQDF,
                  code5=code5$SIOQDF,
                  code7=code7$SIOQDF,
                  code8=code8$SIOQDF,
                  code10=code10$SIOQDF)
upper$rowsum <- rowSums(upper[,2:6])

downer<-data.frame(dth=data.frame(dt),
                   code54=code54$SIOQDF,
                   code55=code55$SIOQDF,
                   code57=code57$SIOQDF,
                   code58=code58$SIOQDF,
                   code60=code60$SIOQDF)
downer$rowsum <- rowSums(downer[,2:6])
##########################################

end<-length(tdp_item1$YMD)-1

bind<-NULL
reduce_cumsum<-NULL
increase_cumsum<-NULL
for(i in 1:end){
stoc<-tdp_item1$ACT[tdp_item1$YMD==tdp_item1$YMD[i]]

up_cal<-upper %>% filter(ymd(upper$date.hour) >= ymd(tdp_item1$YMD[i]))
up_cal2 <- up_cal[ymd(tdp_item1$YMD[i+1]) > ymd(up_cal$date.hour) ,]

dw_cal<-downer %>% filter(ymd(downer$date.hour) >= ymd(tdp_item1$YMD[i]))
dw_cal2 <- dw_cal[ymd(tdp_item1$YMD[i+1]) > ymd(dw_cal$date.hour) ,]

up_cal2$rowsum[1] <-up_cal2$rowsum[1]+stoc
stoc_trend <- (up_cal2$rowsum - dw_cal2$rowsum)
stoc_trend<-cumsum(stoc_trend)

bind <- c(bind,stoc_trend)

reduce_cumsum<-c(reduce_cumsum,cumsum(dw_cal2$code60))
increase_cumsum<-c(increase_cumsum,cumsum(up_cal2$code10))
}



bind_time<-upper$date.hour[ymd(upper$date.hour)>=ymd(tdp_item1$YMD[1])]
bind_time<-bind_time[tdp_item1$YMD[i+1]>bind_time]

#############

upper2<-upper
downer2<-downer
bind_time2<-bind_time


                                output$plot4 <- renderPlotly(


fig2 <- plot_ly(x = ~upper2$date.hour, y = ~upper2$code4, type = 'bar', name = 4)%>% 
add_trace(x = ~upper2$date.hour, y = ~upper2$code5, name = 5) %>% 
add_trace(x = ~upper2$date.hour, y = ~upper2$code7, name = 7) %>% 
add_trace(x = ~upper2$date.hour, y = ~upper2$code8, name = 8) %>% 
add_trace(x = ~upper2$date.hour, y = ~upper2$code10, name = 10) %>% 
add_trace(x = ~downer2$date.hour, y = ~downer2$code54,base = -downer2$code54, name = 54) %>% 
add_trace(x = ~downer2$date.hour, y = ~downer2$code55,base = -(downer2$code55+downer2$code54), name = 55) %>% 
add_trace(x = ~downer2$date.hour, y = ~downer2$code57,base = -(downer2$code57+downer2$code55+downer2$code54), name = 57) %>% 
add_trace(x = ~downer2$date.hour, y = ~downer2$code58,base = -(downer2$code58+downer2$code57+downer2$code55+downer2$code54), name = 58) %>% 
add_trace(x = ~downer2$date.hour, y = ~downer2$code60,base = -(downer2$code60+downer2$code58+downer2$code57+downer2$code55+downer2$code54), name = 60) %>% 
layout(title=paste0(tdf_col[colers],"-",unis[items]),yaxis = list(title = 'Count'),xaxis = list(title = 'y-m-d'), barmode = 'stack') %>% 
add_lines(x = ~bind_time2, y = ~bind, line = list(shape="hv",dash="dot"), name = "act stoc",
fill="tonexty") %>% 
add_lines(x = ~bind_time2, y = ~reduce_cumsum, line = list(shape="hv"), name = "month decrease") %>% 
add_lines(x = ~bind_time2, y = ~increase_cumsum, line = list(shape="hv"), name = "month increase") %>% 
add_lines(x = ~downer2$date.hour, y = ~cumsum(downer2$code60), line = list(shape="hv"), name = "year decrease") %>% 
add_lines(x = ~upper2$date.hour, y = ~cumsum(upper2$code10), line = list(shape="hv"), name = "year increase") %>% 

layout(
    title = "Stock",
    xaxis = list(

rangeselector = 
list(
        buttons = list(
          list(count = 3,label = "3 mo",step = "month",stepmode = "backward"),
          list(count = 6,label = "6 mo",step = "month",stepmode = "backward"),
          list(count = 1,label = "1 yr",step = "year",stepmode = "backward"),
          list(count = 1,label = "YTD",step = "year",stepmode = "todate"),
          list(step = "all")
         )
),

rangeslider = list(type = "date")),
yaxis = list(title = "value"))





                                )






tdp2 <- read.csv(tdppath,stringsAsFactors = F)

tdp2$day <- ymd(paste0(tdp2$YMTGDP,"28"))
tdp2$uni<-paste0(tdp2$ITMCDP,"-",tdp2$CLRCDP)
tdp3<-tdp2[tdp2$day==max(tdp2$day),]

output$plot5 <- renderPlotly(
fig3 <- plot_ly(data = tdp3, x = ~log(CONSUME), y = ~log(ACT), color = ~uni)
)










en <- data.frame(item=tdp3$ITMCDP,co=tdp3$CLRCDP,act=tdp3$ACT)

en2 <- en %>% group_by(item) %>% summarise(act=sum(act))
en2$pa<-""




output$plot6 <- renderPlotly(

fig4 <- plot_ly(
  labels = c(en$co,en2$item),
  parents = c(en$item,en2$pa),
  values = c(en$act,en2$act),
  type = 'sunburst',
  branchvalues = 'total'
)

)












}#functionの定義の終わり
)#shinyserverの終わり