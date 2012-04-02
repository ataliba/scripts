#!/usr/bin/php

<?

/*
 * Arquivo : c2play.php 
 * Autor   : Ataliba Teixeira < ataliba em ataliba ponto eti ponto br > 
 * Site    : http://www.ataliba.eti.br
 * 
 * ----------------------------------------------------------------------
 * 
 * � um interface em php para o programa mpg123.  Procura todos os arquivos que estao 
 * em um diretorio X e ali, ele trabalha ... 
 * 
 * ----------------------------------------------------------------------
 * Instala��o : 
 *
 * Copie o arquivo c2play.php para um diretorio que esteja no seu path de execut�veis :
 * # cp c2play.php /bin/c2play
 * # chmod 755 /bin/c2play
 *
 * Ap�s isto, abaixo do diretorio de m�sicas, crie uma estrutura do seguinte modo : 
 * # mkdir /meudiretoriodemusicas/artista/album
 *
 * e para cada �lbum do artista fa�a a mesma coisa : 
 * # mkdir /meudiretoriodemusicas/artista/album2
 *
 * e fa�a isto para cada artista que voc� for adicionar as mp3. Caso o artista n�o 
 * tenha um album especifico, crie uma pasta qualquer, somente para garantir alguma 
 * tranquilidade na hora de tocar. 
 * 
 * O uso do programa � : para tocar todos os mp3 
 * $ c2play
 * 
 * Para tocar as m�sicas de um artista espec�fico : 
 * $ 2play artista 
 *
 * Outras op��es estar�o sendo adicionadas aos pouco no player
 *
 * ----------------------------------------------------------------------
 * Changelog : 
 * 
 * 19/05/2006 - Primeira vers�o publica
 * 22/05/2006 - Bug para nao gerar um loop infinito quando alcancar o final de todas as 
 *              musicas do diretorio com as mp3 
 * 25/05/2006 - Adicionada a op��o de ouvir somente as m�sicas de uma artista especifico
 *
 * ----------------------------------------------------------------------
 * Licensa : 
 * 
 * GPLv2 
 *
 */
 
// Nao mexa nestas variaveis
define("version","0.3");

// Vari�veis que voc� deve modificar, modifique o segundo campo dos defines 

define("tmp_archive","/tmp/arquivos.txt");
define("minhas_mp3","/home/musicas");

 
function list_artists($dir)
 {
   static $i = 0;

   $d = opendir($dir);
       
   echo "Artistas contidos no diretorio \n";
       
    while ($file = readdir($d))
     {
        if ($file == '.' || $file == '..') continue;
        if (is_dir($dir.'/'.$file))
         {
            echo $file."\n";
         }
                  
     }
          
 }
 
function print_version()
 {
   echo "2play - mpg123 randomizer em PHP \n"
       ."Version ".version."\n"
       ."Usage : \n"
       ." list - listar os artistas \n"
       ." help - lista este help \n"
       ." play artista - toca musicas de um artista especifico \n"
       ." play - toca as musicas todas do diretorio \n \n";
        
 }
 
function write_musics($data)
 {
   $arquivo = tmp_archive;
   
   $abre = fopen($arquivo, "a+"); 
   $salva = fwrite($abre, $data);
   fclose($abre); 

 }


// funcao ls foi retirada do manual do php na funcao falando sobre o opendir.
 
function ls($dir)
{
       static $i = 0;
       $files = Array();
       $d = opendir($dir);
       while ($file = readdir($d))
       {
         
               if ($file == '.' || $file == '..') continue;
               if (is_dir($dir.'/'.$file))
                {
                  $files += ls($dir.'/'.$file);
                  continue;
                }
                  
                if(strstr("$file",".mp3"))
                 {
                   $files[$i++] = $dir.'/'.$file;
			       write_musics($dir."/".$file."\n",tmp_archive);
                   
                 }  
               
       }
       return $files;
}

function Play($caminho)
 {
   
   $status = True; 
   
   unlink(tmp_archive);

   if("$caminho" == "")
    {
      ls(minhas_mp3);
    }
   else
    {
      ls(minhas_mp3."/$caminho");
    }
    
   $arquivos = file(tmp_archive);   
   
   $final = count($arquivos);
   
   $estado[$final - 1] = array();
   
   for($i = 0; $i < $final; $i++)
    {
      $estado[$i] = "False";
    }  
   
   $counter = 0;

   while ($status) 
    {
      
      $numero = rand(0,$final-1);
      
      if("$estado[$numero]" == "False")
       {
        system("clear");
        $counter += 1;
        
        echo "###############################################################\n"
            ."#####              MP3 PLAYER EM PHP                          #\n";
         
        $musica = str_replace("\n","",$arquivos[$numero]);
        echo "# -> Tocando m�sica $numero de $final \n# -> M�sica $counter da sess�o\n\n";
        $estado[$numero] = "True";
        system("mpg123 -v \"$musica\"");    
        
        if($counter == ( $final - 1 ))
         {
           echo "Finalizando se��o ... ";
           exit(0);
         }
         
       }
         
    }

    
 }



if($argc < 2)
 {
  print_version();
  exit(0);
 }
 
 

 $variavel = $argv[1];
 switch($variavel)
  {
      case "list":
          $files = list_artists(minhas_mp3);
          break;
          
      case "version":
          print_version();
          break;
      
      case "play":
        if($argc == 3)
          $caminho = $argv[2];
        else
          $caminho = "";
          
        Play($caminho);
        break;
        
      default:
        print_version();
        break;

 }
    
?> 
