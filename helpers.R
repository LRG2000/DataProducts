library(shiny)
getcols <- function(dataframe) {
  classes <- lapply(dataframe, class)
  facts <- which(classes == "factor")
  nms <- names(dataframe)
  ncols <- dim(dataframe)[2]
  inds <- seq(1:ncols)
  if (length(facts) != 0) {
    cols.factors <- facts
    cols.nofacts <- inds[-facts]
    cols <- list(factors = nms[facts], nonfactors = nms[-facts], 
                 factinds= as.numeric(facts),
                 nonfactinds=inds[-facts] )
    
  } else { 
    cols <- list(factors = "none", nonfactors = nms, 
    factinds = 0, nonfactinds = inds)}
 
  return(cols)
  
  

}