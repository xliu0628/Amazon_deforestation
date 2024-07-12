#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out

## this script aims to extract the daily precipitation data from the accumulated precipitation
## The way it does is to extract the last time step from the daily output (in hourly resolution but with 24 hours written to one file)
## and then ncrcat all the hourly data. 
## the daily data is achieved by subtracting the hourly data from the hourly data next. 

#module load nco
varname='precip'
var='RAINNC'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'
year1=2010
year2=2011

fall1=$(ls $outdir/precip.ILgrassland.201[0-1]*.nc)
#ncrcat $fall1 $outdir/$varname.ILgrassland.201009_201102.nc

### Get the daily data

ncks -d Time,1,180 $outdir/precip.ILgrassland.201009_201102.nc $outdir/tmp.nc
cdo sub $outdir/tmp.nc $outdir/precip.ILgrassland.201009_201102.nc $outdir/precip.daily.ILgrassland.201009_201102.nc

