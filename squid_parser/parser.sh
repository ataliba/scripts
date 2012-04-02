#!/bin/sh
#
# parser.sh - Parser para os logs do squid 
# 
# Homepage : http://www.ataliba.eti.br/sections/squid_parser
# Autor : Ataliba de Oliveira Teixeira
# Mantenedor : Ataliba de Oliveira Teixeira < ataliba@ataliba.eti.br >
#
# --------------------------------------------------------------
# Programa que le os logs do squid e os formata para ser jogado em uma 
# base de dados, visando criar aplicações para gerenciamento do mesmo.
# a ideia eh um sarg em que o administrador possa criar todas as consultas
# que o mesmo quiser. 
# dentro em breve o proprio projeto squid_parser terá um front end em php 
# para leitura destes dados
#
# ---------------------------------------------------------------
# 
# Historico : 
# v0.1 - Liberada para o publico neste dia, ainda sem todas as funcionalidades
#
# --------------------------------------------------------------
# License : 
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
# Variaveis globais do script : 

SQL_LOG="/var/log/squidsql_log" # log do script ( todas vez que o mesmo rodar ele ira gerar esta saida
ARQUIVO_SQL="squid.sql"

# -------------------------------------------------------------------
# Variaveis para acesso ao MySQL
# -------------------------------------------------------------------

MYSQL_HOST="" # host do seu mysql
MYSQL_USER="" # usuario do seu mysql
MYSQL_PASS="" # senha do seu usuario no mysql
MYSQL_DB="" # base de dados em que se gravarao os dados

# -------------------------------------------------------------------

echo -ne "Criando arquivo sql : " # mensagem de inicio de processamento

rm -rf $ARQUIVO_SQL # deleta o antigo squid.sql 

COUNTER=0 # zera o contador ( para o log ) 

while read linha # enquanto houverem linhas para serem lidas no access.log ele o while continuara sendo processado
do 

  SPACE1=`echo $linha | awk -F" " '{ print $1 }'` # SPACE1 contem o horario no timestamp do squid
  
  SPACE2=`echo $SPACE1 |  perl timeconvert.pl` # SPACE2 contem o horario em formato reconhecivel por humanos 
                                               # e que foi processado pelo timeconvert.pl
  
  HORA=`echo $SPACE2 | awk -F" " '{ print $4 }'` # HORA CONTEM A HORA DO EVENTO
  DIA=`echo $SPACE2 | awk -F" " '{ print $3 }'`  # DIA CONTEM O DIA DO EVENTO
  ANO=`echo $SPACE2 | awk -F" " '{ print $5 }'`  # ANO CONTEM O ANO DO EVENTO
  MES=`echo $SPACE2 | awk -F" " '{ print $2 }'`  # MES CONTEM O MES DO EVENTO
 
  # Este case tranforma o formato literal do mes em um formato passivel de ser inserido no MySQL
  case $MES in   
	Jan ) MES1="01";;
	Feb|Fev ) MES1="02";;
	Mar ) MES1="03";;
	Apr|Abr ) MES1="04";;
	May|Mai) MES1="05";;
	Jun ) MES1="06";;
	Jul ) MES1="07";;
	Aug|Ago ) MES1="08";;
	Sep|Set ) MES1="09";;
	Oct|Out ) MES1="10";;
	Nov ) MES1="11";;
	Dec|Dez ) MES1="12";; 
  esac

  DATA_ACESSO="$ANO-$MES1-$DIA"; # forma a data para ser inserida no MySQL	

  T_RESPOSTA=`echo $linha | awk -F" " '{ print $2 }'` # tempo de resposta do evento
  
  IP=`echo $linha | awk -F" " '{ print $3 }'` # ip que gerou o evento ( ip do host na rede ) 
  IP2=`php trata_mysql.php "$IP"`
  
  STATUS=`echo $linha | awk -F" " '{ print $4 }'` # status do acesso 
  STATUS2=`php trata_mysql.php "$STATUS"`
  
  BYTES_TRANSFER=`echo $linha | awk -F" " '{ print $5 }'` # bytes transferidos
  
  METODO_DE_TRANSFERENCIA=`echo $linha | awk -F" " '{ print $6 }'` # o metodo que foi usado na transferencia
  METODO_DE_TRANSFERENCIA2=`php trata_mysql.php "$METODO_DE_TRANSFERENCIA"`

  URL=`echo $linha | awk -F" " '{ print $7 }'` # a url acessada
  URL2=`php trata_mysql.php "$URL"`
 
  CACHE=`echo $linha | awk -F" " '{ print $9 }'` # se foi puxado do cache ou direto
  CACHE2=`php trata_mysql.php "$CACHE"`

  TIPO_DE_OBJETO=`echo $linha | awk -F" " '{ print $10 }'` # o tipo de objeto acessado
  TIPO_DE_OBJETO2=`php trata_mysql.php "$TIPO_DE_OBJETO"`

  
   # o comando sql para insercao no banco de dados eh jogado para o arquivo squid.sql 
  echo "INSERT INTO squid_logs(DATA_ACESSO,HORA,T_RESPOSTA,IP,STATUS_ACESSO,BYTES_TRANSFER,METODO_DE_TRANSFERENCIA,URL,CACHE,TIPO_DE_OBJETO) VALUES('$DATA_ACESSO','$HORA','$T_RESPOSTA','$IP2','$STATUS','$BYTES_TRANSFER','$METODO_DE_TRANSFERENCIA2','$URL2','$CACHE2','$TIPO_DE_OBJETO2');" >> $ARQUIVO_SQL

  echo -ne " +" # imprime uma linha de status do proprio script 
  COUNTER=`expr $COUNTER + 1` # incrementa o contador 

done < access.log 


echo " [ done ]"

echo -ne "Foram processadas $COUNTER linhas \n" >> $SQL_LOG # imprime um log com o numero de linhas processadas

mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DB < $ARQUIVO_SQL

DATA_PROCESSAMENTO=`date`

echo -ne "DATA DE PROCESSAMENTO : $DATA_PROCESSAMENTO ( dados no mysql ) \n\n" >> $SQL_LOG

# EOF
