#!/bin/sh
# file : bind.sh 
########################################################
# Author : Philippe Chadefaux 10 Jan 2002
# Modified by : Ataliba Teixeira on 18 Aug 2005
# Webpage : http://cerebro.freeshell.org 
#
########################################################
# 
# An rc script to reload, start and other options to 
# manage the bind service on OpenBSD or other BSD systems
#
# to use this script : 
# /bin/bind (stop|start|reload|restart|status)
#
# To install this script copy, type this commands : 
# # mv bind.sh /bin/bind
# # chmod 755 /bin/bind
#
########################################################
# Changelog : 
#
# 18 Aug 2005 - Public version available on internet 
#
########################################################
# License : 
#
# Under GPL License 
#
########################################################

case "$1" in
	start)

	if [ -x /var/run/named.pid ]
	then
	  $0 stop
	fi	

	 /usr/sbin/named -t /var/named -u named
	echo -e "Starting Bind....  "
	sleep 2
	if [ \( -e /var/run/named.pid \) ]
		then
			echo -e "Ok\n"
			logger -t "Bind" "Starting Bind"
		else
			echo -e "Failed\n"
			logger -t "Bind" "Bind start failed"
		fi
	;;
	stop)
	if [ \( -e /var/run/named.pid \) ]
		then
			PID=`cat /var/run/named.pid`
			kill -9 $PID
			sleep 2
		fi
		if [ "`/bin/ps -axc |grep named | grep -v grep`" != "" ]
		then
			PIDON=`/bin/ps -axc | grep named | grep -v grep | awk '{print $1}'`
			 kill -9 $PIDON
			sleep 2
		fi 

        if [ "`/bin/ps -axc |grep named | grep -v grep`" != "" ]
		then
			$0 stop
		fi 
		
		if [ -x /var/run/named.pid ] 
		then
	        rm -f /var/run/named.pid
     	fi	

		echo -e "Bind stopped ....\n"
		logger -t "Bind" "Bind Stopped"

	;;
	reload)
	if [ \( -e /var/run/named.pid \) ]
		then

			TEST=`/bin/ps -axc |grep named | grep -v grep |wc -l`
			if [ $TEST != 1 ]
			then
				
				echo -e "Several sessions of Bind are launched TEST $TEST\n"
				echo -e "Service restarted ....!"	
				$0 start	
			else
				PID=`cat /var/run/named.pid`
				 kill -HUP $PID
				echo -e "If your have this error, your think to increment the serial number ..!\n"
				echo -e "Reload the database....\n"
				logger -t "Bind" "Bind Reload make"
			fi
		fi
	;;
	restart)
 		$0 start	
	;;
	status)
	if [ \( -e /var/run/named.pid \) ]
		then
			PID=`cat /var/run/named.pid`
			echo -e "Bind is running (pid $PID)....\n"
			ETAT=`/usr/sbin/host -t SOA openbsd-edu.net`
			echo -e "$ETAT\n"
		else
			echo -e "Bind is not running\n"
		fi
	;;
	*)
	echo "Usage: $0 ( start | stop | reload | restart | status )"
	exit 1
esac

exit 0
