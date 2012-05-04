#!/usr/bin/php

<?php

 /*
  * Arquivo    : criamp3.php
  * Mantenedor : Ataliba Teixeira < ataliba em ataliba ponto eti ponto br > 
  * Site       : http://www.ataliba.eti.br
  *
  * --------------------------------------------------------------------------
  *
  * Comando em PHP Script para gerar mp3 utilizando o cdparanoia para extrair 
  * as musicas e o bladeenc para gerar as mp3. 
  * Ha uma serie de perguntas que devem ser respondidas pelo usuario, via prompt
  * e logo apos, eh so esperar gerar as musicas e ouvi-las. 
  * 
  * Para instalar o comando, primeiramente, voce precisa dos programas 
  * cdparanoia - http://www.xiph.org/paranoia/
  * bladeenc - http://bladeenc.mp3.no/
  * Após isto é só copiar como root o arquivo criamp3.php para o diretorio /usr/local/bin
  * # mv criamp3.php /usr/local/bin/criamp3
  * 
  * É interessante lembrar que a primeira linha eh o local onde está hospedado o seu php 
  * em linha de comando, portanto, digite a seguinte linha : 
  * # whereis php 
  * e coloque o caminho para o binário do php no seu sistema operacional.
  * 
  * --------------------------------------------------------------------------
  * Changelog : 
  * 
  * 17-05-2006 - Primeira versao publica
  * 
  * --------------------------------------------------------------------------
  * Licensa : 
  * 
  * GPLv2
  *
  */
  
  
  
  // variaveis padrao do script 
  
  $DATA = date("G").date("i");
  $diretoriotemporario = "/tmp/criamp3-$DATA";
  
  // funcoes do script 
  
  function MakeDirectory($dir, $mode = 0755)
   {
    if (is_dir($dir) || @mkdir($dir,$mode)) return TRUE;
    if (!MakeDirectory(dirname($dir),$mode)) return FALSE;
    return @mkdir($dir,$mode);
   }

  function CreatingDirs($tmpcaminho,$tipo)
   {

    $caminho = explode("/",$tmpcaminho);

    if($tipo == "naolocal")
     $dirtocreate = "/";

   if(count($caminho) > 2)
     {
      foreach($caminho as $local)
       {
        $dirtocreate = $dirtocreate.$local."/";
        if(MakeDirectory($dirtocreate))
         $feito = TRUE;
       }
   }
    else
     {
     if(MakeDirectory($caminho[0]))
       $feito = TRUE;

    }

   return $feito;

   }
   
   

  echo "Quantas musicas possui este cd ? ";
  $var_stdin = fopen('php://stdin', 'r');
  $NUMERO = str_replace("\n", "", fgets($var_stdin,100));
  
  echo "Qual o nome do artista ? ( Utilizar underline para dividir palavras) : ";
  $var_stdin = fopen('php://stdin', 'r');
  $NOMEARTISTA = str_replace("\n", "", fgets($var_stdin,100));
  
  echo "Agora vamos ler o nome das musicas : \n";
  
  
  $NOMES = array();
  

  for($i = 0; $i < $NUMERO; $i++)
   {
     $faixa = $i + 1;
     echo "Digite o nome da musica $faixa do cd ? ( use underline para separar as palavras ) : ";
     $var_stdin = fopen('php://stdin', 'r');
     $NOMES[$i] = str_replace("\n", "", fgets($var_stdin,100));
       
   }
  
  echo "Deseja gravar as músicas em outro diretório ? ";
  $var_stdin = fopen('php://stdin', 'r');
  $outdir = str_replace("\n", "", fgets($var_stdin,100));
  
  
  if ( "$outdir" == "" ) 
   {
     $COMANDO="bladeenc -progress=1 -del -br 128";
   }
  else
   {
     $COMANDO="bladeenc -progress=1 -del -br 128 -outdir=\"$outdir\"";
         

     if($outdir[0] == "/")
      {
        $feito = CreatingDirs($outdir,"naolocal");
      }
     else
      {
        $feito = CreatingDirs($outdir,"local");
      }
     
     if(!$feito)
      {
        echo "Impossivel criar o diretorio $outdir \n";
        exit(1);
      }  
     
   }
   
   echo "Extraindo as músicas do cd ";
   system("mkdir $diretoriotemporario; cd $diretoriotemporario; cdparanoia \"1-\" -B");

   for($i = 1; $i <= $NUMERO; $i++)
    {
	  $COUNTER = $i - 1;

      $ATUAL_NAME = $NOMEARTISTA."-".$NOMES[$COUNTER].".wav";
      if($i < 10)
       {
       
         $file = "track0".$i.".cdda.wav";
       }
      else
       {
         $file = "track".$i.".cdda.wav";
       }
      
      rename("$diretoriotemporario/$file","$diretoriotemporario/$ATUAL_NAME");
      system("cd $diretoriotemporario; $COMANDO $ATUAL_NAME");
   
    }
    
   rmdir("$diretoriotemporario");
   
 ?>
 
