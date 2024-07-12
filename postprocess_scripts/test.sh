#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 02:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out



fall0=$(ls $outdir/precip*.ctrl.nc)
ncrcat $fall0 $varname.200509_200602.ctrl.nc
fall0=$(ls $outdir/precip*.ILgrassland.nc)
ncrcat $fall0 $varname.200509_200602.ILgrassland.nc

