#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 00:30:00
#SBATCH --ntasks-per-node=2
#SBATCH -o Tanguro.out


#module load nco
varname='energy'
var='T2'

### select var and then take monthly mean



## select and then concatenate
#for exp in 'bigclearing' 'mediumclearing' 'smallclearing'; do
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'
for year in 2005; do
    echo $fout0
    for mon in {09..12}; do  
	    files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/3Dfields_d01_$((year))-${mon}* ))
	    files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/3Dfields_d01_$((year))-${mon}* ))  
        echo ${files0[@]}
      
        ncea -O -v T2,Q2 ${files0[@]} ${outdir}/T2_RH.${year}${mon}.ctrl.nc
        ncea -O -v T2,Q2 ${files1[@]} ${outdir}/T2_RH.${year}${mon}.ILgrassland.nc

  done
done

for year in 2005; do
    echo $fout0
    for mon in {01..02}; do
            files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/3Dfields_d01_$((year+1))-${mon}* ))
            files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/3Dfields_d01_$((year+1))-${mon}* ))
        echo ${files0[@]}

	ncea -O -v T2,Q2 ${files0[@]} ${outdir}/T2_RH.$((year+1))${mon}.ctrl.nc
	ncea -O -v T2,Q2 ${files1[@]} ${outdir}/T2_RH.$((year+1))${mon}.ILgrassland.nc

  done
done

