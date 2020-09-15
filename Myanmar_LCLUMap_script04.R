library(randomForest)
load(file='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/random_forest_model/random_forest_model_V7_tp1.RData')

inpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/testing_data/csv/V6/'
outpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/'

hvlist=c('H01V09',	'H01V10',	'H01V11',	'H02V06',	'H02V07',	'H02V08',	'H02V09',	'H02V10',	'H02V11',	'H02V12',	'H02V13',	'H03V05',	'H03V06',	'H03V07',	'H03V08',	'H03V09',	'H03V10',	'H03V11',	'H03V12',	'H03V13',	'H03V14',	'H03V15',	'H03V16',	'H04V03',	'H04V04',	'H04V05',	'H04V06',	'H04V07',	'H04V08',	'H04V09',	'H04V10',	'H04V11',	'H04V12',	'H04V13',	'H04V14',	'H04V15',	'H04V16',	'H04V17',	'H05V02',	'H05V03',	'H05V04',	'H05V05',	'H05V06',	'H05V07',	'H05V08',	'H05V09',	'H05V10',	'H05V11',	'H05V12',	'H05V13',	'H05V14',	'H05V15',	'H05V16',	'H06V01',	'H06V02',	'H06V03',	'H06V04',	'H06V05',	'H06V06',	'H06V07',	'H06V08',	'H06V09',	'H06V10',	'H06V11',	'H06V12',	'H06V13',	'H06V14',	'H06V15',	'H06V16',	'H07V01',	'H07V02',	'H07V03',	'H07V04',	'H07V05',	'H07V06',	'H07V07',	'H07V08',	'H07V09',	'H07V10',	'H07V11',	'H07V12',	'H07V13',	'H07V14',	'H07V15',	'H07V16',	'H07V17',	'H07V18',	'H08V02',	'H08V03',	'H08V04',	'H08V06',	'H08V07',	'H08V08',	'H08V09',	'H08V10',	'H08V11',	'H08V12',	'H08V14',	'H08V15',	'H08V16',	'H08V17',	'H08V18',	'H08V19',	'H08V20',	'H08V21',	'H08V22',	'H08V23',	'H08V24',	'H09V07',	'H09V08',	'H09V09',	'H09V10',	'H09V11',	'H09V16',	'H09V18',	'H09V19',	'H09V20',	'H09V21',	'H09V22',	'H09V23',	'H10V09',	'H10V10',	'H10V11',	'H10V21',	'H11V09')

for (hv in hvlist) {
  infile=paste0(inpath, 'testing_data_', hv, '_V6.csv')
  outfile=paste0(outpath, 'predicted_', hv, '_V7_tp1_prob.csv')
  if (file.exists(outfile)) next
  
  print(paste0('start working on ', infile, " at ", Sys.time()))
  data=read.csv(infile, header=T)
  predicted=predict(rf_tp1, data, type="prob")
  outdata<-data.frame("predict"=predicted)
  
  write.csv(outdata, file=outfile, col.names = TRUE)
  print(paste0(outfile, " is done! at ", Sys.time()))
}