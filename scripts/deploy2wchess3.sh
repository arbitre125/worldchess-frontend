#!/usr/bin/env bash

#
# Скрипт загружает текущую ветку разработки на wchess3.dev39.ru
#
# Для работы скринта необходимо установить утилиты:
# ng (npm install -g @angular/cli)
# sshpass (https://gist.github.com/arunoda/7790979)
#


cd ..

echo
echo "#====================#"
echo "|   wchess3 deploy   |"
echo "#====================#"
echo


# 1. Удаляем папку dist
DIST=dist
if [ -d "$DIST" ]; then
  echo "Clean up $DIST..."
  rm -rf $DIST
fi


# 2. Собираем приложение
echo "Building..."
ng b -env=dev


# 3. Подключаемся по sftp
echo "Copying..."
HOST=wchess3.dev39.ru
PORT=7822
USER=wchess3
sshpass -p 'wchess3Dev' sftp -oPort=$PORT $USER@$HOST <<EOT
cd /var/www/wchess3
rm *
put dist/*
quit
EOT

echo
echo "wchess3 is updated now. "
echo
echo "Done! 🍺"


cd -