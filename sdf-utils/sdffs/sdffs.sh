#!/bin/sh 

source $HOME/.myscripts/sdffs

# Version of the script 
Version=29

case $1 in 

mount)
   
   if [ ! -e $LocalPath ]; then
     echo -n  "Creating the mounting dir "
     sudo mkdir -p $LocalPath
     sudo chown -R $UserID:$GroupID $LocalPath
     sleep $Sleep
     echo -e "\033[40;31;1;5m [ Ok ] \033[m"
   fi  
     
   PStat=$(ps aux | grep sshfs | grep -v grep | grep "$RemotePath")
   if [ "$PStat"  == "" ]; then

       echo -n  "Mount your dir at SDF Public Access Unix System"
       if [ -z $2 ]; 
         then
           /usr/bin/sshfs $SDFID@$Server:$RemotePath \
		   $LocalPath
        else
           /usr/bin/sshfs -p $2 $SDFID@$Server443:$RemotePath  \
		    $LocalPath
       fi
  
       echo -e "\033[40;31;1;5m [ Enjoy !!! ] \033[m"
       
    else
      echo "Your dir at SDF Public Access Unix System is already mounted "
   fi

   ;;
umount)
   PStat=$(ps aux | grep sshfs | grep -v grep | grep "$RemotePath")
   if [ "$PStat"  != "" ]; then
      
      echo -n "Umount your dir at SDF Public Access Unix System"
      sudo /bin/umount $LocalPath
      sleep $Sleep
      echo -e "\033[40;31;1;5m [ Ok ] \033[m"
    else
     echo "Your dir isn't mounted at SDF Public Access Unix System"
   fi

   ;;

status)
   PStat=$(ps aux | grep sshfs | grep -v grep | grep "$RemotePath")
   if [ "$PStat"  != "" ]; then 
     Status=" Online"
   else
     Status=" Offline"
   fi
  
   echo -e "Status of sdffs service is \033[40;34;1;5m $Status \033[m"
   if [ "$Status" = " Online" ]; then
      echo $PStat | awk -F" " '{print "\033[40;34;1;5mRemote FS: \033[m" $12" \033[40;34;1;5mMounted on: \033[m"$13}'
   fi
   ;;
update)
   Check_Version
   ;;
*)
  echo -e "Script Version \033[40;34;1;5m$Version\033[m"
  echo "Use: $0 mount [port]" 
  echo "     $0 umount " 
  ;;
esac
