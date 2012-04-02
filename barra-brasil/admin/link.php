<?php

$nome = $HTTP_POST_VARS["nome"];
$link = $HTTP_POST_VARS["link"];	
$nome2 = mysql_escape_string($nome);
$link2 = mysql_escape_string($link);
     
 include("../config.inc");
   

 $sql = "INSERT INTO sitesbarrabrasil(nome,url) VALUES('$nome2','$link2')";
 echo $sql;

 mysql_query($sql) or die("impossivel efetuar a query no banco de dados ! ");

 mysql_close($conexao);

 echo "Script processado . <a href='index.php'>voltar</a><br>";
?>