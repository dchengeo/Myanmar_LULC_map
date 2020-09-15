pro Myanmar_village_mapping_map_prediction_results_V7_prob

inpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/'
outpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/tif/V7/'

infilelist=file_search(inpath+'*_V7_tp*_prob.csv', count=c)

for i=0, c-1 do begin
    infile=infilelist[i]
    indata_csv=read_csv(infile, header=header)
    predicted=byte(indata_csv.field2*100)
    basename=file_basename(infile)
    HV=strmid(basename, 10, 6)
    type=strmid(basename, 20, 3)
    
    infile_ref=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/testing_data/tc_'+HV+'.tif', /remove_all)
    ref=QUERY_TIFF(infile_ref, GEOTIFF=map_info)

    outdata=reform(predicted, 3000, 3000)

    outfile=strcompress(outpath+'predicted_'+HV+'_V7_'+type+'_prob.tif', /remove_all)
    if file_test(outfile) eq 1 then continue
    write_tiff, outfile, outdata, GEOTIFF=map_info
    print, outfile+' is done!'
    progress_bar, i, 0, c-1
endfor

end