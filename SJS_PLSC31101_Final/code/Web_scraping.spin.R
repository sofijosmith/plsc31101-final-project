###I Will scrape all of the English and Arabic Questions and Answers from Ayatollah Hakeem and Sistani's
#websites and transform it into and English and Arabic language data frames

##Set Up
library(tidyverse)
library(stringr)
library(rvest)
library(purrr)
library(knitr)
Sys.setlocale("LC_CTYPE", "arabic" )

##Function for Hakeem's Website
scrape_doc_hakeem <- function(URL) { 
  doc <- read_html(URL)
  
  Question <- html_nodes(doc, ".question_content") %>%
    html_text()
  
  Answer <- html_nodes(doc, ".question_answer")%>%
    html_text()
  
  return(list (Question = Question,
               Answer = Answer))
}

##English language URLs
urls_hakeem_en <- read_html("http://www.alhakeem.com/en/questions") %>% 
  html_nodes(".search-box+ ul span") %>% 
  html_nodes("a")  %>% 
  html_attr("href")

##scrapes all pages and writes a CSV
Hakeem_en <-map(urls_hakeem_en, scrape_doc_hakeem) %>%
  bind_rows()

write.csv(Hakeem_en, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\Hakeem_EN_raw.csv")

##Now in Arabic!
urls_hakeem_ar <- read_html("http://www.alhakeem.com/ar/questions") %>% 
  html_nodes(".search-box+ ul span") %>% 
  html_nodes("a")  %>% 
  html_attr("href")

Hakeem_ar <- map(urls_hakeem_ar, scrape_doc_hakeem) %>%
  bind_rows()

write.csv(Hakeem_ar, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\Hakeem_AR_raw.csv", fileEncoding = "UTF-8")


## Function for Sistani's Website
scrape_doc_sistani <- function(URL) { 
  doc <- read_html(URL)
  
  QA <- html_nodes(doc, ".one-qa") %>%
    html_text()
  
  bookmark <- html_nodes(doc, ".qa-num") %>% 
    html_attr("href")
  
  return(list (QA= QA,
               bookmark = bookmark))
}

#English language URLS
sub_urls <- read_html("https://www.sistani.org/english/qa/")%>% 
  html_nodes("div.qa-tree") %>% 
  html_nodes("a")  %>% 
  html_attr("href")
base_url <- "https://www.sistani.org"

full_URLS <- str_c(base_url, sub_urls)

#Get English language data
sistani_full_en <- map(full_URLS, scrape_doc_sistani) %>%
  bind_rows()
#breakup data into columns
Sistani_EN <- sistani_full_en %>%
  separate(QA, sep =  "\n\n", into = c("Question", "Answer"))

#Write CSV
write.csv(Sistani_EN, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\Sisitani_EN_raw.csv", fileEncoding = "UTF-8")


##Now in Arabic!
#URLS
sub_urls_ar <- read_html("https://www.sistani.org/arabic/qa/") %>% 
  html_nodes("div.qa-tree") %>% 
  html_nodes("a")  %>% 
  html_attr("href")

base_url <- "https://www.sistani.org"

full_URLS_AR <- str_c(base_url, sub_urls_ar)

#scrapes all data
sistani_full_ar <- map(full_URLS_AR, scrape_doc_sistani) %>%
  bind_rows()

#breaks into columns
Sistani_ar_raw <- sistani_full_ar %>%
  separate(QA, sep =  "\n\n", into = c("Question", "Answer"))

#creates new CSV
write.csv(Sistani_ar_raw, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\Sistani_AR_raw.csv", fileEncoding = "UTF-8")


##Najafy
scrape_doc_najafy <- function(URL) { 
  doc <- read_html(URL)
  
  QA <- html_nodes(doc, ".istefsub") %>%
    html_text()
  
  return(QA)
}

URLS_Najafy <- c("http://www.alnajafy.com/list/mainnews-1-677-469.html", "http://www.alnajafy.com/list/mainnews-1-677-161.html", "http://www.alnajafy.com/list/mainnews-2-1-677-161-1.html","http://www.alnajafy.com/list/mainnews-3-1-677-161-1.html", "http://www.alnajafy.com/list/mainnews-1-677-195.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-195-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-196.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-197.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-437.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-438.html", 
                 "http://www.alnajafy.com/list/mainnews-1-677-439.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-440.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-436.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-435.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-435-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-435-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-435-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-433.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-431.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-165.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-168.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-171.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-175.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-176.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-178.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-180.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-181.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-182.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-183.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-188.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-189.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-190.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-190-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-421.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-422.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-423.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-423-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-423-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-424.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-424-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-424-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-425.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-426.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-426-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-427.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-428.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-429.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-429-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-429-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-430.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-430-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-430-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-430-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-419.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-418.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-417.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-416.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-416-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-416-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-415.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-415-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-415-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-415-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-414.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-414-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-414-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-414-1.html",
                 "http://www.alnajafy.com/list/mainnews-5-1-677-414-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-413.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-412.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-411.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-411-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-410.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-409.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-409-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-443.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-192.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-193.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-194.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-194-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-194-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-194-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-441.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-18.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-18-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-18-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-19.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-19-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-19-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-19-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-202.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-20.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-20-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-203.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-26.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-5-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-6-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-7-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-8-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-9-1-677-26-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-27.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-5-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-6-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-7-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-8-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-9-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-10-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-11-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-12-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-13-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-14-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-15-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-16-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-17-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-18-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-19-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-20-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-21-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-22-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-23-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-24-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-25-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-26-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-27-1-677-27-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-17.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-17.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-17.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-17.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-17.html",
                 #http://www.alnajafy.com/list/mainnews-6-677-17.html",
                 # "http://www.alnajafy.com/list/mainnews-7-677-17.html",
                 #"http://www.alnajafy.com/list/mainnews-8-677-17.html",
                 #"http://www.alnajafy.com/list/mainnews-9-677-17.html",
                 #"http://www.alnajafy.com/list/mainnews-10-677-17.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-204.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-22.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-22.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-22.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-22.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-23.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-23.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-23.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-23.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-23.html",
                 #"http://www.alnajafy.com/list/mainnews-6-677-23.html",
                 # "http://www.alnajafy.com/list/mainnews-7-677-23.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-24.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-24.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-25.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-25.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-25.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-211.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-210.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-209.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-208.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-208.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-208.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-208.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-207.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-206.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-206.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-205.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-205.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-205.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-205.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-205.html",
                 #"http://www.alnajafy.com/list/mainnews-6-677-205.html",
                 #"http://www.alnajafy.com/list/mainnews-7-677-205.html",
                 #"http://www.alnajafy.com/list/mainnews-8-677-205.html",
                 # "http://www.alnajafy.com/list/mainnews-9-677-205.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-442.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-14.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-12.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-12.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-12.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-12.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-12.html",
                 # "http://www.alnajafy.com/list/mainnews-6-677-12.html",
                 # "http://www.alnajafy.com/list/mainnews-7-677-12.html",
                 # "http://www.alnajafy.com/list/mainnews-8-677-12.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-11.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-10.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-9.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-7.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-7.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-6.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-6.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-6.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-5.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-4.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-3.html",
                 #"http://www.alnajafy.com/list/mainnews-7-1-677-2-1.html",
                 # "http://www.alnajafy.com/list/mainnews-6-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-5-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-1-677-2-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-219.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-218.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-218.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-218.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-216.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-215.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-214.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-214.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-214.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-214.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-213.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-212.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-99.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-98.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-98.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-98.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-98.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-97.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-96.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-95.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-95.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-94.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-93.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-93.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-93.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-92.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-92.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-92.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-92.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-6-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-7-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-8-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-9-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-10-677-92.html",
                 # "http://www.alnajafy.com/list/mainnews-11-677-92.html",
                 #"http://www.alnajafy.com/list/mainnews-12-677-92.html",
                 #"http://www.alnajafy.com/list/mainnews-13-677-92.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-91.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-90.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-90.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-89.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-89.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-89.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-89.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-88.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-88.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-87.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-87.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-87.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-86.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-86.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-86.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-85.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-84.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-84.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-84.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-84.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-84.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-83.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-83.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-82.html",
                 "http://www.alnajafy.com/list/mainnews-7-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-6-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-5-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-1-677-82-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-81.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-81.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-80.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-80.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-32.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-32.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-31.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-30.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-29.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-29.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-29.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-29.html",
                 #"http://www.alnajafy.com/list/mainnews-6-677-29.html",
                 #"http://www.alnajafy.com/list/mainnews-7-677-29.html",
                 #"http://www.alnajafy.com/list/mainnews-8-677-29.html",
                 # "http://www.alnajafy.com/list/mainnews-9-677-29.html",
                 # "http://www.alnajafy.com/list/mainnews-10-677-29.html",
                 # "http://www.alnajafy.com/list/mainnews-11-677-29.html",
                 # "http://www.alnajafy.com/list/mainnews-12-677-29.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-220.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-106.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-106.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-106.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-106.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-106.html",
                 #"http://www.alnajafy.com/list/mainnews-6-677-106.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-102.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-102.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-221.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-221.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-221.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-108.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-108.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-101.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-101.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-101.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-222.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-104.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-105.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-105.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-109.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-109.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-223.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-224.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-783.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-103.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-107.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-110.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-225.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-225.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-225.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-226.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-227.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-229.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-230.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-230.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-230.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-230.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-115.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-115.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-115.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-115.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-115.html",
                 #"http://www.alnajafy.com/list/mainnews-6-677-115.html",
                 #"http://www.alnajafy.com/list/mainnews-7-677-115.html",
                 # "http://www.alnajafy.com/list/mainnews-8-677-115.html",
                 # "http://www.alnajafy.com/list/mainnews-9-677-115.html",
                 # "http://www.alnajafy.com/list/mainnews-10-677-115.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-452.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-235.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-236.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-779.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-926.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-116.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-116.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-116.html",
                 "http://www.alnajafy.com/list/mainnews-4-677-116.html",
                 "http://www.alnajafy.com/list/mainnews-5-677-116.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-238.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-242.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-245.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-246.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-247.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-275.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-274.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-269.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-268.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-266.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-265.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-264.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-263.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-139.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-260.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-257.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-254.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-251.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-250.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-248.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-248.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-248.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-277.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-278.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-279.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-280.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-281.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-282.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-284.html",
                 "http://www.alnajafy.com/list/mainnews-1-677-232.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-232.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-232.html",
                 "http://www.alnajafy.com/list/mainnews-4-1-677-233-1.html",
                 "http://www.alnajafy.com/list/mainnews-3-1-677-233-1.html",
                 "http://www.alnajafy.com/list/mainnews-2-1-677-233-1.html",
                 "http://www.alnajafy.com/list/mainnews-1-1-677-233-1.html", 
                 "http://www.alnajafy.com/list/mainnews-1-677-234.html",
                 "http://www.alnajafy.com/list/mainnews-2-677-234.html",
                 "http://www.alnajafy.com/list/mainnews-3-677-234.html")

Najafy <- map(URLS_Najafy, scrape_doc_najafy)

#Turn into DF
Najafy_AR <- data.frame(matrix(unlist(Najafy), nrow=1888, byrow=T),stringsAsFactors=FALSE)

#Change Col Name
colnames(Najafy_AR) <- c("Question")

#Initial cleaning in order to spearate
Najafy_AR$Question <- gsub(":السؤال", "", Najafy_AR$Question)
Najafy_AR$Question <- gsub("\\:", "", Najafy_AR$Question)
Najafy_AR$Question <- gsub("الجواب", "\\!", Najafy_AR$Question)

#New Data Frame
Najafy_test<- Najafy_AR %>%
  separate(Question, sep =  "\\!", into = c("Question", "Answer"))

#Write CSV
write.csv(Najafy_test, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\Najafy_raw.csv", fileEncoding = "UTF-8")
write.csv(Sistani_ar_raw, "C:\\Users\\sofia\\Desktop\\SJS_PLSC31101_Final\\data\\Sistani_AR_raw.csv", fileEncoding = "UTF-8")

