#' Stand-alone version of steepest descent algorithm. This is similar to the CHEMTAX steepest descent algorithm. It is not required to use this function, and as results are not bound by minimum and maximum, results may be unrealistic.
#'
#' @param S   Sample data matrix – a matrix of pigment samples
#' @param Fmat   Pigment to Chl a matrix
#' @param num.loops Number of loops/iterations to perform (no default)
#'
#' @return A list containing 
#' \enumerate{
#'  \item The F matrix (pigment: Chl *a*) ratios
#'  \item RMSE (Root Mean Square Error)
#'  \item Condition number
#'  \item class abundances
#'  \item Figure (plot of results)
#'  \item MAE (Mean Absolute Error)
#'  }
#' @export
#'
#' @examples
#' MC <- Matrix_checks(Sm,Fm)
#' Snew <- MC$Snew
#' Fnew <- MC$Fnew
#' SDRes <- Steepest_Desc(Fnew,Snew, num.loops = 20)
#' 
Steepest_Desc <- function(Fmat, S, num.loops) {
  S_Chl     <- S[, ncol(S)]
  S_weights <- Bounded_weights(S, 30)
  place     <- which(Fmat[, -ncol(Fmat)] > 0)

  F_new <- Steepest_Descent(Fmat, place, S, S_weights, num.loops)
  F_new <- NNLS_MF_Final(as.matrix(F_new[[1]]), S, S_Chl, S_weights)
  
  return(F_new)
}



