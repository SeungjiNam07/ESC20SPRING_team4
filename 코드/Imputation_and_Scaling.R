library(tidyverse)
library(mice)



data_noimp = read_csv("data_removed_without_imputation.csv")

data_noimp[data_noimp == "?"] = NA

for(i in 1:ncol(data_noimp)){
  data_noimp[,i] = data_noimp[,i] %>% unlist() %>% as.numeric
}

imp = mice(data_noimp, seed = 1234)

complete.data = complete(imp)

View(complete.data)

write.csv(complete.data, "imputed_data.csv", row.names = FALSE)

data = complete.data

data = data %>% select(-Attr37)

write.csv(data, "imputed_data.csv", row.names = FALSE)

library(tidymodels)

data = read_csv("C:/Users/dhxog/Desktop/ESC4-1/Final_Project/imputed_data.csv")
View(data)

ggplot(data, aes(x = Attr1, color = class, group = class)) + geom_density()


for(i in 1:(ncol(data)-1)){
  if(min(data[,i] > 0)){
    data[,i] = log(data[,i])
  }
  else{
    data[,i] = log(data[,i] - min(data[,i]) + 1)
  }
}
normalize <- function(x)
{
  return((x- min(x)) /(max(x)-min(x)))
}

for(i in 1:(ncol(data)-1)){
  data[,i] = normalize(data[,i])
}

summary(data)

write.csv(data, "scaled_data.csv", row.names = FALSE)
