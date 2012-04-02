#!/usr/bin/php

<?php
 /* 
  * Arquivo : barra.php 
  * Mantenedor : Ataliba Teixeira 
  * 
  * -------------------------------------------------------------------------
  * 
  * O que eh ? 
  * Barra que gera randomicamente uma barra estatica paera mostrar
  * links na sua pagina. 
  * Necessario configurar as variaveis de banco e o path para o local
  * onde sua barra sera gravada. 
  *
  * -------------------------------------------------------------------------
  * Changelog : 
  * 21/03/2006 - Primeira versao liberada ao publico 
  *
  * -------------------------------------------------------------------------
  * Licensiamento : 
  * FDL
  */ 
 
 
 $MYSQL_HOST="localhost"; // endereco de sua base
 $MYSQL_USER="seusuario"; // seu usuario mysql
 $MYSQL_PASS="suasenha"; // sua senha no mysql
 $MYSQL_DB="suadatabase"; // sua base de dados no mysql

 // localizacao aonde sua barra estatica vai ser gravada

 $arquivo = "/path/para/sua/barra.html";
  	
 $abre = fopen($arquivo, "w"); // Abre o arquivo
 	
 $conexao = mysql_connect("$MYSQL_HOST", "$MYSQL_USER", "$MYSQL_PASS")
    or die ("Configuração de banco de dados errada !!!");
    

 $db = mysql_select_db("$MYSQL_DB")
    or die("Impossivel selecionar esta base de dados");

   $SITENAME = "Seu site";
   $SITEURL  = "http://www.seusite.com.br";
   $ar = array("","","","","","");
   
   $frase = "<center><table  bgcolor=\"#6699CC\" cellspacing=\"0\" cellpadding=\"1\" width=\"99%\"
border=\"0\" style=\"margin:0;top:0;left:0\"> <tr> <td>"
       ." <table bgcolor=\"#6699CC\" cellspacing=\"0\" cellpadding=\"1\" width=\"100%\" border=\"0\">"
       ."<tr valign=\"middle\"><td align=\"center\" valign=top width=\"40\">"
       ."<img src=\"imagens/barra-brasil.gif\"></td><td align=\"left\" width=\"20%\" height=\"26\">"
       ."&nbsp;&nbsp;"
	   ."<a href=\"$SITEURL\" target=_parent style=\"text-decoration: none; color: black; font-weight: bold; font-family: verdana,geneva, sans-serif, arial; font-size: 8pt\">$SITENAME</a>&nbsp;"
	   ."</td><td width=\"80%\" height=\"26\"  align=right>";
	   
	   

  $sql = "SELECT MAX(idLinks) from Links";

  $resultado = mysql_query($sql)
     or die("impossivel efetuar a query");

  $linha1 = mysql_fetch_array($resultado);

  $numeroregistros = $linha1[0];
  
  
  for($i=0; $i<=5; $i++)
   {
     
     $nome = "";
    
     while("$nome" == "")
      {
      	 
      	 $numero = rand(1,$numeroregistros);
         
		 $ar[$i] = $numero;

      	 $sql = "SELECT * FROM Links WHERE idLinks='$numero' and br='1'";
     
         $resultado = mysql_query($sql) 
           or die("impossivel efetuar a segunda query");
           
        $linha = mysql_fetch_array($resultado);
        
        $id = $linha["idLinks"];
        $nome = $linha["nome"];
        $url = $linha["link"];

        for($j=0;$j<=$i;$j++)
          if($j != $i)
              if($ar[$i] == $ar[$j]) {
				 $nome = ""; }
              else
                 $ar[$i] = $numero;
                   
      }
           
     
     $frase = $frase." <a href=\"$url\" target=_parent style=\"text-decoration: none; color: WHITE; font-family: verdana, geneva, sans-serif, arial; font-size: 8pt\">$nome</a>";
	 

     if($i <= 4)
       $frase = $frase."&nbsp;&middot;&nbsp;";
     else
       $frase = $frase."&nbsp;&nbsp;";

    }
  
  
 $frase = $frase." </td></tr></table></td></tr></table></center>";
 
 echo "$frase";
 
 $abre = fopen($arquivo, "w"); // Abre o arquivo
 $salva = fwrite($abre, $frase); // Escreve no arquivo o total de visitas
 fclose($abre); // Fecha o arquivo novamente
	
 mysql_close($conexao);
 
 //////////// 
 // EOF /////
 ////////////

?>
