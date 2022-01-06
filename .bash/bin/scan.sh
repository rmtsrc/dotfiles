#!/usr/bin/env bash

# Usage `$scan bank bank-name-statement`
# Saves files in `~/Documents/Archive/banking/1970/1970-12-25-bank-name.jpg`

# `sudo pamac install tesseract tesseract-data-eng`
# set -x

TOPIC=$1
SUBJECT=$2

DATE=`date +%Y-%m-%d`
YEAR=`date +%Y`
NAME="$DATE-$SUBJECT"

mkdir -p ~/Documents/Archive/$TOPIC/$YEAR

times=1
function scan {
  scanimage --device-name "genesys:libusb:003:011" --resolution 300 --mode color --format jpeg > ~/Documents/Archive/$TOPIC/$YEAR/$NAME-$times.jpg

  read -p "Scan another page? " -n 1 -r
  echo # move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    times=$((times+1))
    scan
  fi
}
scan


for file in ~/Documents/Archive/$TOPIC/$YEAR/$NAME*.jpg
do
	tesseract $file $file
done

for n in {0..100}
do
  cat ~/Documents/Archive/$TOPIC/$YEAR/$NAME-$n.jpg.txt >> ~/Documents/Archive/$TOPIC/$YEAR/$NAME.txt 2>/dev/null
done

convert ~/Documents/Archive/$TOPIC/$YEAR/$NAME*.jpg ~/Documents/Archive/$TOPIC/$YEAR/$NAME.pdf
rm -f ~/Documents/Archive/$TOPIC/$YEAR/$NAME-*
