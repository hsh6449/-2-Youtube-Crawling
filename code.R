#cmd 에서 java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.1.jar -port 4446

library(RSelenium)
library(rvest)
library(httr)

remD <- remoteDriver(port = 4446L,
                     browserName = "chrome")
remD$open()#서버에연결 

title_you <- "펭수" #펭수라고 검색해서 펭수가 어떤 컨텐츠를 하는지 알아봄
remD$navigate(paste0("https://www.youtube.com/results?search_query=",title_you))

html <- remD$getPageSource()[[1]]
html <- read_html(html) #html 불러오기

youtube_title <-  html%>%html_nodes("#video-title") %>%
  html_text()

youtube_title <- gsub("\n","",youtube_title)
youtube_title <- trimws(youtube_title) #전처리
youtube_title

write.table(youtube_title,
            file="C:/Users/user/Desktop/산하/전북대/19.2/데이터시각화/과제펭수_title.txt",
            sep=",",
            row.names=FALSE,
            quote=FALSE) #결과물 메모장에 저장


remD$navigate("https://www.youtube.com/watch?v=Ofi8fGaP6nU") #펭수영상중 상위에 위치한 영상하나의 댓글을 크롤링하기위해 영상의 url을 복사

remD$executeScript("window.scrollTo(0,500)")#유튜브는 한페이지안에 댓글이 다 나오므로 스크롤링함
remD$executeScript("window.scrollTo(500,1500)")
remD$executeScript("window.scrollTo(1500,2500)")
remD$executeScript("window.scrollTo(2500,3500)")
remD$executeScript("window.scrollTo(3500,4500)")
html1 <- remD$getPageSource()[[1]]
html1 <- read_html(html1)

ytube_comments <- html1 %>% html_nodes("#content-text") %>% html_text()
ytube_comments <- ytube_comments[1:60]
head(ytube_comments)

ytube_comments <- gsub("\n","",ytube_comments)
ytube_comments <- trimws(ytube_comments)
ytube_comments
write.table(ytube_comments,
            file="C:/Users/user/Desktop/산하/전북대/19.2/데이터시각화/과제펭수 댓글 2-1_title.txt",
            sep=",",
            row.names=FALSE,
            quote=FALSE)
