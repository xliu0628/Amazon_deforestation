#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM
#SBATCH -t 01:30:00
#SBATCH --ntasks-per-node=118
#SBATCH -o 2005.out


#module load nco
varname='3Dfields'
var='T2'

### select var and then take monthly mean

outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do

ncea $outdir/3Dfields.Month1?.ensmean.ctrl.nc $outdir/test.ctrl.nc
ncea $outdir/3Dfields.Month1?.ensmean.ILgrassland.nc $outdir/test.ILgrassland.nc

