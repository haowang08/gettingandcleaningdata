run <- function(folder1 = "test", folder2 = "train") {
    
    #filepaths and files
    filedir1 <- paste("./UCI HAR Dataset", folder1, sep = "/")
    filedir2 <- paste("./UCI HAR Dataset", folder2, sep = "/")
    x1 <- "X_test.txt"
    y1 <- "y_test.txt"
    sub1 <- "subject_test.txt"
    x2 <- "X_train.txt"
    y2 <- "y_train.txt"
    sub2 <- "subject_train.txt"
    
    #reading features key
    features <- read.table("./UCI HAR Dataset/features.txt")
    features2 <- as.vector(features[,2])
    
    #subsetting vector of fields that contain 'mean' or 'std'
        meanstd <- sort(c(grep("mean", features2, ignore.case=TRUE), grep("std", features2, ignore.case=TRUE)))
    
    #reading activities key
    activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("code", "activities"))
    
    #test folder
        #inner joining test subject data to activities data
        #install.packages('plyr')
        #library(plyr)
        testsubj1 <- data.frame(read.table(paste(filedir1, y1, sep="/"), col.names="code"), read.table(paste(filedir1, sub1, sep="/"), col.names="subject"))
        testsubj2 <- join(testsubj1, activities, type="inner")        
    
        #reading and subsetting test data on 'mean' or 'std'
        testdata <- read.table(paste(filedir1, x1, sep="/"), col.names = features2)
        meanstddata_test <- testdata[,meanstd]
        extracttestdata <- data.frame(testsubj2, meanstddata_test)
    
    #train folder
    #inner joining test subject data to activities data
    trainsubj1 <- data.frame(read.table(paste(filedir2, y2, sep="/"), col.names="code"), read.table(paste(filedir2, sub2, sep="/"), col.names="subject"))
    trainsubj2 <- join(trainsubj1, activities, type="inner")    
    
    #reading and subsetting test data on 'mean' or 'std'
    traindata <- read.table(paste(filedir2, x2, sep="/"), col.names = features2)
    meanstddata_train <- traindata[,meanstd]
    extracttraindata <- data.frame(trainsubj2, meanstddata_train)
    
    #combining
    combined_data <- data.table(rbind(extracttestdata, extracttraindata))
    
    abc <-  as.data.frame(combined_data
            %>% group_by(activities, subject)
            %>% summarise_each(funs(mean)))
    
    head(abc)
    write.table(abc, "tidystep5.txt", row.names=FALSE)
}