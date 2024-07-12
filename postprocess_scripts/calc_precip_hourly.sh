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
for year in 2005; do
    echo $fout0
#    for mon in {10..09}; do
            files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/3Dfields_d01_$((year))-* ))
            files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/3Dfields_d01_$((year))-* ))
        echo ${files0[@]}

        ncrcat -O -v $var ${files0[@]} ${outdir}/$varname.${year}.tmp.ctrl.nc
        ncrcat -O -v $var ${files1[@]} ${outdir}/$varname.${year}.tmp.ILgrassland.nc

#  done
done
file0=${outdir}/$varname.${year}.tmp.ctrl.nc
ncks -d Time,1,2927 $file0 tmp.nc
cdo sub tmp.nc $file0 ${outdir}/$varname.hourly.${year}.ctrl.nc


