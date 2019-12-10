#This is my code for coming up with a data frame of Gendered Questions from the raw data I pulled

##Set Up: Loading packages and data
library(tidyverse)
library(stringr)
library(rvest)
library(purrr)
library(knitr)
library(readr) #to read in csvs in Arabic
Sys.setlocale("LC_CTYPE", "arabic" ) #setting location to export/manipulate Arabic text

Sis_EN <- read.csv(file = "data/Sistani_EN_raw.csv", stringsAsFactors = F)
Hakeem_EN <- read.csv(file = "data/Hakeem_EN_raw.csv", stringsAsFactors = F)

Sis_AR <- read_csv("data/Sisitani_AR_raw.csv") #stringsAsFactors gets an error message in AR
Hakeem_AR <- read_csv("data/Hakeem_AR_raw.csv")
Najafy_AR <- read_csv("data/Najafy_raw.csv")


##English Languge Cleaning: 
#deleting excess coloumn, adding speakers, and removing unnecessary words in text
#I then bind it together in a full data frame
Sis_EN$Speaker <- "Sistani" 
Sis_EN$bookmark <- NULL


Sis_EN$Question <- gsub("Question: ","", Sis_EN$Question)
Sis_EN$Question <- gsub("\\d", "", Sis_EN$Question)
Sis_EN$Answer <- gsub("Answer: ", "", Sis_EN$Answer)

Sis_EN <- Sis_EN[!(Sis_EN$Answer == "\n" | Sis_EN$Answer == ""),]

Hakeem_EN$Speaker <- "Hakeem"

Hakeem_EN$Question <- gsub("Question ", " ", Hakeem_EN$Question)
Hakeem_EN$Question <- gsub("\\:", " ", Hakeem_EN$Question)
Hakeem_EN$Answer <- gsub("Answer ", " ", Hakeem_EN$Answer)
Hakeem_EN$Answer <- gsub("\\:", " ", Hakeem_EN$Answer)

EN_Full_Clean <- rbind.data.frame(Sis_EN, Hakeem_EN, stringsAsFactors = F)



###Now in Arabic!
##Arabic Language Cleaning
#Sistani
Sis_AR$Speaker <- "السيستاني" 
Sis_AR$bookmark <- NULL

Sis_AR$Question <- gsub("السؤال: ","", Sis_AR$Question)
Sis_AR$Question <- gsub("\\d", "", Sis_AR$Question)
Sis_AR$Answer <- gsub("الجواب: ", "", Sis_AR$Answer)

Sis_AR <- Sis_AR[!(Sis_AR$Answer == "\r\n" | Sis_AR$Answer == ""),]

#Hakeem
Hakeem_AR$Speaker <- " الحكيم"

Hakeem_AR$Question <- gsub("السؤال ", " ", Hakeem_AR$Question)
Hakeem_AR$Question <- gsub("\\:", " ", Hakeem_AR$Question)
Hakeem_AR$Answer <- gsub("الجواب ", " ", Hakeem_AR$Answer)
Hakeem_AR$Answer <- gsub("\\:", " ", Hakeem_AR$Answer)


#Najafy
Najafy_AR$Speaker <- "النجيفي"

#No clue why StringsAsFactors works here, but it does
AR_Full_Clean <- rbind.data.frame(Sis_AR, Hakeem_AR, Najafy_AR, stringsAsFactors = F)

##Write new csvs
write.csv(EN_Full_Clean , "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\EN_Full_Clean.csv")

write.csv(AR_Full_Clean, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\AR_Full_Clean.csv", fileEncoding = "UTF-8")
