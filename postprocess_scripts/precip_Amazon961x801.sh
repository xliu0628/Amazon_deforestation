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
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'
files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_200509_200602/energyflux_d01_* ))
files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_200509_200602_ILgrassland/energyflux_d01_* ))

for ii in ${files0[@]};
do	
    suffix=${ii:70:10}
    fout=${outdir}${varname}.ctrl.${suffix}.nc
    echo $fout
   
    ncks -v $var $ii $fout 
done

for ii in ${files1[@]};
do	
    suffix=${ii:82:10}
    fout=${outdir}${varname}.ILgrassland.${suffix}.nc
    echo $fout
   
    ncks -v $var $ii $fout 
done
exit
fall0=$(ls $outdir/precip*.ctrl.nc)
ncrcat $fall0 $varname.200509_200602.ctrl.nc
fall0=$(ls $outdir/precip*.ILgrassland.nc)
ncrcat $fall0 $varname.200509_200602.ILgrassland.nc

