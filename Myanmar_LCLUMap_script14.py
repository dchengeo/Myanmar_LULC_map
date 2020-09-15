from osgeo import gdal
import glob
import os

inpath_shp=r'/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GIS/'
outpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GFC/V1.5/mosaic/clipped_to_grid/'
if os.path.isdir(outpath) == False:
    os.makedirs(outpath)

infile_csv='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/MCD11A2/V6/mosaic/clipped/SL_adjusted/centroids/refined/projected/clipped_to_grid/needed_hv_tiles.csv'
with open(infile_csv, 'r') as f:
    content=f.read()
content=content.split()

proj_ref=inpath_shp+'Myanmar_Grid_90km_H11V22.prj'
variablelist=['gain', 'lossyear']

for variable in variablelist:
    infile='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GFC/V1.5/mosaic/GFC_'+variable+'_Myanmar_mosaic_UTM46N_nearest.tif'
    for hv in content:
        infile_shp=inpath_shp+'Myanmar_Grid_90km_'+hv+'.shp'
        outfile=outpath+variable+'_'+hv+'.tif'
        if os.path.isfile(outfile) == False:
            os.system('gdalwarp -of GTIFF -r near -t_srs '+proj_ref+' -crop_to_cutline -cutline ' + infile_shp + ' ' + infile + ' ' + outfile+ ' --config GDAL_NUM_THREADS 25')
            print outfile + ' is done!'

