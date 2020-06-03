data = matrix(c(

"LDA", "mice", 0.951, 0.590,
"LDA", "knn", 0.953, 0.625,
"LDA", "median", 0.951, 0.597,

"QDA", "mice", 0.166, 0.538,
"QDA", "knn", 0.163, 0.519,
"QDA", "median", 0.146, 0.523,

"SVM", "mice", 0.948, 0.584,
"SVM", "median", 0.956, 0.613,
"SVM", "knn", 0.908, 0.603, 

"adaboost", "all", 0.954, 0.590,

"Decision_Tree", "mice", 0.911, 0.609,
"Decision_Tree", "median", 0.936, 0.707,
"Decision_Tree", "knn", 0.922, 0.660,

"Random_Forest", "mice", 0.952, 0.808,
"Random_Forest", "median", 0.958, 0.898,
"Random_Forest", "knn", 0.952, 0.607,

"xgboost", "mice", 0.955, 0.846,
"xgboost", "median", 0.967, 0.930, 
"xgboost", "knn", 0.958 , 0.8894,

  
"Light_GBM", "mice", 0.951, 0.846,
"Light_GBM", "median", 0.968, 0.934,
"Light_GBM", "knn", 0.956, 0.885),
22, 4, byrow = T)

colnames(data) = c("Model", "Imputation", "F1", "AUC")

data = data.frame(data)

library(ggplot2)
install.packages("ggthemes") # Install 
library(ggthemes) # Load

ggplot(data, aes(x = Model, y = F1, fill = Imputation)) + geom_bar(stat = 'identity', position = "dodge") + theme_wsj() + scale_color_wsj(palette = "dem_rep")

ggplot(data, aes(x = Model, y = AUC, fill = Imputation)) + geom_bar(stat = 'identity', position = "dodge")
