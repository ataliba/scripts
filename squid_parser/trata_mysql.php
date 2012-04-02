#!/usr/bin/php -q

<?
 
# 
# trata_mysql.php 
#
# 
# Homepage : http://www.ataliba.eti.br/sections/squid_parser
# Autor : Ataliba de Oliveira Teixeira
# Mantenedor : Ataliba de Oliveira Teixeira < ataliba@ataliba.eti.br >
#
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


  $string = $argv[1]; // pega o primeiro argumento passado para o 
                     //  comando 
  
  $string2 = mysql_escape_string($string); // utiliza uma funcao mysql
                                          // para escapar os caracteres 
                                         // reservados do mysql

  echo "$string2"; // imprime a string tratada
 
?>
