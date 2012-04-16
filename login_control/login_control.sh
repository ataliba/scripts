#!/bin/sh 
#
# Version 0.1
# AUTHOR AND MAINTAINER: Ataliba Teixeira < http://github.com/ataliba >
#
# NAME
#   login_control
#
# DESCRIPTION 
#   Limit the number of logins of a user on a Linux System 
#
# HOW TO USE ? 
#
# To install this script you need to create a file named login_control on you /etc directory
# After this, copy this script to the /usr/local/bin directory and set the exec permissions on this. 
# # touch /etc/login_control
# # cp login_contro.sh /usr/local/bin/login_control
# # chmod 755 /usr/local/bin/login_control
# 
# The default of this script is logout all the users try to connect more than one time on you Linux. 
# But, if you need to permit more than one connect of a specific user, on the /etc/login_control file 
# you need to put ( one per line ) the login and the number of connections of this user: 
# Sintax: user:number of connections
# Example: ataliba:2
# 
# If you have problems, open a bug request on GitHub
#
# CHANGELOG ( MM/DD/YYYY)
#
#  ataliba 	04/16/2012		- First public version 
#

Me=`whoami`
Number=`who | grep $Me | wc -l`

# Processing user exceptions 

LoginControl=`grep $Me /etc/login-control | awk -F":" '{print $2}'`

# Logout or login 

if [ -z $LoginControl ]; then 
  if [ $Number -gt 1 ]; then 
     exit
  fi
 else
    if [ $Number -gt $LoginControl ]; then 
      echo "You account has $Number connections at this time. Your limit is $LoginControl connections."
      sleep 3 
      exit
    fi
fi

