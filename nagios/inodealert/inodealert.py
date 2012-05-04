#!/bin/env python
# 
# File      : inodealert.py 
# Author    : Ataliba Teixeira < https://github.com/ataliba  >  
# Version   : 0.1 
# About     : put this shell script on your Linux system to monitoring
#             the use of inodes on your system. It's a good script to 
#             use in boxes had a big number of small files, like systems 
#             had batch processing or big number of reports ( like squid ). 
# 
# Use       : put this small shell script on your cron . I believe two times 
#	      a day is a good number. 
# 
# TODO      : 
#              
# Changelog :
#

import string 
import os 
import sys 

File="/proc/sys/fs/inode-nr"


f = open(File, "r")
Text = f.read()

Values = string.split(Text , '	')

Percent = ( 100 * float(Values[1]) )  / (float(Values[0]) + float(Values[1]))

print Percent 

if Percent > 75: 
  print 'Houston, we had a warning '
elif Percent > 85: 
  print 'Houston, we had a problem coming ' 
elif Percent > 90:
  print 'Houston, mutant monkeys  here. '
else:
  print 'Things are ok, bye'

