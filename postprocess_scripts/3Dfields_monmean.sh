#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM
#SBATCH -t 47:30:00
#SBATCH --ntasks-per-node=128
#SBATCH -o test.out


#module load nco
varname='3Dfields'
var='T2'

### select var and then take monthly mean



## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'

years=("2008" "2010" "2011" "2015" "2020")
for year in ${years[@]}; do
#    echo $fout0
    for mon in {01..02}; do  
	    files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/3Dfields_d01_$((year+1))-${mon}* ))
	    files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/3Dfields_d01_$((year+1))-${mon}* ))  
#        echo ${files0[@]}
 
   echo ${outdir}/3Dfields.$((year+1))${mon}.ctrl.nc	
	ncea -O ${files0[@]} ${outdir}/3Dfields.$((year+1))${mon}.ctrl.nc
	ncea -O ${files1[@]} ${outdir}/3Dfields.$((year+1))${mon}.ILgrassland.nc

  done
done

