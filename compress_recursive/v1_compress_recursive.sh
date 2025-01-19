#!/bin/bash

 # Detect and count the number of times a file is compressed (gzip, tar, bzip, etc.) using comm, printf and process substitution


 set -e
 export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
 set -x

 error_handler() {
     local line_num=$1
     local error_msg=$2
     echo "Error en la línea $line_num: $error_msg" >&2
     exit 1
 }

 trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR



##################################


compress_file=data.gz
count=0

initial_dir=(*)

function ctrl_c() {
    echo -e "\n[+] Saliendo ...\n"
    exit 0
}

trap ctrl_c INT

if [ ! -s $compress_file ]; then
    echo -e "\nEmpty file\n"
    exit 1
fi

while [ -s "$compress_file" ]; do
    if file "$compress_file" | grep -qE 'compressed|tar' ; then
        7z x "$compress_file" 
        count=$((count + 1))
        after_dir=(*)
        compress_file="$(comm -13 <(printf "%s\n" "${initial_dir[@]}") <(printf "%s\n" "${after_dir[@]}"))"
        initial_dir=(*)
        #revisar pq si he descomprimido habrá algun archivo y esto puede ser innecesario.
        if [ -z "$compress_file" ]; then
            break
        fi
    else
        break
    fi
done

if [ "$count" -eq 0 ]; then
    echo -e "\nThe file is not compressed\n"
else
    echo -e "\The file was compressed $count time(s)\n"
fi
