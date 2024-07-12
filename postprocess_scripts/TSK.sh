#!/bin/sh
#module load nco
varname='TSK'
var='TSK'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
DIR=/ocean/projects/ees210014p/xjliu/Xingu_exp_10day

for year in {2013..2020}; do
    fout0=$varname.${year}.obs
    fout1=$varname.${year}.bigclearing
#    fout2=$varname.${year}.mediumclearing
#    fout3=$varname.${year}.smallclearing
   
    files0=( $DIR/Xingu_${year}/3Dfields_d01_${year}*_00:00:00)
    files1=( $DIR/Xingu_${year}_bigclearing/3Dfields_d01_${year}*_00:00:00)
#    files2=( $DIR/Xingu_${year}_mediumclearing/3Dfields_d01_${year}*_00:00:00)
#    files3=( $DIR/Xingu_${year}_smallclearing/3Dfields_d01_${year}*_00:00:00)
    
    ### concatenate the daily data 
#    ncrcat -O -v $var ${files0[@]:0:26} $fout0.nc &
#    ncrcat -O -v $var ${files1[@]:0:26} $fout1.nc &
#    ncrcat -O -v $var ${files2[@]:0:26} $fout2.nc &
#    ncrcat -O -v $var ${files3[@]:0:26} $fout3.nc &

    ### take multi-daily mean
#    echo $(ls ${files0[@]:6:25})
    echo $year
    ncea -O -v  $var ${files0[@]:5:20} $fout0.multiday.mean.nc
    ncea -O -v  $var ${files1[@]:5:20} $fout1.multiday.mean.nc
#    ncea -O -v  $var ${files2[@]:5:20} $fout2.multiday.mean.nc
#    ncea -O -v  $var ${files3[@]:5:20} $fout3.multiday.mean.nc
done
wait

## Take the ensemble mean
files0=$(ls $varname.*.obs.multiday.mean.nc)
echo $files0
files1=$(ls $varname.*.bigclearing.multiday.mean.nc)
files2=$(ls $varname.*.mediumclearing.multiday.mean.nc)
files3=$(ls $varname.*.smallclearing.multiday.mean.nc)

ncea -O $files0 $varname.obs.multiday.ensmean.nc
ncea -O $files1 $varname.bigclearing.multiday.ensmean.nc
ncea -O $files2 $varname.mediumclearing.multiday.ensmean.nc
ncea -O $files3 $varname.smallclearing.multiday.ensmean.nc

exit

files0=$(ls $varname.*.obs.nc)
echo $files0
files1=$(ls $varname.*.bigclearing.nc)
files2=$(ls $varname.*.medclearing.nc)
files3=$(ls $varname.*.smallclearing.nc)
## ensemble mean
#ncea -O $files0 $varname.obs.ensmean.nc
#ncea -O $files1 $varname.bigclearing.ensmean.nc
#ncea -O $files2 $varname.mediumclearing.ensmean.nc
#ncea -O $files3 $varname.smallclearing.ensmean.nc
