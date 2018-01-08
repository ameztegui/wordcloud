# Loading Packages
library(tm)
library(wordcloud)
library(RColorBrewer)

# Reading the File

abstracts = readLines("./data/abstracts.txt")

# Converting the text file into a Corpus
abstracts <-Corpus(VectorSource(abstracts))

# Data Cleaning

modi_abstracts <- tm_map(abstracts,stripWhitespace)
modi_abstracts <- tm_map(modi_abstracts,tolower)
modi_abstracts <- tm_map(modi_abstracts,removeNumbers)
modi_abstracts <- tm_map(modi_abstracts,removePunctuation)
modi_abstracts<-tm_map(modi_abstracts,removeWords, stopwords("english"))


# Have a look at the most common words
terms <- as.matrix(TermDocumentMatrix (modi_abstracts)) #Creates a TDM
v = sort(rowSums(TDM1), decreasing = TRUE) 
head(v, n = 100)

# After looking at the text document ,I also noticed the following words stop words
# which I wanted to remove:
      
modi_abstracts<-tm_map (modi_abstracts, removeWords, 
                   c("can", "different", "found","main", "study","showed","whereas", "however"))



# Create wordcloud

wordcloud (modi_abstracts, scale=c(5,0.5), max.words=50, 
           random.order=TRUE, rot.per=0.35, use.r.layout=FALSE, 
           colors=brewer.pal(8, "Dark2"))
