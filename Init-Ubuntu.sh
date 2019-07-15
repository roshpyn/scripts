#!/bin/bash
version="19.07.15v1"
author="roshpyn"
function Get-Help {
echo "$0 v$version

by $author"
}
source ./Draw-ProgressBar.sh 

toinstall=(
    Update
    Upgrade
    Auto
    Get-dwm
    Get-Rust
    Get-go
    Get-Code
)
echo ${toinstall[*]}
function Is-Parameter {
    # $1 - argument   S2, $3 - expected parameters 
    if [ $1 == $2 -o $1 == $3 ]; 
    then 
        true
    else 
        false
    fi
}
Update () { apt -qq -q update ; }
Upgrade () { apt -qq -q upgrade -y ; }
Auto () { 
    apt -qq -q autoremove 
    apt -qq -q autoclean 
}
Get-dwm () {
    mkdir ~/srcs > /dev/null
    cd ~/srcs > /dev/null
    git clone git://git.suckless.org/dwm > /dev/null
    clear
    
}
Get-go () {
    snap install go > /dev/null
}
Get-Rust () {
    apt -qq -q install cargo -y
}
Get-Code () {
    snap install code --classic > /dev/null
}

function Install {
    Get-ProgressBar ${toinstall[*]}
}

arg=$1

if Is-Parameter $arg "-h" "--help"; then
    Get-Help
elif Is-Parameter $arg "-i" "--install"; then
    Install
fi