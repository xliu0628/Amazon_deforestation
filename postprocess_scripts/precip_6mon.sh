#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out


#module load nco
varname='precip'
var='RAINNC'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801/'
files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_201509_201602/energyflux_d01_* ))
files1=( /jet/home/xjliu/Amazon_exp/Amazon961x801_ILgrassland/energyflux_d01_* )

for ii in ${files0[@]};
do	
    suffix=${ii:70:10}
    fout=${outdir}${varname}.ctrl.${suffix}.nc
    echo $fout
   
    ncks -v $var $ii $fout 
	#	fileout=$outdir+
done
