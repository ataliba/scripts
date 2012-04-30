#!/bin/bash
#Converter wma para mp3 :: instale o mplayer
##www.rwstudio.net46.net
 
for i in *.wma; do cp -p "$i" "`basename "$i" .wma`.mp3"; done
for i in *.mp3 ; do mplayer -vo null -vc dummy -af resample=48100 -ao pcm:waveheader "$i" && lame -b 192 -m s audiodump.wav -o "$i"; done
rm audiodump.wav
