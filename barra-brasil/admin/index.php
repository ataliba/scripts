<html>
<title>Gerenciando a hp eti </title>
<style type="text/css">
<!--
td {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 12px; color: #666600}
body {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 12px; color: #666600}
H3
{font-family:arial; font-size: 18px;
    MARGIN-TOP: 3px;
    MARGIN-BOTTOM: 3px

}
H4
{font-family:arial; font-size: 16px;
    MARGIN-TOP: 3px;
    MARGIN-BOTTOM: 3px

}
H5
{font-family:arial; font-size: 14px;
    MARGIN-TOP: 3px;
    MARGIN-BOTTOM: 3px
}
ul { font-family:arial; MARGIN-TOP: 3px; MARGIN-BOTTOM: 3px }
A
{
	color: black;
    TEXT-DECORATION: underline
}
A:hover
{
	color: #666666;
	TEXT-DECORATION:none
}
-->
</style>

<body bgcolor="white">
<?php
  
  include("../config.inc");
  
  echo "<h2>NOvo Cadastro de Link</h2>";							       
  echo "<form action='link.php' method='post'>"
      ."Nome : <input name='nome' type='text' size='50'><br>"
      ."Link : <input name='link' type='text' size='100'><br>";

  echo "<br><input type='submit' value='Cadastrar'>";
 echo "</form>";
 							       
?>
<center>
								      by Ataliba
									  Teixeira<br>Todos os direitos
									  reservados<br>Powered by Mysql
									  and PHP<br></center>			          
</body>
</html>

