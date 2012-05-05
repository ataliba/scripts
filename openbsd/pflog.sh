#!/bin/sh
# Archive : pflog 
# Author : Ataliba Teixeira < ataliba at ataliba dot eti dot br >
# Web Page : http://www.ataliba.eti.br ( in portuguese ) 
#
###############################################################
# The script : 
# This script is designed to see the logs of pf under a OpenBSD
# box
# This script have filters to see things you need in pf logs 
#
# the use is : 
# # pflog 
# This command send to you the pf logs in the moment
# # pflog -i 172.23.200.78
# Send only the logs have the ip 172.23.200.78 
#
###############################################################
# Changelog : 
# 
# Public version available on 2005-08-30
#
###############################################################
# License : 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# The variables of the program 

PF_INT="pflog0" # the pf interface

PFCOMMAND="tcpdump -n -e -ttt -i $PF_INT" # the command to see the pf logs

# the functions of the program


print_help()
 {
    
	echo "PfLog - a command to see and filter the pf logs "
	echo "Use : pf [ options ] [ ips or other things ]"
	echo "Example : pflog -i 172.23.200.99 "
	echo " "
		
 }

run_command()
 {
    case $1 in
      "-i")
	     if [ -x $2 ]; then 
		   print_help
		   exit 0
		 fi
		 
         $PFCOMMAND | grep -i $2
		 ;;
        *)
		 print_help
		 ;;
    esac 
 }	

if [ `id -u` != 0 ]; then
   echo "Only the user root must run this command"
   echo " " 
   exit 0
fi

if [ -x $1 ]; then
      $PFCOMMAND 
      exit 0 
fi 

#!/bin/sh
# Archive : pflog 
# Author : Ataliba Teixeira < ataliba at ataliba dot eti dot br >
# Web Page : http://www.ataliba.eti.br ( in portuguese ) 
#
###############################################################
# The script : 
# This script is designed to see the logs of pf under a OpenBSD
# box
# This script have filters to see things you need in pf logs 
#
# the use is : 
# # pflog 
# This command send to you the pf logs in the moment
# # pflog -i 172.23.200.78
# Send only the logs have the ip 172.23.200.78 
#
###############################################################
# Changelog : 
# 
# Public version available on 2005-08-30
#
###############################################################
# License : 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# The variables of the program 

PF_INT="pflog0" # the pf interface

PFCOMMAND="tcpdump -n -e -ttt -i $PF_INT" # the command to see the pf logs

# the functions of the program


print_help()
 {
    
	echo "PfLog - a command to see and filter the pf logs "
	echo "Use : pf [ options ] [ ips or other things ]"
	echo "Example : pflog -i 172.23.200.99 "
	echo " "
		
 }

if [ `id -u` != 0 ]; then
   echo "Only the user root must run this command"
   echo " " 
   exit 0
fi

if [ -x $1 ]; then
      $PFCOMMAND 
      exit 0 
fi

case $1 in
   "-i")
     if [ -x $2 ]; then 
 	   print_help
	   exit 0
	 fi
	 echo "Running the command $PFCOMMAND | grep -i $2"	 
     $PFCOMMAND | grep -i $2
     ;;
   *)
	 print_help
	 ;;
esac
