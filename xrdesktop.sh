#!/bin/sh 

while [ -z $Ip ];
 do
  Ip=$(Xdialog --title 'Rdesktop' --inputbox 'Digite o ip do servidor' 0 0 2>&1)
 done

while [ -z $Opt ];
 do
Opt=$( Xdialog --stdout --menu 'Escolha a opção:' 10 100 30 console 'console do servidor' \
     AltaResolucao 'Alta resolução do servidor' \
     )
 done

case $Opt in
  console)
    Command="  -0"
  ;;
  AltaResolucao)
    Command=" -a 24 -g 1024x768"
    ;;
esac


/usr/bin/rdesktop $Ip $Command -r disk:Remote=/home/ataliba/Remote

