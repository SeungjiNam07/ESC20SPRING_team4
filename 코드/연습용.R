library(tidyverse)
library(tidymodels)

data = read_csv("FS_2y_before_Bankruptcy_train.csv")

skimr::skim(data)
