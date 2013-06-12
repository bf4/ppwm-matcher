#!/usr/bin/env bash
# ./serve.sh setup
# ./serve.sh start
if [ ! -n "$1" ]
then
    echo "Usage: ./serve.sh [start|stop|restart|setup]"
else
    case "$1" in

    setup)
      test -s 'config/application.yml'
      if [ $? -eq 1 ]
      then
        echo -e 'copying over example application.yml'
        cp config/application.example.yml config/application.yml
      fi
      ruby init.rb
      ;;

    start)
      bundle exec thin start -p 9393 $2
      ;;

    stop)
      bundle exec thin stop
      ;;

    esac
fi
