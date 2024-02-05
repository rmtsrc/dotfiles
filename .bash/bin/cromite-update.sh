#!/usr/bin/env bash

DICTIONARY=en-GB-10-1
APPS_PATH=~/Applications
INSTALL_PATH=$APPS_PATH/Cromite

update_path=$APPS_PATH/Cromite-update
cromite_path=$INSTALL_PATH/chrome
dictionary_path=~/.config/chromium/Dictionaries
dictionary_tmp=$update_path/$DICTIONARY.txt
download_url=https://github.com/uazo/cromite/releases/latest/download
update_file=updateurl.txt
tar_file=chrome-lin64.tar.gz

function download_cromite {
  echo "Downloading Cromite..."
  rm -Rf $update_path
  mkdir -p $update_path
  wget --directory-prefix=$update_path $download_url/$tar_file
  mkdir $update_path/cromite
  tar xzf $update_path/$tar_file --directory $update_path/cromite --strip-components=1

  echo "Downloading dictionary..."
  dictionary_url=https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries/+/refs/heads/main/$DICTIONARY.bdic?format=TEXT
  rm -f $dictionary_tmp
  wget -O $dictionary_tmp $dictionary_url
}

function install_cromite {
  echo "Installing Cromite..."
  rm -Rf $INSTALL_PATH
  mv $update_path/cromite $INSTALL_PATH

  echo "Installing dictionary..."
  mkdir -p $dictionary_path
  base64 -d $dictionary_tmp >$dictionary_path/$DICTIONARY.bdic
  rm -Rf $update_path
}

function check_for_update {
  installed_version_response=$($cromite_path --version)
  current_version_response=$(curl -L $download_url/$update_file)

  [[ $installed_version_response =~ Cromite\ (.+) ]] && installed_version=${BASH_REMATCH[1]}
  [[ $current_version_response =~ version=([^;]+) ]] && current_version=${BASH_REMATCH[1]}

  if [[ "$installed_version" != *"$current_version"* ]]; then
    download_cromite
    notify-send "Cromite update available" "Restart to apply"
  fi
}

if test -f "$cromite_path"; then
  check_for_update &
  $cromite_path
  if [ -d "$update_path/cromite" ]; then
    install_cromite
  fi
else
  download_cromite
  install_cromite
  $cromite_path
fi
