#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 04:30:00
#SBATCH --ntasks-per-node=4
#SBATCH -o 2005.out


#module load nco
varname='energy'
var='T2'

### select var and then take monthly mean



## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Xingu_160X200'
years=("2010" "2020")
for year in ${years[@]}; do
    for mon in {09..12}; do
	    files0=($(ls /jet/home/xjliu/Amazon_exp/Xingu_${year}09/energyflux_d01_$((year))-${mon}* ))
	    files1=($(ls /jet/home/xjliu/Amazon_exp/Xingu_${year}09_allforests/energyflux_d01_$((year))-${mon}* ))  
        echo ${files0[@]}
      
  #      ncea -O ${files0[@]} ${outdir}/energy.${year}${mon}.ctrl.nc
  #      ncea -O ${files1[@]} ${outdir}/energy.${year}${mon}.allforests.nc

  done
done

for year in ${years[@]}; do
    for mon in {01..02}; do
            files0=($(ls /jet/home/xjliu/Amazon_exp/Xingu_${year}09/energyflux_d01_$((year+1))-${mon}* ))
            files1=($(ls /jet/home/xjliu/Amazon_exp/Xingu_${year}09_allforests/energyflux_d01_$((year+1))-${mon}* ))
        echo ${files0[@]}

	ncea -O  ${files0[@]} ${outdir}/energy.$((year+1))${mon}.ctrl.nc
	ncea -O  ${files1[@]} ${outdir}/energy.$((year+1))${mon}.allforests.nc

  done
done

