from osgeo import gdal
import glob
import os

inpath_shp=r'/gpfs/data1/lobodagp/dchen/Tony/Myanmar/GIS/'
infile='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Global_surface_water_dynamics_data/Water_class99_18_mosaic_UTM46N.tif'
outpath='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/Water_mask/clipped_to_grid/V3/'
if os.path.isdir(outpath) == False:
    os.makedirs(outpath)
infile_csv='/gpfs/data1/lobodagp/dchen/Tony/Myanmar/MCD11A2/V6/mosaic/clipped/SL_adjusted/centroids/refined/projected/clipped_to_grid/needed_hv_tiles.csv'
with open(infile_csv, 'r') as f:
    content=f.read()
content=content.split()

proj_ref=inpath_shp+'Myanmar_Grid_90km_H11V22.prj'
variable='water'

for hv in content:
    infile_shp=inpath_shp+'Myanmar_Grid_90km_'+hv+'.shp'
    outfile=outpath+variable+'_'+hv+'_V3.tif'

    if os.path.isfile(outfile) == False:
        os.system('gdalwarp -of GTIFF -r near -tr 30 30 -t_srs '+proj_ref+' -crop_to_cutline -cutline ' + infile_shp + ' ' + infile + ' ' + outfile+ ' --config GDAL_NUM_THREADS 25')
        print outfile + ' is done!'

