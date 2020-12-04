path<-"C:\\Users\\Desktop\\country_stoc"

if(require(RODBC)){print("already installed")} else { install.packages("RODBC") }
library(RODBC)
if(require(shiny)){print("already installed")} else { install.packages("shiny") }
library(shiny)
if(require(tidyverse)){print("already installed")} else { install.packages("tidyverse") }
library(tidyverse)



runApp(path)
