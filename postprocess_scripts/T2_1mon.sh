#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=10
#SBATCH -o Tanguro.out


#module load nco
varname='T2'
var='T2'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon561x721'
for year in 2015; do
    echo $fout0

    files0=( /jet/home/xjliu/Amazon_exp/Amazon561x721/3Dfields_d01_$year-11-??_* )
    files1=( /jet/home/xjliu/Amazon_exp/Amazon561x721_ILgrassland/3Dfields_d01_$year-11-??_* )
   
   ### concatenate the hourly data of the same day
#      echo ${files0[@]}
      echo ${files1[@]}
        fout0=$outdir/$varname.${year}11.obs
        fout1=$outdir/$varname.${year}11.ILgrassland
    ncrcat -O -v $var ${files0[@]} $fout0.nc
#    ncrcat -O -v $var ${files1[@]} $fout1.nc
#	ncea -O -v $var ${files0[@]:13:17} $fout0.$day.nc
    ncea -O -v $var ${files0[@]:4:26} $fout0.Day5_30mean.nc
    #ncea -O -v $var ${files1[@]:4:26} $fout1.Day5_30mean.nc

    done
    echo fout0*.nc
    

