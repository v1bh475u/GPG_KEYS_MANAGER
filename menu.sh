#!/bin/bash
source configure.sh
source display.sh
menu(){
    configure
    display
    while true;
    do
    echo "WHAT WOULD YOU LIKE TO DO?" ;
    echo "1. Generate a new GPG key pair" ;
    echo "2. List all GPG keys" ;
    echo "3. Export a GPG key" ;
    echo "4. Remove a GPG key" ;
    echo "0. Exit" ;
    read -p "ENTER YOUR CHOICE: " choice ;
    clear
    if [ $choice -eq 1 ]
    then
        gpg --full-generate-key
    elif [ $choice -eq 2 ]
    then
        gpg --list-keys --keyid-format=long
    elif [ $choice -eq 3 ]
    then
        echo  "Enter which key you want to set?(Indexing from 0)"
        uid=($(gpg --list-secret-keys --keyid-format=long| awk '/uid/{print $3}'))
        for i in ${uid[@]}; do
            echo "$i"
        done
        read k
        key=($( gpg --list-secret-keys --keyid-format=long | awk '/sec/{if (length($2)>0) print $2}'|awk -F '/' '{print $2}'))  
        git config --global user.signingkey ${key[$k]}
        git config --global commit.gpgsign true
        echo "Key Set!" 
    elif [ $choice -eq 4 ]
    then
        uid=($(gpg --list-secret-keys --keyid-format=long| awk '/uid/{print $3}'))
        for i in ${uid[@]}; do
            echo "$i"
        done
        echo "Which key do you want to remove? (Indexing starting from 0)"
        read k
        key=($( gpg --list-secret-keys --keyid-format=long | awk '/sec/{if (length($2)>0) print $2}'|awk -F '/' '{print $2}')) 
        gpg --delete-secret-key ${key[$k]}
        gpg --delete-key ${key[$k]}
        echo "Key Deleted!"
    elif [ $choice -eq 0 ]
    then
        figlet "You know the rules and so do I! Say Goodbye..." -cf slant | lolcat
        exit
    else
        echo "INVALID CHOICE"
    fi
    done
}
menu