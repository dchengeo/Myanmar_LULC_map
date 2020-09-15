pro Myanmar_village_mapping_map_merge_two_model_results_V7_prob

inpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/tif/V7/'
outpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/tif/V7/merged/'

infilelist=file_search(inpath+'*_V7_tp1_prob.tif', count=c)

for i=0, c-1 do begin
    infile=infilelist[i]
    
    basename=file_basename(infile)
    HV=strmid(basename, 10, 6)
    
    ref=QUERY_TIFF(infile, GEOTIFF=map_info)
    indata=read_tiff(infile)
    
    infile_2=strcompress(inpath+'predicted_'+HV+'_V7_tp2_prob.tif', /remove_all)
    indata_2=read_tiff(infile_2)
    
    infile_mask='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/testing_data/terrainTp_'+HV+'.tif'
    mask=read_tiff(infile_mask)
    
    outdata=indata*(mask eq 1)+indata_2*(mask eq 2)
    
    outfile=strcompress(outpath+'predicted_'+HV+'_V7_prob_merged.tif', /remove_all)
    if file_test(outfile) eq 1 then continue
    write_tiff, outfile, outdata, GEOTIFF=map_info
    print, outfile+' is done!'
    progress_bar, i, 0, c-1
endfor

end