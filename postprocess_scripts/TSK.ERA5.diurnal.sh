dir=/jet/home/xjliu/WPS4.3/Tanguro
for ii in {00..23};do
	files=( $dir/met_em.d01.2014-07-??_${ii}:00:00.nc )
#	echo ${files[@]}
     ncea -O -v SKINTEMP ${files[@]} TT.Day$ii.nc

     done

fall=( ./TT.Day*.nc )
echo ${fall[@]}
ncrcat -O ${fall[@]} TT.ERA5.diurnal.nc
