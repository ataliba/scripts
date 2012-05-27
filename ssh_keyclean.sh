#!/bin/bash
DATA="`ssh $1 echo 2>&1|grep known_hosts:`"

if [[ "$DATA" =~ ([^ ]+):([0-9]+) ]]
then
        echo "SSH KeyCleaner v. 0.1";
        echo -n "Delete key from line"
        echo -n " ${BASH_REMATCH[2]} in"
        echo -n " ${BASH_REMATCH[1]}? "
        read -n1 -p"(y/n) : " A
        echo
        if [ "$A" == "y" ]
        then
                sed -i " ${BASH_REMATCH[2]}d"  ${BASH_REMATCH[1]}
                echo "Cleaning"
        fi;
else
        echo "Bad output from ssh command. Sorry.";
fi;
