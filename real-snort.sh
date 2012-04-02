#!/bin/sh
# script que ve as mensagens do snort em tempo real 

tail -f /var/log/snort/alert > /tmp/out &

dialog --title 'Mensagens do Snort em tempo real' \
--tailbox /tmp/out 30 60 

killall tail 

# final do script 


