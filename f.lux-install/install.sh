#!/bin/bash
#===============================================================================
#
#          FILE:  install.sh
# 
#         USAGE:  ./install.sh 
# 
#   DESCRIPTION:  A simple installation script for the xflux linux binary  
# 
#  REQUIREMENTS:  Shell script, wget and internet connection 
#          BUGS:  
#         NOTES:  
#        AUTHOR:  Ataliba Teixeira  (ataliba@ataliba.eti.br)
#       VERSION:  0.2
#       CREATED:  03/30/2012 09:46:15 PM BRT
#      REVISION:  1
#===============================================================================

TheDir=/tmp/f.lux

# Creating the f.lux temp directory and download the xflux binary 

mkdir $TheDir 

cd $TheDir 

wget http://secure.herf.org/flux/xflux.tgz


# Asking for your address and getting the coordinates on Maps API

echo -n "Give me your address / Manda aí o seu endereço "
read Maps 

cd $TheDir 

curl ""

#Looking for four keywords in here
for key in changelog lat lng
do
OUTPT=`grep $key /tmp/geodecode.xml | tr -d '\t' | sed 's/^\([^<].*\)$/\1/' `
eval ${key}=`echo -ne \""${OUTPT}"\"`
done

# Getting the results in specific arrays
lat=( `echo ${lat}` )
lng=( `echo ${lng}` )

echo ${lng[@]} | awk -F">" '{print $2}' | awk -F"<" '{print $1}'
echo ${lat[@]} | awk -F">" '{print $2}' | awk -F"<" '{print $1}'


