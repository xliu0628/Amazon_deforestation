#!/bin/sh
#module load nco
varname='cloudfrac'
var='CLDFRA'
foldername='cloudfrac_crop'

mkdir -p ./${foldername}

for ii in {2..10}; do
    case=Tanguro201401_member${ii}
    files=$(ls /jet/home/xjliu/Tanguro_exp/${case}/3Dfields_d01_2014-01-[1-2]?_00:00:00)
    fout=${foldername}/${varname}_member${ii}
#    ncea -O -v $var $files $fout &
    echo $files
    
    files2=$(ls /jet/home/xjliu/Tanguro_exp/${case}_notrees/3Dfields_d01_2014-01-[1-2]?_00:00:00)
    fout2=${foldername}/${varname}_member${ii}_notrees
    ncea -O -v $var $files2 $fout2 &
 #   echo $files2
 done

 wait
 all1=$(ls ${foldername}/${varname}_member*_notrees)
 #all1=$(ls ${foldername}/${varname}_member*)
 ncea -O $all1 ${foldername}/${varname}_diurnal_ensmean_notrees
