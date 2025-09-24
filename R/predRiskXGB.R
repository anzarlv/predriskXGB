#' The main risk prediction function using XGBoost
#' 
#' This function allows you to predict the risk of a sample given their
#' morphometric feature data
#' @param test the data for which the model will predict risk
#' @param model_family the family of the model (e.g. g3oligo)
#' @param index index value to select the model that will be run
#' (e.g. 1 to 51 for g3 oligo)

predRiskXGB <- function(test=NULL, model_family=NULL, index=NULL) {

  # error checking: ensure 1 <= index <= nrow(patient_to_index_mapping)
  if(index >= 1 && index <= nrow(patient_to_index_mapping)) {
    patientid <- patient_to_index_mapping$patient[index]
  } else {
    stop("Invalid index.")
  }
  
  # ensure the testing data is formatted correctly
  test <- data.frame(test)
  formatted_testing <- test[,feature_order]
  if(ncol(formatted_testing) != length(feature_order)) {
    stop("The testing data does not contain enough feature information.")
  }

  # search for the XGBoost model in "data" given the model_family and patientid
  file_xgb <- paste0("list_models_", model_family)

  # error checking: ensure the XGBoost model file exists
  if(exists(file_xgb)) {
    message("predRiskXGB: loading ", file_xgb)
    
    # Get the model list object
    list_models <- get(file_xgb)

    # Set feature names
    list_models[[index]]$feature_names <- colnames(formatted_testing)

    # predict risk score for the test data
    risk_score <- predict(list_models[index], newdata = as.matrix(formatted_testing), type = "risk")
    return(risk_score)

  # else statement is for if the XGBoost model file does not exist
  } else {
    stop("Model file not found. Ensure correct model_family is entered.")
  }
}
