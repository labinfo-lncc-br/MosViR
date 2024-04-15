#' appmodels
#' @aliases models machine learning soft voting classes 
#' @description This function convert to a mnmer matrix and apply machine learning models   
#'
#' @param mtx data.frame of mn-mers dataset 
#' @param m number of the mnmer
#' @param n number of the mnmer
#' @param len character of the length of the fragment (550, 1000, 3000, 5000, 10000 bp)
#' @param cls character represents which class is applied class1 or class2
#' @return dataframe 
#'
#' @keywords machine learning models softvoting classification 
#' 
#' @export 
appmodels <- function (mtx, m, n, len, cls)
{
    ldf <- data.frame (ids=mtx[,1])
    mtx <- mtx[,-1]

    ddr <- system.file ("models", package="MosVir")

    load (paste0(ddr,"/models_",cls,"_",len,"_",m,n,".rda"))
    p <- predict(models[[1]], mtx, preProcess = c("center", "scale"),type = "prob")
    pma <- p

    for (i in 2:length(models)){
        p <- predict(models[[i]], mtx, preProcess = c("center", "scale"),type = "prob")
        pma <- pma + p
    }
    pma <- pma/length(models)
    return (cbind (ldf,pma))
}
