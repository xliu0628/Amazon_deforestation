#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 01:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out


#module load nco
varname='energy'
var='TSK'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do

for year in {2011..2012}; do
    fout0=$varname.${year}.obs
    fout1=$varname.${year}.bigclearing
    fout2=$varname.${year}.mediumclearing
    fout3=$varname.${year}.smallclearing
   
    files0=$( find /jet/home/xjliu/Xingu_exp/Xingu_${year}/energyflux_d01_${year}-08*_00:00:00 -size +80M)
    files1=$( find /jet/home/xjliu/Xingu_exp/Xingu_${year}_bigclearing/energyflux_d01_${year}-08*_00:00:00 -size +80M)
#    files0=( /jet/home/xjliu/Xingu_exp/Xingu_${year}/energyflux_d01_${year}-08*_00:00:00)
    #files1=( /jet/home/xjliu/Xingu_exp/Xingu_${year}_bigclearing/energyflux_d01_${year}-08*_00:00:00)
#    files2=( /jet/home/xjliu/Xingu_exp/Xingu_${year}_mediumclearing/energyflux_d01_${year}-08*_00:00:00)
#    files3=( /jet/home/xjliu/Xingu_exp/Xingu_${year}_smallclearing/energyflux_d01_${year}-08*_00:00:00)
    
    ### take multi-daily mean
    echo $year
    echo  ${files1}
    # echo $(ls ${files1[@]:0:29})
    ncea -O  ${files0} $fout0.multidaymean.nc & 
    ncea -O  ${files1} $fout1.multidaymean.nc &
#    ncea -O  ${files0[@]:0:29} $fout0.multidaymean.nc & 
#    ncea -O  ${files1[@]:0:29} $fout1.multidaymean.nc &
#    ncea -O  ${files2[@]:0:29} $fout2.multidaymean.nc &
#    ncea -O  ${files3[@]:0:29} $fout3.multidaymean.nc &

    wait
   ## Take the difference relative to obs.
    ncbo -O $fout1.multidaymean.nc $fout0.multidaymean.nc dif.$fout1.multidaymean.nc
#    ncbo -O $fout2.multidaymean.nc $fout0.multidaymean.nc dif.$fout2.multidaymean.nc
#    ncbo -O $fout3.multidaymean.nc $fout0.multidaymean.nc dif.$fout3.multidaymean.nc
done
exit
## Take the ensemble mean
files0=$(ls $varname.*.obs.multidaymean.nc)
files1=$(ls $varname.*.bigclearing.multidaymean.nc)
#files2=$(ls $varname.*.mediumclearing.multidaymean.nc)
#files3=$(ls $varname.*.smallclearing.multidaymean.nc)

ncea -O $files0 $varname.obs.multiday.ensmean.nc
ncea -O $files1 $varname.bigclearing.multiday.ensmean.nc
#ncea -O $files2 $varname.mediumclearing.multiday.ensmean.nc
#ncea -O $files3 $varname.smallclearing.multiday.ensmean.nc

wait

files1=$(ls dif.$varname.*.bigclearing.multidaymean.nc)
#files2=$(ls dif.$varname.*.mediumclearing.multidaymean.nc)
#files3=$(ls dif.$varname.*.smallclearing.multidaymean.nc)

ncea -O $files1 dif.$varname.bigclearing.multiday.ensmean.nc
#ncea -O $files2 dif.$varname.mediumclearing.multiday.ensmean.nc
#ncea -O $files3 dif.$varname.smallclearing.multiday.ensmean.nc

