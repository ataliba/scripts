#!/system/bin/sh
#
#Shadows Renice Script
	
if [ -e /system/bin/shadow.sh ];
then
  busybox renice -18 `pidof com.android.phone`;
  nvalue=$(cat /proc/`pidof com.android.phone`/stat | cut -d ' ' -f 19)
  if [ $nvalue -ne -18 ];
  then
    busybox renice -18 `pidof com.android.phone`;
  fi
busybox renice  5 `busybox pidof com.google.process.gapps`;
  nvalue=$(cat /proc/`pidof com.android.phone`/stat | cut -d ' ' -f 19)
  if [ $nvalue -ne -5 ];
  then
    busybox renice  5 `busybox pidof com.google.process.gapps`;
  fi


  echo "+++ Shadow Script: renice done";
else
  echo "***** Skipping Shadows Script";
fi;