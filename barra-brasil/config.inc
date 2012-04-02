<?php
 

   $MYSQL_HOST="localhost"; // o endereco do seu banco de dados
   $MYSQL_USER="seuusuario"; // seu usuario no banco de dados
   $MYSQL_PASS="suasenha"; // sua senha no banco de dados 
   $MYSQL_DB="seubancodedados"; // banco de dados que contem seus registros

/*
 usar o script de criação do banco de dados que esta contido neste mesmo 
 pacote. 
*/

   $SITENAME="Nome do seu site"; // coloque aqui o nome do seu site
   $SITEURL="http://seusite.com.br"; // endereco do seu site

    $conexao = mysql_connect("$MYSQL_HOST", "$MYSQL_USER", "$MYSQL_PASS")
       or die ("Configuração de banco de dados errada !!!");
    

   $db = mysql_select_db("$MYSQL_DB")
       or die("Impossivel selecionar esta base de dados");


?>



