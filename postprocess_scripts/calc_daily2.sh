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
year1=2008
year2=2009
files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year1}09_${year2}02/energyflux_d01_* ))
files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year1}09_${year2}02_ILgrassland/energyflux_d01_* ))

for ii in ${files0[@]};
do	
    suffix=${ii:70:10}
    fout=${outdir}/${varname}.ctrl.${suffix}.nc
    echo $fout
#    ncks -d Time,23,23 -v $var $ii  $fout 
done

for ii in ${files1[@]};
do	
    suffix=${ii:82:10}
    fout=${outdir}/${varname}.ILgrassland.${suffix}.nc
    echo $fout
#    ncks -d Time,23,23 -v $var $ii  $fout 
done

fall0=$(ls $outdir/precip.ctrl.200[8-9]-??-??.nc)
ncrcat $fall0 $outdir/$varname.ctrl.200809_200902.nc
fall1=$(ls $outdir/precip.ILgrassland.200[8-9]*.nc)
ncrcat $fall1 $outdir/$varname.ILgrassland.200809_200902.nc

### Get the daily data
year1=("2005","2008","2015","2008")
year2=("2006","2009","2016","2009")

cd $outdir
ncks -d Time,1,180 precip.ILgrassland.200809_200902.nc tmp.nc
cdo sub tmp.nc precip.ILgrassland.200809_200902.nc precip.daily.ILgrassland.200809_200902.nc

rm -f tmp.nc
ncks -d Time,1,180 precip.ctrl.200809_200902.nc tmp.nc
cdo sub tmp.nc precip.ctrl.200809_200902.nc precip.daily.ctrl.200809_200902.nc

cd /jet/home/xjliu/repos/WRF_postprocessing/
