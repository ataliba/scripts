#!/usr/bin/php

<?php

/* 
 * File : agenda.php 
 * Mantenedor : Ataliba de Oliveira Teixeira < ataliba em ataliba ponto eti ponto br ) 
 * 
 * ----------------------------------------------------------------
 * 
 * Programa que faz o básico, ou seja, procura um número de telefone ( ramal ), em uma lista
 * pré-cadastrada em um txt que tem um padrão específico.
 * Na realidade, a idéia é ter um comando simples que faça a busca do telefone de alguém.
 * A primeira versao vai ser feita em PHP, mas tendo em vista o Python ser uma linguagem mais 
 * tranquila para a criação de comandos deste tipo, em breve solto a versão em Python.
 * 
 * ----------------------------------------------------------------
 * 
 * Para instalação : 
 * 
 * Para instalar é só executar os seguintes passos : 
 * 
 * Primeiro, procure aonde está o binário do php em seu sistema : 
 * # whereis php 
 * Edite a primeira linha do programa com este resultado. 
 * Depois, efetue os seguintes passos : 
 * # mv agenda.php /usr/bin/agenda
 * # chmod 755 /usr/bin/agenda
 * 
 * -----------------------------------------------------------------
 * 
 * Changelog : 
 * 
 * 20-06-2006 : Primeira versão pública do script
 * 
 * -----------------------------------------------------------------
 * 
 * Licensa : 
 * 
 * GPLv2
 * 
 */
 
 // constantes do programa 
 $tmphome = shell_exec("echo \$HOME");
 
 $HOME = str_replace("\n","",$tmphome);
  
 define("DATABASE_FILE","$HOME/.agendatabajara");
 define("VERSION","0.1");
 
 // funcoes do programa 
 
 function print_help()
  {
     echo "Agenda - Pequena agenda de ramais em PHP \n"
         ."Version ".VERSION."\n"
         ."Usage : \n"
         ." add - adicionar um número na agenda \n"
         ." find - procura um nome na agenda \n \n";
   
  }
  
function find_telef($nome)
  {
    if(!file_exists(DATABASE_FILE))
     {
       echo "Você ainda não tem uma base de usuários ... \n ";
     }
    
     if(!($fp = fopen(DATABASE_FILE, "r+")))
      { 

         echo "Impossivel abrir o arquivo $txtsarchive para leitura \n";

         return;
      }
    
    while(!feof($fp))
     {
        $text = fgets($fp, 500);
        if($text == NULL || $text == "")
         {
           return;
         }
        else
         {
          $agenda = explode("|",$text);
         } 
        $pos = strpos("$agenda[0]","$nome");
        
        if(is_int($pos))
         {
           echo "Nome : $agenda[0] / Ramal : $agenda[1] \n";
         }
         
  }

  fclose($fp);
    
  }
 
 
function insert_telef($nome,$ramal)
  {
 
   $data = "$nome|$ramal\n";
   
   $arquivo = DATABASE_FILE;

   $abre = fopen($arquivo, "a+");
   $salva = fwrite($abre, $data);
   fclose($abre);


  }
  
  
// corpo principal do programa 
 
 if($argc < 2 )
   print_help();
 
 if($argc > 1 )
  {
    $option = $argv[1];
  }
 else
  {
    $option = "";
  }
  
 switch($option)
  {
    case "add":
      if($argc < 4 ) 
       {
         print_help();
       }
      else
       {
        $nome = $argv[2];
        $telefone = $argv[3];
        insert_telef($nome,$telefone);
        
       }
       
      break;
    
    case "find":
     
     if($argc < 3 ) 
       {
         print_help();
       }
      else
       {
        $nome = $argv[2];
        find_telef($nome);

       }
      
     break;
     
    default:
      print_help();
      break;
      
  }


?>

