#!/bin/bash

#Port Scanner with echo on local ports in background

function ctrl_c(){
  echo -e "\n\n[+] Saliendo .....\n"
  exit 1
}
#Ctrl+c
trap ctrl_c INT

#
for port in $(seq 1 65535); do
  (echo ' ' > /dev/tcp/127.0.0.1/$port) 2>/dev/null && echo -e "\n[+]Puerto: $port =>abierto\n" || echo -e "\n[+]Puerto: $port=>cerrado\n" &
  sleep 1
done
