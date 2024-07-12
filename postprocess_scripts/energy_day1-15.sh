#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 03:00:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out


#module load nco
varname='energy'
var='TSK'

## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon561x721'
for year in 2015; do
    echo $fout0

    for day in {01..05}; do   
        echo $day
      	#files0=( /jet/home/xjliu/Amazon_exp/Amazon561x721/energyflux_d01_$year-11-${day}_* )
        #files1=( /jet/home/xjliu/Amazon_exp/Amazon561x721_ILdeforested/energyflux_d01_$year-11-${day}_* )
        files1=( /jet/home/xjliu/Amazon_exp/Amazon561x721_ILgrassland/energyflux_d01_$year-11-${day}_* )
   
   ### concatenate the hourly data of the same day
    #  echo ${files1[@]}
#        fout0=$outdir/$varname.${year}.obs
#        fout1=$outdir/$varname.${year}.ILdeforested
        fout1=$outdir/$varname.${year}.ILgrassland
        
#	ncrcat ${files0[@]} $fout0.$day.nc
#        ncrcat 	${files1[@]} $fout1.$day.nc
        ncrcat 	${files1[@]} $fout1.$day.nc

    done
    

  done


    ### take multi-daily mean
 f0=( ${fout0}.*.nc)
 f1=( ${fout1}.*.nc)
    echo  ${f0[@]:0:5}
    echo  ${f1[@]:0:5}
#    ncrcat -O  ${f0[@]:0:5} $fout0.day1_5.nc  
    ncrcat -O  ${f1[@]:0:5} $fout1.day1_5.nc 

#    wait
   ## Take the difference relative to obs.
#    ncbo -O $fout1.multidaymean.nc $fout0.multidaymean.nc dif.$fout1.multidaymean.nc
#    ncbo -O $fout2.multidaymean.nc $fout0.multidaymean.nc dif.$fout2.multidaymean.nc
#    ncbo -O $fout3.multidaymean.nc $fout0.multidaymean.nc dif.$fout3.multidaymean.nc
