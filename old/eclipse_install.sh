#!/bin/bash
# 
# file : eclipse_install.sh 
# 
###########################################################################
# 
# This program install eclipse on a Slackware Box 
#
###########################################################################
# Changelog : 
#
# v0.1 - First public version
#
###########################################################################
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


if [ "$UID" -ne "0" ]; then
	echo  -e "\nSomente o root pode rodar este comando.\n"
	exit 1
fi

#### ENDERECOS DE DOWNLOAD DO ECLIPSE

ECLIPSE_URL="http://ftp.sun.ac.za/ftp/mirrorsites/eclipse/downloads/drops/R-3.1.1-200509290840/eclipse-SDK-3.1.1-linux-gtk.tar.gz"

### DOWNLOAD DO JSSDK-1.4.2

BLACKDOWN_URL="http://ftp2.skynet.be/pub/ftp.blackdown.org/JDK-1.4.2/i386/rc1/j2sdk-1.4.2-rc1-linux-i586-gcc3.2.bin"

RC_JAVA="/etc/rc.d/rc.java"

echo "=> Recuperando o home do usuario ... "

user_home=`cat /etc/passwd | awk -F":" '{print $6}' | grep $usuario`


cd /usr/local

echo "=> Baixando o java .. "

wget $BLACKDOWN_URL

echo "=> Baixando o eclipse ... "

wget $ECLIPSE_URL

# procedimentos de instalacao do j2dsk 

echo "=> Efetuando a instalacao do Java ... "

chmod 755 j2sdk-1.4.2-rc1-linux-i586-gcc3.2.bin

/usr/local/j2sdk-1.4.2-rc1-linux-i586-gcc3.2.bin

ln -s /usr/local/j2sdk1.4.2 /usr/local/java

# procedimentos de instalacao do eclipse 

echo "=> Efetuando a instalacao do Eclipse ... "

tar -xvzf eclipse-SDK-3.1.1-linux-gtk.tar.gz

ln –s /usr/local/java/jre /usr/local/eclipse/jre

groupadd eclipse 

chgrp eclipse -R /usr/local/eclipse

chmod 770 -R eclipse

# criando o arquivo rc.java 

echo "=> Criando o arquivo rc.java "

echo "JAVA_HOME=\"/usr/local/java\"" >> $RC_JAVA
echo "JRE_HOME=\"/usr/local/java/jre\"" >> $RC_JAVA
echo "CLASSPATH=\"$JAVA_HOME:$JAVA_HOME/lib:$JRE_HOME/lib:.\"" >> $RC_JAVA
echo "MANPATH=\"\$MANPATH:$JAVA_HOME/man\"" >> $RC_JAVA
echo "JAVA_DOC=\"$JAVA_HOME/docs\"" >> $RC_JAVA
echo "PATH=\"$PATH:$JAVA_HOME/bin:$JRE_HOME/bin\"" >> $RC_JAVA
echo "export  JAVA_HOME JRE_HOME CLASSPATH MANPATH JAVA_DOC PATH" >> $RC_JAVA


chmod 755 $RC_JAVA
echo " " >> /etc/rc.d/rc.local
echo "if \[ -x $RC_JAVA ]; then " >> /etc/rc.d/rc.local
echo "  $RC_JAVA" >> /etc/rc.d/rc.local
echo "fi " >> /etc/rc.d/rc.local
echo " " >> /etc/rc.d/rc.local

echo "=> Instalacao terminada, somente criar um apontador em seu Gerenciador de Janelas para o Eclipse ... "
