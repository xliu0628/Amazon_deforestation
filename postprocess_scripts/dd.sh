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
year1=2011
year2=2012
files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year1}09_${year2}02/energyflux_d01_2011-11-30_00:00:00))
files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year1}09_${year2}02_ILgrassland/energyflux_d01_* ))

for ii in ${files0[@]};
do	
    suffix=${ii:70:10}
    fout=${outdir}/${varname}.ctrl.${suffix}.nc
    echo $files0
#    ncks -O -d Time,23,23 -v $var $ii  $fout 
done

for ii in ${files1[@]};
do	
    suffix=${ii:82:10}
    fout=${outdir}/${varname}.ILgrassland.${suffix}.nc
    echo $fout
#    ncks -d Time,23,23 -v $var $ii  $fout 
done

fall0=$(ls $outdir/precip.ctrl.201[1-2]-??-??.nc)
echo $fall0
ncrcat $fall0 $outdir/$varname.ctrl.201109_201202.nc
#fall1=$(ls $outdir/precip.ILgrassland.201[0-1]*.nc)
#ncrcat $fall1 $outdir/$varname.201109_201202.ILgrassland.nc

ncks -O -d Time,1,180 $outdir/precip.ctrl.201109_201202.nc $outdir/tmp.nc
cdo sub $outdir/tmp.nc $outdir/precip.ctrl.201109_201202.nc precip.daily.ctrl.201109_201202.nc

