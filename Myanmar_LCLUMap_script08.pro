pro Myanmar_village_mapping_classify_village_probability

infile='D:\lobodagp\dchen\Tony\Myanmar\Village_mapping\predicted\tif\V7\merged\mosaic\village_mapping_predicted_mosaic_V7_prob_merged.tif'
ref=QUERY_TIFF(infile, GEOTIFF=map_info)
indata=read_tiff(infile)
outdata=byte(indata ge 50 and indata le 100)*1b

outfile='D:\lobodagp\dchen\Tony\Myanmar\Village_mapping\predicted\tif\V7\merged\mosaic\village_mapping_predicted_mosaic_V7_ge50_prob.tif'
write_tiff, outfile, outdata,  GEOTIFF=map_info

end