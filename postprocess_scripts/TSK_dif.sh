#!/bin/sh
#module load nco
varname='TSK'
var='TSK'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do

for year in {2003..2009}; do
    fout0=$varname.${year}.obs
    fout1=$varname.${year}.bigclearing
    fout2=$varname.${year}.mediumclearing
    fout3=$varname.${year}.smallclearing
  

#    ncbo -O $fout1.multiday.mean.nc $fout0.multiday.mean.nc dif.$fout1.multiday.nc 
#    ncbo -O $fout2.multiday.mean.nc $fout0.multiday.mean.nc dif.$fout2.multiday.nc 
#    ncbo -O $fout3.multiday.mean.nc $fout0.multiday.mean.nc dif.$fout3.multiday.nc 
done

files1=$( ls dif.$varname.*.bigclearing.multiday.nc )
files2=$( ls dif.$varname.*.mediumclearing.multiday.nc )
files3=$( ls dif.$varname.*.smallclearing.multiday.nc )
echo $files1
ncecat $files1 dif.$varname.bigclearing.multiday.nc
ncecat $files2 dif.$varname.mediumclearing.multiday.nc
ncecat $files3 dif.$varname.smallclearing.multiday.nc

