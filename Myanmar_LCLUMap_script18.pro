pro Myanmar_generate_2016_base_map_entire_country_V3
infile_csv='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/MCD11A2/V6/mosaic/clipped/SL_adjusted/centroids/refined/projected/clipped_to_grid/needed_hv_tiles.csv'
indata_csv=read_csv(infile_csv)
hvlist=indata_csv.field1

n=n_elements(hvlist)
ns=3000
nl=3000
for i=0, n-1 do begin
    hv=hvlist[i]
    
    infile_Water=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Water_mask/clipped_to_grid/V3/water_'+hv+'_V3.tif', /remove_all)
    ref=QUERY_TIFF(infile_Water, GEOTIFF=map_info)

    if file_test(infile_Water) eq 0 then continue
    Water=read_tiff(infile_Water)

    infile_impSurface=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GMIS/clipped_to_grid/impervious_surface_'+hv+'.tif', /remove_all)
    if file_test(infile_impSurface) eq 0 then continue
    impSurface=read_tiff(infile_impSurface)

    infile_settlement=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/predicted/tif/V7/merged/mosaic/clipped_to_grid/village_'+hv+'.tif', /remove_all)
    if file_test(infile_settlement) eq 0 then continue
    settlement=read_tiff(infile_settlement)

    infile_crop=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Croplands/clipped_to_grid/crop_'+hv+'.tif', /remove_all)
    if file_test(infile_crop) eq 0 then continue
    crop=read_tiff(infile_crop)

    infile_lossyear=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GFC/V1.5/mosaic/clipped_to_grid/lossyear_'+hv+'.tif', /remove_all)
    if file_test(infile_lossyear) eq 0 then continue
    lossYear=read_tiff(infile_lossyear)

    infile_gain=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GFC/V1.5/mosaic/clipped_to_grid/gain_'+hv+'.tif', /remove_all)
    if file_test(infile_gain) eq 0 then continue
    gain=read_tiff(infile_gain)

    infile_treecover=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Landsat_VCF/clipped_to_grid/TC_'+hv+'.tif', /remove_all)
    if file_test(infile_treecover) eq 0 then continue
    treecover=read_tiff(infile_treecover)

    infile_NDVI=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Village_mapping/testing_data/ndvi_dc_'+hv+'.tif', /remove_all)
    if file_test(infile_NDVI) eq 0 then continue
    NDVI=read_tiff(infile_NDVI)

    infile_curvature=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/SRTM_DEM/mosaic/clipped_to_grid/curvature_'+hv+'.tif', /remove_all)
    if file_test(infile_curvature) eq 0 then continue
    curvature=read_tiff(infile_curvature)

    infile_flowAccumu=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/SRTM_DEM/mosaic/clipped_to_grid/flow_accumulation_'+hv+'.tif', /remove_all)
    if file_test(infile_flowAccumu) eq 0 then continue
    flowAccumu=read_tiff(infile_flowAccumu)
    
    infile_bg=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/bareground/clipped_to_grid/bareground_'+hv+'.tif', /remove_all)
    if file_test(infile_bg) eq 0 then continue
    bareground=read_tiff(infile_bg)

    outdata=bytarr(ns, nl)
    outdata[where(Water eq 2 or Water eq 3)]=1
    outdata[where(outdata eq 0 and impSurface ge 0 and impSurface le 100)]=2
    outdata[where(outdata eq 0 and settlement eq 1)]=3
    outdata[where(outdata eq 0 and crop eq 2 or crop eq 3)]=4
    outdata[where(outdata eq 0 and gain eq 1 or lossYear ge 1 and lossYear le 16)]=5
    outdata[where(outdata eq 0 and treecover ge 40 and treecover le 100)]=6
    outdata[where(Water eq 5 or Water eq 6 or Water eq 7 or Water eq 8)]=7
    outdata[where(outdata eq 0 and curvature le -1 and curvature gt -10 and flowAccumu ge 3)]=8
    outdata[where(outdata eq 0 and NDVI le 500 or bareground eq 1)]=10
    outdata[where(outdata eq 0)]=9

    outfile=strcompress('/gpfs/data1/lobodagp/dchen/Tony/Myanmar/basemap/country_wide/basemap_'+hv+'_V3.tif', /remove_all)
    write_tiff, outfile, outdata,  GEOTIFF=map_info
    print, outfile+' is done!'
endfor


end
