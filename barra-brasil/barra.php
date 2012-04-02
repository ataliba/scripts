<?php 

/*
 * File : barra.php
 *
 * Autor : Ataliba Teixeira
 * WebPage : http://www.ataliba.eti.br
 * Baseado no projeto encabecado pelo pessoal do Br-Linux + UnderLinux
 * para uniao dos sites nacionais de software livre
 * --------------------------------------------------------------------------------
 * Funcao : 
 * 
 * Barra baseada no projeto Barra Brasil criado pelo site Br-Linux, com a diferen�a que esta
 * barra mostra atrav�s de um algoritmo semi-rand�mico, os links escolhidos de uma base de 
 * dados. A id�ia veio de uma reclama��o no site acusando o projeto de ser uma panela.
 * Com este c�digo � poss�vel ter uma s�rie de sites sendo mostrados e cria a possibilidade
 * da cria��o de pequenas comunidades. 
 * O script de carregamento da base de dados, se encontra no diretorio admin
 *
 * ---------------------------------------------------------------------------------
 * Como instalar ? 
 *
 * Mude as variaveis no arquivo config.inc
 * No seu mysql ou phpmysadmin rode o arquivo que cont�m as instru��es mysql 
 * que � o arquivo que est� no diretorio sql -> sql.txt
 * 
 * Fa�a o upload para sua p�gina e inclua no seu c�digo de site ( a� vai depender do seu 
 * CMS
 * generalizando, possivelmente voc� ter� que efetuar a linha 
 * include("barra.php");
 *
 * ----------------------------------------------------------------------------------
 * Changelog : 
 *
 * 16/03/2006 - Primeira vers�o liberada para o p�blico
 * 17/03/2006 - Segunda vers�o liberada para o p�blico, que agora realmente faz uma escolha 
 *              de links rand�micos. Ainda persiste alguns testes que v�o ser necess�rios 
 *              em uma nova vers�o
 *
 * ----------------------------------------------------------------------------------
 * Licensiamento : 
 * 
 * FDL
 *
 * ----------------------------------------------------------------------------------
 */

  
   include("config.inc");

?>


<table bgcolor="#000000" cellspacing="0" cellpadding="0" width="100%"
border="0" style="margin: 0;top:0;left:0">
 <tr>

 <td>
  <table bgcolor="#c0c0c0" cellspacing="0" cellpadding="1"
width="100%" border="0">
   <tr valign="middle">
    <td align="center" valign=top width="40" background=barra-fundo.jpg><img src="barra-brasil.gif"></td>
    <td align="left" width="20%" height="26" background=barra-fundo.jpg>
     &nbsp;&nbsp;

<?php echo "<a href=\"$SITEURL\" target=_parent style=\"text-decoration: none; color: black; font-weight: bold; font-family: verdana, geneva, sans-serif, arial; font-size: 8pt\">$SITENAME</a>&nbsp;"; ?>

</td>
    <td width="80%" height="26" background=barra-fundo.jpg align=right>

<?php

  $sql = "SELECT MAX(id) from sitesbarrabrasil";

  
  $resultado = mysql_query($sql)
     or die("impossivel efetuar a query");

  $linha1 = mysql_fetch_array($resultado);

  $numeroregistros = $linha1[0];

  if($numeroregistros <= 6)
   {
     for($i=0;$i <= 5; $i++)
     {
         
         $sql = "SELECT * FROM sitesbarrabrasil WHERE id='$i'";

         $resultado = mysql_query($sql) 
           or die("impossivel efetuar a segunda query");

         $linha = mysql_fetch_array($resultado);

         $nome = $linha["nome"];
         $url = $linha["url"];

     }
     
     return;
  }

   
  for($i=0; $i<=5; $i++)
   {
     
     $nome = "";
     
     while("$nome" == "")
      {
          
          $numero = rand(1,$numeroregistros);
           
		  $ar[$i] = $numero;

          $sql = "SELECT * FROM sitesbarrabrasil WHERE id='$numero'";

          $resultado = mysql_query($sql) 
            or die("impossivel efetuar a segunda query");

          $linha = mysql_fetch_array($resultado);

          $nome = $linha["nome"];
          $url = $linha["url"];
          
          for($j=0;$j<=$i;$j++)
            if($j != $i)
              if($ar[$i] == $ar[$j])
                 $nome = "";
              else
                 $ar[$i] = $numero;
       }

      echo "<a href=\"$url\" target=_parent style=\"text-decoration: none; color: WHITE; font-family: verdana, geneva, sans-serif, arial; font-size: 8pt\">$nome</a>";
  
      if($i <= 4)
        echo "&nbsp;&middot;&nbsp;";
      else
       echo "&nbsp;&nbsp;";

   }

  mysql_close($conexao); 
  
 ?>

     </td>

    </tr>
  </table>
 </td>
 </tr>
</table>
