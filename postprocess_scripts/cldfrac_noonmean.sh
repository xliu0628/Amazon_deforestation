#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=10
#SBATCH -o Tanguro.out


#module load nco
varname='cloudfrac'
var='CLDFRA'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon561x721'
for year in 2015; do
    echo $fout0

    files0=( /jet/home/xjliu/Amazon_exp/Amazon561x721/3Dfields_d01_$year-11-??_15* )
    files1=( /jet/home/xjliu/Amazon_exp/Amazon561x721_ILdeforested/3Dfields_d01_$year-11-??_15* )
   
   ### concatenate the hourly data of the same day
#      echo ${files0[@]}
      echo ${files0[@]:5:25}
        fout0=$outdir/$varname.${year}11UTC15.obs
        fout1=$outdir/$varname.${year}11UTC15.ILdeforested
	ncea -O -v $var ${files0[@]:5:25} $fout0.nc
	ncea -O -v $var ${files1[@]:5:25} $fout1.nc

    done
    echo fout0*.nc
    

