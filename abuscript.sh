#!/bin/bash
rm -rf /tmp/abuscript
board=$1
thread=$2
filetype=$3
directory=$(pwd)
if [ "$board" == "install" ]
then
  sudo ln abuscript.sh /bin/abuscript &> /dev/null
  exit
fi
if [ "$thread" != "" ]
then
  mkdir /tmp/abuscript &> /dev/null
  cd /tmp/abuscript
  wget --header "Cookie: usercode_auth=35f8469792fdfbf797bbdf48bab4a3ad" -c -q https://2ch.hk/$board/res/$thread.html
  grep -Po "(?<=href=\"/$board/src)[^\"]*$filetype" $thread.html | sed "s/.*/2ch.hk\/$board\/src&/" > links.txt
  cd $directory
  mkdir $thread &> /dev/null
  cd $thread
  wget -c --header "Cookie: usercode_auth=35f8469792fdfbf797bbdf48bab4a3ad" -nc -q -i /tmp/abuscript/links.txt
  echo "Скачано файлов: $(ls -1 | wc -l)"
else
  echo "Использование: abuscript <Доска> <Тред> <Расширение>"
  echo "Пример: abuscript b 12345678 webm"
  echo "P.S. Если не указывать расширение будут скачиваться все файлы треда"
fi
rm -rf /tmp/abuscript
