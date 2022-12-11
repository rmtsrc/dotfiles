#!/bin/bash

counter=0
while "$@"; do
  ((counter = counter + 1))
  echo "Run $counter"
done
