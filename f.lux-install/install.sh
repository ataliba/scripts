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

wget  http://secure.herf.org/flux/xflux.tgz

tar -xzf xflux.tgz

# Asking for your address and getting the coordinates on Maps API

echo -n "Give me your address / Manda aí o seu endereço "
read Maps 

Addr=`echo $Maps | sed 's/ /+/g'`

cd $TheDir 

lynx --source  "http://maps.google.com/maps/api/geocode/xml?address=$Addr&sensor=false" >> $TheDir/geodecode.xml

#Looking for four keywords in here
for key in changelog lat lng
do
OUTPT=`grep $key $TheDir/geodecode.xml | tr -d '\t' | sed 's/^\([^<].*\)$/\1/' `
eval ${key}=`echo -ne \""${OUTPT}"\"`
done


# Getting the results in specific arrays
Lng=`echo ${lng[@]} | awk -F">" '{print $2}' | awk -F"<" '{print $1}'`
Lat=`echo ${lat[@]} | awk -F">" '{print $2}' | awk -F"<" '{print $1}'`

# Creating your xflux configuration 

echo "LNG=$Lng" > $HOME/.xflux
echo "LAT=$Lat" >> $HOME/.xflux

# Creating the xflux start script 

echo "#!/bin/sh" > $HOME/bin/xflux
echo "source \$HOME/.xflux" >> $HOME/bin/xflux
echo >> $HOME/bin/xflux
echo "$HOME/Utils/xflux -l \$LAT -g \$LNG &" >> $HOME/bin/xflux
echo >> $HOME/bin/xflux

 
# Installing the xflux binary

mkdir $HOME/Utils
mv $TheDir/xflux $HOME/Utils
chmod 755 $HOME/Utils/xflux

# Creating the XFCE, Gnome and LXDE start 

echo "[Desktop Entry]" > $HOME/.config/autostart/Xflux.desktop 
echo "Encoding=UTF-8" >> $HOME/.config/autostart/Xflux.desktop
echo "Version=0.9.4" >> $HOME/.config/autostart/Xflux.desktop
echo "Type=Application" >> $HOME/.config/autostart/Xflux.desktop
echo "Name=Xflux" >> $HOME/.config/autostart/Xflux.desktop
echo "Comment=XFLUX " >> $HOME/.config/autostart/Xflux.desktop
echo "Exec=$HOME/bin/xflux" >> $HOME/.config/autostart/Xflux.desktop 
echo "StartupNotify=false " >> $HOME/.config/autostart/Xflux.desktop
echo "Terminal=false " >> $HOME/.config/autostart/Xflux.desktop
echo "Hidden=false " >> $HOME/.config/autostart/Xflux.desktop


echo "Xflux installed .... " 


