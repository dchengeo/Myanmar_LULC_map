

import arcpy
import glob
import os 
import pandas as pd
from arcpy.sa import *
arcpy.CheckOutExtension("Spatial")

infile_shp=r'D:\lobodagp\dchen\Tony\Myanmar\Village_mapping\MIMU_Village_Points\Village_mapping_sample_points_merged_all_training_V7.shp'

infile_txt=r'C:\Users\itscd\Dropbox\Tables\Myanmar\Village_mapping_variable_list_training.csv'
content=pd.read_csv(infile_txt)

infileList=content.loc[:, 'File Name']
variableList=content.loc[:, 'Variable Code']
n=len(infileList)

in_rasters=[]
for i in range(n):
    in_rasters.append([infileList[i], variableList[i]])

outfile=r'D:\lobodagp\dchen\Tony\Myanmar\Village_mapping\MIMU_Village_Points\Village_mapping_sample_points_merged_all_training_V7_extracted.shp'
arcpy.Copy_management(infile_shp, outfile)

ExtractMultiValuesToPoints(outfile, in_rasters)

print(outfile + ' is done!')

arcpy.CheckInExtension("Spatial")
