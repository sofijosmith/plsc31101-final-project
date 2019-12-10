###Finding Gendered Content
##Set Up
library(tidyverse)
library(stringr)
library(rvest)
library(purrr)
library(knitr)
library(readr) #to read in csvs in Arabic
Sys.setlocale("LC_CTYPE", "arabic" ) #setting location to export/manipulate Arabic text

EN_Full <- read.csv("data/EN_FUll_Clean.csv", stringsAsFactors = F) #stringsAsFactors gets an error message in AR
EN_Full$X <- NULL
AR_Full <- read_csv("data/AR_Full_Clean.csv")
AR_Full$X1 <- NULL

##English
#First I create a dictionary of gendered terms 
toMatch <-  c("woman", "women", "feminine", "female", "marriage", 
              "divorce", "khul", "maher", "mahr", "family",  "abortion","pregnancy",  
              "menstration", "hijab", "niqab", "modesty", "shy", "shyness", "wife", "wives", 
              "engagement", "widow", "mother", "daughter", "dowry", "adultery", "zina")


Match_list <- paste(toMatch, collapse="|")
#This searches for then adds new columns with the gendered words

EN_Full_Gendered <- EN_Full %>%
  mutate(Words_Q = str_match_all(EN_Full$Question, Match_list))%>%
  mutate(Words_A = str_match_all(EN_Full$Answer, Match_list))

#"flatten" list formed above
EN_Full_Gendered$Words_A <- vapply(EN_Full_Gendered$Words_A, paste, collapse = ",", character(1L))
EN_Full_Gendered$Words_Q <- vapply(EN_Full_Gendered$Words_A, paste, collapse = ",", character(1L))

#remove rows with neither gendered questions nor answers
EN_Full_Gendered <- EN_Full_Gendered[!(EN_Full_Gendered$Words_Q=="" & EN_Full_Gendered$Words_A ==""),]

#Write new csv
write.csv(EN_Full_Gendered , "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\results\\EN_Full_Gendered.csv")

###Arabic

## Function to detect matches
exists <- function(s1, s2){
  return(grepl(s1, s2))
}

detect_words <- function(text, words){
  for (i in seq_along(1:length(words))){
    if(exists(words[i], text)){
      return(1)
    }
  }
  return(0)
}

## Dictionary 
toMatch_AR <- c("مرأة", "نساء", "نسوية", "زوجة", "زوجات", "طلاق", "مهر", "ارمل
                ة", "عائلة", "أم", "بنت", "ابنة", "حيض", "طمث", "عدة", "نفاس", "حامل",
                "ولادة", "إجهاض", "أطفال", "مرضعة", "حجاب", "خمار", "نقاب", "احتشام", "
                حشمة", "حياء", "سن اليأس")

## New Gendered Frame

Gendered_Q <- map(AR_Full$Question, detect_words, toMatch_AR) %>%
  unlist()
Gendered_A <- map(AR_Full$Answer, detect_words, toMatch_AR) %>%
  unlist()

AR_Full_Gendered <- cbind.data.frame(AR_Full, Gendered_Q, Gendered_A)

AR_Full_Gendered <- AR_Full_Gendered %>%
  group_by(Gendered_A, Gendered_Q) %>%
  mutate(Gendered_Score = sum(Gendered_Q + Gendered_A == 0))

##removes all non gendered questions
AR_Full_Gendered<- AR_Full_Gendered[!(AR_Full_Gendered$Gendered_Score == 0), ]

#removes the gendered scores
AR_Full_Gendered$Gendered_Q <- NULL
AR_Full_Gendered$Gendered_A <- NULL
AR_Full_Gendered$Gendered_Score <- NULL
#Write new csvs!
write.csv(AR_Full_Gendered, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\results\\AR_Full_Gendered.csv", fileEncoding = "UTF-8")

