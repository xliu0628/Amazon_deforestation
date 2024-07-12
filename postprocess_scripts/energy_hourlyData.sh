#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 01:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out

#### This script will do the following: 
## - Take the monthly mean value of fields at local noon
## - take the mean diurnal cycle
## - take the long time series

#### How to?
#### monthly mean at local noon: ncea all_UTC15.nc
#### mean diurnal cycle: for ii in range(24):
####                             ncea utc_ii.nc
#### long time series: ncrcat
#module load nco
varname='energy'
var='TSK'


## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon561x721'
for year in 2014; do
#    for month in {12}; do   
month=12 
echo $month
      	files0=( /jet/home/xjliu/Amazon_exp/Amazon6mon_ILgrassland/energyflux_d01_$year-$month-??_15:00:00 )
      	#files0=( /jet/home/xjliu/Amazon_exp/Amazon6mon/energyflux_d01_$year-$month-??_15:00:00 )
        echo ${files0[@]}

	#### get the monthly mean of local noon
	fout0_UTC15=$outdir/$varname.$year.$month.UTC15.mean.ILgrassland.nc
	#fout0_UTC15=$outdir/$varname.$year.$month.UTC15.mean.ILgrassland.nc
	        ncea -O ${files0[@]} $fout0_UTC15
        echo ${fout0_ts}

     
	### concatenate the hourly data of each month
       files0_hr=( /jet/home/xjliu/Amazon_exp/Amazon6mon_ILgrassland/energyflux_d01_$year-$month-*:00:00 )
        echo ${files0_hr[@]}
        fout0_ts=$outdir/$varname.${year}.$month.hourly.ILgrassland.nc
	ncrcat -O ${files0_hr[@]} $fout0_ts
        echo ${fout0_ts}

    done
    

exit
  ### Get the mean diurnal cycle 
  for hour in {00..23}; do
       files0_hour=( /jet/home/xjliu/Amazon_exp/Amazon6mon_ILgrassland/energyflux_d01_*_$hour:00:00 )
       echo ${files0_hour[@]}

       fout_hour=$outdir/$varname.UTC$hour.mean.ILgrassland.nc
       echo $fout_hour
       ncea -O ${files0_hour[@]} $fout_hour
  done

  fhourly=$outdir/$varname.UTC??.mean.ILgrassland.nc
  echo $fourly
  fout_diurnal=$outdir/$varname.UTC1_24.mean.ILgrassland.nc
  ncrcat -O $fhourly $fout_diurnal
