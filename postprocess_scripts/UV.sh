#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=10
#SBATCH -o Tanguro.out


#module load nco
varname='UV'
var='U'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon561x721'
for year in 2015; do
    echo $fout0

    files0=( /jet/home/xjliu/Amazon_exp/Amazon6mon/3Dfields_d01_$year-01-* )
    files1=( /jet/home/xjliu/Amazon_exp/Amazon6mon_ILgrassland/3Dfields_d01_$year-01* )
   
   ### concatenate the hourly data of the same day
#      echo ${files0[@]}
      echo ${files1[@]}
        fout0=$outdir/$varname.${year}01.ctrl
        fout1=$outdir/$varname.${year}01.ILgrassland.
    ncrcat -O -v $var ${files0[@]} $fout0.nc
    ncrcat -O -v $var ${files1[@]} $fout1.nc

    done
    echo fout0*.nc
    

