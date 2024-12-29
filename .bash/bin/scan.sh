#!/usr/bin/env bash

# Usage `scan.sh bank bank-name-statement`
# Saves files in `~/Documents/Archive/banking/1970/1970-12-25-bank-name.jpg`

# Usage `scan.sh bank bank-name-statement ~/Documents/Scans`
# Saves files in `~/Documents/Scans/banking/1970/1970-12-25-bank-name.jpg`

# `sudo pamac install tesseract tesseract-data-eng`
# set -x

TOPIC=$1
SUBJECT=$2

if [[ -z "$TOPIC" ]] || [[ -z "$SUBJECT" ]]; then
  echo "Usage: scan.sh bank bank-name-statement (optional location: ~/Documents/Scans)"
  echo "Saves files in: ~/Documents/Scans/banking/1970/1970-12-25-bank-name.jpg"
  exit
fi

DATE=$(date +%Y-%m-%d)
YEAR=$(date +%Y)
NAME="$DATE-$SUBJECT"
LOCATION=${3:-$HOME/Documents/Archive}
FULL_LOCATION=$LOCATION/$TOPIC/$YEAR
FILE_PREFIX="$FULL_LOCATION/$NAME-PAGE"

mkdir -p $FULL_LOCATION

page=1
function scan {
  page_file="$page"
  if [[ ${#page} -lt 2 ]]; then
    page_file="0$page"
  fi

  # List scanners via: `scanimage --help` or `lsusb`
  scanimage --device-name "genesys:libusb:003:011" --resolution 300 --mode color --format jpeg --progress >$FILE_PREFIX-$page_file.jpg

  read -p "Scan another page? " -n 1 -r
  echo # move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    page=$((page + 1))
    scan
  fi
}
scan

for file in $FILE_PREFIX-*.jpg; do
  tesseract $file $file
done

for n in $FILE_PREFIX-*.jpg.txt; do
  cat $n >>$FULL_LOCATION/$NAME.txt 2>/dev/null
done

magick $FILE_PREFIX-*.jpg $FULL_LOCATION/$NAME.pdf
rm -f $FILE_PREFIX-*
