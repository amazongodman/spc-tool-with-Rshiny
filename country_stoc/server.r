library(shiny)
library(RODBC)
#library(stringr)
library(tidyverse)
#input data and some compute data
shinyServer(function(input, output) {

  output$FA000 <- renderTable({

connOracle <- odbcConnect(input$odbc, input$user, input$pass)

qt <- paste0(
"select YMTGDP, ITMCDP, sum(ASCQDP) as SUMASCQDP from ",
input$country,
".TDP00 ",
"where ITMCDP IN ( select ITMCA0 from " , 
input$country,
".FA000 ",
"where ",
"SIZCA0 = \'",
input$SIZCA0,
"\' ",
"and ",
"CHNCA0 = \'",
input$CHNCA0,
"\' ",
"and ",
"CLSCA0 = \'",
input$CLSCA0,
"\' ",
"and ",
"TAPCA0 = \'",
input$TAPCA0,
"\' ",
"and ",
"ST1CA0 || ST2CA0 || ST3CA0 || ST4CA0 || ST5CA0 || ST6CA0 || ST7CA0 like \'",
input$statistic,
"\' ",
") and NOT DPTCDP = \'99\' ",
"and CLRCDP = \'",
input$clrc,
"\' ",
"and DPTCDP = \'",
input$depot,
"\' ",
"group by YMTGDP, ITMCDP")

data1 <- input$non_use

if(data1[1] != 0){

check1<-match(data1,1)
check1[is.na(check1)]<-0

check2<-match(data1,2)
check2[is.na(check2)]<-0

check3<-match(data1,3)
check3[is.na(check3)]<-0

check4<-match(data1,4)
check4[is.na(check4)]<-0



check5<-match(data1,5)
check5[is.na(check5)]<-0

check6<-match(data1,6)
check6[is.na(check6)]<-0



sp <- str_split(qt, pattern = " ")
sp <- data.frame(sp)


if(sum(check6)==1){
sp <- sp[-(59:62),] 
sp <- data.frame(sp)
}else{}

if(sum(check5)==1){
sp <- sp[-(55:58),] 
sp <- data.frame(sp)
}else{}



if(sum(check4)==1){
sp <- sp[-(33:48),]
sp <- data.frame(sp)
}else{}

if(sum(check3)==1){
sp <- sp[-(29:32),]
sp <- data.frame(sp)
}else{}

if(sum(check2)==1){
sp <- sp[-(25:28),]
sp <- data.frame(sp)
  }else{}

if(sum(check1)==1){
  sp <- sp[-(21:24),]
  sp <- data.frame(sp)
  }else{}

#why trans dataframe was work well?? fuck!!

kuru<-nrow(sp)
#why not use nrow ?? << when remove some row , 1 col data frame will change vector 

bind_remo<-NULL
for(ss in 1:kuru){
pas <- as.character(sp[ss,])
bind_remo<-paste(bind_remo, pas)
}
SqL <-paste(bind_remo)
} else if (data1[1] == 0){
SqL <- qt 
}


SqL <- gsub("&", " ", SqL)
SqL <<- gsub("&", " ", SqL)


#SqL <- sub("--", "  ", SqL)
#SqL <<- sub("-", " ", SqL)


r.tbl <<- sqlQuery(connOracle, SqL )
odbcClose(connOracle)

head(r.tbl,1)

  })





















































































  output$TDF00 <- renderTable({

connOracle <- odbcConnect(input$odbc, input$user, input$pass)

tdf <<- paste0(
"select sioudf, sum(sioqdf) as SUMUDF from ",
input$country,
".TDF00 ",
"where ITMCDF IN ( select ITMCA0 from " , 
input$country,
".FA000 ",
"where ",
"SIZCA0 = \'",
input$SIZCA0,
"\' ",
"and ",
"CHNCA0 = \'",
input$CHNCA0,
"\' ",
"and ",
"CLSCA0 = \'",
input$CLSCA0,
"\' ",
"and ",
"TAPCA0 = \'",
input$TAPCA0,
"\' ",
"and ",
"ST1CA0 || ST2CA0 || ST3CA0 || ST4CA0 || ST5CA0 || ST6CA0 || ST7CA0 like \'",
input$statistic,
"\' ",
") and NOT DPTCDF = \'99\' and shscdf = \'60\' ",
"and CLRCDF = \'",
input$clrc,
"\' ",
"and DPTCDF = \'",
input$depot,
"\' ",
"group by sioudf")

data1 <<- input$non_use

if(data1[1] != 0){

check1<-match(data1,1)
check1[is.na(check1)]<-0

check2<-match(data1,2)
check2[is.na(check2)]<-0

check3<-match(data1,3)
check3[is.na(check3)]<-0

check4<-match(data1,4)
check4[is.na(check4)]<-0

check5<-match(data1,5)
check5[is.na(check5)]<-0

check6<-match(data1,6)
check6[is.na(check6)]<-0



sp <- str_split(tdf, pattern = " ")
sp <- data.frame(sp)

if(sum(check6)==1){
sp <- sp[-(62:65),] 
sp <- data.frame(sp)
}else{}

if(sum(check5)==1){
sp <- sp[-(58:61),] 
sp <- data.frame(sp)
}else{}


if(sum(check4)==1){
sp <- sp[-(32:47),] 
sp <- data.frame(sp)
}else{}

if(sum(check3)==1){
sp <- sp[-(28:31),]
sp <- data.frame(sp)
}else{}

if(sum(check2)==1){
sp <- sp[-(24:27),]
sp <- data.frame(sp)
  }else{}

if(sum(check1)==1){
  sp <- sp[-(20:23),]
  sp <- data.frame(sp)
  }else{}

#why trans dataframe was work well?? fuck!!
kuru<-nrow(sp)
#why not use nrow ?? << when remove some row , 1 col data frame will change vector 

bind_remo<-NULL
for(ss in 1:kuru){
pas <- as.character(sp[ss,])
bind_remo<-paste(bind_remo, pas)
}
tdf_SqL <- paste(bind_remo)
} else if (data1[1] == 0){
tdf_SqL <- tdf 
}

#<-str_pad(c("9", "10"), 3L, "0")

#tdf_SqL <- sub("--", "  ", tdf_SqL)
tdf_SqL <- gsub("&", " ", tdf_SqL)
tdf_SqL <<- gsub("&", " ", tdf_SqL)

tdf.tbl <<- sqlQuery(connOracle, tdf_SqL)
odbcClose(connOracle)

head(tdf.tbl,1)

  })

  output$qy <- renderText({
  print(SqL)
  })

  output$che <- renderText({
  print(tdf_SqL)
  })

  output$plot <- renderPlot({

df <- group_by(r.tbl, YMTGDP)
df <- select(df, YMTGDP, SUMASCQDP)
df <- group_by(r.tbl, YMTGDP)
df <- df[order(r.tbl$YMTGDP),]
df <- summarize(df, n = n(), SUM = sum(SUMASCQDP))
#head(df,100)
#write.csv(df,"TDP.csv",row.names=F)

df2 <- tdf.tbl[order(tdf.tbl$SIOUDF),]
#write.csv(df2,"TDF.csv",row.names=F)
#head(df2,30)

start_time<-gsub("-","",input$start)
end_time<-gsub("-","",input$end)
start_time2<-substr(start_time,1,6)
end_time2<-substr(end_time,1,6)

df <- df[df$YMTGDP>=as.numeric(start_time2) & df$YMTGDP<=as.numeric(end_time2),]
df2 <- df2[df2$SIOUDF>=as.numeric(start_time) & df2$SIOUDF<=as.numeric(end_time),]








df$ind<-c(1:nrow(df))
plot(df$ind, df$SUM, type="n", xlab="",ylab="",xaxt="n",ylim=c(0,max(df[,3])), main = input$country)
axis(1,at=df$ind, labels = df$YMTGDP,las=2)

end<-nrow(df)-1

for(o in 1:end){
  oo<-o+1
segments(o, df$SUM[o], oo, df$SUM[o])
segments(oo, df$SUM[o], oo, df$SUM[oo])
}

SD<-sd(df2[,2])
line<-1.64*SD*sqrt(input$leadtime)
abline(h=line,col="red",lty=2)

  })


    output$tbb <- renderTable({
#sp
  })





















  })




















