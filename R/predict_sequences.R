#' predict_sequences
#' @aliases arbovirus mosquito-specific classification 
#' @description This function classifies sequences for the groups of arbovirus, mosquito-specific or othervirus    
#'
#' @param seqs DNAStringSet object to perform the classification 
#' @param cutoff is the probability limit for the soft voting of the models in ML
#' @param all.data logical indicates if all sequence must be shown or only mosquito-specific and arbovirus
#'
#' @return dataframe 
#'
#' @keywords arbovirus mosquito classification 
#' 
#' @examples
#'  
#' seqfile <- system.file ('extdata/PRJNA778885_known.fasta.gz',package="MosVir")
#' seqs <- readDNAStringSet(seqfile)
#' res <- predict_sequences (seqs, cutoff=0.5, all.data=TRUE)
#'
#' @export 
predict_sequences <- function (seqs, cutoff=0.5, all.data=TRUE)
{
    print ("Reading sequences and pre-processing them.")

    lt500 <- DNAStringSet()
    lt1000 <- DNAStringSet()
    lt3000 <- DNAStringSet()
    lt5000 <- DNAStringSet()
    lt10000 <- DNAStringSet()

    for (i in 1:length(seqs)){
        lt <- seqs[[i]]@length;
        if ( lt >= 500 & lt < 1000)
            lt500 <- c(lt500, seqs[i])
        else if (lt >= 1000 & lt < 3000)
            lt1000 <- c(lt1000, seqs[i])
        else if (lt >= 3000 & lt < 5000)
            lt3000 <- c(lt3000, seqs[i])
        else if (lt >= 5000 & lt < 10000)
            lt5000 <- c(lt5000, seqs[i])
        else if (lt >= 10000)
            lt10000 <- c(lt10000, seqs[i])
    }

    print ("Aplying models:")
    m <- 1
    n <- 2

    mclass1 <- data.frame()

# Apply models in different fragments for class 1 mosquito or othervirus
    if (length(lt500)>0) {
        m500 <- mnmer (lt500, m, n)
        md500 <- appmodels (m500, m, n, "500", "class1")
        md500$class1 <- ifelse (md500[,2]>cutoff, "mosquito.associated", "otherviruses")
        m500 <- m500[m500[,1] %in% md500[md500$class1 == "mosquito.associated",1],]
	mclass1 <- rbind(mclass1, md500)
    }
    print ("Mosquito: 500bp sequences . . . OK!")
    if (length(lt1000)>0) {
        m1k <- mnmer (lt1000, m, n)
        md1k <- appmodels (m1k, m, n, "1000", "class1")
        md1k$class1 <- ifelse (md1k[,2]>cutoff, "mosquito.associated", "otherviruses")
        m1k <- m1k[m1k[,1] %in% md1k[md1k$class1 == "mosquito.associated",1],]
	mclass1 <- rbind (mclass1, md1k)
    }
    print ("Mosquito: 1000bp sequences . . . OK!")
    if (length(lt3000)>0){
        m3k <-  mnmer (lt3000, m, n)
        md3k <- appmodels (m3k, m, n, "3000", "class1")
        md3k$class1 <- ifelse (md3k[,2]>cutoff, "mosquito.associated", "otherviruses")
        m3k <- m3k[m3k[,1] %in% md3k[md3k$class1 == "mosquito.associated",1],]
    	mclass1 <- rbind (mclass1, md3k)
    }
    print ("Mosquito: 3000bp sequences . . . OK!")
    if (length(lt5000)>0){
        m5k <-  mnmer (lt5000, m, n)
        md5k <- appmodels (m5k, m, n, "5000", "class1")
        md5k$class1 <- ifelse (md5k[,2]>cutoff, "mosquito.associated", "otherviruses")
        m5k <- m5k[m5k[,1] %in% md5k[md5k$class1 == "mosquito.associated",1],]
	mclass1 <- rbind (mclass1, md5k)
    }
    print ("Mosquito: 5000bp sequences . . . OK!")
    if (length(lt10000)>0){
        m10k <- mnmer (lt10000, m, n)
        md10k <- appmodels (m10k, m, n, "10000", "class1")
        md10k$class1 <- ifelse (md10k[,2]>cutoff, "mosquito.associated", "otherviruses")
        m10k <- m10k[m10k[,1] %in% md10k[md10k$class1 == "mosquito.associated",1],]
	mclass1 <- rbind (mclass1, md10k)
    }
    print ("Mosquito: 10000bp sequences . . . OK!")

#    mclass1 <- rbind (md500, md1k, md3k, md5k, md10k)

# Apply the class2 of the arbovirus

    mclass2 <- data.frame()

    if (exists("m500")){
        ma500 <- appmodels (m500, m, n, "500", "class2")
        ma500$class2 <- ifelse (ma500[,2]>cutoff, "arboviruses", "mosquito")
	mclass2 <- rbind (mclass2, ma500)
    }
    print ("Arboviruses: 500bp sequences . . . OK!")
    if (exists("m1k")){
        ma1k <- appmodels (m1k, m, n, "1000", "class2")
        ma1k$class2 <- ifelse (ma1k[,2]>cutoff, "arboviruses", "mosquito")
	mclass2 <- rbind (mclass2, ma1k)
    }
    print ("Arboviruses: 1000bp sequences . . . OK!")
    if (exists("m3k")){
        ma3k <- appmodels (m3k, m, n, "3000", "class2")
        ma3k$class2 <- ifelse (ma3k[,2]>cutoff, "arboviruses", "mosquito")
	mclass2 <- rbind (mclass2, ma3k)
    }
    print ("Arboviruses: 3000bp sequences . . . OK!")
    if (exists("m5k")){
        ma5k <- appmodels (m5k, m, n, "5000", "class2")
        ma5k$class2 <- ifelse (ma5k[,2]>cutoff, "arboviruses", "mosquito")
    	mclass2 <- rbind (mclass2, ma5k)
    }
    print ("Arboviruses: 5000bp sequences . . . OK!")
    if (exists("m10k")){
        ma10k <- appmodels (m10k, m, n, "10000", "class2")
        ma10k$class2 <- ifelse (ma10k[,2]>cutoff, "arboviruses", "mosquito")
    	mclass2 <- rbind (mclass2, ma10k)
    }
    print ("Arboviruses: 10000bp sequences . . . OK!")

#    mclass2 <- rbind (ma500, ma1k, ma3k, ma5k, ma10k)

    mdata <- merge (mclass1, mclass2, by=c(1,1), all.x=all.data)

    return (mdata)
}

