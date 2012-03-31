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
# v0.1 - Liberada para publico em x-x-2005
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

if [ `id -u` != 0 ]; then 
   echo -ne "Somente o root pode rodar este script \n"
   exit 0 
 fi
 
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then 
   echo -ne "Uso : multiping.sh [ip ] [ comeco ] [ final ] \n"
   echo -ne "Exemplo : multiping.sh 192.168.1 1 10 \n"
   exit 0 
fi 
if [ $3 -lt $2 ]; then 
  echo -ne "O segundo argumento tem que ser menor que o terceiro argumento \n"
  echo -ne "Tente jogar os dados corretamente agora ... "
  exit 0 
fi 

for i in `seq $2 $3`; do
    STATUS=`fping $1.$i | awk -F" " '{ print $3 }'`
	if [ "$STATUS" = "alive" ]; then
	    echo -ne "$1.$i esta respondendo ao ping\n"
    else
       echo -ne "$1.$i nao esta respondendo ao ping \n"
    fi
done
