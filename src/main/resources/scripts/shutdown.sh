#!/bin/bash

function exitByKill(){
   kill -9 $(ps -ef|grep  app.core.Main.*process.flag=${process.flag}|egrep -v grep|gawk '{ print $2 }')
}

function exitBySignal(){
   echo "EXIT" > signal
}

if [ "$#" -gt "0" -a "$1" = "kill" ]
then
  exitByKill
else
  exitBySignal
fi

