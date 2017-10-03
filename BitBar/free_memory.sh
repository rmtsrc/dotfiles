#!/usr/bin/env bash

# Created by Uğur "vigo" Özyılmazel,
# feel free to add/change or implement more kool features
# @vigobronx


installed_memory=$(sysctl -n hw.memsize)
installed_memory_in_gb=$(bc <<< "scale=2; $installed_memory/1024/1024/1000")
page_types=("wired down" "active" "inactive")
all_consumed=0
for page_type in "${page_types[@]}"; do
  consumed=$(vm_stat | grep "Pages ${page_type}:" | awk -F: '{print $2}' | tr -d '[[:space:]]' | grep -e "[[:digit:]]*" -ho)
  consumed_gb=$(bc <<< "scale=2; ($consumed*4096)/1024/1024/1000")
  all_consumed=$(bc <<< "scale=2; $all_consumed+$consumed_gb")
done
gb_free=$(printf "%.2fG" $(bc <<< "scale=2; $installed_memory_in_gb-$all_consumed"))

memory_free_percentage=$(memory_pressure | tr -d '\n' | awk '{gsub ( "%","" ); print $NF}')
colour=green
if [[ "$memory_free_percentage" -lt "13" ]] ; then colour=orange ; fi
if [[ "$memory_free_percentage" -lt "7" ]] ; then colour=red ; fi
echo -n "$gb_free - $memory_free_percentage% free | color=$colour"
