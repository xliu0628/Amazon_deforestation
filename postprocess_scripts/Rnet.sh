#!/bin/sh
#module load nco
varname='precip'
var='RAINNC'

for year in {2003..2009}; do
    f0=/jet/home/xjliu/Xingu_exp/Xingu_Cheyenne/Xingu_${year}/3Dfields_d01_${year}-07-26_00:00:00
    f1=/jet/home/xjliu/Xingu_exp/Xingu_Cheyenne/Xingu_${year}_bigclearing/3Dfields_d01_${year}-07-26_00:00:00
    f2=/jet/home/xjliu/Xingu_exp/Xingu_Cheyenne/Xingu_${year}_mediumclearing/3Dfields_d01_${year}-07-26_00:00:00
    f3=/jet/home/xjliu/Xingu_exp/Xingu_Cheyenne/Xingu_${year}_smallclearing/3Dfields_d01_${year}-07-26_00:00:00
    fout0=$varname.${year}.obs.nc
    fout1=$varname.${year}.bigclearing.nc
    fout2=$varname.${year}.mediumclearing.nc
    fout3=$varname.${year}.smallclearing.nc
    ncks -O -v RAINNC -d Time,0,23 $f0 $fout0 &
    ncks -O -v RAINNC -d Time,0,23 $f1 $fout1 &
    ncks -O -v RAINNC -d Time,0,23 $f2 $fout2 &
    ncks -O -v RAINNC -d Time,0,23 $f3 $fout3 &
 
    wait 
    ncbo -O $fout1 $fout0 dif.$fout1
    ncbo -O $fout2 $fout0 dif.$fout2
    ncbo -O $fout3 $fout0 dif.$fout3 

done

wait

files0=$(ls $varname.*.obs.nc)
echo $files0
files1=$(ls $varname.*.big*.nc)
files2=$(ls $varname.*.med*.nc)
files3=$(ls $varname.*.small*.nc)
## ensemble mean
ncea -O $files0 $varname.obs.ensmean.nc
ncea -O $files1 $varname.bigclearing.ensmean.nc
ncea -O $files2 $varname.mediumclearing.ensmean.nc
ncea -O $files3 $varname.smallclearing.ensmean.nc
