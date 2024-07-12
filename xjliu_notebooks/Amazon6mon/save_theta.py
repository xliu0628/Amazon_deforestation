#!/bin/bash
#SBATCH -N 1 
#SBATCH -p RM-512
#SBATCH -t 4:00:00
#SBATCH --ntasks-per-node=128
#SBATCH -o aa.out


import numpy as np
import pandas as pd
import xarray
import time
import glob

import matplotlib.colors as mcolors

from netCDF4 import Dataset

from wrf import getvar,vinterp


path = '/ocean/projects/ees210014p/xjliu/Amazon_exp/'

int_levels=[1000,975,925,850,750,700,600,500,400,300,200,100]
vert_coord="pressure"
files0 = glob.glob(path+'Amazon_NoahMP/3Dfields_d01_2015-11-*')
files0.sort()
files0

files1 = glob.glob(path+'Amazon_NoahMP_ILdeforested/3Dfields_d01_2015-11-*')
files1.sort()
files1

for ii in range(1):
    
    ncfile0 = Dataset(files0[ii])
    # Get the Sea Level Pressure
    T0 = getvar(ncfile0, "theta")

    ncfile1 = Dataset(files1[ii])
    T1 = getvar(ncfile1, "theta")
    
    Theta0 = vinterp(ncfile0,T0,"pressure",int_levels)
    Theta1 = vinterp(ncfile1,T1,"pressure",int_levels)
    
for ii in range(1,24*15):
    
    ncfile0 = Dataset(files0[ii])
    # Get the Sea Level Pressure
    T0 = getvar(ncfile0, "theta")

    ncfile1 = Dataset(files1[ii])
    T1 = getvar(ncfile1, "theta")
    
    tmp0 = vinterp(ncfile0,T0,"pressure",int_levels)
    tmp1 = vinterp(ncfile1,T1,"pressure",int_levels)
    
    Theta0=xarray.concat((Theta0,tmp0),dim='TIME')
    Theta1=xarray.concat((Theta1,tmp1),dim='TIME')

del Theta0.attrs['projection']
del Theta1.attrs['projection']

Theta0.to_dataset().to_netcdf(path+'post_processing/Amazon561x721/Theta.obs.Noah.day1_15.nc')
Theta1.to_dataset().to_netcdf(path+'post_processing/Amazon561x721/Theta.ILgrassland.Noah.day1_15.nc')
