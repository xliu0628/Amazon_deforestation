#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 16:30:00
#SBATCH --ntasks-per-node=64
#SBATCH -o Tanguro.out


#module load nco
varname='energy'
outdir='/jet/home/xjliu/Amazon_exp/post_processing/Amazon961x801'

years=("2005" "2008" "2011" "2020")
for year in $years[@]; do
    echo $fout0
    for mon in {9..12}; do  
	    files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/energyflux_d01_$((year))-${mon}* ))
	    files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/energyflux_d01_$((year))-${mon}* ))  
        echo ${files0[@]}
      
        ncea -O ${files0[@]} ${outdir}/energy.${year}${mon}.ctrl.nc
        ncea -O ${files1[@]} ${outdir}/energy..${year}${mon}.ILgrassland.nc

  done
done

for year in 2020; do
    echo $fout0
    for mon in {01..02}; do
            files0=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02/energyflux_d01_$((year+1))-${mon}* ))
            files1=($(ls /jet/home/xjliu/Amazon_exp/Amazon961x801_${year}09_$((year+1))02_ILgrassland/energyflux_d01_$((year+1))-${mon}* ))
        echo ${files0[@]}

	ncea -O  ${files0[@]} ${outdir}/energy.$((year+1))${mon}.ctrl.nc
	ncea -O  ${files1[@]} ${outdir}/energy.$((year+1))${mon}.ILgrassland.nc

  done
done

