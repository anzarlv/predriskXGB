# predriskXGB (pre-release version)
Inferring risk based on a tumour's morphometric features. The predriskXGB package contains a collection of trained models and a wrapper function that facilitates its use.

## Package Installation
```
library(devtools)
Sys.setenv(GITHUB_PAT = <personal access token>)
install_github("diamandis-lab/predriskXGB")
```

## Model overview

| Model family | No. models | Model class           | Training dataset                 | Data type (features)                             | Dependent variable (target) |
|--------------|------------|-----------------------|----------------------------------|--------------------------------------------------|-----------------------------|
|  g3oligo     |   51       | XGBoost_survival:cox  | TCGA-LGG (G3 oligodendroglioma)  | Morphometric feature values from CellProfiler and survival data (status and time)    |   risk score                |

## Function overview
- The function `predRiskXGB()` is used to infer risk in morphometric feature data by using one of the trained XGBoost models included in the predriskXGB package. For example, the command `predRiskXGB(test = test_data, model_family = 'g3oligo', index = 18)` is used to infer risk using morphometric feature data from `test_data` by using the 18th model from the `g3oligo` family of models.

## Note about testing data
- Read in testing data using `read.csv()` function in R, store the output of the `read.csv()` function in a variable, pass this in as `test` into the function
- The testing data must contain values for all the morphometric features included in training
- The function will handle the following issues related to testing data: 1) incorrect order of features (the function maintains the ordering of the features in the testing data to be consistent with the ordering of the features in the training data), and 2) additional features (the function will select the required features assuming the features in the testing data is a superset of the features in the training data)
- In the data directory you will be able to load: 1) sample test data with correct formatting (demo_feature_data.RData), note that the testing data can contain multiple patients, the example given is just one patient, and 2) ordering of the features (feature_column_map.RData), note that ordering is handled by the function, but this is a good list to ensure that the testing data has all required features

## Credits
Developed by Anzar Alvi at the [Diamandis Lab](https://www.diamandis.org/) at the [Princess Margaret Cancer Research Tower](https://www.uhnresearch.ca/institutes/pm).

![Diamandis Lab Logo](./vignettes/Diamandis_Lab_logo.png)
![Princess Margaret Cancer Centre Logo](./vignettes/PMCC_logo.png)
