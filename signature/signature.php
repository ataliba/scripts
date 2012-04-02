#!/usr/bin/php -q  

<?php
    
	# Arquivo : signature.php
	# --------------------------------------------------------------------
	# Mantenedor e Autor :
	# Ataliba de Oliveira Teixeira < ataliba@ataliba.eti.br >
	# Pagina : http://cerebro.freeshell.org/index.php?section=arquivos&op=view&idArchives=15&category=4&id=1
	# ---------------------------------------------------------------------
	# O que faz ? 
	# Este arquivo atraves do fortune mandado pelo signature.sh gera a assinatura 
	# em formato html, amigável com todos os atuais clientes de email do Linux
	# ---------------------------------------------------------------------
	# Changelog : 
	#
	# v0.2 - arrumado o bug que nao deixava funcionar o script ( variavel email nao existia)
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


    $tmp = $argv[1];
	
    $SIGNATURE_FILE=""; // path completo para o seu arquivo de assinatura
	$SIGNATURE_NAME=""; // seu nome 
	$SIGNATURE_LINUX_REGISTRY=""; // seu numero de registro counter.li
	$SIGNATURE_MAIL=""; // seu email para ser adicionado na assinatura
	$fortune=nl2br($tmp); // adiciona quebra de linha ao fortune
	
	// gera a mensagem do fortune 
    $mensagem = "$SIGNATURE_NAME <br />Mailto: <a href=\"mailto:$SIGNATURE_MAIL\">$SIGNATURE_MAIL</a><br />Registered Linux User : $SIGNATURE_LINUX_REGISTRY <br />"
                              ."$fortune";
    
  	
    $abre = fopen($SIGNATURE_FILE, "w"); // Abre o arquivo
    $salva = fwrite($abre, $mensagem); // Escreve no arquivo o total de visitas
    fclose($abre); 

?>
