#!/bin/sh
#
# Arquivo : multiping.sh                                                          
#---------------------------------------------------------------------- 
# Autor e Mantenedor :                                                            
# Ataliba de Oliveira Teixeira < ataliba@ataliba.eti.br or ataliba@ataliba.net >  
# Site : http://www.ataliba.eti.br/sections/shell_utils/                          
#                                                                                
# ---------------------------------------------------------------------
# O programa recebe atraves de linha de comando argumentos que sao 
# parte primeira do ip, ip inicial e ip final
# no final ele imprime um relatorio com todas as maquinas que estao up e que 
# estao down na tela
#
# ----------------------------------------------------------------------
# Historico : 
#
# v0.1   -   Liberada para publico em 12-05-2005
# v0.1.1 -   Colocado teste para ver se existe ou nao o fping no sistema
# v0.1.2 -   Pega o path automaticamente do fping no sistema
# v0.1.3 - 	 Novas opcoes de trabalho com o script 
# 
# ----------------------------------------------------------------------
# Licensa : 
#
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
#
#
# ---------------------------------------------------------------------
#

VERSION="v0.1.3"


if [ `id -u` != 0 ]; then 
   echo -ne "Somente o root pode rodar este script \n"
   exit 0 
 fi


#
# atraves do comando whereis ele procura o comando. joga o comando para o awk, e ele 
# pega a parte antes do : , antes do : ha o arquivo procurado. depois se joga para outro
# comando awk , e ele tenta imprimir , se for  vazio, a mensagem do fping eh mostrada, 
# logo apos se houver ele passa numa boa pelo if 
#

FPING=`whereis fping | awk -F":" '{ print $2 }' | awk -F" " '{ print $1 }'`

if [ -z $FPING ]; then
   echo -ne "Nao existe o fping ... favor instala-lo \n\n"
   exit 0
fi 

# 
# se algum dos tres argumentos faltar ele imprime a mensagem 
#

if [ -z $1 ] ; then 
   echo -ne "$0 $VERSION \n"
   echo -ne "Uso : multiping.sh [ip ] [ comeco ] [ final ] \n"
   echo -ne "Exemplo : $0 192.168.1 1 10 \n"
   echo -ne "Exemplo : $0 192.168.1 \n" 
   echo -ne "Exemplo : $0 192.168.1  100 \n"
   exit 0 
fi 


if [ -z $2 ]; then # se somente o argumento 2 existe
  comeco=1
  final=254
else 
  if [ -z $3 ]; then 
     final=254
  else
    if [ $2 -gt 1 ]; then 
      comeco=1
      final=$2
	else
      comeco=$1
	  final=$2	  
fi  
fi
fi
#
# se o terceiro argumento for menor que o segundo argumento ele imprime a mensagem
#

if [ -z $3 ] && [ -z $2 ]; then 
  if [ $3 -lt $2 ]; then 
    echo -ne "O segundo argumento tem que ser menor que o terceiro argumento \n"
    echo -ne "Tente jogar os dados corretamente agora ... "
    exit 0 
  fi
fi

#
# Logo apos vem o programa propriamente dito. ha um for, que executa o ping no intervalo
# mandado pelo usuario em linha de comando 
#

for i in `seq $comeco $final`; do
    STATUS=`$FPING $1.$i | awk -F" " '{ print $3 }'` # pega o alive da resposta do comando 
	if [ "$STATUS" = "alive" ]; then  # se for alive ele imprime o ping 
	    echo -ne "$1.$i esta respondendo ao ping\n"
    else
       echo -ne "$1.$i nao esta respondendo ao ping \n" # se nao for ele imprime que nao pode ser o ping
    fi
done
