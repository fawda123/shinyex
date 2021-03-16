
# import data
url <- 'https://raw.githubusercontent.com/tbep-tech/tbep-r-training/013432d6924d278a9fbb151591ddcfd5b7de87ab/data/otbfimdat.csv'
otbfimdat <- read.csv(url, stringsAsFactors = F)

write.csv(otbfimdat, 'data/otbfimdat.csv', quote = F)
