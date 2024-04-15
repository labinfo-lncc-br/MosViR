#' save_fasta
#' @aliases save fasta format results soft voting classes 
#' @description This function save a FASTA file of the predictions results  
#'
#' @param seqs DNAStringSet object for the FASTA sequences
#' @param res data.frame with the results of the predict_sequences function 
#' @param file string for the output file to write a FASTA file
#' @param group string of the groups: all (default), mosquito, mosquito-specific or arboviruses
#'
#' @keywords machine learning models softvoting classification 
#' 
#' @export 
save_fasta <- function (seqs, res, file, category="all")
{
    if (category == "mosquito"){
        res <- na.omit(res)
        res <- res[res$class1=="mosquito",]
    }
    else if (category == "mosquito-specific") {
       res <- na.omit (res)
       res <- res[res$class2=="mosquito",]
    }
    else if (category == "arboviruses"){
        res <- na.omit (res)
        res <- res[res$class2=="arboviruses",]
    }

    sqs <- seqs [res[,1]]
    writeXStringSet(sqs, file, format="fasta")
}