#!/usr/bin/env python 
# 
# File      : inodealert.py 
# Author    : Ataliba Teixeira < https://github.com/ataliba  >  
# Version   : 0.2.1 
# About     : put this shell script on your Linux system to monitoring
#             the use of inodes on your system. It's a good script to 
#             use in boxes had a big number of small files, like systems 
#             had batch processing or big number of reports ( like squid ). 
# 
# Use       : put this small shell script on your cron . I believe two times 
#	      a day is a good number. 
# 
# TODO      : 
#		Create a new script to use on nagios
#              
# Changelog :
#	      Version 0.2 
#		Insert an smtp before create  / Create the shell object on this script
#	      Version 0.2.1 
#	 	Some changes on code to solve errors
#

import string 
import os 
import sys 
import smtplib 
from subprocess import Popen, PIPE
from email.MIMEText import MIMEText

# Don't change nothing
File="/proc/sys/fs/inode-nr"

# Change this 
From = 'from@from.com' 
To = 'to@to.com'

# Objects to use on shell 
class Cmd(object):
   def __init__(self, cmd):
       self.cmd = cmd
   def __call__(self, *args):
       command = '%s %s' %(self.cmd, ' '.join(args))
       result = Popen(command, stdout=PIPE, stderr=PIPE, shell=True)
       return result.communicate()

class Sh(object):
    def __getattr__(self, attribute):
        return Cmd(attribute)


# Simple function to send e-mail 

def SendEmail(error, message):

	
   	msg = MIMEText("%s"% message)
	msg['Subject'] = error
   	msg['From'] = From
   	msg['To'] = To

	sh = Sh()

	try:
		smtpObj = smtplib.SMTP('localhost')
		smtpObj.sendmail(From, To, msg.as_string())         
		sh.logger("InodeAlert Successfully sent email")
		smtpObj.quit()
	except smtplib.SMTPException:
		sh.logger("InodeAlert Error: unable to send email")



# main functions of the script 

sh = Sh()
f = open(File, "r")
Text = f.read()

Values = string.split(Text , '	')

Percent = ( 100 * float(Values[1]) )  / (float(Values[0]) + float(Values[1]))

if Percent > 75: 
	SendEmail('You had reached 75% of you filesystem inodes','You had reached 75% of your filesystem inodes. You need to clean some files.')
	sh.logger("InodeAlert This is a warning: You had reached 75% of you filesystem inodes")
elif Percent > 85: 
	SendEmail('You had reached 85% of you filesystem inodes','You had reached 75% of your filesystem inodes. You need to clean some files.')
	sh.logger("InodeAlert This is a warning: You had reached 85% of you filesystem inodes")
elif Percent > 90:
	SendEmail('You had reached 90% of you filesystem inodes','You had reached 75% of your filesystem inodes. You need to clean some files.')
	sh.logger("InodeAlert Critical: You had reached 90% of you filesystem inodes")
else:
	sh.logger("InodeAlert The number of inodes on your system are ok ")

