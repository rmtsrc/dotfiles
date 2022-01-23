#!/usr/bin/env bash

# Usage ./wsl-custom-hostnames.sh "hostnames" "ports"

# Automatically sets up WSL host/domain names both in Windows and in Linux
# and forwards the listed ports to Linux

# Hostnames and ports are separated by a space
# Using an > in a port will forward one port to the other

# For example running `./wsl-custom-hostnames.sh "myname.example.com myname.local" "8000 80>8000"`
# Then running `python3 -m http.server` in WSL can be accessed via http://myname.example.com

# Note: to allow other devices to connect you will need to add a new firewall rule via:
# `Win+R` > `wf.msc` > Inbound Rules > New Rule > Port and allow the ports you wish to expose to the network

HOSTNAMES=$1
PORTS=$2

hostsFile=/mnt/c/Windows/System32/drivers/etc/hosts
tmpDir=/mnt/c/tmp
tmpHostsFile=$tmpDir/hosts
customComment="# WSL custom hosts"
wslIp=`ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1`
wslHost="wsl.localdomain"
wslHosts="$wslIp $HOSTNAMES $wslHost"

# WSL update hosts file

wslHostsFile=/etc/hosts
wslTmpHostsFile=/tmp/hosts

cp $wslHostsFile $wslTmpHostsFile

if ! grep -q "$wslHosts" $wslTmpHostsFile; then
  if grep -q "$wslHost" $wslTmpHostsFile; then
    sed -i "s/.*wsl\.localdomain$/$wslHosts/" $wslTmpHostsFile
  else
    echo $wslHosts >> $wslTmpHostsFile
  fi

  sudo cp -f $wslTmpHostsFile $wslHostsFile
fi

# Windows update hosts file

mkdir -p $tmpDir
cp -f $hostsFile $tmpHostsFile
chmod +w $tmpHostsFile

if grep -q "$customComment" $tmpHostsFile; then
  if grep -q "$wslHosts" $tmpHostsFile; then
    exit 0
  fi
  sed -i "/$customComment/{n;s/.*/$wslHosts/}" $tmpHostsFile
else
  cat <<EOT >> $tmpHostsFile

$customComment
$wslHosts
EOT
fi

# Windows generate port proxy cmd

portProxy=""
for p in $PORTS
do
  if [[ "$p" == *">"* ]]; then
    IFS='>' read -ra PARTS <<< "$p"
    portFrom=${PARTS[0]}
    portTo=${PARTS[1]}

    # WSL
    sudo iptables -t nat -I PREROUTING -p tcp --dport $portFrom -j REDIRECT --to-ports $portTo
    sudo iptables -t nat -I OUTPUT -p tcp -o lo --dport $portFrom -j REDIRECT --to-ports $portTo
  else
    portFrom=$p
    portTo=$p
  fi
  portProxy="${portProxy}"$'\n'"netsh interface portproxy add v4tov4 listenport=$portFrom listenaddress=0.0.0.0 connectport=$portTo connectaddress=$wslIp"
done

# Windows run PowerShell

echo "Start-Process PowerShell -WindowStyle Hidden -Verb runAs -ArgumentList '-ExecutionPolicy Bypass -File C:\tmp\wslSetupNetwork.ps1'" > $tmpDir/wslElevateToAdminSetupNetwork.ps1

cat <<EOT > $tmpDir/wslSetupNetwork.ps1
#Requires -RunAsAdministrator

Copy-Item -force C:\tmp\hosts C:\Windows\System32\drivers\etc\hosts
$portProxy
EOT

powershell.exe -ExecutionPolicy Bypass -File C:\\tmp\\wslElevateToAdminSetupNetwork.ps1
