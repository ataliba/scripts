#!/bin/sh 
#################################################
#  Script hldb.sh – Hora Legal Brasileira        
#                                               
#  Autor: Ataliba Teixeira < ataliba@ataliba.eti.br > 
# Baseado no script de Pablo Nehab Hess – "NatuNobilis"  
# ################################################
# O que faz ? 
#  Este script pega a hora legal de Brasilia e  fornece a hora correta para o comando 
# `date’ 
# ################################################
# Changelog : 
#
# ################################################
# SCRIPT SOBRE A LICENSA GPL 
#################################################

LYNX=`which lynx`
DATE=`which date`
ECHO=`which echo`
CLOCK=`which clock`

if [ -z $LYNX ]; then
   $ECHO "Lynx nao existe, impossivel rodar este script"
   exit 1 
 fi 

if [ "$UID" -ne "0" ]; then
	$ECHO -e "\nSomente o root pode rodar este comando.\n"
	exit 1
fi


# montando as datas padrao do sistema 
LINHA=`$LYNX --dump http://pcdsh01.on.br/ispy.asp | grep Bras`
LINE_DATE=`$ECHO $LINHA | awk -F" " '{print $2}'`
LINE_HOUR=`$ECHO $LINHA | awk -F" " '{print $3}'`

HHMM=`$ECHO $LINE_HOUR | cut -f1,2 -d ":" --output-delimiter="" `

DIA=`$ECHO $LINE_DATE | cut -f1 -d "/"`
# Tratar a saida para satisfazer o formato do comando date.
if [ $DIA -lt 10 ]; then
        DIA=0$DIA
fi
MES=`$ECHO $LINE_DATE| cut -f2 -d "/"`
# Tratar a saida para satisfazer o formato do comando date.
if [ $MES -lt 10 ]; then
        MES=0$MES
fi

$DATE $MES$DIA$HHMM$ANO
$CLOCK -w 
