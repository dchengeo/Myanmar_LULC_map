library(randomForest)

indata="D:/lobodagp/dchen/Tony/Myanmar/Village_mapping/MIMU_Village_Points/Village_mapping_sample_points_merged_all_training_V7_refined_tp2.csv"
all <- read.csv(indata, header=TRUE)
all$Assessment<-as.factor(all$Assessment)

x=all[,c(2:28)]
y=all$Assessment
rf_tp1<-randomForest(x, y, ntree=1000, importance=TRUE)

save(rf_tp1,  file="D:/lobodagp/dchen/Tony/Myanmar/Village_mapping/random_forest_model/random_forest_model_V7_tp2.RData")
