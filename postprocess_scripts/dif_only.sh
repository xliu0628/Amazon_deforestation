#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 01:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out


#module load nco
varname='energy'
DIR=/ocean/projects/ees210014p/xjliu/Xingu_exp

## Taking the difference relative to CTRL
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do

for year in {2013..2020}; do
    fout0=$varname.${year}.obs
    fout1=$varname.${year}.bigclearing
  #  fout2=$varname.${year}.mediumclearing
  #  fout3=$varname.${year}.smallclearing
   
    f0=$DIR/Xingu_${year}/energyflux_d01_${year}-08-29_00:00:00
    f1=$DIR/Xingu_${year}_bigclearing/energyflux_d01_${year}-08-29_00:00:00
   # f2=$DIR/Xingu_${year}_mediumclearing/energyflux_d01_${year}-07-30_00:00:00
   # f3=$DIR/Xingu_${year}_smallclearing/energyflux_d01_${year}-07-30_00:00:00
    
    ### take multi-daily mean

   ## Take the difference relative to obs.
    ncbo -O $f1 $f0 dif.$fout1.nc
   # ncbo -O $f2 $f0 dif.$fout2.nc
   # ncbo -O $f3 $f0 dif.$fout3.nc
done
wait

## Take the ensemble mean

files1=$(ls dif.$varname.*.bigclearing.nc)
#files2=$(ls dif.$varname.*.mediumclearing.nc)
#files3=$(ls dif.$varname.*.smallclearing.nc)

ncea -O $files1 dif.$varname.bigclearing.ensmean.nc
#ncea -O $files2 dif.$varname.mediumclearing.ensmean.nc
#ncea -O $files3 dif.$varname.smallclearing.nsmean.nc

ncecat -O $files1 dif.$varname.bigclearing.all.nc
#ncecat -O $files2 dif.$varname.mediumclearing.all.nc
#ncecat -O $files3 dif.$varname.smallclearing.all.nc
