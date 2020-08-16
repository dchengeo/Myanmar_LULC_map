from osgeo import gdal
from subprocess import call
import glob
import os
import re
import fnmatch

inpath=r'Z:\lobodagp\Data_common\Myanmar\MOD07_L2\\'
outpath=r'F:\Tony\Myanmar\MOD07_L2\Projected\\'

infilelist=glob.glob(inpath+'*.hdf')
n=len(infilelist)

extent=r'F:\Tony\Myanmar\GIS\Myanmar.shp'

for infile in infilelist:
    basename = os.path.splitext(os.path.basename(infile))[0]
    outfile1 = outpath + basename + '_surface_pressure.tif'
    outfile2 = outpath + basename + '_temperature.tif'
    outfile3 = outpath + basename + '_water_vapor.tif'


    if os.path.isfile(outfile1) == False:
        call(
            'gdalwarp -of GTIFF -tps -t_srs "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" -r bilinear -crop_to_cutline -cutline '+extent+' -tr 926.624 926.624 HDF4_EOS:EOS_SWATH:"'+infile+'":mod07:Surface_Pressure '+outfile1)
        print()

    if os.path.isfile(outfile2) == False:
        call(
            'gdalwarp -of GTIFF -tps -t_srs "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" -r bilinear -crop_to_cutline -cutline '+extent+' -tr 926.624 926.624 HDF4_EOS:EOS_SWATH:"'+infile+'":mod07:Retrieved_Temperature_Profile '+outfile2)
    else: print(outfile2+' is skipped!')

    if os.path.isfile(outfile3) == False:
        call(
            'gdalwarp -of GTIFF -tps -t_srs "+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" -r bilinear -crop_to_cutline -cutline '+extent+' -tr 926.624 926.624 HDF4_EOS:EOS_SWATH:"'+infile+'":mod07:Water_Vapor '+outfile3)
    else: print(outfile3+' is skipped!')
