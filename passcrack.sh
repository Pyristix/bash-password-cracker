#!/bin/bash

pass=$1
pass_hash=$(echo "$1" | md5sum | cat)
echo "Your password hash is:"
echo $pass_hash

echo
echo "Attempting to crack password:"

password_cracked=false

start=`date +%s`

letters=( a b c d e f g h i j k l m n o p q r s t u v w x y z )

function crack_char {
    attempt_hash=$(echo $1 | md5sum | cat)
    if [ "$attempt_hash" == "$pass_hash" ] ; then
        end=`date +%s`
        echo "Password cracked in "$((end-start))"s"
        exit 1
    else
        for i in "${letters[@]}"
        do
        if [ ${#1} -lt ${#pass} ] ; then
            new_arg=$1$i
            echo "Tried password: $new_arg"
            echo "$attempt_hash"
            crack_char $new_arg
        fi
        done
    fi
}

crack_char ""
