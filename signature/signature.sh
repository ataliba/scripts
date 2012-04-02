#!/bin/sh 
# Arquivo : signature.sh
# --------------------------------------------------------------------
# Mantenedor e Autor :
# Ataliba de Oliveira Teixeira < ataliba@ataliba.eti.br >
# Pagina : http://cerebro.freeshell.org/index.php?section=arquivos&op=view&idArchives=15&category=4&id=1
# ---------------------------------------------------------------------
# O que faz ? 
# Este arquivo manda um fortune via linha de comando para o programa signature.php 
# ---------------------------------------------------------------------
# Changelog : 
#
# v0.2 - algumas mudanças operacionais no script como aviso de falta do fortune e 
# mapeamento automatico do path do mesmo no sistema
#
# ---------------------------------------------------------------------
# Licensa : 
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

SIGNATURE_PHP_PATH="" # insira aqui o path completo para o signature.php

# pega o path do fortune no seu sistema 
FORTUNE=`whereis fortune | awk -F":"  '{ print $2 }' | awk -F" " '{ print $1 }'`

# confere se voce tem o fortune instalado 
if [ -z $FORTUNE ]; then
  echo -ne "OPAAAAAAAAAAAAAAA !!! \nVoce nao possui o pacote fortune instalado no seu sistema \nFavor instala-lo senao o programa nao vai funcionar \n"
  exit 0
fi
   
TEMP=`$FORTUNE` # chama o comando fortune ( confira o path no seu sistema ) 

php $SIGNATURE_PHP_PATH/signature.php "$TEMP"
