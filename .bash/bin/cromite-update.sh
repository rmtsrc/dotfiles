#!/usr/bin/env bash

DICTIONARY=en-GB-10-1
INSTALL_PATH=~/Applications/Cromite

download_url=https://github.com/uazo/cromite/releases/latest/download
update_file=updateurl.txt
tar_file=chrome-lin64.tar.gz

installed_version_response=$($INSTALL_PATH/chrome --version)
current_version_response=$(curl -L $download_url/$update_file)

[[ $installed_version_response =~ Cromite\ (.+) ]] && installed_version=${BASH_REMATCH[1]}
[[ $current_version_response =~ version=([^;]+) ]] && current_version=${BASH_REMATCH[1]}

if [[ "$installed_version" != *"$current_version"* ]]; then
  echo "Updating Cromite..."
  rm -f /tmp/$tar_file
  wget --directory-prefix=/tmp $download_url/$tar_file
  rm -Rf $INSTALL_PATH
  mkdir -p $INSTALL_PATH
  tar xzf /tmp/$tar_file --directory $INSTALL_PATH --strip-components=1
  rm -f /tmp/$tar_file

  echo "Updating dictionary..."
  dictionary_url=https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries/+/refs/heads/main/$DICTIONARY.bdic?format=TEXT
  dictionary_path=~/.config/chromium/Dictionaries
  dictionary_tmp=/tmp/$DICTIONARY.txt
  rm -f $dictionary_tmp
  wget -O $dictionary_tmp $dictionary_url
  mkdir -p $dictionary_path
  base64 -d $dictionary_tmp >$dictionary_path/$DICTIONARY.bdic
  rm -f $dictionary_tmp
fi

$INSTALL_PATH/chrome
