#!/bin/sh
#module load nco
varname='TSK'
var='TSK'

DIR=/jet/home/xjliu/Tanguro_exp/Tanguro201407
   
    files0=( $DIR/3Dfields_d01_2014*_00:00:00)
   echo ${files0[@]} 
ncea -O -v  $var ${files0[@]:5:20} TSK.WRF.diurnal.201407.nc
