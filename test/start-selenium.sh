#!/bin/sh

SELENIUM_SERVER=selenium-server-standalone-2.25.0.jar
LOG=selenium-server.log

if [ ! -e "$SELENIUM_SERVER" ]
then
  wget -O $SELENIUM_SERVER http://selenium.googlecode.com/files/selenium-server-standalone-2.25.0.jar
fi

# does not export
if [ "$SELENIUM_SERVER_STARTED" != "true" ]
then
  echo --------------------------------------------------------------- >> $LOG
  date "+%F %H:%M:%S" >> $LOG
  java -jar $SELENIUM_SERVER 1>> $LOG 2>> $LOG &
  export SELENIUM_SERVER_STARTED=true
fi

