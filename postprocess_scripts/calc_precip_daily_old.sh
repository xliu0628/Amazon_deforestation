#!/bin/bash

### Get the daily data
year1=(2005 2010 2015 2008)
year2=("2006" "2011" "2016" "2009")

outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'

for ii in {2..2};
do
    f1=$outdir/precip.ctrl.${year1[ii]}09_${year2[ii]}02.nc
    fout=$outdir/precip.daily.ctrl.${year1[ii]}09_${year2[ii]}02.nc
    echo $f1
    echo $fout
#    ncks -d Time,1,179 $f1 tmp.nc
#    cdo sub tmp.nc $f1 $fout 
#    rm -f tmp.nc
done

wait
for ii in {1..1};
do
    f1=$outdir/precip.ILgrassland.${year1[ii]}09_${year2[ii]}02.nc
    fout=$outdir/precip.daily.ILgrassland.${year1[ii]}09_${year2[ii]}02.nc
    echo $f1
    echo $fout
#    ncks -d Time,1,179 $f1 tmp.nc
#    cdo sub tmp.nc $f1 $fout 
    rm -f tmp.nc
done

